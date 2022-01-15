let s:remove_action_history = []
let s:last_quickfix_list_id = v:null

function! qfloc_edit#quickfix#remove_entry(index) abort
  let l:list = getqflist()
  let l:to_remove_entry = l:list[a:index]
  let l:current_cursor_line = line('.')
  let l:current_cursor_column = col('.')

  call remove(l:list, a:index)
  call setqflist(l:list, 'r')
  call cursor(current_cursor_line, current_cursor_column)
  call s:add_entry_to_remove_action_history(a:index, l:to_remove_entry)
endfunction

function! qfloc_edit#quickfix#undo_last_removal() abort
  call s:synchronize_remove_action_history()

  if len(s:remove_action_history) > 0
    let l:list = getqflist()
    let l:last_remove_action = s:remove_action_history[-1]
    let l:last_removed_entry = l:last_remove_action['entry']
    let l:last_removed_index = l:last_remove_action['index']
    let l:current_cursor_line = line('.')
    let l:current_cursor_column = col('.')

    call insert(l:list, l:last_removed_entry, l:last_removed_index)
    call setqflist(l:list, 'r')
    call cursor(current_cursor_line, current_cursor_column)
    call s:delete_last_entry_from_remove_action_history()
  endif
endfunction

function! qfloc_edit#quickfix#is_quickfix_list_window(window_number) abort
  return
        \ qfloc_edit#utils#window_has_qf_filetype(a:window_number) &&
        \ qfloc_edit#utils#window_has_qickfix_option(a:window_number) &&
        \ !qfloc_edit#utils#window_has_location_option(a:window_number)
endfunction

function! s:synchronize_remove_action_history() abort
  let l:current_quickfix_list_id = getqflist({ 'all': v:true })['id']

  if l:current_quickfix_list_id != s:last_quickfix_list_id
    let s:remove_action_history = []
    let s:last_quickfix_list_id = l:current_quickfix_list_id
  end
endfunction

function! s:add_entry_to_remove_action_history(index, entry) abort
  let l:remove_action = { 'index': a:index, 'entry': a:entry }

  call s:synchronize_remove_action_history()
  call add(s:remove_action_history, l:remove_action)
endfunction

function! s:delete_last_entry_from_remove_action_history() abort
  call remove(s:remove_action_history, -1)
endfunction
