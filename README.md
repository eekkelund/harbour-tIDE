 
# tIDE

tIDE, transportable IDE, is an application for SailfishOS to create new applications on the go! You can use it as pocket sized QtCreator or just normal text editor.

All feature suggestions and contributions welcome! :)

Includes keyboard and root mode!

![tIDE](https://github.com/eekkelund/harbour-tIDE/blob/devel/tide/icons/128x128/harbour-tide.png?raw=true "tIDE")
![tIDEroot](https://github.com/eekkelund/harbour-tIDE/blob/devel/roothelper/icons/128x128/harbour-tide-root.png?raw=true "tIDEroot")


## Features

* Basic IDE features such as:
  * Syntax highlighting ( QML, JS & Python)
  * Project template creation for SailfishOS
  * Autocomplete (Installs new keyboard)
  * Running your application
  * Application output & debug log
  * Building a RPM (experimental)
  * Installing built RPM
  * Predictive text (QML, JS & Python)

* Normal text editor features including:
  * Line numbers (experimental)
  * Autosave
  * Themes
  * Font settings
  * Indentation
  * Redo/Undo
  * Search
  * Launch from terminal (harbour-tide /path/to/file.txt)
  * Change file on the fly
  * Split view, only for large screens

* Keyboard:
  * Predictive text depending on what file opened
    * .qml = QML, properties, JS and common keywords
    * .js  = JS and common keywords
    * .py  = Pythons and common keywords
    * .*   = Common keywords
  * Tabulator button on Sym view
  * Arrow keys
    * On shift latched possibility to jump words
    * On shift down copying
  * Basic hardware support including common shortcuts 
    * CTRL+Z, CTRL+F, CTRL+S, CTRL combinations
    * SHIFT combinations
    * etc. etc.

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
  * Compiling*
- [ ] Git gui
- [X] Root mode
- [X] Building (kinda, needs more work)
- [ ] OBS
- [ ] Help mode(API's)
- [ ] Cover for harbour
- [X] Icon
- [ ] Harbour version
- [ ] App cover
- [ ] Fix line numbering
- [ ] Nemomobile version
- [ ] Breakpoints
- [X] About page
- [X] Add new file
- [X] Hw keyboard
- [X] File navigation
- [X] Arrow keys functionality
- [ ] Rewrite some Python parts
- [X] Tab button
- [X] UI for Tablet

## Installation

Download RPM from openrepos and `pkcon install-local harbour-tide`  

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

[Version 0.1](https://openrepos.net/content/eekkelund/tide) 21/12/2016

## Contributors

[wellef](https://github.com/wellef): Project deleting, wrap mode setting for the editor, Python bug fixes

Thank you! :)

## Credits

Base of the keyboard: Jolla's [maliit keyboard](https://github.com/maliit) and SaberAltria's [Dolphin keyboard](https://github.com/SaberAltria/harbour-dolphin-keyboard).  
Some highlighting rules and indentation: Oleg Yadrov's [QML Creator](https://github.com/olegyadrov/qmlcreator)  
SettingsPage slider: [Ancelad](https://github.com/Ancelad)  
Dedicated to: [Gido Griese](https://talk.maemo.org/member.php?u=60993)  
Icon: [gri4994](https://github.com/gri4994)  

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
