set terminal postscript color
set data style lines
set output 'react_0.10-hist-wait.ps'
set title 'react_0.10-hist-wait'
plot 'react_0.10-hist_5x5-wait.dat', 'react_0.10-hist_15x15-wait.dat', 'react_0.10-hist_10x10-wait.dat'
