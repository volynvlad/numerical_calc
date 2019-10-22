clear;
clc;

delt = 10**(-6);

a = randi([-10,10]);
b = a + randi([3, 10]);

v = 4;
n = 10;
A = zeros(n);
f = zeros(n ,1);
  
for i = 1:n
    f(i) = a + (b - a) * rand;
    for j = 1:n
        if i == j
            A(i, j) = 100 + v;
        else 
            A(i, j) = 1 / (i + j + v);
        endif
    endfor
endfor
n = 7; N = n**2;
eps = 1.e-3;
A = gallery('poisson', n);
err = zeros(1, 3);
n = N;
for i = 1:n
    f(i) = a + (b - a) * rand;
end
B = diag(diag(A));
% 1 | D =  A;
x = zeros(n, 1);
r = f - A * x;
for i = 1:n
    w(i,1) = r(i,1) / B(i,i);
endfor
t = dot(w, r) / dot(A * w, w);
x = x + t * w;
k = 1;
err(1, k) = norm(r) / norm(t);
while norm(r) / norm(t) >= delt    
    k = k + 1;
    r = f - A * x;
    for i = 1:n
        w(i,1) = r(i,1) / B(i,i);
    endfor
    t = dot(w, r) / dot(A * w, w);
    x = x + t * w;
    err(1, k) = norm(r) / norm(t);
endwhile
 
% 2 | D = A' * A;
x = zeros(n, 1);

r = f - A * x;
for i = 1:n
    w(i,1) = r(i,1) / B(i,i);
endfor
t = dot(w, r) / dot(A * w, w);
x = x + t * w;
k = 1;
err(2, k) = norm(r) / norm(t);
while norm(r) / norm(t) >= delt    
    k = k + 1;
    r = f - A * x;
    for i = 1:n
        w(i,1) = r(i,1) / B(i,i);
    endfor
    t = dot(A * w, r) / dot(A * w, A * w);
    x = x + t * w;
    err(2, k) = norm(r) / norm(t);
endwhile

% 3 | D = A' * inv(B) * A;
x = zeros(n, 1);

r = f - A * x;
for i = 1:n
    w(i,1) = r(i,1) / B(i,i);
endfor
t = dot(w, r) / dot(A * w, w);
x = x + t * w;
k = 1;
err(3, k) = norm(r) / norm(t);
while norm(r) / norm(t) >= delt    
    k = k + 1;
    r = f - A * x;
    for i = 1:n
        w(i,1) = r(i,1) / B(i,i);
    endfor
    t = dot(A * w, w) / dot(inv(B) * A * w, A * w);
    x = x + t * w;
    err(3, k) = norm(r) / norm(t);
endwhile

x = zeros(size(err)(2) ,1);
for i = 1:size(x)
    x(i) = i;
endfor
err
plot(x, err(1, :), x, err(2, :), x, err(3, :));