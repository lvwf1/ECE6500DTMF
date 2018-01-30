%% 4.2

function xx = DTMFdial(keyNames,fs)



%DTMFDIAL Create a signal vector of tones that will dial
% a DTMF (Touch Tone) telephone system.
%
% usage: xx = DTMFdial(keyNames,fs)
% keyNames = vector of CHARACTERS containing valid key names
% fs = sampling frequency
% xx = signal vector that is the concatenation of DTMF tones.
%




TTkeys = ['1','2','3','A';
    '4','5','6','B';
    '7','8','9','C';
    '*','0','#','D'  ];

TTcolTones = [1209,1336,1477,1633]; %-- in Hz
TTrowTones = [697,770,852,941];

LenKey = length(keyNames);


xx = [];

T180 = 0: 1/fs : 180/1000;
silence = zeros(1, 161 );

for p = 1:LenKey
    
    
    try
        [r,c] = find(keyNames(p)==TTkeys);
    catch exception
        disp('WRONG!');
    end
    
    if isempty(r) || isempty(c)
        disp('WRONG!');
        return;
    end
    
    
    temp = cos(2*pi* TTrowTones(r)  *T180) + cos(2*pi* TTcolTones(c)  *T180);
    xx = [xx temp(1:end-1) silence(1:end-1) ];
end

xx = [xx 0];

end