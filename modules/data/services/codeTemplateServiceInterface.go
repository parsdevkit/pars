package services

import codetemplate "parsdevkit.net/structs/template/code-template"

type CodeTemplateServiceInterface interface {
	GetByName(name string) (*codetemplate.TemplateBaseStruct, error)
	Save(model codetemplate.TemplateBaseStruct) (*codetemplate.TemplateBaseStruct, error)
	List() (*([]codetemplate.TemplateBaseStruct), error)
	ListBySetAndLayers(set string, layers ...string) (*([]codetemplate.TemplateBaseStruct), error)
	Remove(name string, permanent bool) (*codetemplate.TemplateBaseStruct, error)
	GetHash(name string) string
}
