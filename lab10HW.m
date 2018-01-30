
clear
clc


[n,fo,ao,w] = firpmord([643 764 776 897],[0 1 0],[0.01 0.02 0.01],3333);
b = firpm(n,fo,ao,w);

w=0:pi/2000:pi;
H=freqz(b,1,w); %frequency response
plot(w/2/pi*3333,abs(H)); %frequency response magnitude plot
xlim([0,1667]);

hold on;

plot(w/2/pi*3333,ones(1,length(w))*0.98);  %second
plot(w/2/pi*3333,ones(1,length(w))*1.02);  %top

line([643 643], [0 1.2], 'Color',[.8 .1 1]); 
line([764 764], [0 1.2], 'Color',[.8 .1 1]); 
line([776 776], [0 1.2], 'Color',[.8 .1 1]); 
line([897 897], [0 1.2], 'Color',[.8 .1 1]); 

plot(w/2/pi*3333,ones(1,length(w))*0.01); %botton
hold off
shg

%{
xx = DTMFdial('159D*86A',3333);
figure;
subplot(2,1,1);
plotspec(xx,3333);

subplot(2,1,2);
plotspec(firfilt(xx,b),3333);
shg
%}