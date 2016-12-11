 
# tIDE

Is Transportable IDE for SailfishOS devices.

All feature suggestions welcome! :)

Includes keyboard!

## Screenshots

<img src="https://cloud.githubusercontent.com/assets/11635400/21082725/1b47c23e-bfea-11e6-8324-96427c66b317.png" alt="Dark theme" style="width: 200px;"/>
<img src="https://cloud.githubusercontent.com/assets/11635400/21082726/1b493aa6-bfea-11e6-909b-44b506755b22.png" alt="Settings" style="width: 200px;"/>
<img src="https://cloud.githubusercontent.com/assets/11635400/21082724/1b47770c-bfea-11e6-86c2-3d232d494142.png" alt="Predictive text" style="width: 200px;"/>
<img src="https://cloud.githubusercontent.com/assets/11635400/21082723/1b467816-bfea-11e6-8614-53b3a88ffd50.png" alt="Building&Running" style="width: 200px;"/>

## Features

* Basic IDE features such as:
  * Syntax highlighting(Supports QML, JS & Python)
  * Create template SailfishOS projects
  * Auto completion (Installs new keyboard)
  * Running the application
  * Debug log while running the application
  * Building a RPM(experimental)
  * Keyboard has predictive text(Supports QML, JS & Python)

* Normal text editor features including:
  * Line numbering
  * Autosaving
  * Theming
  * Font settings
  * Indentation
  * Redo/Undo
  * Search

## Roadmap

Not in particular order..:)

* C++ support
  * Syntax highlighting
  * Predictive
  * Compiling
* Github/Gitlab gui
* Start as root
* Building
* OBS
* Help mode(API's)
* Icon and cover for harbour
* Harbour version
* App cover
* Fix line numbering
* Suggestions + Bugs

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
