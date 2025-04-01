function [raiz, iter, error] = muller(f, x0, x1, x2, tol, max_iter)
    % Método de Müller para encontrar raíces de ecuaciones no lineales
    % 
    % Inputs:
    %   f - función a evaluar (como function handle, ej. @(x) x^2 - 2)
    %   x0, x1, x2 - tres puntos iniciales
    %   tol - tolerancia para el criterio de parada
    %   max_iter - número máximo de iteraciones permitidas
    %
    % Outputs:
    %   raiz - aproximación de la raíz encontrada
    %   iter - número de iteraciones realizadas
    %   error - error final de la aproximación
    
    % Inicialización
    iter = 0;
    error = inf;
    h1 = x1 - x0;
    h2 = x2 - x1;
    delta1 = (f(x1) - f(x0)) / h1;
    delta2 = (f(x2) - f(x1)) / h2;
    d = (delta2 - delta1) / (h2 + h1);
    
    fprintf('Iter\t x0\t\t x1\t\t x2\t\t Raiz\t\t Error\n');
    fprintf('------------------------------------------------------------\n');
    
    while error > tol && iter < max_iter
        iter = iter + 1;
        
        % Coeficientes de la parábola
        b = delta2 + h2*d;
        D = sqrt(b^2 - 4*f(x2)*d);
        
        % Elegir el denominador más grande para mayor estabilidad
        if abs(b - D) < abs(b + D)
            E = b + D;
        else
            E = b - D;
        end
        
        % Calcular el incremento
        h = -2*f(x2)/E;
        p = x2 + h;
        
        % Calcular el error
        if iter > 1
            error = abs(h);
        end
        
        % Mostrar información de la iteración
        fprintf('%d\t %f\t %f\t %f\t %f\t %f\n', iter, x0, x1, x2, p, error);
        
        % Actualizar puntos para la siguiente iteración
        x0 = x1;
        x1 = x2;
        x2 = p;
        
        % Recalcular coeficientes
        h1 = x1 - x0;
        h2 = x2 - x1;
        delta1 = (f(x1) - f(x0)) / h1;
        delta2 = (f(x2) - f(x1)) / h2;
        d = (delta2 - delta1) / (h2 + h1);
    end
    
    raiz = x2;
    
    if iter == max_iter && error > tol
        warning('Se alcanzó el número máximo de iteraciones sin converger.');
    end
end

% Definir la función
f = @(x) x^3 - 13*x - 12;

% Parámetros iniciales
x0 = 4.5;
x1 = 5.5;
x2 = 5;
tolerancia = 1e-6;
max_iteraciones = 100;

% Llamar al método de Müller
[raiz, iteraciones, error_final] = muller(f, x0, x1, x2, tolerancia, max_iteraciones);

% Mostrar resultados
fprintf('\nResultado final:\n');
fprintf('Raíz aproximada: %.8f\n', raiz);
fprintf('Iteraciones: %d\n', iteraciones);
fprintf('Error final: %.2e\n', error_final);