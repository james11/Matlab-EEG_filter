
clear all
clc

load('EEG-close.txt')
load('EEG-open.txt')
load('filt1.tf.num.txt')
load('filt1.tf.den.txt')


% EEG_open = EEG_open
% EEG_close = EEG_close

subplot(5,2,1)
plot(EEG_open,'r')
title('open')

subplot(5,2,2)
plot(EEG_close)
title('close')

filted_open = filter(filt1_tf_num, filt1_tf_den, EEG_open)
filted_closed = filter(filt1_tf_num, filt1_tf_den, EEG_close)

subplot(5,2,3)
plot(filted_open , 'r')

subplot(5,2,4)
plot(filted_closed)

subplot(5,2,5)
plot(EEG_close)
hold on
plot(EEG_open,'r')

subplot(5,2,6)
plot(filted_closed)
hold on
plot(filted_open,'r')


x = 0:1:10240
impRes = filt1_tf_num(1,1:9614)
freqRes = fft(impRes , 10240*2)
abs_Res = abs(freqRes)

freq_open = fft(filted_open(10000:20000) , 10240*2)
freq_close = fft(filted_closed(10000:20000) , 10240*2)

abs_open = abs(freq_open)
abs_close = abs(freq_close)

subplot(5,2,7)
plot(abs_open(1:256) ,'r' )
title('freq-open')

subplot(5,2,8)
plot(abs_close(1:256))
title('freq-close')

subplot(5,2,9)
plot(abs_open(1:256) ,'r' )
% label('open' )
hold on
plot(abs_close(1:256))
% title('open')
hold on
plot(1600*abs_Res(1:256) , 'g')

