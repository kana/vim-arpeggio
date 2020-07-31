## Contents

- [Introduction](#introduction)
- [Installation](#installation)
- [Requirements](#requirements)
- [Interface](#interface)
  - [Commands](#commands)
  - [Functions](#functions)
  - [Mappings](#mappings)
  - [Variables](#variables)
- [Bugs](#bugs)


## Introduction

`arpeggio` is a Vim plugin to define another type of `key-mapping` called `arpeggio-key-mapping` - it consists of 2 or more keys(the `lhs`) and it will be expanded to another key sequence, the `rhs`, whenever all the keys in the `lhs` are simultaneously pressed. For example:<br/>
```vim
  Arpeggio inoremap jk  <Esc>
  " OR
  call arpeggio#map('i', '', 0, 'jk', '<Esc>')
```
With the above definition, you can input `<Esc>` in Insert mode by pressing `j` and `k` simultaneously, while you can move the cursor by pressing `j` or `k` solely.<br/>

The concept of this plugin is derived from Emacs' [key-chord.el](http://www.emacswiki.org/emacs/key-chord.el), but there are the following differences:<br/>

* Number of keys to be simultaneously pressed is unlimited.
* Custom delay for each key is supported (see `g:arpeggio_timeoutlens`). This is a generalization of [space-chord.el](http://www.emacswiki.org/emacs/space-chord.el).

## Installation
To define arpeggio key mappings in vimrc, you have to add one of the following extra lines into vimrc before any definitions:<br/>

a) If you use Vim 8 or later, and you installed this plugin as `packages`:<br/>
```vim
" Load this plugin at this timing
" to define :Arpeggio, arpeggio#map() and others used later.
packadd vim-arpeggio
```
b) Like (a), but you have more plugins to be loaded earlier:<br/>
```vim
packloadall
```
c) If you use Vim 7 or older, or you install this plugin as the traditional style (i.e. you don't install this plugin as a package):<br/>
```vim
call arpeggio#load()
```

## Requirements

Vim 7.2 or later

## Interface

### Commands

#### Arpeggio {command}
Equivalent to `:Arpeggio{command} ...`. This command is just for readability.<br/>

```vim
:Arpeggiomap {lhs} {rhs}			*:Arpeggiomap*
:Arpeggiomap! {lhs} {rhs}			*:Arpeggiomap!*
:Arpeggiocmap {lhs} {rhs}			*:Arpeggiocmap*
:Arpeggioimap {lhs} {rhs}			*:Arpeggioimap*
:Arpeggiolmap {lhs} {rhs}			*:Arpeggiolmap*
:Arpeggionmap {lhs} {rhs}			*:Arpeggionmap*
:Arpeggioomap {lhs} {rhs}			*:Arpeggioomap*
:Arpeggiosmap {lhs} {rhs}			*:Arpeggiosmap*
:Arpeggiovmap {lhs} {rhs}			*:Arpeggiovmap*
:Arpeggioxmap {lhs} {rhs}			*:Arpeggioxmap*
```
Like `:map` and others, but map to `{rhs}` if and only if all keys in `{lhs}` are simultaneously pressed.<br/>

Available `:map-arguments` are `<buffer>`, `<expr>`, `<silent>` and/or `<unique>`.  See also `arpeggio#map()` for other notes and limitations.<br/>
```vim
:Arpeggionoremap {lhs} {rhs}			*:Arpeggionoremap*
:Arpeggionoremap! {lhs} {rhs}			*:Arpeggionoremap!*
:Arpeggiocnoremap {lhs} {rhs}			*:Arpeggiocnoremap*
:Arpeggioinoremap {lhs} {rhs}			*:Arpeggioinoremap*
:Arpeggiolnoremap {lhs} {rhs}			*:Arpeggiolnoremap*
:Arpeggionnoremap {lhs} {rhs}			*:Arpeggionnoremap*
:Arpeggioonoremap {lhs} {rhs}			*:Arpeggioonoremap*
:Arpeggiosnoremap {lhs} {rhs}			*:Arpeggiosnoremap*
:Arpeggiovnoremap {lhs} {rhs}			*:Arpeggiovnoremap*
:Arpeggioxnoremap {lhs} {rhs}			*:Arpeggioxnoremap*
```
Variants of `:Arpeggiomap` without remapping, like `:noremap`.<br/>
```vim
:Arpeggiounmap {lhs} {rhs}			*:Arpeggiounmap*
:Arpeggiounmap! {lhs} {rhs}			*:Arpeggiounmap!*
:Arpeggiocunmap {lhs} {rhs}			*:Arpeggiocunmap*
:Arpeggioiunmap {lhs} {rhs}			*:Arpeggioiunmap*
:Arpeggiolunmap {lhs} {rhs}			*:Arpeggiolunmap*
:Arpeggionunmap {lhs} {rhs}			*:Arpeggionunmap*
:Arpeggioounmap {lhs} {rhs}			*:Arpeggioounmap*
:Arpeggiosunmap {lhs} {rhs}			*:Arpeggiosunmap*
:Arpeggiovunmap {lhs} {rhs}			*:Arpeggiovunmap*
:Arpeggioxunmap {lhs} {rhs}			*:Arpeggioxunmap*
```
Like `:unmap` and others, but remove key mappings defined by `:Arpeggiomap` and/or others.<br/>
```vim
:Arpeggiomap [{lhs}]				*:Arpeggiomap_l*
:Arpeggiomap! [{lhs}]				*:Arpeggiomap_l!*
:Arpeggiocmap [{lhs}]				*:Arpeggiocmap_l*
:Arpeggioimap [{lhs}]				*:Arpeggioimap_l*
:Arpeggiolmap [{lhs}]				*:Arpeggiolmap_l*
:Arpeggionmap [{lhs}]				*:Arpeggionmap_l*
:Arpeggioomap [{lhs}]				*:Arpeggioomap_l*
:Arpeggiosmap [{lhs}]				*:Arpeggiosmap_l*
:Arpeggiovmap [{lhs}]				*:Arpeggiovmap_l*
:Arpeggioxmap [{lhs}]				*:Arpeggioxmap_l*
```
List key mappings which are defined by `:Arpeggiomap` or others and which contain all keys in `{lhs}`. If `{lhs}` is omitted, list all key mappings defined by `:Arpeggiomap` or others.<br/>

### Functions

```vim
arpeggio#list({modes}, {options}, [{lhs}])	arpeggio#list()
```

Function version of `:Arpeggiomap_l` and others. See `arpeggio#map()` for the details of arguments.<br/>

For this function, `{lhs}` can be omitted or can be 0. If so, all arpeggio mappings defined in `{modes}` will be listed.<br/>

```vim
arpeggio#load()					arpeggio#load()
```
Load this plugin if it is not loaded yet. Otherwise, does nothing. Call this function to ensure that `arpeggio-commands` are defined before you use one of them, especially, in your `vimrc`.
See also **_Installation_**.

```vim
arpeggio#map()
```
```vim
arpeggio#map({modes}, {options}, {remap-p}, {lhs}, {rhs})
```
Function version of `:Arpeggiomap` and others.<br/>

{modes} **_String_**<br/> 
Each character means one or more modes to define the given key mapping. "n" means Normal mode, "v" means Visual mode and Select mode (the same as what `:vmap` does), and so forth.<br/>

{options} **_String_**.<br/>
Each character means one of `:map-arguments`. The meanings of characters are as follows:

* Char	Meaning ~
* b	`buffer`
* e	`expr`
* s	`silent`
* u	`unique`

Other `:map-arguments` are not supported for arpeggio key mappings.<br/>

Note that the meaning of `unique` is a bit different:<br/>

* If a key in `{lhs}` is already mapped to something other than a part of `arpeggio-key-mapping`, an error will be raised and defining of this mapping will be aborted.<br/>
* If `{lhs}`is already mapped to another `arpeggio-key-mapping`, an error will be raised and defining of this mapping will be aborted.<br/>

{remap-p} **_Number as a boolean_**<br/>
True means that `{rhs}` will be remapped, and false means that `{rhs}` will not be remapped.

`{lhs}` **_String._**
This value must contain two or more keys. Special keys such as `<C-u>`must be escaped with `<` and `>`, i.e., use `<C-u>` not `\<C-u>`.

`{rhs}` **_String_**<br/>

```vim
arpeggio#unmap({modes}, {options}, {lhs})	*arpeggio#unmap()*
```
Function version of `:Arpeggiounmap` and others. See `arpeggio#map()` for the details of arguments.<br/>

### Mappings

In the following description, `{X}` means a character in the `{lhs}` which is used for `:Arpeggiomap` and others.<br/>

#### {X}
Mapped to internals. Don't map `{X}` to anything. To customize the action for solely typed `{X}`, use `<Plug>(arpeggio-default:{X})` instead.<br/>

```vim
<Plug>(arpeggio-default:{X})			*<Plug>(arpeggio-default:{X})*
```
Pseudo key sequence to customize the action whenever `{X}` is typed solely. By default, this key sequence is mapped to `{X}` with no remapping.<br/>

### Variables

#### arpeggio_timeoutlen
```vim
g:arpeggio_timeoutlen	number  (default 40)
```
The time in milliseconds to determine whether typed keys are simultaneously pressed or not.<br/>

#### arpeggio_timeoutlens 
```vim
g:arpeggio_timeoutlens	Dictionary (default {})
```
Each key (in this dictionary) is a string of a key (on a keyboard), and each value is a number which means the same as `g:arpeggio_timeoutlen` but it is used only for the corresponding key.<br/>

### Bugs

* Not all keyboards have [N-key rollover](http://en.wikipedia.org/wiki/Rollover_(key)). Though this plugin supports unlimited number of simultaneously pressed keys, 3 or more keys may not be inputted simultaneously.<br/>
For keyboards which don't have N-key rollover, it's possible to emulate to simultaneously press 3 or more keys by pressing each key after the ither  key in a very short time, i.e., **_arpeggio_**.<br/>

* `arpeggio-key-mapping` may not work or may have conflicts with `@` and/or `key-mapping` because recorded key sequences don't have any information about typing delay for each key. So some keys may be treated as an arpeggio key mapping unexpectedly.<br/>

* `arpeggio-key-mapping` does not support `<SID>` in `{rhs}`. For example, the following mappings are not expanded to call the script-local function:
  ```vim
    function! s:Foo()
      return 'bar'
    endfunction
    Arpeggio inoremap xy  <C-r>=<SID>Foo()<CR>
  ```
  It is possible to support `<SID>` without any special treatment, but it is hard work. If you really want to use script-local settings from arpeggio key mappings, please use the following workaround:
  ```vim
    function! s:Foo()
      return 'bar'
    endfunction
    inoremap <Plug>Foo  <C-r>=<SID>Foo()<CR>
    Arpeggio imap xy  <Plug>Foo
  ```
