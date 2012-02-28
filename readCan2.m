function [ deg, t ] = readCan2(tName, m)

%% reads the logged file of the vector can analyzer and returns the 
% encoder reading for the desired motor m
%
% function [ deg, t ] = readCan2(tName, m)
%
% Send:
%	tName	=	string of the path and name to the can logged file
%	m	=	the motor you are interested in
%
% Return:
%	deg	=	angel of joint in deg
%	t	=	time in seconds

addpath('huboJointConstants');
huboJointConst;


disp(['Reading Joint: ', jn{m+1}])
%fid=fopen('logs/enc_read_r4_SR90.txt','r');
fid=fopen(tName,'r');

for l=1:4
    fgetl(fid);
end
A=textscan(fid,'%f %d %s %s %s %d %s %s %s %s %s %s %s %s');

fclose(fid);

%0.134488 1  18              Rx   d 6 00 00 00 00 00 00

%%PostProcess data for a given index

%motorIndex='68'; %Hex value of index (replace with whatever you want
motN		=	jmcM(m+1);			% Motor number
motorIndex 	=	dec2hex(hex2dec('60')+motN);	% JMC number

ind=find(strcmp(A{3}, motorIndex));

rawdata1	=strcat(A{10:-1:7});
rawdata2	=strcat(A{14:-1:11});
traw		=A{1};		%% time raw
t		=traw(ind);

deg 		= [];
rawData 	= []; 


tNum = min(find(jmc(motN+1,:) == m));

%disp(['tNum = ',num2str(tNum), '   motN = ', num2str(motN), '   size ind = ', num2str(size(ind))])
if( tNum == 1)
	rawData = rawdata1(ind);
%	disp('choice 1')
elseif(tNum == 2)
	rawData = rawdata2(ind);
%	disp('choice 2')
end
%disp('h1')
%motorDataString=rawdata2(ind);

%disp(['rawData size = ', num2str(size(rawData))])
motorDataString=rawData;
%disp('h2')
motorData=hex2dec(motorDataString);
%disp('h3')
m2Val = typecast(uint32(motorData),'int32');
%disp('h4')
deg = enc2deg(m,double(m2Val)); 

%disp(['size deg = ', num2str(size(deg))])

%plot(m2Val);
%title('enc Tick')

%figure
%deg = enc2deg(12,double(m2Val));
%plot(deg);
%title('deg')
end
