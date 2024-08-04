package services

import (
	dataresource "parsdevkit.net/structs/resource/data-resource"
)

type DataResourceServiceInterface interface {
	GetByName(name string) (*dataresource.ResourceBaseStruct, error)
	Save(model dataresource.ResourceBaseStruct) (*dataresource.ResourceBaseStruct, error)
	List() (*([]dataresource.ResourceBaseStruct), error)
	ListBySet(set string) (*([]dataresource.ResourceBaseStruct), error)
	ListBySetAndLayers(set string, layers ...string) (*([]dataresource.ResourceBaseStruct), error)
	Remove(name string, force, permanent bool) (*dataresource.ResourceBaseStruct, error)
	GetHash(name string) string
}
