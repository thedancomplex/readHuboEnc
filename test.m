close all
clear all

addpath('huboJointConstants');
huboJointConst;

[ mot ] = readCanEnc('logs/enc_read_r1.txt');
%save motR13.mat mot
%load motR13;
m = LSRi;

tt 		= mot(m,1,:);
t		= tt(:);
encTicksT 	= mot(m,2,:);
encTicks	= encTicksT(:);
deg		= enc2deg(m,encTicks);

plot(t,deg);
figure;
plot(t,encTicks)
