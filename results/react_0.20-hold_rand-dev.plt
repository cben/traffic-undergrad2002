set terminal postscript color
set data style lines
set output 'react_0.20-hold_rand-dev.ps'
set title 'react_0.20-hold_rand-dev'
plot 'react_0.20-hold_rand_5x5-dev.dat', 'react_0.20-hold_rand_15x15-dev.dat', 'react_0.20-hold_rand_10x10-dev.dat'
