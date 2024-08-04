package services

import (
	objectresource "parsdevkit.net/structs/resource/object-resource"
)

type ObjectResourceServiceInterface interface {
	GetByName(name string) (*objectresource.ResourceBaseStruct, error)
	Save(model objectresource.ResourceBaseStruct) (*objectresource.ResourceBaseStruct, error)
	List() (*([]objectresource.ResourceBaseStruct), error)
	ListBySet(set string) (*([]objectresource.ResourceBaseStruct), error)
	ListBySetAndLayers(set string, layers ...string) (*([]objectresource.ResourceBaseStruct), error)
	Remove(name string, force, permanent bool) (*objectresource.ResourceBaseStruct, error)
	GetHash(name string) string
}
