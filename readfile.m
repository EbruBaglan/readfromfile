% readfile.m
% 
%     * Get Principle Moment of Inertia values(obtained from
%       SpaceClaim) from a .txt file, convert them into inputs for
%       Simulink/Simscape. Unit [kgm^2]
%
%     * Define motor distances from CoM of the system
%       x1, x3, x5, y1, y3, y5, z1, z3, z5 Unit: [m]
%
%     * Define m and g. Unit [kg] and [m/s^2]
%
% Input:   *  .txt file with an example input as follows:
%               4464512595.98375 g mm^2 (-0.16701, 0, 0.98596)
%               19001812472.7181 g mm^2 (0, 1, 0)
%               20862708580.4138 g mm^2 (0.98596, 0, 0.16701)
%          * x1, x3, x5, y1, y3, y5, z1, z3, z5 in [m]
%          * m and g in [kg] and [m/s^2]
%
% Output:  * Workspace variables mentioned above.
%
% Written by Ebru Baglan for Keio University, Master's Thesis.
% 05/2023, v01.
%
% Improvements: Get the points from file as well.
%               Get them from SpaceClaim into a file automatically.

clc; clear;

% Read the file in the given format, assign them into val matrix
fileID = fopen('inertia.txt','r');
formatSpec = ['%f' ' g mm^2 (' '%f' ',' '%f' ',' '%f' ')'];
val = fscanf(fileID,formatSpec);
fclose(fileID);
format longG

% Calculate inertias, change units from gmm^2 to kgm^2
Ixx = val(9) * val(10) * 10^-9; %kgm^2
Iyy = val(5) * 10^-9; %kgm^2
Izz = val(1) * val(4) * 10^-9; %kgm^2

Ixz = ( val(1) * val(2) + val(9) * val(12) )*10^-9;

% Display results on command window
X = sprintf('Principals: [%f %f %f] kgm^2',Ixx,Iyy,Izz);
disp(X)
Y = sprintf('Products of Inertia: [0 %f 0] kgm^2', Ixz);
disp(Y)

% Enter the motor position values manually below.
x1 = -186.91 * 10^-3; x3 =  -39.59 * 10^-3; x5 = 390.45 * 10^-3; %m
y1 =     145 * 10^-3; y3 =  445.67 * 10^-3; y5 = 601.63 * 10^-3; %m
z1 = -313.54 * 10^-3; z3 = -228.49 * 10^-3; z5 = -35.01 * 10^-3; %m

% Enter the bow angle of the pilot, m and g values.
a = 30 / 180 * pi; % rad
m = 100; % kg
g = 9.80665; % m/s^2;