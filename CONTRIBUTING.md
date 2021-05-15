[#](#) CONTRIBUTING

<details> <summary>Contents</summary>

- [Sharing  is Good](#sharing-is-good)
- [Standard Structures](#standard-structures)
- [Version Control](#version-control)
- [Open Source Licenses](#open-source-licenses)
- [Long Term Storage, Cite-able](#long-term-storage,-cite-able)
- [Testing](#testing)
  - [Linting](#linting)
  - [Unit Testss](#unit-testss)
- [Code Formatting](#code-formatting)
- [Documentation](#documentation)

</details>

## Sharing  is Good

Science is a community sharing a  set of ideas  and tools,
where everyone does each other the courtesy of trying and
critiquing and improving each other ideas.
The more code is shared, the more we can understand it
and, hence, learn  how to write better code.

For code to be shared:

- It should be well organized using a standard structure.
- It should be under version control.
- It should be unencumbered of  propitiatory licenses.
  Hence, you need an **open source license**. 
- It should be accessible for now and for all time in the future.
  Your code needs to be **mirrored** 
  in some long-term, cite-able, repository.
- It should to be  trusted by the community. This means that it needs a good
  **test suite**.
- It needs to be effectively **documented**.

## Standard Structures

Your repo is your resume. Make it look good-- you will be judged by its  contents.

Here's the structure of this repo showing some of the standard bits:

- `./.gitignore` : files never to share (eg. tmp directories). The contents of
  this file depend on the platform/tools you are using 
   (e.g. for Mac, see [Macos.gitignore](https://github.com/github/gitignore/blob/master/Global/macOS.gitignore).
   To find the right things to ignore for your toolset, see e.g. [the gitignore repo](https://github.com/github/gitignore).
- `./.travis.yml` : post-commit hook for running unit tests. Discussed  [below](#unit-tests).
- `./CODE_OF_CONDCT.md` :  in an open source community, your greatest  resource is other programmers.
   Be polite. Be helpful. Be inclusive. 
- `./CONTRIBUTING.md` : notes on what is expected for code in this  repo (i.e. what you are reading  right now).
- `./LICENSE.md` : a statement on how this work can be  shared
- `./README.md` : some quick intro notes. Also, good place to show your badges to let folks see, at a glance, what
  this is all about. e.g.
  - [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4728990.svg)](https://doi.org/10.5281/zenodo.4728990) : code is available, forever, is  some long term storage facility;
  - [![Build Status](https://travis-ci.com/timm/lunar.svg?branch=main)](https://travis-ci.com/timm/lunar) : code is being
    tested, each  time it is committed;
  - ![](https://img.shields.io/badge/linting-luac-brown) : each time the code is saved, we lint it for errors.
  - and others beside.
- `./data/` : place to store the demo data files
- `./docs/` : contains documentation generated from the code
- `./ell` : (Optional) contains shell programming tricks. To use, type `sh ell`.
     This file defines (e.g.)
   - A `gp` command that is my "save to github shortcut". FYI, `gp` runs      
     `git add *;git commit -am save;git push;git status`
   - A `vi` command that starts up VIM with all my preferred packages installed (using config files
     from `./etc/vimrc`);
   - A `vims` command that updates all my VIM packages.
   - A `tmux` command that gives me a nice terminal-based multi-window envrionment.
- `./etc/` : place to store miscellaneous files; e.g. all the config files needed by `./ell`.
   Keeps the rest of the repo clean and simple.
- `./requirements.txt` : lists code dependencies. Before trying to run this code,
   first check that you have all these dependancies.
- `./src/` : place for the source code
  - `./src/eg.moon` : all my unit tests. Note that
     - My `./travis.yml` gets all its  unit tests from `./src/eg.moon`.
     - An alternate approach is to have a separate test directory `./tests` for all the unit
     tests. That is a really good approach when  lots of people are writing lots of test files.

If you want to add more directories, feel free. 
But consider using  [standard directory names](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard#Directory_structure).
And where possible, do not clutter up the root.

## Version Control

Git. Enough  said. Just do it.

## Open Source Licenses

(To add a license to your repo, add a  [LICENSE.md](https://github.com/timm/lunar/blob/main/LICENSE.md)
file to the root of your repo.)

Open source licenses are licenses that comply with the Open Source Definition— 
in brief, they allow software to be freely used, modified, and shared. 

There are many different kinds of license and there are [on-line tools](https://choosealicense.com)
to help you decide which one is right for you.

- Choose anything you like but be aware the 
  [more esoteric you get](http://www.wtfpl.net), the fewer people will use your code.
- In practice, most folks using the MIT license or (if you are worried
  about patent trolls) the Apache license. 
  - The former is preferred for lightweight projects while the latter 
    requires a lot of documentation. 
  - E.g. see how much work goes into the [Zehyphr release notes](https://github.com/zephyrproject-rtos/zephyr/releases/tag/zephyr-v2.5.0) 
    (and Zephyr uses the Apache license).


## Long Term Storage, Cite-able

(Your repo needs a "digital object idenitifier" badge that assigns a unique ID
to your code _and_ which backs up a copy of the code to some long term storage. 
To check for that badge, look for something like:

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4728990.svg)](https://doi.org/10.5281/zenodo.4728990)

This badge makes the code "cite-able".)

Github repos are temporary, they  can be deleted. For
someone to trust  code, they must trust they can  access
it both now and in the  future.
Developers need to
registered their repo at some long-term storage facility  like Zenodo. There:

- It you make a release in Github
- Zenodo will grab a zipped copy and store it on its
hard drives (somewhere in Switzerland) and issues you with a "DOI" (digital object
identifier) 

For notes on that process, see [here](http://guides.github.com/activities/citable-code/).


##  Testing

Unit tests are run (e.g.) every time you commit to a repo. Those tests can take
a while to run. In-between times, whenever you save a file, there are  some fast lint  tests
that look for illegal code.

### Linting

In a washing machine,
the lint filter  is that part of a washing machine that catches  the little fluffy bits
you do not want in  your clothes. In programming, a lint filter is a code that quickly
catches  dubious code constructs.

You need some linting for your code development. For Python, see the 
`pyflakes` (not to be confused  with `flake8` that includes both linting and code formatting,
see below).

Whenever you save a file, there are  some fast lint checks
that look for illegal code.
For example, for my lua code, I use VIM editor and the `vim-syntastic` add-on. 
This code checks for code quirks, every time a file is saved. For example, the following
error suggests that  some `end` keyword is missing in a function.

      some.lua|41 error| 'end' expected (to close 'function' at line 16) near <eof>

Very handy!


### Unit Testss

(Your repo needs a [.travis.yml](https://github.com/timm/lunar/blob/main/.travis.yml)
that adds a "post-commit hook" to the  repo. This hook runs a test suite each time
the code is committed. This, in turn, updates a badge on your repo that  tells people
your code has  tests and those tests are working.)

[![Build Status](https://travis-ci.com/timm/lunar.svg?branch=main)](https://travis-ci.com/timm/lunar)

To code the test suite, you need something that runs and returns 
the shell flag _$?=0_ (if there 
are no errors) or _$?&gt;0_ (if errors were found). This is simple- just have a demo
suite that does some asserts. If those asserts fail, your code will crash  and set
_$?&gt;0_.

As to how to write the test suite, there are any number of unit test tools.
And its easy to write your own. For example, the  test suite here  is inside
[./src/eg.moon](https://github.com/timm/lunar/blob/main/src/eg.moon). This code can be called in
three ways:

- `cd src; ./eg.moon` which just runs everything;
- `cd src; ./eg.moon ?` which lists all the  available tests;
- `cd src; ./eg.moon xxx` which runs just test `xxx`. This last call
  is very handy when writing and debugging just on example.


## Code Formatting

Imagine a lecture room where your code is being  displayed for students to read  and  discuss.
Or a book,  discussing code. For that to work:

- The code has to be  short (functions, methods, less than a few dozen  lines).
- The code has to be not too wide (less than 80 characters). Hence, this code uses 
  two  spaces for tabs. FYI, to implement that in the VIM editor, add this line to
  top of file:

     -- vim: ts=2 sw=2 et :

OPTIONAL: There are automatic style checking plugins for most editors such
as (for Python)  the PEP8
add-on  (also known as Pycodestyle) available in most programming editors that auto-formats
the code every time you save it. FYI- PEP8 can be a little verbose
(it refuses to let you write short one-line methods  as  one line) but you might find it useful.

## Documentation

Code needs to be understood. It needs pretty prints that shows comments with the code,
and perhaps even
syntax highlighting for the keywords in the code (though some prefer to show comments in the doco,
but not the code--  its a matter of taste).

There are  any number of tools for that purpose. Here:

- We create a directory `./docs
  master index file `./docs/index.html`
- We tell Github to serve `./docs` as a website (see  
  see https://github.com/yourName/yourProject/settings/pages).
- Then we use a [shell script](/etc/moon2md) to convert `src/*.moon` to `docs/*md`.
  that describe the code.
  - To see that documented, please go to [this project's doco site](http://menzies.us/linar).

Now that is the simplest path. Feel free to be more sophisticated:
- [pdoc3](https://pdoc3.github.io/pdoc/)
- [Sphinx](https://www.sphinx-doc.org/en/master/)
- [Pandoc](https://pandoc.org) and many more besides.  FYI: pdoc3 is  a personnel
  favorite.

No  matter what documentation framework you use, always know that the main cost
of documentation is not setting up the framework. Rather, its organizing your
thoughts to generate succinct, useful docs. Good luck with that.

