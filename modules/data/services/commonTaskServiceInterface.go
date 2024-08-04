package services

import commontask "parsdevkit.net/structs/task/common-task"

type CommonTaskServiceInterface interface {
	GetByName(name string) (*commontask.TaskBaseStruct, error)
	Save(mommonl commontask.TaskBaseStruct) (*commontask.TaskBaseStruct, error)
	List() (*([]commontask.TaskBaseStruct), error)
	ListBySetAndLayers(set string, layers ...string) (*([]commontask.TaskBaseStruct), error)
	Remove(name string, permanent bool) (*commontask.TaskBaseStruct, error)
	GetHash(name string) string
}
