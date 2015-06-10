# Class: ps_m4_examples::stdlib_ex
#
#
class ps_m4_examples::stdlib_ex {
	#returns filename
	notify{basename('/tmp/test.txt'):}

	#count
	$array = ['1','2','3','4','5','6','7','2']
	$count = count($array,'2')
	notify{"number of matches is $count":}

	#hash has key
	$my_hash = {'key_one' => 'value_one'}
  	if has_key($my_hash, 'key_one') {
    	notify{'Wow! there is a key here':}
  	}
  	else{
  		fail('there is no key in the hash')	
  	}

  	#bool validate
  	$boolvar = false
  	if(is_bool($boolvar)){
  		notify{'this is bool':}
  	}

  	#validate IP
  	$ip = '192.168.1.1'
  	if (is_ip_address($ip)) {
  		notify{"ip is $ip":}
  	}

  	#merge hashes
  	$hash1 = {'one' => 1, 'two' => 2}
	$hash2 = {'two' => 'dos', 'three' => 'tres'}
	$merged_hash = merge($hash1, $hash2)
	notify{"overridden value of two key is $merged_hash['two']":}

	#validate regex
	validate_re($::puppetversion, '^2.7', 'The $puppetversion fact value does not match 2.7')
}
