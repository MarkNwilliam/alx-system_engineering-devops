# Install Nginx
class nginx {
    package { 'nginx':
        ensure => installed,
    }
}

class { 'nginx': }

# Configure custom HTTP header response
class nginx::custom_header {
    file { '/etc/nginx/sites-available/default':
        ensure  => file,
        content => template('nginx/default.erb'),
        require => Class['nginx'],
        notify  => Service['nginx'],
    }
}

class { 'nginx::custom_header': }

# Define custom header template
class nginx::custom_header::template {
    file { '/etc/nginx/sites-available/default':
        ensure  => file,
        content => template('nginx/default.erb'),
        require => Class['nginx'],
        notify  => Service['nginx'],
    }
}

class { 'nginx::custom_header::template': }
