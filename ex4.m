clear;
clc;

n = 7; N = n**2;
eps = 1.e-5;
A = gallery('poisson', n);
E = eye(size(A));
f = rand(N, 1);

function [Err] = commom_method(B, A, f)
    inv_B = inv(B);
    D = inv_B * A;
    g = inv_B * f;
    x = zeros(size(D)(1), 1);
    r = D * x - g;
    err = norm(r) / norm(g);
    k = 0;
    Err = zeros(1000, 1);

    while err > eps && k < 1000
        tau = (r' * r) / (( A * r)' * r);
        x = x - tau * r;
        r = D * x - g;
        err = norm(r) / norm(g);
        k = k + 1;
        Err(k) = err;
    endwhile 
endfunction


% method yakobi
B = zeros(size(A));
for i = 1:size(A)(1)
    B(i, i) = A(i, i);
endfor
err_yakobi = commom_method(B, A, f);

% method zeidelya
B = triu(A);
err_zeidelya = commom_method(B, A, f);

% triag method

diag_A = zeros(size(A));
for i = 1:size(A)(1)
    diag_A(i, i) = A(i, i);
endfor
R1 = triu(A) - diag_A .* eye(size(A)(1)) / 2;
R2 = tril(A) - diag_A .* eye(size(A)(1)) / 2;
B = (E + R1 / 2) * (E + R2 / 2);
err_triag = commom_method(B, A, f);

x = zeros(1000 ,1);
for i = 1:1000
    x(i) = i;
endfor
plot(x, err_yakobi, x, err_zeidelya, x, err_triag);
legend ("Jacoby", "Zeidel", "triag");
