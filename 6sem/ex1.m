clear;
clc;

# 4 variant

f = @(x, u) x + 3 * u ./ x;
u = @(x) x .** 3 - x .** 2;
u_prim = @(x) 3 * x .** 2 - 2 * x;

u0 = 0;
x0 = 1;
X = 2;


n = 20;
h = (X - x0) / n;

x = [x0];
y = [u0];

for k = 1:n
  x(k + 1) = x0 + k * h;
  y(k + 1) = y(k) + h * f(x(k), y(k));
endfor

#fplot(u, [x0, max(x)]);
#hold on;
#scatter(x, y, 10, "filled");

lambda = -4;
# h < 2 / 4 = 1/2;
u0 = 1;
h = 2 / 3;

y = [u0];

for k = 1:n
  x(k + 1) = x0 + k * h;
  y(k + 1) = (1 - h * abs(lambda)) ** (k + 1) * u0;
endfor

fplot(u, [0, max(x)]);
hold on;
scatter(x, y, 10, "filled");

