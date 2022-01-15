# Vim Quickfix & Location List Edits

This is a minimal plugin that allows to edit quickfix or location lists. The so
far supported actions are to remove an entry from a list and undo such a removal
again.

This functionality is especially useful for use-cases where the quickfix list
acts like a _TODO_ list (in any format). When being finished with an entry it
can be simply removed. When an entry got removed mistakenly or too early, it can
be simply recovered.

All actions to edit quickfix or location lists intentionally always replace the
current list. This is to keep the history of the lists clean and don't clutter
it with a new list for each edit action.

## Installation

Install the plugin with your favorite manager tool or just as a native package.
Here is an example using
[packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
require('packer').use('weilbith/vim-qfloc-edit')
```

## Usage

The plugin works out of the box. It automatically defines mappings on quickfix
or location list buffers that follow Vim standards. When being in the window
with such a buffer, hit `dd` to remove the entry under the cursor. Type `u` at
any location within the window to iteratively undo the last remove actions.

Please checkout the [docs](./docs/qfloc_edit.txt) (`:help qfloc-edit.txt`) to
read about all commands to be more flexible and also how to configure the plugin
with some examples.
