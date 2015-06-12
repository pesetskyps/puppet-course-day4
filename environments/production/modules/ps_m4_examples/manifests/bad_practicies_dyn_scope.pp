class ps_m4_examples::bad_practicies_dyn_scope {
  include ps_m4_examples::bad_practicies_dyn_scope_child
  include ps_m4_examples::bad_practicies_dyn_scope_child_2
  
  notify{$myvar:}
}