command! DeinRemove call map(dein#check_clean(), "delete(v:val, 'rf')") | call dein#recache_runtimepath()
