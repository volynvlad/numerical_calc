clear;
clc;


# Метод сеток решения смешанной задачи
# для уравнения теплопроводности. Явная схема.
# 4 variant

h = 0.1;
k = 4;
tau = 0.005;
a = k / 2;

X = [-15:h:150];
T = [-50:tau:50];

M = size(X)(2);
N = size(T)(2);

gamma0 = @(t) -t ** 2;
gamma1 = @(t) a * t;

ksi = @(x) x + x ** 2;

U = [];

for i = 1:N
    U(1, i) = gamma0(T(i));
    U(M, i) = gamma1(T(i));
end

for i = 1:M
    U(i, 1) = ksi(X(i));
end

for n = 1:N - 1
    for m = 2:M - 1
       U(m, n + 1) = U(m, n) + 2 * tau * (X(m) ** 2 - 2 * T(n)) + tau * (U(m + 1, n) - 2 * U(m, n) + U(m - 1, n)) / (h * h);
    end
end
U

[TT, XX] = meshgrid(T, X);

mesh(XX, TT, U);