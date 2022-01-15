function! qfloc_edit#utils#window_has_qf_filetype(window_number) abort
  let l:buffer_number = winbufnr(a:window_number)
  let l:filetype = getbufvar(l:buffer_number, '&filetype')
  return l:filetype ==# 'qf'
endfunction

function! qfloc_edit#utils#window_has_location_option(window_number) abort
  let l:window_info = s:get_window_info(a:window_number)
  let l:location_option = get(l:window_info, 'loclist', 0)
  return l:location_option > 0
endfunction

function! qfloc_edit#utils#window_has_qickfix_option(window_number) abort
  let l:window_info = s:get_window_info(a:window_number)
  let l:quickfix_option = get(l:window_info, 'quickfix', 0)
  return l:quickfix_option > 0
endfunction

function! s:get_window_info(window_number) abort
  let l:window_id = 0

  if a:window_number == 0
    let l:window_id = win_getid()
  else
    let l:window_id = win_getid(a:window_number)
  end

  return get(getwininfo(l:window_id), 0)
endfunction
