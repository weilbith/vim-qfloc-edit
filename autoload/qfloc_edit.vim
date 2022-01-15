function! qfloc_edit#remove_entry_in_current_window(index) abort
  if qfloc_edit#quickfix#is_quickfix_list_window(0)
    call qfloc_edit#quickfix#remove_entry(a:index)
  elseif qfloc_edit#location#is_location_list_window(0)
    call qfloc_edit#location#remove_entry(a:index, 0)
  end
endfunction

function! qfloc_edit#undo_last_removal_in_current_window() abort
  if qfloc_edit#quickfix#is_quickfix_list_window(0)
    call qfloc_edit#quickfix#undo_last_removal()
  elseif qfloc_edit#location#is_location_list_window(0)
    call qfloc_edit#location#undo_last_removal(0)
  end
endfunction
