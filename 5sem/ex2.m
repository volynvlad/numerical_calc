clear;
clc;

a = randi([-10,10]);
b = a + randi([3, 10]);
v = 4;

n_list = [4, 6, 8, 10, 12];
nev = zeros(size(n_list)(2));

for z = 1:size(n_list)(2)
    n = n_list(z);
    A = zeros(n);
    f = zeros(n, 1);
    for i = 1:n
        f(i) = a + (b - a) * rand;
        for j = 1:n
            if (i == j)
                A(i, j) = 1 / (i + j + v);
            endif
        endfor
    endfor
    
    x = SquareRoot(A, f)
    A \ f
    
    nev(z) = norm(f - A * x) / norm(f);
    
endfor
Plot(nev, n_list)
