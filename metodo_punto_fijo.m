clc; clear all; close all;

% Definición de la función g(x)
g = @(x) exp(-x);

% Parámetros del método
tolerancia = 1e-6;
x0 = 0; % Valor inicial
max_iter = 1000; % Número máximo de iteraciones
iter = 0; % Contador de iteraciones
error = inf; % Inicializar el error

% Método de punto fijo
while error > tolerancia && iter < max_iter
    x1 = g(x0); % Calcular el nuevo valor
    error = abs(x1 - x0); % Calcular el error
    x0 = x1; % Actualizar x0
    iter = iter + 1; % Incrementar el contador de iteraciones
end

% Resultados
if error <= tolerancia
    fprintf('La solución es: %.6f\n', x0);
    fprintf('Número de iteraciones: %d\n', iter);
else
    fprintf('No se encontró solución dentro del número máximo de iteraciones.\n');
end