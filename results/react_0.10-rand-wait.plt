set terminal postscript color
set data style lines
set output 'react_0.10-rand-wait.ps'
set title 'react_0.10-rand-wait'
plot 'react_0.10-rand_5x5-wait.dat', 'react_0.10-rand_15x15-wait.dat', 'react_0.10-rand_10x10-wait.dat'
