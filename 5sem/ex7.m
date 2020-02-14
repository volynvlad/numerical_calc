clear;
clc;

n = 10;
v = 9;
eps = 10**(-9);

function[prod] = notDiagProd(A, n)
	A = A - diag(diag(A), 0);
	prod = 0;
	for i = 1:n
		for j = 1:n
			prod = prod + A(i, j)**2;
		endfor
	endfor
endfunction

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

copy_A = A;

display(A);

while(notDiagProd(A, n) > eps)
	for k = 1:n
		for m = 1:n
			if(k != m)
				T = eye(n);
				w = (2 * A(k, m)) / (A(k, k) - A(m, m));
				s = sign(w) * sqrt((sqrt(1 + w**2) - 1) / (2 * sqrt(1 + w**2)));
				c = sqrt((sqrt(1 + w**2) + 1) / (2 * sqrt(1 + w**2)));
				T(k, k) = c;
				T(m, m) = c;
				T(m, k) = s;
				T(k, m) = -s;
				A = T' * A * T;
			endif
		endfor
	endfor
endwhile

display(A);
diags = diag(A);
display(diags);
display(eigs(copy_A, n));
