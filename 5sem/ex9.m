clear;
clc;

eps = 10 ** (-6);

# variant 7

f1 = @(x,y) y - 0.5 * x .** 2 + x - 0.5;
f2 = @(x,y) 2 * x + y - (1 / 6) * y .** 3 - 1.6;
X = -5:0.1:5;
Y = X;
[X,Y] = meshgrid(X,Y);
#f1(X,Y)

contour(X, Y, f1(X,Y), [0,0])
hold on
contour(X, Y, f2(X,Y), [0,0])
hold on
x0 = [-1 3];
f1_prim_x = @(x, y) -x + 1;
f1_prim_y = @(x, y) 1;
f2_prim_x = @(x, y) 2;
f2_prim_y = @(x, y) 1 - (1 / 2) * y ** 2;

det_A = f1_prim_x(x0(1), x0(2)) * f2_prim_y(x0(1), x0(2)) 
      - f2_prim_x(x0(1), x0(2)) * f1_prim_y(x0(1), x0(2));

alpha = - f2_prim_y(x0(1), x0(2)) / det_A
betta =   f1_prim_y(x0(1), x0(2)) / det_A
gamma =   f2_prim_x(x0(1), x0(2)) / det_A
delta = - f1_prim_x(x0(1), x0(2)) / det_A

phi1 = @(x,y) x + alpha * f1(x, y) + betta * f2(x, y);
phi2 = @(x,y) y + gamma * f1(x, y) + delta * f2(x, y);

x = x0;

k = 1;
errs = [];
err = 1;
while err > eps
    x_prev = x;
    x(1) = phi1(x(1), x(2));
    x(2) = phi2(x(1), x(2));
    err = norm(x_prev - x);
    plot(x(1), x(2), '.', 'MarkerSize', 25);
    hold on
    errs(1,k) = k;
    errs(2,k) = err;
    k = k + 1;
end
display(k);
display(x);
plot(errs(1, :), errs(2, :));
hold on
#semilogy(errs(1, :), errs(2, :));


  