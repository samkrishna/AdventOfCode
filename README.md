# Advent of Code

These are solutions for the [Advent of Code](https://adventofcode.com) puzzles.

They are constructed in the following four languages:

- Objective-C
- Swift
- Python 3.x
- Racket

## Structure

Currently, the repo for a given year is organized as follows:

- &lt;year&gt;
- applelang (for both Objective-C and Swift using Xcode IDE)
- python3 (using Wing IDE)
- racket (using DrRacket IDE)

Right now, only 2018 has any entries filled out.

### Python 3

I'm using Python 3.7.0 with [pyenv](https://github.com/pyenv/pyenv) and [pipenv](https://pipenv.readthedocs.io/en/latest/) for dependency management. In case you've never encountered this configuration before, I recommend the following link: [Why you should use pyenv + Pipenv for your Python projects](https://hackernoon.com/reaching-python-development-nirvana-bb5692adf30c)

I've also configured [WingIDE Pro](https://wingware.com/downloads/wing-pro) (currently v. 6.1.2) to use the pipenv shell environment. If you want to use WingIDE with the Pipenv environment, you'll need to get the pipenv path information **AFTER** you get pipenv working. You can do this by running the following command:

```
$ pipenv --venv | pbcopy
```

which you then paste into the WingIDE Project properties, with the following addendum:

```
<Pipenv shell path prefix>/AdventOfCode-AdSqjYm2/bin/python3
```

And you should be good to go.
