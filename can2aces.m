function []	=	can2aces(tName, m)
%% converts vector CANalyzer logs to ACES motion script.
% Note: current assumptions is that all joint's are being sampled at the same
% rate in the logging file.
%
% function []	=	can2aces(tName, m)
%
% Send:
%	tName	=	string of the path and name to the can logged file
%	m	=	array of the motors you are interested in
%
% Ouput:
%	tName.aces	=	will add file to logging director with the 
%				extention of *.aces added

addpath('huboJointConstants');
huboJointConst;

mot 	=	[];

for ( i = 1:length(m) )
	[d, t] = readCan2(tName, m(i));

	mot(:,i) = d;
end

%% Convert to rad
mot 	=	degtorad(mot);		


fid 	=	fopen([tName,'.aces'],'w');

%% print headder
for( i = 1:length(m) )
	fprintf(fid,[jn{m(i)+1},' ']);
end	

%% print new line
fprintf(fid,'\n');

ss = size(mot);
for( i = 1:ss(1) )		%% Each row
	for ( ii = 1:ss(2) )	%% each element in the row
		fprintf(fid, [num2str(mot(i,ii)), ' '] );
	end
	fprintf(fid,'\n');
end

fclose(fid);
end

