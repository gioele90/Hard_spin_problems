function [ out ] = random_walk_loop_4( adj )
    % Given an adjacency matrix - defining the tri-coupled nodes
    % Perform a random walk until one creates a loop
    % Cut the tail and return the loop sequence

    % Number of nodes
    num_nodes = length(adj);
    adj_size=size(adj);
    
    % Until loop is found
    loop_found = false;
    while(~loop_found)
        
        % Pick random starting 4-coupling (quad)
        node_perm = randperm(num_nodes);
        adj_w = node_perm(1);
        indices = find(squeeze(adj(adj_w,:,:,:)));
        [adj_x,adj_y,adj_z]=ind2sub(adj_size,indices);
        rand_ind = randi(length(adj_x));
        adj_x = adj_x(rand_ind);
        adj_y = adj_y(rand_ind);
        adj_z = adj_z(rand_ind);
        
        % Set the starting quad of the loop
        loop_start = sort([adj_w,adj_x,adj_y,adj_z]);
        % Initialise loop sequence starting at loop_start
        loop_seq = {loop_start};
        % Initialise previous 4-coupling to 0's array
        prev_quad = [0,0,0,0];
        
        % Until loop is found
        while(~loop_found)            
            % Find adjacent 4-couplings (2D array)
            current_quad = loop_seq{end};
            %   Pick two random dimensions of current tri
            chosen_dims = randperm(4);
            %   Select random column with two common nodes
%             selected_points = adj(:,:,current_quad(chosen_dims(1)),current_quad(chosen_dims(2)));
%             %   Find all 1's in selected column
%             adj_quad = find(selected_points);
%             [adj_quadx,adj_quady]=ind2sub([adj_size(1),adj_size(2)],adj_quad);
%             % Remove previous tri-coupling from adjacent tri-couplings
%             temp_adj_quad = [];
%             for i = 1:length(adj_quadx)
%                 % Index to co-ord
%                 potential_quad = [ current_quad(chosen_dims(1)), current_quad(chosen_dims(2)), adj_quadx(i), adj_quady(i) ];
%                 % Is this equal to the previous node (modulo some permutations)
%                 if ~isequal( sort(potential_quad), sort(prev_quad) ) && ~isequal( sort(potential_quad), sort(current_quad) )
%                     temp_adj_quad = [temp_adj_quad; potential_quad];
%                 end
%             end
            selected_points = adj(:,current_quad(chosen_dims(1)),current_quad(chosen_dims(2)),current_quad(chosen_dims(3)));
            %   Find all 1's in selected column
            adj_quad = find(selected_points);
            % Remove previous tri-coupling from adjacent tri-couplings
            temp_adj_quad = [];
            for i = 1:length(adj_quad)
                % Index to co-ord
                potential_quad = [ current_quad(chosen_dims(1)), current_quad(chosen_dims(2)), current_quad(chosen_dims(3)), adj_quad(i) ];
                % Is this equal to the previous node (modulo some permutations)
                if ~isequal( sort(potential_quad), sort(prev_quad) ) && ~isequal( sort(potential_quad), sort(current_quad) )
                    temp_adj_quad = [temp_adj_quad; potential_quad];
                end
            end
            % Update adjacent tris to exclude previous tri, and be in
            % co-ordinate form
            adj_quad = temp_adj_quad;
            
            % If no valid adjacent tris, then abort and start over
            if isempty(adj_quad)
                break; 
            end
            
            % Pick random adjacent tri
            next_quad = adj_quad(randi(length(adj_quad(:,1))),:);
            % Set previous tri
            prev_quad = loop_seq{end};
            % Add to loop sequence
            loop_seq = [loop_seq, sort(next_quad)];
            
            % If loop_seq{end} exists in loop_sequence, then loop found
            for i = 1: length(loop_seq)-1
                if isequal(loop_seq{i}, loop_seq{end})
                    % Set loop_found flag to true
                    loop_found = true;

                    % Cut tail off sequence
                    loop_seq = loop_seq(i:end);
                    break;
                end
            end
        end 
    end    
    
    % Return loop sequence
    out = loop_seq;
end

