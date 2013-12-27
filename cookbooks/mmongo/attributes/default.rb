default[:mmongo][:dbpath] = "/var/lib/mongodb"
default[:mmongo][:logpath] = "/var/log/mongodb"
default[:mmongo][:bind_host] = node.ipaddress
default[:mmongo][:port] = 27017
default[:mmongo][:replset_name] = "rs0"
default[:mmongo][:auth] = true
default[:mmongo][:keyfile] = "/etc/mongodb.key"

#This as an example key, generate a new key using "openssl rand -base64 741"
default[:mmongo][:auth_key] = "fC3TbH+7HWmVDJe4AfL2lKLxdO6CcC+4JDx0O9p0aS2GBFYukdZ5lSo6IjiVoViP
Mq2lAYo5zjpKGO9qrTOVLGUipxFBiWRmeReFxQRiRXr9o1rSCbswWpDCIJ24lqiV
iVtN2gLP6GjBMva9Y+xDdiHXUMxVYY84bBxtgZokxcdYoluPXxSn/M7WQgaF2pwI
COpd2vg+k+x6PyB6HQmPxaspKYW4IMad39WmxUw95LCPrhFlVYQZiL8VI8lJHxYl
89oZu/WDZzL4UsSfjkIHQPY5NXahnxPYHitB1jqJret2GEC/S5XJhznrQUhKqG8s
dfMMY1h4DdU1ERXBonMB0Hh4EIfe+03VaAedGrAHEC8Oce4izCm0LROmflIDv7cm
5/u4QJQR2QTDpQn3gtOlhU/P1yAbFjmZAm+xivG+q9OIf1Hn1ykDfc6frrPwxdQS
NEaUwhXatLBj4zwpBEAcd+K0fXbfUzBYbXHlUPeqcgG8ggeAGD/Z17OFpcvt+hsV
ExNrvK1AXvbVpRCGTIO+GF3nHOCmuOsJjFOP60n+D4UOoPUnfs3akiDOX+zJ16Uo
bIg+vVPS2W1G78Mz1pJPTmQ1tRj378RVOKZJ6UaeCAXSuEUG1jqoOKumRlsUjNvh
Bfjz2p3gqp76tZd2BuggJymxtM+//w2KDRcL+HJAYTq+YByPdHwItzjszygAAkV7
VzFq8wqVxZ1IkXyvMrQwFzUFsDAQzO7ihgFdkB7P6c63EtgzcyR6wlQTIdsDs0oX
JJHxOILAbv3CCIUR9BhgSihEFkTGgpfwYfNZncZebhQgVxAl16YgrBtiDjFBa/iS
uK7PVotsY/W/wGmAkN41kbJ91N4P77tk1B/+8rY/KUMr8HSQ36FUNaJtQl6iq9mP
9ocwQuxJ6G5QT8Qa38kpYMWZWHiJBSWjPk9l2Dha6xTE4TarRqndpNYRdWlC0jKl
MqZU3DTX4C8pYMMOyTrcH/R+RoA8"

default[:mmongo][:admin_user] = "admin"
default[:mmongo][:admin_pass] ="admin"
default[:mmongo][:database] = "mydb"
default[:mmongo][:db_user] = "user"
default[:mmongo][:db_pass] = "user"