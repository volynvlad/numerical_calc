function [x, d] = Gauss (A,f)
    d = 1;
    [n, m] = size(A);
    x = zeros(n, 1);
    A(:, m + 1) = f';
    for k = 1:n
        d = d * A(k, k);
        A(k, :) = A(k, :) / A(k, k); 
        for j = k + 1:m
            A(j, :) = A(j, :) - A(j, k) * A(k, :);
        endfor
    endfor
    f = A(:, m + 1);
    x(n) = f(n);
    for i = n-1:-1:1
        x(i) = f(i) - A(i,i + 1:end - 1) * x(i+1:end);
    endfor
endfunction