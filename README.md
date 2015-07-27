# Flog plugin for TextMate 2

by Nat Budin<br/>
With inspiration from [Rubocop.tmbundle](https://github.com/fazibear/Rubocop.tmbundle) by Michal Kalbarczyk

## Features

* Automatically runs [Flog](http://ruby.sadi.st/Flog.html) on your Ruby code and puts clickable warning signs in the gutter for complex methods
* Can produce a detailed Flog complexity report (using a menu command)

## Installation

Make sure `$TM_RUBY` is set, then run:

```bash
gem install flog
mkdir -p ~/Library/Application\ Support/Avian/Bundles
cd ~/Library/Application\ Support/Avian/Bundles
git clone https://github.com/nbudin/Flog.tmbundle.git
```

## Contributing

Fork the repo and make me a pull request.  This is my first TextMate 2 plugin; I'm sure I have a lot to learn about how to do it well, so please feel free to improve stuff where it looks like I don't know what I'm doing (because I don't).

## License

This plugin is distributed under the terms and conditions of the MIT License.  See the LICENSE file for details.