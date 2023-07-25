clear;
%sampleTime nelle slide T
sampleTime = 1;
%K nelle slide, numero di simboli generati
numSteps = 5;
%definizione asse temporale
time = sampleTime * (0:numSteps-1);
%trasposta
time = time';
%simboli generati
data = [1,-1,1,1,-1];
%variabile di input per la CPM
simin = timeseries(data,time);

%numero di campioni per generazione di forme d'onda e segnale modulato CPM
sample_n = 32;
%fase iniziale
start_phase = 0;
%energia in caso di assenza di rumore
E = 1;
%Ampiezza delle forme d'onda
A = sqrt(2*E/sampleTime);

%frequenza ausiliaria per la generazione delle sinusoidi/cosinusoidi della
%s(t)
f = 2*pi*(1/(4*sampleTime));

f_0 = 2*pi*200;
f_1 = f_0 + f;
f_2 = f_0 - f;

% Il blocco su simulink, si aspetta in input la frequeza ed a partire da
% questa genera la forma d'onda. Il blocco prende in inpunt una var
% denominata u e la moltiplica per 2pi.

%variabile di input per la funzione di generazione di sin e cosin,
%all'interno dell'argomento rappresenta la variabile k
k = [0,1,2,3,4];

%Array con i vari k moltiplicati per la pi/2
pk = (pi/2).*k;

% calcoliamo la sequenza delle cos((pi/2)*k). Valido sia per il caso
% j=1,che j=2.
val_cos = cos(pk);

% calcoliamo la sequenza delle sin((pi/2)*k). Valido sia per il caso j=1.
val_sin_1 = -sin(pk);

% calcoliamo la sequenza delle sin((pi/2)*k). Valido sia per il caso j=2.
val_sin_2 = sin(pk);

%Generazione 3 dei temeseries relativi ai valori assunti dalle funzioni cos
%e sin
val_cos_temp = timeseries(val_cos,time);
val_sin1_temp = timeseries(val_sin_1,time);
val_sin2_temp = timeseries(val_sin_2,time);

phase_state = [0,pi/2,pi,(3*pi)/2];