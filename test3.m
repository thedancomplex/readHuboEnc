close all
clear all

addpath('huboJointConstants');
huboJointConst;

can2aces('logs/enc_read_r4_SR90.txt', [LSP, LEB, RSP, REB]);

