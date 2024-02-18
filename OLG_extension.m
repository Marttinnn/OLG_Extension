clc; clear all; close all;

% Dynare path
addpath c:\dynare\4.5.6\matlab;

% model params
num_age_groups = 4; % age groups
simulation_periods = 40; % sims
population_growth_rate = 0.01; % growth rate

% population
initial_population = [1000, 800, 600, 400];

% params
consumption_per_age_group = zeros(simulation_periods, num_age_groups);
savings_per_age_group = zeros(simulation_periods, num_age_groups);
income_per_age_group = zeros(simulation_periods, num_age_groups); % Fixed variable name num_age_groups

% transition matrix
transition_matrix = [0, 0, 0, 0;
                     1, 0, 0, 0;
                     0, 1, 0, 0;
                     0, 0, 1, 1];

% simulation
for t = 1:simulation_periods
    if t > 1
        population = (transition_matrix * population')' * (1 + population_growth_rate);
    else
        population = initial_population;
    end
    
    % age groups
    for age_group = 1:num_age_groups
        % Simple assumptions about economic behavior
        income_per_age_group(t, age_group) = population(age_group) * 1000 * (1 + 0.02 * age_group);
        consumption_per_age_group(t, age_group) = income_per_age_group(t, age_group) * 0.8;
        savings_per_age_group(t, age_group) = income_per_age_group(t, age_group) - consumption_per_age_group(t, age_group);
    end
end
