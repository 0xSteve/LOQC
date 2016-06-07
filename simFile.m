function out = simFile(theta,theta2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
theta2 = pi*theta2/180;
%create the input register (1/7)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rho_r = state('0');%ones go through zeroes go up
nrr = state('1');
rho_c = rho_r;     %use the same state
nrc = nrr;
r1 = tensor(nrr, rho_r, rho_c, nrc);

%create the first 'slice' and propagate (2/7)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
H = tensor(helper.I, helper.H, helper.H, helper.I);
r2 = u_propagate(r1, H);

%create the second register (3/7)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PBS45 = tensor(helper.I, mygates.PBS45(1), mygates.PBS45(1), helper.I);
r3 = u_propagate(r2, PBS45);

%push r3 through ACNOT (4/7)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
r4 = u_propagate(r3, tensor(helper.I, helper.ACNOT, helper.I));

%push r4 through fibre-optic gyroscope (5/7)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%fibOptGyr = tensor(helper.I,helper.I, mygates.phase(theta), helper.I);
fibOptGyr = tensor(mygates.phase(theta2),helper.I, mygates.phase(theta), mygates.phase(theta2));
r5 = u_propagate(r4, fibOptGyr);

%push r5 through H gate (6/7)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
H = tensor(helper.I, helper.I, helper.H, helper.H);
r6 = u_propagate(r5, H);

%push r6 through recombine(7/7)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s6 = tensor(helper.I, mygates.PBS45(1), mygates.PBS45(1), helper.I);
out = u_propagate(r6, s6);
end