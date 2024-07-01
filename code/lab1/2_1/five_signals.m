% Parameters for the signals
N = 50; % Number of samples, adjust as needed
Fs = 1000; % Sampling frequency, adjust for sine wave as needed
A = 1; % Amplitude for sine wave
f = 100; % Frequency for sine wave, adjust as needed
phi = 0; % Phase for sine wave
r = 1; % Amplitude for exponential signal
w = 2 * pi * f; % Angular frequency for exponential signal
a = 0.9; % Base for power signal

% Signal n for indexing
n = 0:N-1;

% 1. Unit Impulse Signal
delta_n = [1 zeros(1, N-1)];

% 2. Unit Step Signal
u_n = ones(1, N);

% 3. Sine Wave Signal
sin_n = A * sin(2 * pi * f * n / Fs + phi);

% 4. Exponential Signal
exp_n = r * exp(1j * w * n);

% 5. Power Signal
power_n = a .^ n;

% Plot the Unit Impulse Signal
subplot(5, 1, 1);
stem(n, delta_n);
title('Unit Impulse Signal');
xlabel('n');
ylabel('\delta(n)');

% Plot the Unit Step Signal
subplot(5, 1, 2);
stem(n, u_n);
title('Unit Step Signal');
xlabel('n');
ylabel('u(n)');

% Plot the Sine Wave Signal
subplot(5, 1, 3);
stem(n, sin_n);
title('Sine Wave Signal');
xlabel('n');
ylabel('A sin(2\pi f n / Fs + \phi)');

% Plot the Exponential Signal (Real Part)
subplot(5, 1, 4);
stem(n, real(exp_n));
title('Exponential Signal (Real Part)');
xlabel('n');
ylabel('Re{r e^{jwn}}');

% Plot the Exponential Signal (Imaginary Part)
subplot(5, 1, 4);
hold on;
stem(n, imag(exp_n), 'r');
title('Exponential Signal');
xlabel('n');
ylabel('Im{r e^{jwn}}');
hold off;

% Plot the Power Signal
subplot(5, 1, 5);
stem(n, power_n);
title('Power Signal');
xlabel('n');
ylabel('a^n');
