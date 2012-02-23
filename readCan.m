function [ t, ch, id, dlc, d, L ] = readCan( tFile )

%% Reads the can logger data from the Vector CANalyzer software
%% Note: Will exclude first 4 lines due to headers and only read Rx
%%
%%
%% function [ t, ch, id, dlc, d, L ] = readCan( tFile )
%%
%% Send:
%%	tFile	=	Path to file
%%
%% Return
%% 	t	=	time in a float value
%%	ch	=	channel number
%%	id	=	CAN message id
%%	dlc	=	dlc value in int format
%%	d	=	all 8 bytes of data in 16 bit int format
%%	L	=	number of data packets received
fid = fopen(tFile);

aa = textscan(fid, '%s', 'delimiter', 'whitespace', ...
             'treatAsEmpty', {'NA', 'na'}, ...
             'commentStyle', '//','HeaderLines', 4);


baseVal			=	hex2dec('60');  % this is the base value for 
                                                % ENC#_RXDF = 0x60 + #
maxBaseVal		=	hex2dec('90');  % Maximum value (not including
                                                % for enc read
a = aa{1};
t 	= 	[];
ch 	= 	[];
id 	= 	[];
dlc	=	[];
d	=	[,];
L	=	size(a);
for( i = 1:L)
	m		=	a{i};   % get the current string to read
	[s1, s2]	=	strread(m,'%s%s','delimiter','Rx');
	strTop		=	s1{1};  % part of the string with time
	strBot		=	s1{2};  % part of the string with the data
	strTopNa	=	strread(strTop,'%s','delimiter',' ');
	strBotNa	=	strread(strBot,'%s','delimiter',' ');
	t(i)		=	str2num(strTopNa{1});	% time
	ch(i)		=	str2num(strTopNa{2});	% channel
	id(i)		=	hex2dec(strTopNa{3});	% id in dec
	dlc(i)		=	str2num(strBotNa{2});	% dlc
	for( ii = 0:7)
		try
			d(i,ii+1)	=	hex2dec(strBotNa{3+ii});
		catch err
			temp = 1;
		end
	end

end
