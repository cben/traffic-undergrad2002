set terminal postscript color
set data style lines
set output 'react_0.20-hold_hist-car.ps'
set title 'react_0.20-hold_hist-car'
plot 'react_0.20-hold_hist_5x5-car.dat', 'react_0.20-hold_hist_15x15-car.dat', 'react_0.20-hold_hist_10x10-car.dat'
