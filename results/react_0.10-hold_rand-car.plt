set terminal postscript color
set data style lines
set output 'react_0.10-hold_rand-car.ps'
set title 'react_0.10-hold_rand-car'
plot 'react_0.10-hold_rand_5x5-car.dat', 'react_0.10-hold_rand_15x15-car.dat', 'react_0.10-hold_rand_10x10-car.dat'
