define ps_common::create_directories($directoryArray){
  each($directoryArray) |$directory| {
    if ! defined (File[$directory]) {
      file { $directory: ensure => directory }
    }
  }
}
