clear;
clc;

# Метод Рунге-Кутта для систем
# 4 variant

k = 4;
alp = 1 + 0.2 * k;

f1 = @(t, u1, u2) -2 * alp * t * u1 .** 2 + u2 .** 2 - t .** 2 - 1;
f2 = @(t, u1, u2) 1 / (alp * u2 .** 2) - u1 - t / u2;

tau = 0.1;
t0 = 0;
tn = 0.5;
t = [t0];
u1 = [1 / alp];
u2 = [1];

U = [u1; u2];
n = (tn - t0) / tau;

F = @(t, U) [f1(t, U(1), U(2)); f2(t, U(1), U(2))];

for k = 1:n
  t(k + 1) = t0 + k * tau;
  K1 = tau * F(t(k), U(:, k), alp);
  K2 = tau * F(t(k) + tau / 2, U(:, k) + K1/2);
  K3 = tau * F(t(k) + tau / 2, U(:, k) + K2/2);
  K4 = tau * F(t(k) + tau, U(:, k) + K3);
  U(:, k + 1) = U(:, k) + (K1 + 2 * K2 + 2 * K3 + K4) / 6;
endfor

t
U
ode45 (F, [t0, tn], [u1, u2])
hold on;
scatter(t, U(1, :), "r", "filled");
hold on;
scatter(t, U(2, :), "b", "filled");