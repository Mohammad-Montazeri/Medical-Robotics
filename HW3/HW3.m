clc, clear;
% --------- Part One ---------
% ------- 1st approach -------
angles = deg2rad([25, 15, 3]);

a = angles(1);
b = angles(2);
g = angles(3);

ca = cos(a);  sa = sin(a);
cb = cos(b);  sb = sin(b);
cg = cos(g);  sg = sin(g);

Rxyx = [ cb,        sb*sg,                 sb*cg,                 0;
         sa*sb,   -sa*cb*sg + ca*cg,     -sa*cb*cg - ca*sg,     0;
        -ca*sb,    ca*cb*sg + sa*cg,      ca*cb*cg - sa*sg,     0;
         0,        0,                      0,                    1 ];

H1 = [1, 0, 0, 0.2;
      0, 1, 0, 4.1;
      0, 0, 1, -0.1;
      0, 0, 0, 1];

H2 = [1, 0, 0, -0.6;
      0, 1, 0, 0;
      0, 0, 1, 0;
      0, 0, 0, 1];

H = H1 * Rxyx * H2;
H_I_0 = inv(H)

% ------- 2nd approach -------

Hti = [1, 0, 0, 0.6;
      0, 1, 0, 0;
      0, 0, 1, 0;
      0, 0, 0, 1];

Ht0 = Rxyx + ...
[0, 0, 0, 0.2;
      0, 0, 0, 4.1;
      0, 0, 0, -0.1;
      0, 0, 0, 0];

H_alt = Hti * inv(Ht0)

% --------- Part Two ---------

P1_I = [0.6, 0.0, 0.2, 1]';
P2_I = [0.0, 0.3, 0.2, 1]';
P3_I = [0.6, 0.3, 0.0, 1]';
P4_I = [0, 0, 0, 1]';

P1_0 = H_alt * P1_I;
P2_0 = H_alt * P2_I;
P3_0 = H_alt * P3_I;
P4_0 = H_alt * P4_I;

A = [P1_I, P2_I, P3_I, P4_I]';
B = [P1_0, P2_0, P3_0, P4_0]';
B = B(:, 1:3);

H_parameters = (A \ B)';

H_I_0_new = [H_parameters; 
         0, 0, 0, 1]

norm(H_alt - H_I_0)
norm(H_I_0_new - H_I_0)