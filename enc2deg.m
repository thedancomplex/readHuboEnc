function [ deg ] = enc2deg( m, encVal )


%% returns the degree value of the encoder value for the given motor of 
% Jaemi Hubo that was sent
%function [ deg ] = enc2deg( m, encVal )
%
% Send:
%	m 	=	motor number (index)
%	encVal	=	int32 encoter value
%
% Return
%	deg	=	angel in degree of the encoder

addpath('huboJointConstants');
huboJointConst;


drive 		= ratio(5,m+1);
driven		= ratio(1,m+1);
harmonic	= ratio(2,m+1);
enc		= ratio(3,m+1);
quad		= ratio(4,m+1);


deg = encVal/(  driven/drive * harmonic * enc * quad ) * 360.0;
