clear;
clc;


# Метод разности прогонки
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

tau = 0.01;
n = (b-a)/tau + 1;
x = a:tau:b;

u = @(x) x + log(x);

function [a, b, c] = vec_coef(x, h, p, q)
  a = zeros(1, size(x)(2) - 1);
  b = zeros(1, size(x)(2) - 1);
  c = zeros(1, size(x)(2) - 1);
  for k = 1:size(x)(2) - 1
    a(k) = 1 + p(x(k)) * h / 2;
    b(k) = -(2 + h^2 * q(x(k)));
    c(k) = 1 - p(x(k)) * h / 2;
  endfor
endfunction

function y = t(x, h)
  y = f(x) * h^2;
endfunction

[a, b, c] = vec_coef(x, tau, @p, @q);

alpha01 = alpha0 - betta0 / tau
alpha02 = -betta1 / tau
gamma01 = gamma0
betta01 = betta0 / tau
betta02 = alpha1 + betta1 / tau
gamma02 = gamma1

  
X = -betta01 / alpha01;
Z = gamma01 / alpha01;
y = zeros(n, 1);


for k = 2:n
  X(k) = -a(k - 1)/(b(k - 1) + c(k - 1) * X(k - 1));
  Z(k) = (t(x(k - 1), tau) - c(k - 1) * Z(k - 1)) / (b(k - 1) + c(k - 1) * X(k - 1));
endfor

y(end) = (gamma02 - alpha02 * Z(end)) / (betta02 + alpha02 * X(end));

for k = 1:n - 1
  y(n - k) = X(n - k + 1) * y(n - k + 1) + Z(n - k + 1);
endfor  

#X = zeros(n, 1);
#Z = zeros(n, 1);
#X(end) = -alpha02/betta02;
#Z(end) = gamma02/betta02;
#for k = 1:n - 1
#  X(n - k) = -c(n - k) / (b(n - k) + c(n - k) * X(n - k + 1));
#  Z(n - k) = (t(x(n - k + 1), tau) - a(n - k) * Z(n - k + 1)) / (b(n - k) + a(n - k) * X(n - k + 1)); 
#endfor

#y = (gamma01 - betta01 * Z(1)) / (alpha01 + betta01 * X(1));
#for k = 1:n - 1
#  y(k + 1) = X(k) * y(k) + Z(k)
#endfor


fplot(u, [min(x), max(x)]);
hold on;
scatter(x, y, 10, "filled");
legend("Exact solution", "Run Difference Method");

  
  
  
  
  
  
