# Class: ps_m4_examples::add_site() inherits
#
class ps_m4_examples::add_site (
  $sitename,
  $foldername  = $ps_m4_examples::params::foldername,
) inherits ps_m4_examples::params 
{
  notify { "folder from add_site = $foldername and sitename is $sitename": }
}