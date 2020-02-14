clear;
clc;

n = 7; N = n**2;
eps = 1.e-3;
A = gallery('poisson', n);
E = eye(size(A));
f = rand(N, 1);
numb = 1000;

function [Err] = commom_method(B, A, f)
    numb = 1000;
    inv_B = inv(B);
    D = inv_B * A;
    g = inv_B * f;
    x = zeros(size(D)(1), 1);
    r = D * x - g;
    err = norm(r) / norm(g);
    k = 0;
    Err = zeros(numb, 1);

    while err > eps && k < numb
        tau = (r' * r) / (( A * r)' * r);
        x = x - tau * r;
        r = D * x - g;
        err = norm(r) / norm(g);
        k = k + 1;
        Err(k) = err;
    endwhile 
endfunction


% method yakobi
B = diag(diag(A));
err_yakobi = commom_method(B, A, f);

% method zeidelya
B = triu(A);
err_zeidelya = commom_method(B, A, f);

% triag method

R1 = triu(A) - diag(diag(A)) / 2;
R2 = tril(A) - diag(diag(A)) / 2;
B = (E + R1 / 2) * (E + R2 / 2);
err_triag = commom_method(B, A, f);

x = zeros(numb ,1);
for i = 1:numb
    x(i) = i;
endfor
size(err_yakobi);
size(err_zeidelya);
size(err_triag);
plot(x, err_yakobi, x, err_zeidelya, x, err_triag);
legend ("Jacoby", "Zeidel", "triag");
