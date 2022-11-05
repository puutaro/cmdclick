![cmdclick_image](https://user-images.githubusercontent.com/55217593/199425521-3f088fcc-93b0-4a84-a9fd-c75418f40654.png)
# Command Click
shellscript gui platform.

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
* [Upgrading cmdclick](#upgrading-cmd)
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
  * [Shortcut table](#shortcut-table)

Installation
-----
### For windows 10
1. Downlaod [installer.bat](https://drive.google.com/file/d/1XqA2EhTeLQnFtFSh87D1oWIh96Hna1w_/view?usp=share_link) from google drive
2. Double click installer.bat

  - Support ubuntu20.04+
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


Upgrading cmdclick.
-----

All same as installation.


Demo
-----
![cmdclick_exec_sceen_input_exec_demo2](https://user-images.githubusercontent.com/55217593/199518490-5ab2e937-7341-486a-8590-775b433e3e95.gif)

demo flow
1. add -> run -> edit by gui -> run -> edit by editor -> run
2. edit by gui -> set input execute -> run -> edit by editor -> run
3. launch app directory manager -> add app directory -> change direcotry
4.  install script -> run

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
    | `inputExecute`  | `N`/`C`/`E` | before running shellscript, whether ot edit settingVriable(N: no, C: edit in console, E: edit in editor)          |
    | `inputExecDfltVal` | string  | when edit, whether to insert default value to commandVriable. In detail, follow bellow. |
    | `afterCommand` | command | before run shellscript, run command |
    | `shellFileName`  | string | shellscript file name  |
    	- About inputExecDfltVal' usage
  		  If variable between `CMD_VARIABLE_SECTION_START` and `CMD_VARIABLE_SECTION_END exist, it's set default value (str value, checkbox value) Also separate variables with commas.
            Bellow example override val1 and val2 with inputExecVal1 and inputExecVal2-1!inputExecVal2-1. More speaking, valiable2 is checkbox, when editting.
	> \### SETTING_SECTION_START  
	> inputExecDfltVal=valiable1=inputExecVal1,valiable2:CB=inputExecVal2-1!inputExecVal2-1  
	> \### SETTING_SECTION_END  
	>  
	> \### CMD_VARIABLE_SECTION_START  
	> valiable1=val1  
	> valiable2=val2  
	> \### CMD_VARIABLE_SECTION_END  
3. Insert the variables you want to set in the gui between. `CMD_VARIABLE_SECTION_START` and `CMD_VARIABLE_SECTION_END.
4. after `Please write bellow with shell script`, write shellscript.
5. come back Command Click screen, and if it correct, type ctrl+enter if not, esc.


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

### Shortcut Table

Cmdclick's essence is shortcut usage.

| keybind| description | support `app directory manager` |
| --------- | --------- | ------------ |
| `ctrl`+`a` | add | o   |
| `ctrl`+`e`  | edit | o  |
| `ctrl`+`E`  | description edit | o  |
| `ctrl`+`w`  | edit by editor | o  |
| `ctrl`+`r`  | reload list | x  |
| `ctrl`+`s`  | change app directory | x  |
| `ctrl`+`S`  | conversely　change app directory | x  |
| `ctrl`+`d`  | delete | o  |
| `ctrl`+`c`  | launch app directory manager | x |
| `ctrl`+`C`  | setting | x  |
| `ctrl`+`v`  | copy highlited shellscript file path | x  |
| `ctrl`+`m`  | move | o  |
| `ctrl`+`i`  | install | o  |
| `ctrl`+`g`  | descriptoin scroll up | o |
| `ctrl`+`b`  | descriptoin scroll down | o |
