clear;
clc;


# Метод вариации произвольных постоянных
# 4 variant

function y = p(x)
  y = 1/x;
endfunction
function y = q(x)
  y = 0;
endfunction
function y = f(x)
  y = 1/x;
endfunction
function y = f_0(x)
  y = 0;
endfunction

alpha0 = 0; betta0 = 1; gamma0 = 3;
alpha1 = 1; betta1 = 0; gamma1 = 1;

a = 0.5; b = 1;

tau = 0.05;
n = (b-a)/tau + 1;
X = a:tau:b;

u = @(x) x + log(x);

function [x, T, S] = solution(p, q, f, a, b, tau, init_val, n)
  x = a:tau:b;
  T(1) = init_val(1);
  S(1) = init_val(2);
  for k = 1:n - 1
    T(k + 1) = T(k) + tau * S(k);
    S(k + 1) = S(k) + tau * (-p(x(k)) * S(k) + q(x(k)) * T(k) + f(x(k)) );
  endfor
endfunction

init_vals1 = [0 0];
[X_1, T_1, S_1] = solution(@p, @q, @f, a, b, tau, init_vals1, n);

init_vals2 = [0 1];
[X_2, T_2, S_2] = solution(@p, @q, @f_0, a, b, tau, init_vals2, n);

init_vals3 = [1 0];
[X_3, T_3, S_3] = solution(@p, @q, @f_0, a, b, tau, init_vals3, n);

Z = T_1; Z_prim = S_1;
Z1 = T_2; Z1_prim = S_2;
Z2 = T_3; Z2_prim = S_3;

a11 = alpha0 * Z1(1) + betta0 * Z1_prim(1);
a12 = alpha0 * Z2(1) + betta0 * Z2_prim(1);
b1 = gamma0 - alpha0 * Z(1) - betta0 * Z_prim(1);
a21 = alpha1 * Z1(end) + betta1 * Z1_prim(end);
a22 = alpha1 * Z2(end) + betta1 * Z1_prim(end);
b2 = gamma1 - alpha1 * Z(end) - betta1 * Z_prim(end);

C = [a11 a12; a21 a22] \ [b1; b2];

u_method = Z + C(1)*Z1 + C(2)*Z2;
Z1_prim(1)

fplot(u, [min(X), max(X)]);
hold on;
scatter(X, u_method, 10, "filled");
legend("Exact solution", "variable method");
