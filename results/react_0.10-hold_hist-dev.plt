set terminal postscript color
set data style lines
set output 'react_0.10-hold_hist-dev.ps'
set title 'react_0.10-hold_hist-dev'
plot 'react_0.10-hold_hist_5x5-dev.dat', 'react_0.10-hold_hist_15x15-dev.dat', 'react_0.10-hold_hist_10x10-dev.dat'
