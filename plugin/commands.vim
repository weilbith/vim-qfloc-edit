command -nargs=1 RemoveQuickfixEntry call qfloc_edit#quickfix#remove_entry(<f-args>)
command RemoveQuickfixEntryUnderCursor call qfloc_edit#quickfix#remove_entry(line('.') - 1)
command UndoLastQuickfixEntryRemoval call qfloc_edit#quickfix#undo_last_removal()

command -nargs=* RemoveLocationEntry call qfloc_edit#location#remove_entry(<f-args>)
command RemoveLocationEntryUnderCursor call qfloc_edit#location#remove_entry(line('.') - 1, 0)
command -nargs=1 UndoLastLocationEntryRemoval call qfloc_edit#location#undo_last_removal(<f-args>)
command UndoLastLocationEntryRemovalInCurrentWindow call qfloc_edit#location#undo_last_removal(0)

command -nargs=1 RemoveEntryInCurrentListWindow call qfloc_edit#remove_entry_in_current_window(<f-args>)
command RemoveEntryUnderCursorInCurrentListWindow call qfloc_edit#remove_entry_in_current_window(line('.') - 1)
command UndoLastEntryRemovalInCurrentListWindow call qfloc_edit#undo_last_removal_in_current_window()
