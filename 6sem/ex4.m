clear;
clc;

# Метод Адамса
# 4 variant

t0 = 0;
tn = 10;
t = t0:0.1:tn;
u0 = 1;

lambda = -4;
% stable case
% tau < 1 / 4
tau = 1 / 8;

plot(t, exp(lambda * t),";exp(-4t);");
title("exp(-4t)");
h = legend("show");