set terminal postscript color
set data style lines
set output 'react_0.05-hist-dev.ps'
set title 'react_0.05-hist-dev'
plot 'react_0.05-hist_5x5-dev.dat', 'react_0.05-hist_15x15-dev.dat', 'react_0.05-hist_10x10-dev.dat'
