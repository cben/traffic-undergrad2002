set terminal postscript color
set data style lines
set output 'react_0.10-hold_inorder-car.ps'
set title 'react_0.10-hold_inorder-car'
plot 'react_0.10-hold_inorder_5x5-car.dat', 'react_0.10-hold_inorder_15x15-car.dat', 'react_0.10-hold_inorder_10x10-car.dat'
