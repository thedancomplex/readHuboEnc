close all
clear all

addpath('huboJointConstants');
huboJointConst;

d = readCan2('logs/encT.txt');
