<presentation filename="presentation.pdf" pageDuration="3">
  <!-- stylesheet module="standard" function="getParagraphStyles"/ -->
  <title>Project: "Dynamic" Traffic Lights</title>
  <author>Beni Cherniavsky</author>
  <subject>Project presentation</subject>
  <section name="Main">
    <!-- any graphics in the section go on all its pages as a backdrop -->
    <fixedimage x="12" y="36" filename="bg2.png"/>

    <!-- Now for the slides -->

@{
slide_num = 1

outlinelevel = 0

def math(s):
    parts = s.split('$')
    mathmode = 0
    res = parts.pop(0)
    parts = iter(parts)
    for part in parts:
        if part == '':              # $$
            res += '$'
        else:
            res += '<i>' + part + '</i>' + parts.next()
    return res

def para(style, s):
    return '<para style="' + style + '">' + math(s) + '</para>'

def head(s):
    return para("Heading%d" % (outlinelevel + 1,), s)
def body(s):
    return para("BodyText", s)
def bullet(s):
    return para("Bullet", s)
def italic(s):
    return para("Italic", s)
def defn(s):
    return para("Definition", s)
def indent(s):
    return para("Indent", s)

def begin_part():
    global outlinelevel
    outlinelevel += 1

def end_part():
    global outlinelevel
    outlinelevel -= 1

def begin_slide(title, outline_title = None):
    global slide_num
    if not outline_title:
        outline_title = title
    s = '''<slide title="%s" id="Slide%02d" outlinelevel="%d">
    <frame height="468" x="120" y="72" rightmargin="36" width="700" leftmargin="36">
    %s''' % (outline_title, slide_num, outlinelevel, head(title))
    slide_num += 1
    return s

def end_slide():
    return '''</frame>
    </slide>'''

}@

    @begin_slide("Project: ''Dynamic'' Traffic Lights", "Front page")
    @italic("Student")
    @indent("Beni Cherniavsky")
    @italic("Project Supervisor")
    @indent("Ari Todtfeld")
    @italic("Lab")
    @indent("""
    Control, Robotics and Learning Systems Lab, Electrical Engineering,
    Technion, Israel
    """)
    @end_slide()

    @begin_slide("Overview")
    @body("""This project analyzed systems of traffic ligths, roads and cars,
    in search of the best startegy for controlling the traffic lights.""")
    @bullet("Problem formulation.")
    @bullet("Selection of a (quite simplified) model.")
    @bullet("""Simulation software was developed for this model and run with
    many control strategies (due to time constraints only simple strategies
    were tried).""")
    @bullet("Analysis of the the results.")
    @end_slide()

    @begin_slide("Part 1 - Problem formulation", "Problem formulation")
    @body("""In one sentence: given junctions, roads and cars find the best
    strategy for controlling the junctions.""")
    @bullet("Definition of ''best'' will come later.")
    @bullet("""Since the project was open-ended, it was needed to decide on
    the level of complexity with which to work.  The problem eventually
    analyzed was, unsurprisingly, very much of a toy problem.""")
    @end_slide()

    @begin_part()

    @begin_slide("The (too) big problem")
    @body("""Let's first look at the most general (more or less) formulation
    of the problem to see what was omitted in the toy problem.  Our world
    consits of three objects:""")
    @bullet("""Car that move around.  They can probably enter / leave the city
    at certain places.  At junctions they decide what turns they should take.
    They can prefer some roads to others, for complex reasons.""")
    @bullet("""Unidirectional roads that delay cars driving through them.  The
    delay can depend on factors like amount of cars, random effects, etc.""")
    @bullet("""Junctions -- our question is <i>How to control them best?</i>
    They are the most complex part.""")
    @end_slide()

    @begin_part()

    @begin_slide("Real junctions")
    @bullet("""A given junction has $M$ input roads and $N$ output roads.
    There are $M*N$ routes for a car to pass through a junction (or less).""")
    @bullet("""A car arriving from input direction $m$ and decides it wants to
    go to direction $n$ are appended to queue $Q<sub>m,n</sub>$ of the
    junction (not necessarily distinct).""")
    @bullet("""At any moment the junction is serving zero or more queues.
    "Serving" means that from time to time (not necessarily at a fixed rate),
    one car (or more), is popped from the queue (unless it's empty) and
    forwarded to the target road(s) the car had chosen.""")
    @body("Our task is to choose which queue(s) to serve at every moment.")
    @end_slide()

    @begin_slide("Serving constraints")
    @bullet("""Avoid collisions.  Only some combinations of routes through the
    junction can be safely served at the same time.""")
    @bullet("""switching rate.  Between serving different sets of queues we
    most waste some more time to avoid collision.  Let's call all this dead
    time "yellow light" for simplicity.""")
    @bullet("""Pedestrians deserve green time too.  Ignored in this project
    :-).""")
    @end_slide()

    @end_part()

    @begin_slide("What do we want?")
    @body("""By what criteria should we measure how ``good'' a given control
    policy is?""")
    @bullet("""Most importantly, we want minimum total <b>delay</b> for a car along
    his way.""")
    @bullet("""We also want <b>stability</b> (predictable delays are better
    than strongly fluctuating ones) and <b>fairness</b> (different cars should
    get similar treatment if possible).""")
    @bullet("""Cars travel in different ways =&gt; we measure delays per
    queue.""")
    @bullet("""Stability/fairness can be represented by the variance of the
    delay among cars.  There are subtle points in these definitions - over
    what sets we take the means/variances?""")
    @end_slide()

    @begin_slide("Sensors / inputs")
    @body("""What input should be available to the control system?  One can
divide the research in this field into three somewhat separate parts:""")
    @bullet("""Given perfect information, develop the optimal control
    strategy.""")
    @bullet("""Check how sensitive the strategy is to imperfect information.""")
    @bullet("""Devise cheapest sensors giving maximum useful information.""")
    @body("""We do the first part, so let's help ourselves to whatever
    information we need :-).""")
    @end_slide()

    @begin_slide("Down to earth - the toy problem", "The toy problem")
    @body("That's too complex.  Let's make lots of assumptions:")
    @bullet("""Cars decide where to turn statistically with fixed known
    probabilities, e.g. 60% straight, 20% right, 15% left, 5% reverse.  Bad
    model of reality but convenient for us (equal arrival rate at all
    junctions is easy to arrange).""")
    @bullet("""This means that all roads are equal.  Also, let all queues be
    equal, serving one car per time unit.""")
    @bullet("""So let's also adopt discrete time - simplifies simulation and
    especially control definition.""")
    @bullet("""Every road has a constant delay and a "vertical" queue at the
    end.""")
    @bullet("""No yellow light time.  We do check the impact of imposing a
    lower limit on the time each queue is served.""")
    @end_slide()

    @begin_slide("Down to earth - the toy problem (cont.)",
                 "The toy problem (cont.)")
    @body("""And now the most dramatic limitation:""")
    @bullet("""Serve only one queue at a time.  Vastly simplifies control
    decisions.""")
    @bullet("""This is far from reality.  Most importantly, this limits the
    load on each queue to 0.25 (assuming 4 roads per junction)!""")
    @end_slide()

    @end_part()

    @begin_slide("Part 2 - Theoretical analysis", "Theoretical analysis")
    @body("""I first attempted to an analytical approach. I considered a
    single junction:""")
    @bullet("Without any sensors (can try to serve empty queues).")
    @bullet("Arrival rates are given.")
    @bullet("Choose a random queue to serve on each cycle.")
    @bullet("I easily found the optimal serving probabilities.")
    @end_slide()

    @begin_part()

    @begin_slide("First lesson - don't serve empty queues", "First lesson")
    @body("I tried to consider more complicated problems.")
    @bullet("""For example to check which queues are empty and avoid serving
    them.""")
    @bullet("""This already is <b>much</b> harder to analyze (the queues are
    no longer independent).""")
    @bullet("""But a quick calculation showed that <b>more than 50%</b> of the
    time can be wasted on empty queues!""")
    @bullet("""I can't analyze anything but uselessly simple problems.  Time
    for empirical work - I need a simulator to make experiments.""")
    @end_slide()

    @end_part()

    @begin_slide("Part 3 - Software", "Software")
    @body("""The heaviest and longest part of the project was actually writing
    the simulation system.  But this less interesting to present so I'll make
    it short :-).""")
    @body("""More details about the architecture can be found in the full
    report, the documentation extracted from the code and the source code
    itself.""")
    @end_slide()

    @begin_part()

    @begin_slide("Python")
    @body("""I chose <b>Python</b> as my implementation language.""")
    @indent("""Python is an interpreted object-oriented programming language
    suitable (among other uses) for distributed application development,
    scripting, numeric computing and system testing.  Python is often compared
    to Tcl, Perl, Java, JavaScript, Visual Basic or Scheme.  To find out more
    about what Python can do for you, point your browser to
    http://www.python.org/.""")
    @body("Was it worth it?  Definitely yes!")
    @bullet("""Quick prototyping; I didn't feel that debugging takes most of
    the time...""")
    @bullet("""The definition of the simulation batch runs and their
    processing is what scripting languages are ideal for.""")
    @bullet("This presentation was created with two Python tools.")
    @bullet("In the end it was slow but that's a fair price to pay...")
    @end_slide()

    @begin_slide("City generation")
    @bullet("A Manhattan-style geometry.")
    @bullet("For more interest, strip 30% of the roads.")
    @bullet("With 3 and 4 roads, it's a junctions.")
    @bullet("With 2 roads, it's a long road continuation.")
    @bullet("With 1 roads, it's car source/drain.")
    @body("Like this:")
    <prefmt style="Code">@("""\
    +-O-O-O-+          @-+-+-O-@
    | | | | |                |
    O-O-O-O-O     \    +-O-O-O @
    | | | | |   ---\   | | | | |
    O-O-O-O-O       )  O-O-O-O-O
    | | | | |   ---/   |   |   |
    O-O-O-O-O     /    @   + +-O
    | | | | |              | | |
    +-O-O-O-+          @-+-+ +-+""")@# protect the numerous @'s...
    </prefmt>
    @end_slide()

    @begin_slide("Control specification")
    @body("""To implement a wide range of control strategies, a pipeline of
    plug-in filters was used, where each filter takes a list of queues
    considered for serving ad returns a new list (usually subset).""")
    @bullet("""This made specifying all desired control strategies
    surprisingly easy.""")
    @body("""This was further abstracted as orthogonally choosing several
    parameters, specified as strings:""")
    @bullet("free / hold<i>n</i> - switching rate")
    @bullet("fix / flex - adaptiveness of switching rate")
    @bullet("One of pricipal control strategies - see next slide")
    @bullet("rand / lru - tie breaking")
    @end_slide()

    @begin_slide("Control specification (cont.)")
    @body("The principal control strategies are:")
    @italic("blind")
    @indent("Completely dumb.  Decided by rand / lru.")
    @italic("nonempty")
    @indent("Similar but don't serve empty queues.")
    @italic("longest")
    @indent("Serve longest queue.")
    @italic("inorder")
    @indent("Serve in order of arrival")
    @italic("hist")
    @indent("""Serve queue predicted to empty last, according to measurements or load history.""")
    @end_slide()

    @end_part()

    @begin_slide("Part 4 - Simulations", "Simulations")
    @body("There were two serious runs:")
    @bullet("""The first was intended to probe various pararmeters to get some
    feeling and determine interesting parameters for the real run.""")
    @bullet("""With these parameters a much heavier simulation was run to
    provide high-quality data for the analysis.""")
    @end_slide()

    @begin_part()

    @begin_slide("Probing the ground")
    @body("""The first thing I wanted to check was how long I need to simulate
    and on how big a city, to get valid averaged results.""")
    @bullet("""I tried three city sizes and built graphs of total number of
    cars, cumulative mean delay and variance of delay, as a function of the
    simulation time; car sources were first on and after 4000 cycles were
    turned off.""")
    @bullet("""The conclusions was that 15x15 and 5000 cycles are good.""")
    @bullet("""The collected statistics are instructive on their own.""")
    @body("See the LaTeX report for the nice numerical tables.")
    @end_slide()

    @begin_slide("Conclusions")
    @body("""All non-blind strategies have almost equal delay (with
    unconstrained switching).""")
    @bullet("""Least-Recently-Used is <b>much</b> better than random serving.
    The magnitude of the difference surprised me.  This trend repeated in all
    following runs.""")
    @bullet("""In-order serving gives lower variance than all other.  This was
    expected.""")
    @bullet("""The load history measurement doesn't differ noticeably from
    just serving the longest queue.""")
    @body("""When serving each queue for 4 cycles a time, the results are
    similar.""")
    @bullet("For very low loads, serving in-order also gives lower delay!")
    @end_slide()

    @end_part()

    @begin_slide("Heavy car crunching")
    @body("""A more exhaustive simulation was run, with the following
    parameters:""")
    @bullet("15x15 cities.")
    @bullet("3 different city plans were simulated in parallel.")
    @bullet("5000 cycles.")
    @bullet("Higher loads: 0.15, 0.20, 0.23.")
    @bullet("""More control policies.  Switching rates: free / hold2 / hold4 /
    hold8, fixed / adaptive.""")
    @bullet("""Separate statistics for junctions with 3 and 4 roads, since
    they experience different loads.""")
    @body("""This amounted to 648 runs, 207,140,557 car-junctions and above 48
    hours of total run time :-).""")
    @end_slide()

    @begin_part()

    @begin_slide("Results")
    @body("""To display the full data I need an 8-dimensional table...  So I
    wrote a python script to take various cuts/projections of it, reorder the
    axes and create nicely-looking LaTeX tables.""")
    @body("First, I compared between junctions with 3 and 4 roads.")
    @bullet("""As suspected, there is a big difference.  So for precise
    results, I didn't averaged between them any longer.""")
    @body("Then I compared the 3 city plans, for same parameters.")
    @bullet("""There are very noticeable and quite systematic differences.""")
    @bullet("""For lower loads, the delays are always A > B > C.  For higher
    loads, B > A ~= C.  In all cases B has the highest deviation.""")
    @end_slide()

    @begin_slide("Results (cont.)")
    @bullet("""What in the geometry controls this?  I found only one thing: B
    had much more car sources/drains; they emit cars with lower
    auto-correlation than junctions, and this interferes with the control
    policy.""")
    @bullet("""So can we trust the other results, if so much depends on the
    city geometry?  Fortunately yes, because relations between the values are
    approximately the same for all plans.""")
    @body("Now let's compare the effect of the switching rate.")
    @bullet("""If the switching rate is limited, adaptive limiting gives lower
    delay than fixed one.  This makes sense.""")
    @bullet("""On the other hand, it can harm the fairness.""")
    @end_slide()

    @begin_slide("Results (cont.)")
    @body("Last, I compared the different control policies.")
    @bullet("""Basically, the results agree with the first run.""")
    @bullet("""With the increase in the load, the differences aren't smaller.
    It could be expected that when all queue are full, a blind policy won't
    have a higher delay.  Probably the load is not high enough.""")
    @bullet("""With slow switching rates, the policies do become similar.
    None of them can predict the future very well.""")
    @bullet("""As previously, serving in-order gives the lowest deviation but
    the delay isn't as low as when serving the longest queue.""")
    @end_slide()

    @end_part()

    @begin_slide("The bottom lines")
    @bullet("""First, avoid serving empty queues as much as possible.
    Choosing the longest queue is a good strategy to minimize this.  Breaking
    the tie by choosing the one whose front car arrived first is better
    yet.""")
    @bullet("""Second, flexibly controlling the green time is another way to
    reduce it.  Serve a queue as long as it has cars, when it empties, switch
    to another.""")
    @bullet("""Third, always prefer least-recently-used approaches to picking
    at random.  This helps both for delay and fairness.""")
    @bullet("""There is some trade-off between delay and fairness.  Serving in
    order of arrival is always most fair; however it is not very practical
    since if the switching rate is limited, it gives suboptimal delay.""")
    @end_slide()

    @begin_slide("Future directions")
    @body("""In this project I didn't get really interesting results; it was
    more of a foundation from which somebody can continue.  There are many
    ways.""")
    @bullet("""One could perform more research with the current simulator.
    The conditions tried are not representative of real-life traffic; higher
    loads, longer green times, longer roads and yellow lights would be
    interesting to explore.  The role of the city's geometry should be
    explored more; the current Manhattan-like geometry is very arbitrary.""")
    @bullet("""Implement logging/visualization facilities that would allow one
    to track the history of a single car (or a little group) and get a feeling
    of the system's behavior.  This could help to gain intuition for
    second-order effects.""")
    @end_slide()

    @begin_slide("Future directions (cont.)")
    @bullet("""Smarter car routing; a simple approach is to choose a route
    like now when a car is created and remove all cycles from it.""")
    @bullet("""Account for main/local roads; make cars prefer big roads.""")
    @bullet("""Each of the assumptions described at the first chapter could be
    lifted.  Serving multiple queues at once would be most valuable for
    getting closer to reality.""")
    @bullet("""The ultimate goal: devise control policies that involve
    communication between junctions.""")
    @bullet("""Use your imagination to continue this list...""")
    @end_slide()
    
   </section>
</presentation>

@# Local Variables:
@# paragraph-start: "[ 	]*$\\|[ 	]*\\(</?\\([_:[:alpha:]][-_.:[:alnum:]]*\\(?:[^\"'/><]\\|\"[^\"]*\"\\|'[^']*'\\)*\\)?>\\|@.*\\)"
@# End:
