define icinga2::object::service (
  $service_name   = $title,
  $host_name      = $::fqdn,
  $check_command  = false,
  $check_interval = '5m',
  $retry_interval = '1m',
  $groups         = false,
  $sla            = '24x7',
  $vars           = {},
  $target         = '/etc/icinga2/conf.d/puppet/services.conf',
  ) {

  if is_string($groups) {
    if $groups =~ /\[.*\]/ {
      $s_groups = $groups
    }
    else {
      $s_groups = "[ \"${groups}\" ]"
    }
  }
  else {
    $s_groups = false
  }
  if ! defined(Concat[$target]) {
    concat { $target:
      ensure         => present,
      ensure_newline => true,
    }
  }

  if ! defined(Concat::Fragment["${target}_header"]) {
    concat::fragment { "${target}_header":
      target  => $target,
      content => '# THIS FILE IS MANAGED BY PUPPET',
      order   => '01'
    }
  }

  concat::fragment { "${target}_${name}":
    target  => $target,
    content => template('icinga2/object/service.erb'),
    order   => '02'
  }
}

