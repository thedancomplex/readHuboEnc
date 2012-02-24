function [ deg, t ] = readCan2(tName, m)

addpath('huboJointConstants');
huboJointConst;



fid=fopen('logs/enc_read_r4_SR90.txt','r');

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

ind=find(strcmp(A{3},motorIndex));

rawdata1	=strcat(A{10:-1:7});
rawdata2	=strcat(A{14:-1:11});
traw		=A{1};		%% time raw
t		=traw(ind);






deg 		= [];
rawData 	= [];


tNum = find(jmc(motN+1,:),m+1);

if( tNum == 1)
	rawData = rawdata1(ind);
else if(tNum == 2)
	rawData = rawdata2(ind);
end
motorDataString=rawdata2(ind);
motorData=hex2dec(motorDataString);
m2Val = typecast(uint32(motorData),'int32');
deg = enc2deg(m+1,double(m2Val)); 



%plot(m2Val);
%title('enc Tick')

%figure
%deg = enc2deg(12,double(m2Val));
%plot(deg);
%title('deg')
end
