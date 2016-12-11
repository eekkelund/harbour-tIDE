 
# Project Name

tIDE

Is Transportable IDE for SailfishOS devices.

All feature suggestions welcome! :simple_smile:

Includes keyboard!

## Features

*Basic IDE features such as:
**Syntax highlighting(Supports QML, JS & Python)
**Create template SailfishOS projects
**Auto completion (Installs new keyboard)
**Running the application
**Debug log while running the application
**Building a RPM(experimental)

*Normal text editor features including:
**Line numbering
**Autosaving
**Theming
**Font settings
**Indentation

## Roadmap

Not in particular order..:)

1. C++ support
**Syntax highlighting
**Predictive
**Compiling
2. Github/Gitlab gui
3. Start as root
4. Building
5. OBS
6. Help mode(API's)
7. Icon and cover for harbour
8. Harbour version
9. App cover
10. Fix line numbering
11. Suggestions + Bugs

## Installation

Download RPM from openrepos and `pkcon install-local harbour-tide`
Restart maliit-server `systemctl --user restart maliit-server.service` 

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

No releases yet :)

## Credits

Parts of keyboard are taken from Jolla's [maliit](https://github.com/maliit) keyboard and SaberAltria's [Dolphin keyboard](https://github.com/SaberAltria/harbour-dolphin-keyboard). 
Snippets of code also loaned from Oleg Yadrov's [QML Creator](https://github.com/olegyadrov/qmlcreator)
Thanks for SettingsPage slider belongs to [Ancelad](https://github.com/Ancelad)

## License

Distributed under the GPLv3 license. See ``LICENSE`` for more information.
    
    Copyright (C) 2016  Eetu Kahelin

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
