# AssemblyCrashCourse
Code-along Examples for the
[6502 Assembly Crash Course Video](https://www.youtube.com/watch?v=yEiNs7pKNh8).

## Building the Examples

### Via VSCode
The examples in this project are meant to be built using VSCode via the ca65
Macro Assembler Language extension. I made a
[YouTube video](https://www.youtube.com/watch?v=RtY5FV5TrIU&t=0s) that explains
how to set up a windows development environment.

### Via cl65
You can also build the examples directly from the command-line using the cl65
binary distrubuted as part of CC65. Here's an example of how to build the first
example from the repository root:

```
$ cl65 --verbose --target nes wrapper.s examples/01_XandY.s ; mv wrapper wrapper.nes
```

Note: The "wrapper" code does some basic setup and executes the routine defined
by the example files.

## License
MIT

