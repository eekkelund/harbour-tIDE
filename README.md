 
# tIDE

tIDE, transportable IDE, is an application for SailfishOS to create new applications on the go! You can use it as pocket sized QtCreator or just normal text editor.

All feature suggestions and contributions welcome! :)

Includes keyboard and root mode!

Winner of [Maemo Coding Competition 2016-2017 "Something new"](https://wiki.maemo.org/index.php?title=Maemo.org_Coding_Competition_2016#Results) category

Check also [tIDEditor](https://github.com/eekkelund/harbour-tIDEditor), Jolla Store allowed version of tIDE.

![tIDE](https://github.com/eekkelund/tide/blob/devel/icons/128x128/harbour-tide.png?raw=true "tIDE")
![tIDEroot](https://github.com/eekkelund/harbour-tIDE/blob/devel/roothelper/icons/128x128/harbour-tide-root.png?raw=true "tIDEroot")
![tIDEditor](https://github.com/eekkelund/tide/blob/devel/icons/128x128/harbour-tide-editor.png?raw=true "tIDEditor")


## Features

* Basic IDE features such as:
  * Syntax highlighting ( QML, JS, Bash & Python)
  * Project template creation for SailfishOS
  * Autocomplete (Installs new keyboard)
  * Running your application
  * Application output & debug log
  * Building a RPM (experimental)
  * Predictive text (QML, JS & Python)
  * Installing built RPM

* Normal text editor features including:
  * Line numbers
  * Autosave
  * Themes
  * Font settings
  * Indentation
  * Redo/Undo
  * Search
  * Launch from terminal (harbour-tide /path/to/file.txt)
  * Change files on the fly
  * Split view. And possibility to move separator
  * Set as default editor
  
* Root mode features:
  * Edit UI, application or system files. You name it!
  * Possibility to run applications in /usr/share

* Keyboard:
  * Predictive text depending on what file opened
    * .qml = QML, properties, JS and common keywords
    * .js  = JS and common keywords
    * .py  = Pythons and common keywords
    * .sh  = Bash and common keywords
    * .*   = Common keywords
  * Tabulator button on Sym view
    * Tab settings real tab "\t" or amount of spaces
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
![Predictive text](https://cloud.githubusercontent.com/assets/11635400/22042196/ceeb9e9c-dd12-11e6-9fb9-2c383892bea4.png "Predictive text")
![Building&Running](https://cloud.githubusercontent.com/assets/11635400/21082872/471b3bb8-bfed-11e6-85da-31bc6aa4f333.png "Building & Running")
![App output](https://cloud.githubusercontent.com/assets/11635400/21133077/c1fb2ef0-c11f-11e6-869b-facc0689d669.png "App output")
![Build output](https://cloud.githubusercontent.com/assets/11635400/22043760/d8b025ae-dd19-11e6-8665-000151fc3222.png "Build output")
![File open in split view](https://cloud.githubusercontent.com/assets/11635400/22042203/d5e80f14-dd12-11e6-9254-92c6269b63d2.png "File open in split view")
![Draggable separator](https://cloud.githubusercontent.com/assets/11635400/22042212/db53bd86-dd12-11e6-8293-c00726ec1c40.png "Draggable separator")
![File open](https://cloud.githubusercontent.com/assets/11635400/22042219/e339b94c-dd12-11e6-8668-730f419b342e.png "File open")

## To Do

Not in particular order..:)

- [ ]  C++ support (v.0.3)
  * Syntax highlighting
  * Predictive
  * Compiling*
- [ ] Git gui (v.0.3)
- [X] Root mode
- [X] Building (kinda, needs more work)
- [ ] OBS(v.0.3-0.4)
- [ ] Help mode(API's)(v.0.3-0.4)
- [ ] Cover for harbour
- [X] Icon
- [X] Harbour version(v.0.2.6 Submitted to Jolla store) [tIDEditor](https://github.com/eekkelund/harbour-tIDEditor)
- [ ] App cover(v.0.3-0.4)
- [X] Fix line numbering YEA
- [ ] Nemomobile version(v.0.5)
- [ ] Breakpoints(v.0.5)
- [X] About page
- [X] Add new file
- [X] Hw keyboard
- [X] File navigation
- [X] Arrow keys functionality
- [ ] Rewrite some Python parts(v.0.5)
- [X] Tab button
- [X] UI for Tablet
- [ ] Create patches(v.0.3)
- [ ] .pro file parsing(v.0.3)
- [ ] More highlighting(v.0.3)
- [ ] Settings for topbar(v.0.3)
- [ ] Icon edit?

## Installation

Download RPM from openrepos and `pkcon install-local harbour-tide`
If you have problem when installing try `pkcon refresh` and then try to install again. 

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

[Version 0.2.5](https://openrepos.net/content/eekkelund/tide) 31/01/2017  
[Version 0.2](https://openrepos.net/content/eekkelund/tide) 18/01/2017  
[Version 0.1](https://openrepos.net/content/eekkelund/tide) 21/12/2016

[Changelog](https://github.com/eekkelund/harbour-tIDE/blob/master/rpm/harbour-tide.changes)

## Contributors

[wellef](https://github.com/wellef): Project deleting, wrap mode setting for the editor, Python bug fixes
[GoAlexander](https://github.com/GoAlexander): Icon for searchbar  

### Translations

[eson57](https://github.com/eson57): Swedish  
[d9h02f](https://github.com/d9h02f): Dutch  

Thank you! :)

## Credits

Base of the keyboard: Jolla's [maliit keyboard](https://github.com/maliit) and SaberAltria's [Dolphin keyboard](https://github.com/SaberAltria/harbour-dolphin-keyboard).  
Better 'root@tIDE' script [elros34](https://talk.maemo.org/showpost.php?p=1522202&postcount=28)  
SettingsPage slider: [Ancelad](https://github.com/Ancelad)  
Dedicated to: [Gido Griese](https://talk.maemo.org/member.php?u=60993)  
Icon: [gri4994](https://github.com/gri4994) SVG: [topiasv-p](https://github.com/topiasv-p)  

## License

Distributed under the GPLv3 license. See ``LICENSE`` for more information.
    
    Copyright (C) 2016-2017  Eetu Kahelin

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
