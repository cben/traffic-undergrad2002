set terminal postscript color
set data style lines
set output 'react_0.05-hold_lru-dev.ps'
set title 'react_0.05-hold_lru-dev'
plot 'react_0.05-hold_lru_5x5-dev.dat', 'react_0.05-hold_lru_15x15-dev.dat', 'react_0.05-hold_lru_10x10-dev.dat'
