function [ mot, motOrig ] = readCanEnc( tFile )

addpath('huboJointConstants');			% add the hubo joint constants
						% path
huboJointConst;					% Run Hubo Joint Const

baseVal			=	hex2dec('60');	% this is the base value for 
						% ENC#_RXDF = 0x60 + #
maxBaseVal		=	hex2dec('90');	% Maximum value (not including
						% for enc read
[ t, ch, id, dlc, d, L ] = readCan( tFile );	% get can data
mot = [];
motOrig = [];
moti = [];
moti(jointMax) 		=	0;
for(i = 1:L)
	
	if(id(i) >= baseVal & id(i) < maxBaseVal)

		bn	=	id(i) - baseVal;	% current board num
		bni	= 	bn + 1;			% board number index 
		
		mVal	=	jmcN(bni);
		enc1	=	[];
		if( mVal == 2 & dlc(i) == 8) 		% Two motor motor controller
			%enc(1) = hex2dec([dec2hex(d(i,1)),dec2hex(d(i,2)),dec2hex(d(i,3)),dec2hex(d(i,4))]);
			%enc(1) = hex2dec([dec2hex(d(i,4)),dec2hex(d(i,3)),dec2hex(d(i,2)),dec2hex(d(i,1))]);
			%enc(2) = hex2dec([dec2hex(d(i,8)),dec2hex(d(i,7)),dec2hex(d(i,6)),dec2hex(d(i,5))]);
			%disp(num2str(d(i,:)));
			%pause();
			tt = [dec2hex(d(i,4)),dec2hex(d(i,3)),dec2hex(d(i,2)),dec2hex(d(i,1))];
			%disp(tt);
			enc(1) = hex2dec([dec2hex(d(i,4)),dec2hex(d(i,3)),dec2hex(d(i,2)),dec2hex(d(i,1))]);
			enc(2) = hex2dec([dec2hex(d(i,8)),dec2hex(d(i,7)),dec2hex(d(i,6)),dec2hex(d(i,5))]);
			%encN	=	[d{i}(4),d{i}(3),d{i}(2),d{i}(1)];
			%enc(1) = hex2dec(encN);
			%enc(2) = hex2dec([d{i}(8),d{i}(7),d{i}(6),d{i}(5)]);
			%enc(2) = hex2dec([dec2hex(d(i,5)),dec2hex(d(i,6)),dec2hex(d(i,7)),dec2hex(d(i,8))]);
			moti(bni) = moti(bni) + 1;
			ii = moti(bni);

			%% Motor 1
			mot1 = jmc(bni,1);
			mot(mot1,1,ii) = t(i);		% record the time
			%mot(mot1,2,ii) = typecast(uint32(enc(1)),'int32');		% record the pos
			t = enc(1);
			td = t & hex2dec('7FFFFFFF');
			ts = t & hex2dec('80000000');
			tf = td;
			if(ts > 0 )
				td = - td;
			end

			mot(mot1,2,ii) = td;		% record the pos
			motOrig(mot1,1,ii) = t(i);
			motOrig(mot1,2,ii) = enc(1);
			
			%% Motor 2
			mot2 = jmc(bni,2);	
			mot(mot2,1,ii) = t(i);		% record the time
			%mot(mot2,2,ii) = typecast(uint32(enc(2)),'int32');		% record the pos
			t = enc(2);
			td = t & hex2dec('7FFFFFFF');
			ts = t & hex2dec('80000000');
			tf = td;
			if(ts > 0 )
				td = - td;
			end
			mot(mot2,2,ii) = td;
			motOrig(mot2,1,ii) = t(i);
			motOrig(mot2,2,ii) = enc(2);
			
		end
			

	end

end
