set terminal postscript color
set data style lines
set output 'react_0.05-rand-dev.ps'
set title 'react_0.05-rand-dev'
plot 'react_0.05-rand_5x5-dev.dat', 'react_0.05-rand_15x15-dev.dat', 'react_0.05-rand_10x10-dev.dat'
