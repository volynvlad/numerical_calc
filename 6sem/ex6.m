clear;
clc;


# Метод пристрелки
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

# betta0 != 0
t0 = 0; t1 = 1;
init_val1 = [t0 (gamma0 - alpha0 * t0) / betta0];
init_val2 = [t1 (gamma0 - alpha0 * t1) / betta0];

[X_1, T_1, S_1] = solution(@p, @q, @f, a, b, tau, init_val1, n);
[X_2, T_2, S_2] = solution(@p, @q, @f, a, b, tau, init_val2, n);

C = ((gamma1 - alpha1 * T_1(end) - betta1 * S_1(end)) / 
      alpha1 * (T_2(end) - T_1(end)) + betta1 * (S_2(end) - S_1(end)));

u_method = (1 - C) * T_1 + C * T_2;

fplot(u, [min(X), max(X)]);
hold on;
scatter(X, u_method, 10, "filled");
legend("Exact solution", "variable method");

