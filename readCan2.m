%function [ theOut ] = readCan2(tName)
fid=fopen('logs/enc_read_r4_SR90.txt','r');

for l=1:4
    fgetl(fid);
end
A=textscan(fid,'%f %d %s %s %s %d %s %s %s %s %s %s %s %s');

fclose(fid)

%0.134488 1  18              Rx   d 6 00 00 00 00 00 00

%%PostProcess data for a given index

motorIndex='68'; %Hex value of index (replace with whatever you want

ind=find(strcmp(A{3},motorIndex));

rawdata1=strcat(A{10:-1:7});
rawdata2=strcat(A{14:-1:11});

motor1DataString=rawdata2(ind);

motorData=hex2dec(motor1DataString);

m2Val = typecast(uint32(motorData),'int32');



plot(m2Val);
title('enc Tick')

figure
deg = enc2deg(12,double(m2Val));
plot(deg);
title('deg')
