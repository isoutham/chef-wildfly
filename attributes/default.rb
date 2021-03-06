# encoding: UTF-8
#
# => Wildfly Configuration
# rubocop:disable LineLength

# => Source
default['wildfly']['version'] = '8.1.0'
default['wildfly']['url'] = 'http://download.jboss.org/wildfly/8.1.0.Final/wildfly-8.1.0.Final.tar.gz'
default['wildfly']['checksum'] = '719dc074ace7320dee52ccdd8e3b41beda038f2f09d69af085273d4f00a75266'

# => Base Directory
default['wildfly']['base'] = '/opt/wildfly'

# => Set Wildfly User & Group
default['wildfly']['user'] = 'wildfly'
default['wildfly']['group'] = 'wildfly'

# => Set Wildfly Service Name
default['wildfly']['service'] = 'wildfly'

# => Wildfly Deployment Type (standalone or domain)
default['wildfly']['mode'] = 'standalone'

# => Enforce Configuration (Force's redeployment of configuration, overwriting any local changes)
default['wildfly']['enforce_config'] = false

# => Standalone Mode Configuration
# => (standalone/ha.xml, standalone-full/ha/ha-aws.xml)
default['wildfly']['sa']['conf'] = 'standalone-full.xml'

# => AWS S3_Ping Configuration
default['wildfly']['aws']['s3_access_key'] = 'a'
default['wildfly']['aws']['s3_secret_access_key'] = 'b'
default['wildfly']['aws']['s3_bucket'] = 'c'

# => Domain Mode Configuration
default['wildfly']['dom']['conf'] = 'domain.xml'
default['wildfly']['dom']['host_conf'] = 'host-master.xml'

# => Interface Configuration
# => Should probably put a proxy in front of these... Maybe NginX?
default['wildfly']['int']['mgmt']['bind'] = '0.0.0.0'
default['wildfly']['int']['mgmt']['http_port'] = '9990'
default['wildfly']['int']['mgmt']['https_port'] = '9993'

default['wildfly']['int']['pub']['bind'] = '0.0.0.0'
default['wildfly']['int']['pub']['http_port'] = '8080'
default['wildfly']['int']['pub']['https_port'] = '8443'

default['wildfly']['int']['wsdl']['bind'] = '0.0.0.0'
default['wildfly']['int']['ajp']['port'] = '8009'

# => Debugging Settings
default['wildfly']['jpda']['enabled'] = true
default['wildfly']['jpda']['port'] = '8787'

# => SMTP Settings
default['wildfly']['smtp']['host'] = 'localhost'
default['wildfly']['smtp']['port'] = '25'
default['wildfly']['smtp']['ssl'] = false
default['wildfly']['smtp']['username'] = nil
default['wildfly']['smtp']['password'] = nil

# => Console Log Location
default['wildfly']['log']['console_log'] = '/var/log/wildfly/console.log'
# => Enable Log Rotation on *.log in Console Log Directory
default['wildfly']['log']['rotation'] = true
# => Purge rotated logs older than this many days
default['wildfly']['log']['max_age'] = 375

# => Init Script Timeouts (Seconds)
default['wildfly']['initd']['startup_wait'] = '60'
default['wildfly']['initd']['shutdown_wait'] = '60'

# => Hardcode JAVA_HOME into init.d configuration.
# => Based on value of node['java']['java_home']
default['wildfly']['java']['enforce_java_home'] = true
