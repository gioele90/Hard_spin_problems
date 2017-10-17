function confName = parallelProfileLegion

% Set up Matlab cluster profile for the UCL Legiuon cluster.
%
% Matlab provided parallelProfile.m modified for Legion March 2014
% by BAA
% Updated March 2016 for upgraded Legion and R2015b
% Updated Movember 2016 for R2016b

% System or other parameters
maxworkers = 96;                %Cluster size

% Note: this can also be set to grace
sysname = 'legion';             %System name
sys = [sysname '.rc.ucl.ac.uk'];  %Full system address
sysOS = 'unix';

% Figure out the path on Legion from the user's MATLAB version
%
% Note: legion currently uses DCS from R2016b
v = ver('matlab');
v = v.Release(2:end-1);
% v = 'R2016b';
mlpath = ['/shared/ucl/apps/Matlab/' v '/full'];

if v == 'R2016b'
    fprintf(['\nInitiating MATLAB version %s setup for submission to ' ...
             'the %s cluster...\n\n'],v,sysname);
else
    fprintf(['\n***** Currently %s only supports submission to Matlab ' ...
             'R2016b.\n***** You need to use this version on your local computer.\n\n'], sysname);
    return;
end

% Get the user-specific information that we need
% User ID (usually PID)
prompt = ['Input your ' sysname ' userid (Note this is the same as your main UCL userid): '];
userid = input(prompt, 's');
% System jobs directory
sysdir = input(['\nEnter the folder in your Legion Scratch directory where you would like MATLAB \nto track your jobs. Make sure that this location exists, but is not a \nfolder that you use regularly:\n/home/' userid '/Scratch/'], 's');
sysdir = ['/home/' userid '/Scratch/' sysdir];
sysdir = regexprep(sysdir, '//', '/'); %Remove any accidental double slashes
% Local jobs directory
dataloc = input('\nEnter the folder on your computer where you would like MATLAB \nto track your jobs. This should not be a folder that you use regularly:\n', 's');
while ~exist(dataloc,'dir')
  dataloc = input('Folder does not exist. Please enter another location:\n', 's');
end

confName = [sysname '_' v]; %Profile (configuration) name is SystemName_MatlabVersion, e.g. "ithaca_R2011b"

% Matlab's functionality changed in version 2012a, so we have to do
% different things depending on whether we're in that version or later or
% in 2011b or earlier
dcv = ver('distcomp');
if str2double(dcv.Version) >= 6  %We're working with 2012a or later

  clexists = 0;
  %If the configuration exists already
  try
    cluster = parcluster(confName); %This throws an error if the cluster doesn't exist, skipping over this try section
    clexists = 1;
    choice = questdlg(['Profile ' confName ' already exists. Would you like to overwrite it, rename it, or cancel setup?'],'Profile Exists','Overwrite','Rename','Cancel','Cancel');

    switch choice
  %     case 'Overwrite'

      case 'Rename'
        renamed = 0;
        while renamed == 0
          try
            nm = input('\nEnter name to be used for old profile: ','s');
            saveAsProfile(cluster,nm);
            renamed = 1;
            fprintf('Profile %s renamed to %s.\n',confName,nm);
          catch
          end
        end

      case 'Cancel'
        disp('Configuration setup cancelled.');
        return;
    end
  catch
  end

  if clexists
    cluster = parcluster(confName);
  else
    cluster = parallel.cluster.Generic('JobStorageLocation', dataloc);
  end
  set(cluster,'JobStorageLocation',dataloc);
  set(cluster,'NumWorkers',maxworkers);
  set(cluster, 'HasSharedFilesystem', false);
  set(cluster, 'ClusterMatlabRoot', mlpath);
  set(cluster, 'OperatingSystem', sysOS);
  % The IndependentSubmitFcn must be a MATLAB cell array that includes the additional input
  set(cluster, 'IndependentSubmitFcn', {@independentSubmitFcn, sys, sysdir});
  % If you want to run communicating jobs (including matlabpool), you must specify a CommunicatingSubmitFcn
  set(cluster, 'CommunicatingSubmitFcn', {@communicatingSubmitFcn, sys, sysdir});
  set(cluster, 'GetJobStateFcn', @getJobStateFcn);
  set(cluster, 'DeleteJobFcn', @deleteJobFcn);

  %save the profile
  if clexists
    saveProfile(cluster);
  else
    saveAsProfile(cluster,confName);
  end
  fprintf('\nCreated cluster profile %s.\n',confName);

  fcn = 'independentSubmitFcn'; %Function name to test if support files are in the right place

else %We're working with version 2011b or earlier

  %If the configuration exists already
  try
    tmpconf = distcomp.configuration(confName); %This throws an error if the cluster doesn't exist, skipping over this try section
    choice = questdlg(['Configuration ' confName ' already exists. Would you like to overwrite it, rename it, or cancel setup?'],'Configuration Exists','Overwrite','Rename','Cancel','Cancel');

    switch choice
      case 'Overwrite'
        distcomp.configuration.deleteConfig(confName);

      case 'Rename'
        while tmpconf.Name == confName
          try
            nm = input('\nEnter name to be used for old configuration: ','s');
            tmpconf.Name = nm;
            tmpconf.save();
            tmpconf = distcomp.configuration(confName);
            fprintf('Configuration %s renamed to %s.\n',confName,tmpconf.Name);
          catch
          end
        end

      case 'Cancel'
        disp('Configuration setup cancelled.');
        return;
    end
  catch
  end
  
  %Get a scheduler
  sched = findResource('scheduler', 'type', 'generic');
  %Add the scheduler parameters
  set(sched, 'ClusterMatlabRoot', mlpath);
  set(sched, 'ClusterOsType', sysOS);
  set(sched,'ClusterSize',maxworkers);
  set(sched, 'DataLocation', dataloc);
  set(sched, 'HasSharedFilesystem', false);
  % The SubmitFcn must be a MATLAB cell array that includes the two additional inputs
  set(sched, 'SubmitFcn', {@distributedSubmitFcn, sys, sysdir});
  % If you want to run parallel jobs (including matlabpool), you must specify a ParallelSubmitFcn
  set(sched, 'ParallelSubmitFcn', {@parallelSubmitFcn, sys, sysdir});
  set(sched, 'GetJobStateFcn', @getJobStateFcn);
  set(sched, 'DestroyJobFcn', @destroyJobFcn);

  %Create the configuration from the scheduler
  tmpconf = distcomp.configuration.createNewFromScheduler(sched);
  conf = distcomp.configuration(tmpconf);

  %Add the parallel jobs info
  pj = struct('MinimumNumberOfWorkers',8,'MaximumNumberOfWorkers',16);
  conf.paralleljob.setFromEnabledStruct(pj);
  
  %Rename it and add a description
  conf.Name = confName;
  conf.Description = ['Configuration for ' v ' on ' sysname];
  conf.save();
  fprintf('\nCreated configuration %s.\n',confName);

  fcn = 'parallelSubmitFcn'; %Function name to test if support files are in the right place
end
  
%Give them a warning if we have reason to think that their support files
%have not been put in the right place.
if strcmp(which(fcn),'')
  fprintf('\nWarning: %s not found in the Matlab path. Please make \nsure that the support files for remote submission have been copied into: \n%s\n',fcn,fullfile(matlabroot,'toolbox','local'));
end
