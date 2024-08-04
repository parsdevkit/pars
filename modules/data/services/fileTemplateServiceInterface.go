package services

import filetemplate "parsdevkit.net/structs/template/file-template"

type FileTemplateServiceInterface interface {
	GetByName(name string) (*filetemplate.TemplateBaseStruct, error)
	Save(model filetemplate.TemplateBaseStruct) (*filetemplate.TemplateBaseStruct, error)
	List() (*([]filetemplate.TemplateBaseStruct), error)
	ListBySetAndLayers(set string, layers ...string) (*([]filetemplate.TemplateBaseStruct), error)
	Remove(name string, permanent bool) (*filetemplate.TemplateBaseStruct, error)
	GetHash(name string) string
}
