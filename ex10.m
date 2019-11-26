clear;
clc;

eps = 10 ** (-6);

# variant 7

f1 = @(x,y) y - 0.5 * x ** 2 + x - 0.5;
f2 = @(x,y) 2 * x + y - (1 / 6) * y ** 3 - 1.6;
t = -10:0.1:10;
[X,Y] = ndgrid(t, t);

F1 = f1(X, Y);
F2 = f2(X, Y);

contour(X, Y, F1, [0 0])
hold on
contour(X, Y, F2, [0 0])
hold on

f1_prim_x = @(x, y) -x + 1;
f1_prim_y = @(x, y) 1;
f2_prim_x = @(x, y) 2;
f2_prim_y = @(x, y) 1 - (y ** 2) / 2;

J = @(x, y) [f1_prim_x(x, y), f1_prim_y(x, y); f2_prim_x(x, y), f2_prim_y(x, y)];
F = @(x, y) [f1(x, y); f2(x, y)];
A = @(x, y) [f1(x, y), f1_prim_y(x, y); f2(x, y), f2_prim_y(x, y)];
B = @(x, y) [f1_prim_x(x, y), f1(x, y); f2_prim_x(x, y), f2(x, y)];

x0 = [3 1];

det_A = f1_prim_x(x0(1), x0(2)) * f2_prim_y(x0(1), x0(2)) 
      - f2_prim_x(x0(1), x0(2)) * f1_prim_y(x0(1), x0(2));

alpha = - f2_prim_y(x0(1), x0(2)) / det_A
betta =   f1_prim_y(x0(1), x0(2)) / det_A
gamma =   f2_prim_x(x0(1), x0(2)) / det_A
delta = - f1_prim_x(x0(1), x0(2)) / det_A

phi1 = @(x,y) x + alpha * f1(x, y) + betta * f2(x, y);
phi2 = @(x,y) y + gamma * f1(x, y) + delta * f2(x, y);

x = x0;
err = 1;
k = 1;
errs = [];
while err > eps
    x_prev = x;
    disp(x);
    #x = x_prev - F(x_prev(1), x_prev(2)) / det(J(x_prev(1), x_prev(2)));
    x(1) = x_prev(1) - det(A(x_prev(1), x_prev(2))) / det(J(x_prev(1), x_prev(2)));
    x(2) = x_prev(2) - det(B(x_prev(1), x_prev(2))) / det(J(x_prev(1), x_prev(2)));
    err = norm(x_prev - x);
    errs(1, k) = k;
    errs(2, k) = err;
    k = k + 1;
end
display(k);
display(x);
plot(x(1), x(2), '.', 'MarkerSize', 25);
#plot(errs(1, :), errs(2, :));
#semilogy(errs(1, :), errs(2, :));


  