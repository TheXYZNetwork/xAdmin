# xAdmin
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-3-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->
A free and basic administration system for Garry's Mod.


## What is xAdmin?
xAdmin is a lightweight and simplistic administration tool made with the intent to fit the gap that is currently made by these heavy and feature rich administation systems currently available on Garry's Mod. xAdmin tries to be lightweight and simplistic by only providing the core features needed. xAdmin doesn't even have a User Interface, it is 100% chat/console driven 

## Requirements
~~xAdmin currently requires [MySQLoo](https://github.com/FredyH/MySQLOO) in order to work. I have intentions to allow it to work internally at some point, but for now, it requires [MySQLoo](https://github.com/FredyH/MySQLOO).~~
Running xAdmin as is has no requirements, it's plug and play. If you wish to store your data in MySQL (Suggested), you will need the [MySQLoo](https://github.com/FredyH/MySQLOO) module installed on your server.

## If it's simplistic, why should I use it?
Systems like [ULX](https://github.com/TeamUlysses/ulx) have the goal to be as feature rich as possible and meet the needs of everyone. xAdmin simply wants to provide the base utilities to help you and your team manage your servers.

## A quick rundown
xAdmin is completely chat/console based when being interacted with in-game. This is to keep things as simple as possible. Like other popular admin systems, commands are (by default) prefixed with ``!``. Running a command like ``!god Owain`` through chat will target and god the user ``Owain``. All commands can also be run through the console with ``xadmin <command> <arguments>``. When running chat commands, all words after the initial words are considered individual arguments. In order to pass multiple words as 1 argument, you can surround them in ``"``. This will pass the collections of words as a single argument.

## Install/Config
You can find a guide on installing and configuring xAdmin [here](https://github.com/OwjoTheGreat/xadmin/wiki/Getting-Started). It should give you the general idea of how everything works along with a simple guide on how to install and configure it.

## Documentation
I have created a [simple wiki](https://github.com/OwjoTheGreat/xadmin/wiki) that documents every class and function that xAdmin has. It will show you the arguments they take and what they return. Some functions/classes may have notes informing you of extra information needed. For example: The ban function will not kick the user if they're online.

I have also [documented](https://github.com/OwjoTheGreat/xadmin/wiki/Commands) all the default commands that come with xAdmin along with the arguments they take and what they do.

## Contributions
I encourage you to contribute to this. If it's a small bug fix or adding a command, all contributions are welcome. If you spot a better way of doing something, submit it! The best way to improve stuff is through collaboration. 

## Extensions
Here is a list of verififed or official xAdmin extensions. They're either made by us or approved by us. If you wish to have an xAdmin extension added to the list, just open an issue!
- [**xWarn**](https://github.com/TheXYZNetwork/xWarn) - An addon for xAdmin that allows you to warn players for breaking the rules.
- [**xSGroups**](https://github.com/TheXYZNetwork/xSGroups) - An addon for xAdmin that allows you to set a secondary usergroup in addition to their primary usergroup.

## Credits
- [Owain](https://github.com/OwjoTheGreat)
- [Jake](https://github.com/JakeButterfield)
- [Dr.Pepper](https://github.com/DrPepperG)
- [Livaco](https://github.com/Livaco)
- [Lapin](https://github.com/ExtReMLapin)
- [pack](https://github.com/realpack)
- [MilkGames](https://github.com/MilkGames)
- [CL34R](https://github.com/CL34Rdev)
- [NoSharp](https://github.com/NoSharp)

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://0wain.xyz/"><img src="https://avatars.githubusercontent.com/u/15251181?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Owain</b></sub></a><br /><a href="https://github.com/TheXYZNetwork/xAdmin/commits?author=owainjones74" title="Code">💻</a> <a href="#maintenance-owainjones74" title="Maintenance">🚧</a></td>
    <td align="center"><a href="http://jakebutterfield.co.uk/"><img src="https://avatars.githubusercontent.com/u/12650145?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Jake Butterfield</b></sub></a><br /><a href="https://github.com/TheXYZNetwork/xAdmin/commits?author=JakeButterfield" title="Code">💻</a></td>
    <td align="center"><a href="https://jcra.dev/"><img src="https://avatars.githubusercontent.com/u/17168168?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Dr.Pepper</b></sub></a><br /><a href="https://github.com/TheXYZNetwork/xAdmin/commits?author=DrPepperG" title="Code">💻</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!