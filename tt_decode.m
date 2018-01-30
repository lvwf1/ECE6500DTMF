function phone_number = tt_decode(signal)
digit = ['1' '2' '3' 'A' '4' '5' '6' 'B' '7' '8' '9' 'C' '*' '0' '#' 'D'];
Fs = 8000; % sampling rate
N = 205; % Goertzel block size
Fl = [697 770 852 941]; % low frequencies
Fh = [1209 1336 1477 1633]; % high frequencies
LIM = 0.45; % Limit for detecting tone (if the intensity of the freq from goertzel is less the LIM* the max intensity, the tone wont be detected)

segment_num = floor(length(signal)/N);
Xl = zeros(4,segment_num);
Xh = Xl;

for m = 1 : 4
   for k = 1 : segment_num-1
       Xl(m,k) = abs(gfft(signal((k-1)*N+1:k*N), N, N*Fl(m)/Fs));
       Xh(m,k) = abs(gfft(signal((k-1)*N+1:k*N), N, N*Fh(m)/Fs));
   end
end


Xl(Xl<LIM*max(Xl(:))) = 0;
Xh(Xh<LIM*max(Xh(:))) = 0;

[l1,l2] = max(Xl);
[h1,h2] = max(Xh);

X = digit((l2-1)*4+h2);
X(l1==0) = '-';
X(h1==0) = '-';
cnt = 1;
y = '';
for m = 2 : length(X)
    if X(m) ~= '-' && X(m) ~= X(m-1)
        y = [y X(m)];
        cnt = cnt + 1;
        if cnt == 4 || cnt == 8
            y = [y '-'];
            cnt = cnt + 1;
        end
    end
end

phone_number = y;


