set terminal postscript color
set data style lines
set output 'react_0.20-hold_inorder-dev.ps'
set title 'react_0.20-hold_inorder-dev'
plot 'react_0.20-hold_inorder_5x5-dev.dat', 'react_0.20-hold_inorder_15x15-dev.dat', 'react_0.20-hold_inorder_10x10-dev.dat'
