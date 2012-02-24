close all
clear all

addpath('huboJointConstants');
huboJointConst;

[d, t] = readCan2('logs/enc_read_r4_SR90.txt', LSP);

plot(t,d);
