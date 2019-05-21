MP-Sim
======

[MP-Sim][1] is a simulator framework usable on both [MATLAB][2] and [Octave][3].
It can be integrated with [MATPOWER][4] for power systems related simulations.
Implementation was done by Haeyong (David) Shin as an undergraduate student at
Cornell University under the supervision of Ray D. Zimmerman.

System Requirements
-------------------

*   [MATLAB][2] version 7 (R14) or later, or
*   [GNU Octave][3] version 4.0 or later
*   [MP-Test][5], for running the MP-Sim test suite

Installation
------------

1.  Clone the repository, or unzip the zip file into the location
    of your choice. Do the same for MP-Test.  We will use ``<MPSIM>`` 
    to represent the path to the resulting ``mpsim`` directory.  The
    equivalent corresponds for ``<MPTEST>``.

2.  Add ``<MPSIM>/lib``, ``<MPSIM>/lib/t``, ``<MPTEST>/lib``, and
    ``<MPTEST>/lib/t`` to your MATLAB path.

3.  Run MP-Sim's tests by typing ``test_mpsim`` in the MATLAB console. You 
should see something like:
```matlab
t_mpsim_shared_x_numeric....ok
t_mpsim_shared_x_queue......ok
t_mpsim_process.............ok
t_mpsim.....................ok
t_burger_shop...............ok
t_burger_shop_2d............ok
t_opf_sim...................ok (8 of 8 skipped)
All tests successful (186 passed, 8 skipped of 194)
Elapsed time 0.94 seconds.
```
Additional test cases will be run if [MATPOWER][4] is installed.

Usage
-----

*   Type ``burger_shop().run('burger_shop_example', 'T', 5, 'R', 1);`` to run
    a simulation of a burger shop that will run for 5 periods. The console should
    produce a summary of the simulation, part of which is shown here:

```
Results for run 1 :
                                                                                      inventories
period   day   hr   ordered    delivered   defrosted   grilled   sold             frozen   thawed   grilled
------   ---   --   -------    ---------   ---------   -------   ----             ------   ------   -------
                                                                                    700      100      25 
    1      1     1   1950          0           0          12       21               700       88      16
    2      1     2      0          0         310          54       46               390      344      24
    3      1     3      0        700           0         171      166              1090      173      29
    4      1     4      0          0         120         133      140               970      160      22
    5      1     5      0          0           0         108       99               970       52      31

total:               1950       700         430        478      472
End of run 
```

*   Add in more options to the struct before running the simulation.  
    Example: ``burger_shop().run('burger_shop_example', 'T', 5, 'verbose', 1)``
    will run the same burger shop but print more information to the console
    during the simulation.

Documentation
-------------

There are two primary sources of documentation for MP-Sim. The first is
the [MP-Sim User's Manual][6], which gives an overview of the capabilities
and structure of MP-Sim and provides an example of creating your own MP-Sim
simulation. It can be found in your MP-Sim distribution at
`<MPSIM>/docs/MP-Sim-manual.pdf`
and the latest version is always available at:
<https://github.com/MATPOWER/mpsim/blob/master/docs/MP-Sim-manual.pdf>.

And second is the built-in `help` command. As with the built-in
functions and toolbox routines in MATLAB and Octave, you can type `help`
followed by the name of a command or M-file to get help on that particular
class or function. All of the M-files in MP-Sim have such documentation.

Contributing
------------

Please see our [contributing guidelines][7] for details on how to
contribute to the project or report issues.

License
-------

MP-Sim is distributed under the [3-clause BSD license][8].

----
[1]: https://github.com/MATPOWER/mpsim
[2]: https://www.mathworks.com/
[3]: https://www.gnu.org/software/octave/
[4]: https://github.com/MATPOWER/matpower
[5]: https://github.com/MATPOWER/mptest
[6]: https://github.com/MATPOWER/mpsim/blob/master/docs/MP-Sim-manual.pdf
[7]: CONTRIBUTING.md
[8]: ./LICENSE
