set terminal postscript color
set data style lines
set output 'react_0.05-longest-dev.ps'
set title 'react_0.05-longest-dev'
plot 'react_0.05-longest_5x5-dev.dat', 'react_0.05-longest_15x15-dev.dat', 'react_0.05-longest_10x10-dev.dat'
