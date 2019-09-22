clear;
clc;

n = 5;
A = zeros(n, n);
f = zeros(n, 1);
eye_mat = eye(n);

res = zeros(n, n);

for i = 1:n
    f(i) = i;
    for j = 1:n
        if (i == j)
            A(i, j) = n / (i * i + j - 1);
        else
            A(i, j) = n / (i + j + 1);
        endif
    endfor
endfor
[x, d] = Gauss(A, f);
x
A \ f
d
det(A)  
for i = 1:n
    [res(:, i), _] = Gauss(A, eye_mat(:, i));
endfor
res
inv(A)
