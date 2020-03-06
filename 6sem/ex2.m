clear;
clc;

# Метод Рунге-Кутта
# 4 variant

f = @(x, u) x + 3 * u ./ x;
u = @(x) x .** 3 - x .** 2;
u0 = 0;
x0 = 1;
X = 2;

u_prim = @(x) 3 * x .** 2 - 2 * x;

n = 20;
h = (X - x0) / n;

x = [x0];
y = [u0];

for k = 1:n
  x(k + 1) = x0 + k * h;
  K1 = h * f(x(k), y(k));
  K2 = h * f(x(k) + h / 2, y(k) + K1/2);
  K3 = h * f(x(k) + h / 2, y(k) + K2/2);
  K4 = h * f(x(k) + h, y(k) + K3);
  y(k + 1) = y(k) + (K1 + 2 * K2 + 2 * K3 + K4) / 6;
endfor

  
fplot(u, [1, max(x)]);
hold on;
scatter(x, y, 10, "filled");