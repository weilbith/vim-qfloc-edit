let s:remove_action_history_per_window = {}
let s:last_location_list_id_per_window = {}

function! qfloc_edit#location#remove_entry(index, window_number) abort
  let l:list = getloclist(a:window_number)
  let l:to_remove_entry = l:list[a:index]
  let l:remove_action_history_of_window = get(s:remove_action_history_per_window, a:window_number, [])
  let l:current_cursor_line = line('.')
  let l:current_cursor_column = col('.')

  call remove(l:list, a:index)
  call setloclist(a:window_number, l:list, 'r')
  call cursor(current_cursor_line, current_cursor_column)
  call s:add_entry_to_remove_action_history(a:window_number, a:index, l:to_remove_entry)
endfunction

function! qfloc_edit#location#undo_last_removal(window_number) abort
  call s:synchronize_remove_action_history(a:window_number)
  let l:remove_action_history_of_window = get(s:remove_action_history_per_window, a:window_number, [])

  if len(l:remove_action_history_of_window) > 0
    let l:list = getloclist(a:window_number)
    let l:last_remove_action = l:remove_action_history_of_window[-1]
    let l:last_removed_entry = l:last_remove_action['entry']
    let l:last_removed_index = l:last_remove_action['index']
    let l:current_cursor_line = line('.')
    let l:current_cursor_column = col('.')

    call insert(l:list, l:last_removed_entry, l:last_removed_index)
    call setloclist(a:window_number, l:list, 'r')
    call cursor(current_cursor_line, current_cursor_column)
    call s:delete_last_entry_from_remove_action_history(a:window_number)
  endif
endfunction

function! qfloc_edit#location#is_location_list_window(window_number) abort
  return
        \ qfloc_edit#utils#window_has_qf_filetype(a:window_number) &&
        \ qfloc_edit#utils#window_has_qickfix_option(a:window_number) &&
        \ qfloc_edit#utils#window_has_location_option(a:window_number)
endfunction

function! s:synchronize_remove_action_history(window_number) abort
  let l:current_location_list_id_of_window = getloclist(a:window_number, { 'all': v:true })['id']
  let l:last_location_list_id_of_window = get(s:last_location_list_id_per_window, a:window_number, v:null)

  if l:current_location_list_id_of_window != l:last_location_list_id_of_window
    let s:remove_action_history_per_window[a:window_number] = []
    let s:last_location_list_id_per_window[a:window_number] = l:current_location_list_id_of_window
  end
endfunction

function! s:add_entry_to_remove_action_history(window_number, index, entry) abort
  call s:synchronize_remove_action_history(a:window_number)

  let l:remove_action = { 'index': a:index, 'entry': a:entry }
  let l:remove_action_history_of_window = get(s:remove_action_history_per_window, a:window_number, [])

  call add(l:remove_action_history_of_window, l:remove_action)
  let s:remove_action_history_per_window[a:window_number] = l:remove_action_history_of_window
endfunction

function! s:delete_last_entry_from_remove_action_history(window_number) abort
  let l:remove_action_history_of_window = get(s:remove_action_history_per_window, a:window_number, [])

  call remove(l:remove_action_history_of_window, -1)

  let s:remove_action_history_per_window[a:window_number] = l:remove_action_history_of_window
endfunction
