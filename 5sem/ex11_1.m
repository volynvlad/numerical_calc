clear;
clc;

eps = 10**(-6);

% 2.1 variant7
find_variable = e**pi;
f = @(x) sin(log(x));

a = 20;
b = 25;

fplot(f, [a, b]);
hold on
plot([a:0.01:b], 0);
hold on

while b - a > eps
  mid = (a + b) / 2;
  if f(a) * f(mid) < 0
    b = mid;
  elseif f(mid) * f(b) < 0
    a = mid;
  endif
  x = mid;
endwhile
x
e ** pi
abs(x - e ** pi)