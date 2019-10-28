clear;
clc;

n = 10;
v = 4;

% define matrix A
A = zeros(n);
for i = 1:n
  A(i, i) = v + 10 / (10 + i);
  
  if i <= n - 1
    A(i, i + 1) = v + 10 / i;
    A(i + 1, i) = v + 10 / i;
  endif
  
  if i <= n - 2
    A(i, i + 2) = v + (1 + i) / 10;
    A(i + 2, i) = v + (1 + i) / 10;
  endif
endfor

display(A);

copy_A = A;
S = eye(n);

for i = 1:n - 1
  M = eye(n);
  M_inv = eye(n);
  if A(n - i + 1, n - i) != 0
    for j = 1:n
      if i + j == n
        M(n - i, j) = 1 / A(n - i + 1, n - i);
      elseif
        M(n - i, j) = -A(n - i + 1, j) / A(n - i + 1, n - i);
      endif
      M_inv(n - i, j) = A(n - i + 1, j);
    endfor
  endif
  A = M_inv * A * M;
  S = M * S;
endfor

display(A);


eq = (-1)**n * [1 (-1 * A(1, :))];

eig_values = roots(eq);
display(eig_values);

% display(sum(eig_values));
% display(A(1,1));

y = zeros(n, n);
eig_vectors = zeros(n, n);

for i = 1:n
  for j = 1:n
    y(j, i) = eig_values(i) ** (n - j);
  endfor
  eig_vectors(:, i) = S * y(:, i);
endfor

display(y);

% eig_vectors = S * y;
display(eig_vectors);

% check
display("check");
[vectors, D] = eigs(copy_A, n);
values = diag(D);
display(values);
display(vectors);
