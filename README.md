cgminer-sh
==========

CGMiner API access using BASH and a short Python script.

Requires Python 2.x (tested on 2.6) and BASH 4.x (tested on 4.2).

## Overview
This is a small framework to access the CGMiner API from the Linux shell.

It provides call.sh, which takes a single parameter of an API call as defined in the [CGMiner documentation](https://github.com/ckolivas/cgminer/blob/master/API-README).
Example command:
```
call.sh summary
```

This would call "summary" on the API, giving some basic statistics.

## Example Usage
There is an example script in the scripts folder which checks that CGMiner is still running correctly. I run this as a cron job every 10 minutes.

## License
Released under the MIT license as follows:

```
The MIT License (MIT)

Copyright (c) <2014> <Alex Shepherd (n00bsys0p)>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
