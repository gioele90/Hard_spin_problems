function[ solution ] = matrix_row_distribution( matrix, rank , order )

matrix_dimensions = size(matrix);
no_qubits = matrix_dimensions(1);
no_couplers = matrix_dimensions(2);


%First create an array of the sums of the rows of the matricies.
row_sum_array = zeros([1 no_qubits]);

%Some elements seem to go missing at some point int the code.

% Maybe alter so that multiple values can be changed in on iteraction.
for k =1:no_qubits
    for i =1:no_qubits
        row_sum_array(i) = sum( matrix(i, : ));
    end
    if row_sum_array(k) > rank
        % First find rows with more non-zero elements than required.
        non_zeros = find(matrix(k,:));          %finds the indices of elements with non-zero values. 
        column_index = datasample(non_zeros,1); %randomly selects one.
        
        % Now find rows with fewer than required non-zero elements.
        logic_array = ( row_sum_array < rank );         %Find rows with rank too small.
        indices_array = find(logic_array);              %Find the indices of these non-zero elements.
        row_index = datasample(indices_array, 1);       %Choose one of the rows at random.
        
        if matrix(row_index, column_index ) == 0;           
            matrix(row_index, column_index ) = 1;
            matrix(k, column_index) = 0;                %If not already one, set to be one. Otherwise retart loop.
        else
            k = k-1;  %Restart from value before.
        end
    end
end

solution = matrix;
end