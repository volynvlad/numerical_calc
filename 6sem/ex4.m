clear;
clc;

# Метод Адамса
# 4 variant

t0 = 0;
tn = 10;
u0 = 1;
lambda = -4;
y = [u0];

b = [55/24, -59/24, 37/24, -9/24];

% stable case
% tau < 1 / 4
# почему то сходится только при tau <= 1/13 -> 0
tau = 1 / 16;
n = round((tn - t0) / tau);

% functions
u = @(lambda, t) exp(lambda * t);
f = @(u, lambda) lambda * u;

t = t0:tau:tn;

err_rk4 = (0);
err_ab = (0);

# Рунге-Кутт 4ого порядка

for k = 1:n
  K1 = tau * f(y(k), lambda);
  K2 = tau * f(y(k) + K1 / 2, lambda);
  K3 = tau * f(y(k) + K2 / 2, lambda);
  K4 = tau * f(y(k) + K3, lambda);
  
  y(k + 1) = y(k) + (K1 + 2 * K2 + 2 * K3 + K4) / 6;
  
  err_rk4(k) = abs(y(k) - u(lambda, t(k)));
end
err_rk4(n + 1) = abs(y(n + 1) - u(lambda, t(n + 1)));

# Adam's method

AB = y(1:4);
for k = 4:n
  AB(k + 1) = AB(k) + tau * ( b(1) * f(AB(k), lambda) + 
                              b(2) * f(AB(k - 1), lambda) + 
                              b(3) * f(AB(k - 2), lambda) + 
                              b(4) * f(AB(k - 3), lambda) );

  err_ab(k) = abs(AB(k) - u(lambda, t(k)));  
end
err_ab(n + 1) = abs(AB(n + 1) - u(lambda, t(n + 1)));

# 1.three plots

# accurate function
#plot(t, u(lambda, t));
#hold on;
#title("exp(-4t)");
#scatter(t, y, 50, "r");
#hold on;
#scatter(t, AB, 10, "filled");
#legend({"exp(-4t)", "RK 4th degree", "Adam's method"});

# 2.errors

#semilogy(t, err_rk4);
#hold on;
#semilogy(t, err_ab);
#legend({"error RK 4th degree", "error Adam's method"});

# 3.unstable case

tau = 1 / 2;
t = t0:tau:tn;
n = round((tn - t0) / tau);

AB = y(1:4);
for k = 4:n
  AB(k + 1) = AB(k) + tau * ( b(1) * f(AB(k), lambda) + 
                              b(2) * f(AB(k - 1), lambda) + 
                              b(3) * f(AB(k - 2), lambda) + 
                              b(4) * f(AB(k - 3), lambda) );
end
#scatter(t, AB, 10, "filled");