
clear all
clc

% Data files
load('EEG-close.txt')
load('EEG-open.txt')

% Coefficients of our simulated filter that for alpha wave
load('filt1.tf.num.txt')
load('filt1.tf.den.txt')

fftSize = 1024 *10 *2


subplot(3,3,1)
plot(EEG_open,'r')
title('Eyes-open')
xlabel('# sample pionts')
ylabel('so(t)')

subplot(3,3,2)
plot(EEG_close)
title('Eyes-close')
xlabel('# sample pionts')
ylabel('sc(t)')


% Use function filter() to process signals
filted_open = filter(filt1_tf_num, filt1_tf_den, EEG_open)
filted_closed = filter(filt1_tf_num, filt1_tf_den, EEG_close)

subplot(3,3,4)
plot(filted_open , 'r')
title('filted-open')
xlabel('# sample pionts')
ylabel('so(t)')

subplot(3,3,5)
plot(filted_closed)
title('filted-close')
xlabel('# sample pionts')
ylabel('sc(t)')

subplot(3,3,3)
plot(EEG_close)
hold on
plot(EEG_open,'r')
title('Original')
xlabel('# sample pionts')
ylabel('so(t) & sc(t)')

subplot(3,3,6)
plot(filted_closed)
title('Filted')
xlabel('# sample pionts')
ylabel('so(t) & sc(t)')
hold on
plot(filted_open,'r')


x = 0:1:10240
impRes = filt1_tf_num(1,1:9614)
freqRes = fft(impRes , fftSize)
abs_Res = abs(freqRes)

% Use fft() to transfer filted signals into frequency domain
freq_open = fft(filted_open(10000:20000) , fftSize)
freq_close = fft(filted_closed(10000:20000) , fftSize)

abs_open = abs(freq_open)
abs_close = abs(freq_close)

subplot(3,3,7)
abs_open(1) = abs_open(2)
max_open = max(abs_open(1:256))
plot(abs_open(1:256)/max_open ,'r' )
set(gca ,'YTick',[0:.2:1])
title('freq-open')
xlabel('freq * fftSize / fs')
ylabel('|So(f)|')

subplot(3,3,8)
abs_close(1) = abs_close(2)
max_close = max(abs_close(1:256))
plot(abs_close(1:256)/max_close)
set(gca ,'YTick',[0:.2:1])
title('freq-close')
xlabel('freq * fftSize / fs')
ylabel('|Sc(f)|')

subplot(3,3,9)
plot(abs_open(1:256)/max_open ,'r' )
title('freq-domain')
xlabel('freq * fftSize / fs')
ylabel('|So(f)| & |Sc(f)| & |H(f)| ')
hold on
plot(abs_close(1:256)/max_close)
hold on
max_Res = max(abs_Res(1:256))
plot(abs_Res(1:256)/max_Res , 'g')
set(gca ,'YTick',[0:.2:1])

