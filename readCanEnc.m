function [ t , n ] = readCanEnc( tFile )


baseVal			=	hex2dec('60');	% this is the base value for 
						% ENC#_RXDF = 0x60 + #
maxBaseVal		=	hex2dec('90');	% Maximum value (not including
						% for enc read
[ t, ch, id, dlc, d, L ] = readCan( tFile );	% get can data

for(i = 1:L)
	m 		=	a{i};	% get the current string to read
	[s1, s2]	= 	strread(m,'%s%s','delimiter','Rx');
	strTop 		= 	s1{1};	% part of the string with time
	strBot		=	s1{2};	% part of the string with the data
	strTopNa	=	strread(strTop,'%s','delimiter',' ');
	t(i)		=	str2num(strTopNa{1});
	bn 		= 	hex2dec(strTopNa{3}) - baseVal;
	n(i)		=	hex2dec(strTopNa{3});
end
