module parsdevkit.net/platforms/core

go 1.22

replace parsdevkit.net/core => ../../../core

replace parsdevkit.net/core/utils => ../../utils

replace parsdevkit.net/structs => ../../structs

replace parsdevkit.net/models => ../../models

require (
	github.com/sirupsen/logrus v1.9.3 // indirect
	golang.org/x/sys v0.0.0-20220715151400-c0bba94af5f8 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
	parsdevkit.net/core v0.0.0-00010101000000-000000000000 // indirect
	parsdevkit.net/core/utils v0.0.0-00010101000000-000000000000 // indirect
	parsdevkit.net/models v0.0.0-00010101000000-000000000000 // indirect
	parsdevkit.net/structs v0.0.0-00010101000000-000000000000 // indirect
)
