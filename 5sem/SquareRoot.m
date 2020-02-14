function [x] = SquareRoot(A, f)
    S = zeros(size(A));
    D = zeros(size(A));
    n = size(A)(1);
    x = zeros(n, 1);
    y = zeros(n, 1);

    D(1, 1) = sign(A(1, 1));
    S(1, 1) = sqrt(A(1, 1));
    for i = 2:n
        D(i, i) = sign(A(i, i) - 
        sum((S(1:i - 1, i).^2)' * D(1:i - 1, 1:i - 1)));
        S(i, i) = sqrt(abs(A(i, i) - 
        sum((S(1:i - 1, i).^2)' * D(1:i - 1, 1:i - 1)))
        );
        
        for j = i + 1:n
            tmp_sum = 0;
            for k = 1:i - 1
                tmp_sum = tmp_sum + S(k, i) * D(k, k) * S(k, j);
            endfor
            S(i, j) = (A(i, j) - tmp_sum) / (S(i, i) * D(i, i));
        endfor
    endfor
    
    y(1) = f(1) / (S(1, 1) * D(1, 1));
    for i = 2:n
        tmp_sum = 0;
        for j = 1:i - 1
            tmp_sum = tmp_sum + S(j, i) * y(j) * D(j, j);
        endfor
        y(i) = (f(i) - tmp_sum) / (S(i, i) * D(i, i));
    endfor
    
    x(n) = y(n) / S(n, n);
    for i = n - 1:-1:1
        tmp_sum = 0;
        for j = i + 1:n
            tmp_sum = tmp_sum + S(i, j) * x(j);
        endfor    
        x(i) = (y(i) - tmp_sum) / S(i, i);
    endfor
endfunction 