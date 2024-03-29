![cmdclick_image](https://user-images.githubusercontent.com/55217593/199425521-3f088fcc-93b0-4a84-a9fd-c75418f40654.png)  
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)]((https://opensource.org/licenses/MIT))
# Command Click
Shellscript gui platform made with 100% shell script (fzf, yad, etc)

![範囲を選択_032](https://user-images.githubusercontent.com/55217593/199426265-5e62eea3-5a19-4129-9e66-c7f898328f20.png)

It's a shellscript manager app from gui that have execution, edit, delete, and create as feature.

Pros
----
- Easily turn shellscript into a GUI application.
- Versatile usage for Terminal, Crome, OS setting, etc.
- Ritch key bind.
- List shellscript.

Table of Contents
-----------------
<!-- vim-markdown-toc GFM -->

* [Installation](#installation)
  * [For windows 10](#for-windows-10)
  * [For Ubuntu or Debian](#for-ubuntu-or-debian)
  * [For other Linux](#for-other-linux)
* [Upgrading](#upgrading)
  * [Upgrading for windows 10](#upgrading-for-windows10)
  * [Upgrading for Ubuntu or Debian](#upgrading-for-ubuntu-or-debian)
* [Demo](#demo)
* [Usage](#usage)
  * [Launch](#launch)
  * [Add](#add)
  * [Run](#run)
  * [Edit](#edit)
  	* [by gui](#by-gui)
  	* [by editor](#by-editor)
  	* [description by gui](#description-by-gui)
  * [Exit](#exit)
  * [Move](#move)
  * [Install](#install)
  * [Setting](#setting)
  * [Delete](#delete)
  * [App directory manager](#app-directory-manager)
      * [Launch](#launch)
      * [Add](#add)
      * [Change directory](#change-directory)
      * [Edit](#edit)
      * [Exit](#exit)
      * [Delete](#delete)
  * [Shell to Gui](#shell-to-gui)
  * [Shortcut table](#shortcut-table)
  * [Trouble Shouting](#trouble-shouting)
  	 * [Not Startup](#not-startup)
  * [Android version](#android-version)


Installation
-----
### For windows 10
1. Downlaod [installer.bat](https://drive.google.com/file/d/1XqA2EhTeLQnFtFSh87D1oWIh96Hna1w_/view?usp=share_link) from google drive
2. Double click installer.bat

  	- Support Ubuntu20.04+
	- for windows 11, disable wayland, but it's unconfirmed operation

### For Ubuntu or Debian

- Only X11 support (wayland not support)
- Support Ubuntu20.04+

```
git clone https://github.com/kitamura-take/cmdclick.git ~/.cmdclick
cd ~/.cmdclick/linux/install
bash installer.sh
```

### For other Linux


- Only X11 support (wayland not support)
- It's unconfirmed operation

```
git clone https://github.com/kitamura-take/cmdclick.git ~/.cmdclick
cd ~/.cmdclick/linux/install
vi installer.sh
# please replace apt with your package system cmd, which is yum
bash installer.sh
```


Upgrading.
-----
### Upgrading for windows10
1. delete $HOME/cmdclick directory
2. same as installation.


### Upgrading for Ubuntu or Debian
1. delete $HOME/.cmdclick directory
2. same as installation.


Demo
-----
![show_cmdclick_from_execute_to_always_edit_execute](https://user-images.githubusercontent.com/55217593/201512545-d2134cd4-8490-41ce-b004-84b5a99ac4fe.gif)

demo flow
1. add -> run -> edit by gui -> run -> edit by editor -> run
2. edit by gui -> set `editExecute`(`ONCE`) -> run -> `setVariableType`(`CB`) -> run
3. edit by gui -> set `editExecute`(`ALWAYS`) -> run -> `setVariableType`(`NUM`) -> run
4. Install shellscript -> run -> add -> run
5. edit by gui -> set `editExecute`(`ALWAYS`) -> run 
6. edit by gui -> set `TerminalDo`(`OFF`) -> run 

Usage
-----
CommandClick will launch shellscript platform, read shellscript from $HOME/cmdclick/default or etc.

### Launch

##### for windows
First, type windows key and "cmdclick", then click `cmdclick` icon   
Or key down ctrl+alt+c as shrotcut key. (if your shortcut key is this, change by right click at cmdclick_shortcut.link in desktop)

##### for Linux
Type `cmdclick` for search in menu.
(It's easier to make a keybind)

### Add

Add file to command click

1. Type alt+a, that way, open source file.
2. Write the file name you want to set at shellFileName between `SETTING_SECTION_START` and `SETTING_SECTION_END.
    - Set the various settingVriables below as necessary

    | settingVariable| set value | description  |
    | --------- | --------- | ------------ |
    | `terminalDo` | `ON`/`OFF` | whether to run in terminal   |
    | `openWhere`  | `CW`/`NT` | when runing in terminal, whether to run current tab  or new tab  |
    | `terminalFocus` | `ON`/`OFF`  | whether to forcus to terminal    |
    | `editExecute`  | `N`/`C`/`E` | before running shellscript, you can edit settingVriable(NO: no, ONCE: one time edit ALWAYS:always edit)          |
    | `setVariableType` | string  | when edit, whether to set variable type to commandVariable. You also have multiple specifing this. In detail, follow bellow. |
    | `afterCommand` | command | before run shellscript, run command |
    | `afterCommand` | command | before run shellscript, run command |
    | `ExecBeforeCtrlCmd` | command | before run shellscript, run cmdclik crtl command (prefix NO: only apply when editExecute is NO, prefix `ONCE`: only apply when editExecute is `ONCE`, prefix `ALWAYS`: only apply when editExecute is ALWAYS. no prefix is apply to all editExecute value), prefix `#`: escape ctrl cmd execute|
    | `execAfterCtrlCmd` | command | after run shellscript, run command, detail above same |
    | `shellFileName`  | string | shellscript file name  |
    | `appIconPath`  | string | icon file path for `Shell2Gui`  |
3. Insert the variables you want to set in the gui between. `CMD_VARIABLE_SECTION_START` and `CMD_VARIABLE_SECTION_END.
    - Set the various commandriables below as optional
| settingVariable| set value | description  |
    | --------- | --------- | ------------ |
    | `shellArgs` | string | shellscript args.  You also have multiple specifing this. |

4. after `Please write bellow with shell script`, write shellscript.
5. come back Command Click screen, and if it correct, type ctrl+enter if not, esc.

  - setVariableType option
    | option| description | example  |
    | --------- | --------- | ------------ |
    | `CB` | checkbox | {variablebName}:CB=value1!value2!|..   |
    | `CB` | editable checkbox | {variablebName}:CBE=value1!value2!|..   |
    | `H` | hidden input | {variablebName}:H={password ..etc}   |
    | `NUM` | increment or decrement number | {variablebName}:NUM={init_value}!{min}..{max}!{step}(!{number of decimal places}) |
    | `FL` | file select button | {variablebName}:FL={default file path}   |
    | `SFL`  | create file button | {variablebName}:SFL={default file path}  |
    | `DIR`  | directory select button | {variablebName}:SFL={default directory path}  |
    | `CDIR`  | create directory button | {variablebName}:CDIR={default file path}  |
    | `DT`  | create file button | {variablebName}:SFL={default file path}  |
    | `SCL`  | scale | {variablebName}:SCL={default number}  |
    | `CLR` | select color  | {variablebName}:SCL={default value}    |
    | `LBL` | text label  | {variablebName}:LBL={label text}    |
    | `BTN` | botton  | {variablebName}:BTN={command}    |
    | `FBTN` | botton  | {variablebName}:BTN={command}    |

### Run
Run shellscript

1. Cursor move to script file name you wonts run by mouse or up or down
2. Enter or double click this.
	* When inputExecute is C or E, before runninig, you will edit the script.

### Edit

Cmdclick can edit shellscript by gui or editor

#### by gui
1. Move cursor to script file name you wonts edit by up or down.
2. Type Alt+e or run shellscript when inputExecute in seting secttion is C.
3. Soon cmdclick open the edit's gui, then set each variable you wont to change.
4. When you wont to set the setting variable, type alt+e.
	(when not setting cmd variable, cmdclck automaticaly display setting variable's edit screen)
4. When finishing editing, type ctrl+enter.
5. Soon apear confirm screen, if it correct, type ctrl+enter if not, esc.


#### by editor
1. Move cursor to script file name you wonts edit by up or down.
2. Yype Alt+w or run shellscript when inputExecute in seting secttion is E.
3. Soon editor open the target script , then edit.
4. Come back cmdclick gui screen, and, type ctrl+enter.


#### description by gui
1. Move cursor to script file name you wonts edit by up or down.
2. Type Alt+W.
3. Soon cmdclick open description edit screen , then edit.
4. When finishing editing, type ctrl+enter.
5. Soon apear confirm screen, if it correct, type ctrl+enter if not, esc.

### Delete
delete shellscript file

1. Move cursor to script file name you wonts edit by up or down.
2. Type Alt+d.
3. Soon cmdclick open delete screen , if it correct, type ctrl+enter if not, esc.


### Exit
Exit cmdclick

1. Type esc.
	- Besides this, esc can exit all process (add, run, edit, delete)


### Move
Move shellscript file to other app directory

1. Move cursor to script file name you wont to move by up or down.
2. Type Alt+m.
3. Soon cmdclick open app directory list.
4. Move cursor to app direcotry path name you wont to move by up or down.
 	(if selecting current app directory, target file is copied)
5. Type enter.

### Install

Install mean copy selected shellscript

1. Type Alt+i.
2. Soon cmdclick open file manager.
3. Select file you wont to install.
4. Soon cmdclick open app directory list.
5. Move cursor to app direcotry path name you wont to insert by up or down.
5. Type enter.


### Setting
change setting in cmdclick

1. Type Alt+C.
2. Soon cmdclick open the setting gui, then set each column you wont to change.

	- bellow setting column detail

	    | settingVariable| set value | description  |
        | --------- | --------- | ------------ |
        | `pasteAfterEnter` | `ON`/`OFF` | after pasting cmd to terminal, whether to type enter   |
        | `pasteTargetTerminalName`  | terminal name | past target terminal app name  |
        | `openEditorCmd` | editor cmd  | editor command |
        | `shiban`  | shell shiban | running shellscript's shiban |
        | `runShell` | shell name  | run shell name |
	- `pasteTargetTerminalName`'s example  
	windows) `WindowsTerminal`, `ubuntu2004`, `ubuntu`(cmdclick installing one) etc.  
	ubuntu) `xfce4-terminal`, `gnome-terminal` etc.
3. When you wont to set the column, ctrl+enter.
4. Soon apear confirm screen, if it correct, type ctrl+enter if not, esc.
5. Restart cmdclick in order to reflect the settings


### App directory manager

Cmdclick have app directory manager, which is Directory containing shellscript.
App directory manager is used in order to add, edit, and delete app directory.
- When exitting app directory manager, type esc.


#### Launch
1. Type Alt+c.

#### Add
1. Type alt+a, that way, open gui to set app directory path.
2. specify app directory path.
3. If it correct, type ctrl+enter if not, esc.


#### Change directory
1. Move cursor to change direcotry script file name you wont to run by mouse or up or down.
2. Enter or double click this.


### Shell to Gui
`Cmdclick` can convert shellscript to Gui app.

c [your shellscript make from `Cmdclick`]
  - c is shortcut for cmdclck


### Shortcut Table

Cmdclick's essence is shortcut usage.

| keybind| description | support `app directory manager` |
| --------- | --------- | ------------ |
| `alt`+`q` | add | o   |
| `alt`+`e`  | edit | o  |
| `alt`+`k`  | description edit | o  |
| `alt`+`w`  | edit by editor | o  |
| `alt`+`r`  | reload list | x  |
| `alt`+`s`  | change app directory | x  |
| `alt`+`a`  | conversely　change app directory | x  |
| `alt`+`d`  | delete | o  |
| `alt`+`c`  | launch app directory manager | x |
| `alt`+`p`  | setting | x  |
| `alt`+`v`  | copy highlited shellscript file path | x  |
| `alt`+`m`  | move | o  |
| `alt`+`i`  | install | o  |
| `alt`+`g`  | descriptoin scroll up | o |
| `alt`+`b`  | descriptoin scroll down | o |


### Trouble Shouting
#### Not startup

Kill like bellow command, because leftover cmdclick process is getting in the way  
(When starting, cmdclick check current process, and  start with nothing)
```
c -k
```

### Android version

-> [CommandClick](https://github.com/puutaro/CommandClick)

