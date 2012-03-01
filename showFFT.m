close all
clear all

load throwTestR4;


%% Hubo paramaters
addpath('huboJointConstants');
huboJointConst;


s	=	size(mot);

Fs 	=	1000;		% sampling frequency
T 	=	1/Fs;		% sampling period
L	=	s(1);		% length of signal (samples)
t	=	(0:L-1)*T;	


Ls	=	L;		% sample length of what getsures we care about
NFFT 	=	2^nextpow2(Ls);	% next power of two from length of signal





for ( i = 1:length(m))
	figure;
	y	=	mot(:,i);
	Y 	=	fft(y,NFFT)/Ls;
	f	=	Fs/2*linspace(0,1,NFFT/2+1);
	
	plot(f,2*abs(Y(1:NFFT/2+1)));

	xlabel('Frequency (Hz)')
	ylabel('|Y(f)|')


	title(['FFT of ',jn{m(i)+1}]);
end


