close all
clear all

addpath('huboJointConstants');
huboJointConst;

[ mot, motOrig ] = readCanEnc('logs/enc_read_r1.txt');
save LSRr41.mat mot motOrig
%load motR41;
m = LSRi;

tt 		= mot(m,1,:);
t		= tt(:);
encTicksT 	= mot(m,2,:);
encTicks	= encTicksT(:);
deg		= enc2deg(m,encTicks);


plot(t,deg);
title('deg')
figure;
plot(t,encTicks)
title('enc ticks')

figure

encT1 		= motOrig(m,2,:);
encT		= encT1(:);
plot(t,encT);

title('raw data')
