 
# tIDE

transportable IDE for SailfishOS devices.

All feature suggestions and contributions welcome! :)

Includes keyboard!

![tIDE](https://github.com/eekkelund/harbour-tIDE/blob/devel/tide/icons/128x128/harbour-tide.png?raw=true "tIDE")


## Features

* Basic IDE features such as:
  * Syntax highlighting ( QML, JS & Python)
  * Project template creation for SailfishOS
  * Autocomplete (Installs new keyboard)
  * Running your application
  * Application output & debug log
  * Building a RPM (experimental)
  * Predictive text (QML, JS & Python)

* Normal text editor features including:
  * Line numbers (experimental)
  * Autosave
  * Themes
  * Font settings
  * Indentation
  * Redo/Undo
  * Search

## Screenshots

![Dark theme](https://cloud.githubusercontent.com/assets/11635400/21082871/471aff54-bfed-11e6-8a35-63c3fbb066a8.png "Dark theme in editor")
![Settings](https://cloud.githubusercontent.com/assets/11635400/21082870/471a3cfe-bfed-11e6-8792-a330cea85d68.png "Settings")
![Predictive text](https://cloud.githubusercontent.com/assets/11635400/21082873/471b61d8-bfed-11e6-9a6e-c328f6371804.png "Predictive text")
![Building&Running](https://cloud.githubusercontent.com/assets/11635400/21082872/471b3bb8-bfed-11e6-85da-31bc6aa4f333.png "Building & Running")
![App output](https://cloud.githubusercontent.com/assets/11635400/21133077/c1fb2ef0-c11f-11e6-869b-facc0689d669.png "App output")
![Build output](https://cloud.githubusercontent.com/assets/11635400/21133076/c1fa9ee0-c11f-11e6-9d8b-588c3f4b6780.png "Build output")
  
## To Do

Not in particular order..:)

- [ ]  C++ support
  * Syntax highlighting
  * Predictive
  * Compiling

- [ ] Github/Gitlab gui
- [ ] Start as root
- [ ] Building
- [ ] OBS
- [ ] Help mode(API's)
- [ ] Cover for harbour
- [X] Icon
- [ ] Harbour version
- [ ] App cover
- [ ] Fix line numbering
- [ ] Suggestions + Bugs
- [ ] Nemomobile version
- [ ] Breakpoints
- [X] About page

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

Base of the keyboard: Jolla's [maliit keyboard](https://github.com/maliit) and SaberAltria's [Dolphin keyboard](https://github.com/SaberAltria/harbour-dolphin-keyboard).  
Some highlighting rules and indentation: Oleg Yadrov's [QML Creator](https://github.com/olegyadrov/qmlcreator)  
SettingsPage slider: [Ancelad](https://github.com/Ancelad)
Dedicated to: [Gido Griese](https://talk.maemo.org/member.php?u=60993)

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
