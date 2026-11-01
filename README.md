An undergrad project I did back in 2002 in Technion, EE dept, [Control, Robotics and Learning Systems Lab](https://crml.eelabs.technion.ac.il/).

Not particularly interesting, but the lab website dropped old projects, and [Internet Archive copy](https://web.archive.org/web/20040127154649/http://www.ee.technion.ac.il/control/info/Projects/Students/beny_sherniavsky/index.html) is incomplete so uploading for posterity...
 
* [presentation.pdf](presentation.pdf) is short but was (rightfully) critiqued for presenting raw number tables with zero visualization.

* The final [book.pdf](book.pdf) report has _somewhat_ better analysis with couple graphs.  
  _Perhaps_ I'd also simulated more strategies by that point? Don't remember...
 
* [index.html](https://cben.github.io/traffic-undergrad2002/index.html) explains many files here but largely redundant.

The deeper critique was I over-invested in the simulator fluff but then no time left for actual non-trivial research questions!  So much of the report is your typical **"undergrad trying to get passing grade on barely complete project" slop** (e.g. "only simple strategies were tried" below).  Sorry ;-|
 
I did simulate multi-junction "cities" e.g. results4/{[A.plan](results4/A.plan),[B.plan](results4/B.plan),[C.plan](results4/C.plan)})  
and measure end-to-end metrics like "car journey from source to sink took this long".  
But car routing was very dumb: 60% straight, 20% right, 15% left, 5% U-turn — no goal seeking, no traffic awareness!  
Anyway, the "smart" traffic light **policies were all single-junction** and the results pretty predictable from common sense.
 
* To run, you need Python 2.3. run.py is the main entry point, see the functions inside. book.pdf also contains some useful information on the source.

----

## Original Abstract

> This project analyzed systems of traffic ligths, roads and cars, in search of the best startegy for controlling the traffic lights.  The problem was analyzed and a simplified model was selected.  Simulation software was developed for this model and run with many control strategies (due to time constraints only simple strategies were tried).  This report documents what was done and analyzes the results.

### Original design.txt file (I do NOT remember if it's up-to-date)

> * Discrete time.
>   - Rationale: easier to simulate, suits typical control structures,
>     easier to analyze (e.g. representing that on green light 1 car is
>     served per "second"...)
> * Low traffic density - far from saturation:
>   - Roads have constant(?) delay (might vary but load-independent).
>   - Each road ends with an infinite queue.
>   - In other words we do *not* anylyze jams.
>   - Rationale: while most real-life systems are more interested in
>     high density (most traffic is during peak hours), low density
>     should make the effectiveness of the control more clearly observable.
> * No yellow lights.  Switching has no overhead.
>   - Light cycle length will be dictated by the desire to coordiante
>     intersections (impossible if travel time >> cycle length).
> * At first perfect imformation about cars will be assumed to be availiable.
>   - Each car decides what it's route will be when it's created and
>     follows it.  Maybe this is too strong and probabilistic turning
>     with known probabilities will be used.
>   - Rationale: the tasks of selecting good locations/types for the sensors
>     and of estimating the situation on the roads from their outputs,
>     is interesting but separate from the design of the control.
>   - Common sense care should be taking not to design control
>     architectures that are inherently sensitive to the precision of
>     the road data (e.g. full combinatoric searches).
>   - If time will allow the degradation of effectiveness with the
>     decrease in information can be researched.
> * Intersections, traffic ligths:
>   - The simulator should allow almost anything for research benefit.
>   - For simplicity, only one queue will be served at a time (not
>     counting uncontrolled turnings, e.g. right turns).  For example
>     lights that allow simultaneos strait and left from same road are
>     OK (and realistic).
 
### Original Acknowledgements

> I wish to thank my advisor, Ari Todtfeld, for guiding me; the Control, Robotics and Learning Systems Lab for providing this project and being ready to provide resources for it (even if I mostly prefered to work at home); and my brother Eli for tolerating that I grabbed the computer for long times :-)...
>
> Also I want to thank Richard Stallman, Linus Torvalds, Guido van Rossum, Donald Knuth, Lesley Lamport and all other people who created GNU/Linux, Emacs, Python, LaTeX and all the great free software that I used... 
