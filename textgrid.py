"""Simple text formatting facilities for printing grid pictures.

The idea is to use lexicographically ordered tuples for coordinates to handle
all alignment issues; nesting boxes is translated to chaining coordinates.

"""

from __future__ import generators

from sets import Set                    # python 2.3 library

class Box(object):

    """A 2-D grid that can be travesed in row, column order

    Coords are arbitrary ordered objects; no special negative index treatment
    is done.

    """

    def __init__(self):
        """Return empty grid."""
        self.grid = {}
        self.rows = Set()
        self.cols = Set()

    def __setitem__(self, (row, col), obj):
        """Recursively flatten `Box`es into the box."""
        def tuplify(x):
            try:
                return tuple(x)
            except TypeError:
                return (x,)
        row = tuplify(row)
        col = tuplify(col)
        if isinstance(obj, Box):
            for (subrow, subcol), subobj in obj.grid.iteritems():
                subrow = tuplify(subrow)
                subcol = tuplify(subcol)
                self[row + subrow, col + subcol] = subobj
        else:
            self.rows.add(row)
            self.cols.add(col)
            self.grid[row, col] = obj

    def __iter__(self):
        """Generate iterators in row,column ordering, None for holes."""
        rows = list(self.rows)
        rows.sort()
        cols = list(self.cols)
        cols.sort()
        for row in rows:
            def iter2():
                for col in cols:
                    yield self.grid.get((row, col))
            yield iter2()

    def __str__(self):
        return '\n'.join([''.join([c or ' ' for c in line]) for line in self])


def textbox(s, r0=0, c0=0):
    """Make box from [multiline] str(s); top left corner at r0, c0"""
    s = str(s)
    box = Box()
    row = r0
    for line in s.splitlines():
        col = c0
        for char in line:
            box[row, col] = char
            col += 1
        row += 1
    return box
