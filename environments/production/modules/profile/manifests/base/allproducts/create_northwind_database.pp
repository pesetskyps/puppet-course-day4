# Class: profile::dev::create_northwind_database
#
#
class profile::base::allproducts::create_northwind_database {
	class {'ps_sql::fill_northwind_db':
		require => Class['mssql'],
	}
}