clear workspace;
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

%fase iniziale
start_phase = 0;
%energia in caso di assenza di rumore
E = 1;
%Ampiezza delle forme d'onda
A = sqrt(2*E/sampleTime);

%frequenze ausiliarie (scostamento dalla frequenza di centrobanda, nel nostro
%caso siamo in banda base)
f_1 = 1/(4*sampleTime);
f_2 = - 1/(4*sampleTime);

%variabile di input per la funzione di generazione di sin e cosin,
%all'interno dell'argomento rappresenta la variabile k
num_sequence = [0,1,2,3,0];
%inizializziamo il vettore delle frequenze con la frequenza 1/(4T)
freq = [f_1,f_1,f_1,f_1,f_1];
%inizializziamo il vettore delle frequenze con la frequenza -1/(4T)
freq_2 = [f_2,f_2,f_2,f_2,f_2];

% calcoliamo la sequenza di frequenze effettive.
% Il blocco su simulink, si aspetta in input la frequeza ed a partire da
% questa genera la forma d'onda. Il blocco prende in inpunt una var
% denominata u e la moltiplica per 2pi. A tal fine freq_r rappresenta la
% sequenza degli u da fornire in input al blocco.
freq_r = [freq - (1/4).*num_sequence] + start_phase
k = timeseries(num_sequence,time)
%variabilie di input per il blocco di generazione della forma d'onda.
freq_series = timeseries(freq_r,time)

% calcoliamo la sequenza di frequenze effettive.
% Il blocco su simulink, si aspetta in input la frequeza ed a partire da
% questa genera la forma d'onda. Il blocco prende in inpunt una var
% denominata u e la moltiplica per 2pi. A tal fine freq_r rappresenta la
% sequenza degli u da fornire in input al blocco.
freq_2r = [freq_2 + (1/4).*num_sequence] + start_phase

%variabilie di input per il blocco di generazione della forma d'onda.
freq_series_2 = timeseries(freq_2r,time)

%fase 
p = start_phase;
i=1;
p_j = [0,0,0,0,0];
while i<=numSteps
    p = p - pi/2;
    p_j(1,i) = p;
    i=i+1;
end