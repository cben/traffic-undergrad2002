set terminal postscript color
set data style lines
set output 'react_0.05-hold_rand-wait.ps'
set title 'react_0.05-hold_rand-wait'
plot 'react_0.05-hold_rand_5x5-wait.dat', 'react_0.05-hold_rand_15x15-wait.dat', 'react_0.05-hold_rand_10x10-wait.dat'
