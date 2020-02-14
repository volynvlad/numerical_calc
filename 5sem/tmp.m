clear;
clc;

a = -5;
b = 5;
v = 6;
for p = [2:1:8]
  f = @(u) u * v - (u .^ p) / p;
  #f = @(u) v - u.^2;
  fplot(f, [a, b]);
  hold on  
endfor
