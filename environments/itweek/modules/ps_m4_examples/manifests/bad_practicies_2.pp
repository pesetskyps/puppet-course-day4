class ps_m4_examples::bad_practicies_2 {
  if !defined(File['/tmp/test']) {
    file { '/tmp/test':
      mode  => '0755',
      owner => 'puppet'
    }
  }
}