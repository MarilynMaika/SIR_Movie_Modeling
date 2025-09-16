% Description:
%   Models how a TV show's popularity spreads through word-of-mouth
%   using the SIR epidemiological framework.

% Parameters
a = 0.4;        % Contact rate (per person per day)
b = 0.1;        % Recovery rate (per day)
N = 5000;       % Total potential viewers

% Initial conditions: [Susceptible; Infected; Recovered]
S0 = 4990;      % People who haven't watched
I0 = 10;        % Currently watching and recommending
R0 = 0;         % Finished watching, no longer promoting

% Define SIR model differential equations
dXdt = @(t,X) [
    -a * X(1) * X(2) / N;            % dS/dt
     a * X(1) * X(2) / N - b*X(2);   % dI/dt
     b * X(2)                        % dR/dt
];

% Solve the system over 100 days
[t, X] = ode45(dXdt, [0 100], [S0; I0; R0]);

% Plotting
figure;
plot(t, X(:,1), 'b', 'LineWidth', 1.5); hold on;  % Susceptible
plot(t, X(:,2), 'r', 'LineWidth', 1.5);           % Infected
plot(t, X(:,3), 'g', 'LineWidth', 1.5);           % Recovered

xlabel('Time (days)');
ylabel('Number of Viewers');
legend('Susceptible', 'Infected', 'Recovered');
title('SIR Model of TV Show Viewership Spread');
grid on;
