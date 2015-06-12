class ps_m4_examples::bad_practicies {
  if !defined(File['/tmp/test']) {
    file { '/tmp/test':
      mode  => '0644',
      owner => 'root',
      group => 'puppet'
    }
  }
}