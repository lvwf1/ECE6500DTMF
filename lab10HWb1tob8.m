
clear
clc

fs=1/0.3*1000;
sig= DTMFdial('0123456789ABCD*#',fs);

%spectrogram(sig,256,[],[],fs,'yaxis');
%figure;

[n,fo,ao,w] = firpmord([552   673   685   806],[0 1 0],[0.01 0.02 0.01],fs);
b1 = firpm(n,fo,ao,w);

[n,fo,ao,w] = firpmord([643 764 776 897],[0 1 0],[0.01 0.02 0.01],fs);
b2 = firpm(n,fo,ao,w);

[n,fo,ao,w] = firpmord([725 846 858 979],[0 1 0],[0.01 0.02 0.01],fs);
b3 = firpm(n,fo,ao,w);

[n,fo,ao,w] = firpmord([814 935 947 1068],[0 1 0],[0.01 0.02 0.01],fs);
b4 = firpm(n,fo,ao,w);

[n,fo,ao,w] = firpmord([1082 1203 1215 1336],[0 1 0],[0.01 0.02 0.01],fs);
b5 = firpm(n,fo,ao,w);

[n,fo,ao,w] = firpmord([1209 1330 1342 1463],[0 1 0],[0.01 0.02 0.01],fs);
b6 = firpm(n,fo,ao,w);

[n,fo,ao,w] = firpmord([1350 1471 1483 1604],[0 1 0],[0.01 0.02 0.01],3333);
b7 = firpm(n,fo,ao,w);

[n,fo,ao,w] = firpmord([1477 1627],[0 1],[0.02 0.01],fs);
b8 = firpm(n+6,fo,ao,w);
b8 =firfilt(b8,[0 0 1]);


bL=ones(1,160)/160;


aveP1=firfilt(sig,b1);
aveP1=aveP1.^2;
aveP1=firfilt(aveP1,bL);
aveP1=aveP1(1:40:end);

aveP2=firfilt(sig,b2);
aveP2=aveP2.^2;
aveP2=firfilt(aveP2,bL);
aveP2=aveP2(1:40:end);

aveP3=firfilt(sig,b3);
aveP3=aveP3.^2;
aveP3=firfilt(aveP3,bL);
aveP3=aveP3(1:40:end);

aveP4=firfilt(sig,b4);
aveP4=aveP4.^2;
aveP4=firfilt(aveP4,bL);
aveP4=aveP4(1:40:end);

aveP5=firfilt(sig,b5);
aveP5=aveP5.^2;
aveP5=firfilt(aveP5,bL);
aveP5=aveP5(1:40:end);

aveP6=firfilt(sig,b6);
aveP6=aveP6.^2;
aveP6=firfilt(aveP6,bL);
aveP6=aveP6(1:40:end);

aveP7=firfilt(sig,b7);
aveP7=aveP7.^2;
aveP7=firfilt(aveP7,bL);
aveP7=aveP7(1:40:end);

aveP8=firfilt(sig,b8);
aveP8=aveP8.^2;
aveP8=firfilt(aveP8,bL);
aveP8=aveP8(1:40:end);



%{
subplot(8,1,1);
stem(aveP8);
subplot(8,1,2);
stem(aveP7);
subplot(8,1,3);
stem(aveP6);
subplot(8,1,4);
stem(aveP5);
subplot(8,1,5);
stem(aveP4);
subplot(8,1,6);
stem(aveP3);
subplot(8,1,7);
stem(aveP2);
subplot(8,1,8);
stem(aveP1);
ylim([0.3 0.5]);
%}

sentToDecode=[aveP1(:) aveP2(:) aveP3(:) aveP4(:) ...
              aveP5(:) aveP6(:) aveP7(:) aveP8(:) ];


decodeDTMF( sentToDecode, fs, 40 )



%figure;
%hold on
%strips(aveP1,0.22,fs/40);
%strips(aveP2,0.22,fs/40);
%strips(aveP3,0.22,fs/40);
%strips(aveP4,0.22,fs/40);
%strips(aveP5,0.22,fs/40);
%strips(aveP6,0.22,fs/40);
%strips(aveP7,0.22,fs/40);
%strips(aveP8,0.22,fs/40);
%ylim([0.3 0.5]);

