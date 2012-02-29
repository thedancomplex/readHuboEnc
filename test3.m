close all
clear all

addpath('huboJointConstants');
huboJointConst;

jsR = [ RAP, RAR, RKN, RHP, RHY, RHR, RWY, RW1, RW2 ];
jsL = [ LAP, LAR, LKN, LHP, LHY, LHR, LWY, LW1, LW2 ];
jsSR= [ RSR, RSP, RSY, REB ];
jsSL= [ LSR, LSP, LSY, LEB ];
jsM = [ WST ];

js = [ jsR, jsL, jsSR, jsSL, jsM ];


%can2aces('logs/fullBody_Test_R1_bad_zero.txt', [LSP, LEB, RSP, REB]);
%can2aces('logs/fullBody_Test_R1_bad_zero.txt', js);
%can2aces('logs/dirTest_LWY.txt', js);
can2aces('logs/throwTestR4_feet_still.txt', js);

