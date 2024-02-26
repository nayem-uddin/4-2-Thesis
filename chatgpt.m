% PSO Script
clc;clear all;close all;
% PSO parameters
numParticles = 50;
maxIterations = 100;
inertiaWeight = 0.9;
accelerationCoefficient1 = 2.0;
accelerationCoefficient2 = 2.0;

% Search space for PID parameters [Kp, Ki, Kd]
searchSpace = [0 0 0; 2 2 2];

% Initialize particles
particles = rand(numParticles, 3) .* (searchSpace(2, :) - searchSpace(1, :)) + searchSpace(1, :);
velocities = rand(numParticles, 3) .* (searchSpace(2, :) - searchSpace(1, :)) / 2;

% PSO loop
for iteration = 1:maxIterations
    % Evaluate fitness
    fitness = arrayfun(@pidObjectiveFunction, particles);

    % Update personal best positions
    personalBest = particles;
    personalBestFitness = fitness;

    % Update global best position
    [globalBestFitness, globalBestIndex] = min(fitness);
    globalBest = particles(globalBestIndex, :);

    % Update velocities and positions
    velocities = inertiaWeight * velocities + ...
        accelerationCoefficient1 * rand(numParticles, 3) .* (personalBest - particles) + ...
        accelerationCoefficient2 * rand(numParticles, 3) .* (repmat(globalBest, numParticles, 1) - particles);

    particles = particles + velocities;

    % Clip particles to the search space
    particles = max(particles, searchSpace(1, :));
    particles = min(particles, searchSpace(2, :));
end

% Extract optimized PID parameters
optimalParameters = globalBest;

% Simulink Block (Objective Function)
function cost = pidObjectiveFunction(K)
    % Simulate your system and evaluate the performance
    assignin('base','kk',K);
    oo=sim('testpso.slx');
    % The output 'cost' should represent the performance metric to be minimized
    % ...
    cost=sum(oo.vel);
end

% Integrate PSO with Simulink (e.g., in a MATLAB Function block)
function optimizedParameters = integratePSOwithSimulink()
    % Call the PSO script to obtain optimized parameters
    % ...

    % Use the optimized parameters to set PID controller in the Simulink model
    % ...

    % Simulate the model and evaluate the performance
    % ...

    % Return the optimized parameters
    optimizedParameters = optimalParameters;
end
