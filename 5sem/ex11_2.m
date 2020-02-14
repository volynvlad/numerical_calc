clear;
clc;

% 2.2 variant7
f = @(x, alpha) x .** 3 - 2.5 * x .** 2 -x + 2 * alpha;

alphas = [0:0.05:1];

for alpha = alphas
  g = @(x) f(x, alpha);
  fplot(g, [-4, 4]);
  hold on
endfor
plot([-4:0.01:4], 0);
hold on 

intervals = [-1 -0.2; -0.2 2; 2 5];

eps = 10**(-3);
start = -5;
stop = 5;
step = 2;

for alpha = alphas
  for inter = intervals
    x = [];
    i = 1;
    a = inter(1);
    b = inter(2);
    while b - a > eps
      if f(a, alpha) == 0
        x(i) = a;
        i += 1;
      elseif f(b, alpha) == 0
        x(i) = b;
        i += 1;
      endif
      mid = (a + b) / 2;
      if f(a, alpha) * f(mid, alpha) < 0
        b = mid;
      elseif f(mid, alpha) * f(b, alpha) < 0
        a = mid;
      endif
      x = mid;
    endwhile
    alpha
    x
    plot(x);
    hold on
  endfor
endfor
  
    

