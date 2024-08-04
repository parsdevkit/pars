package services

import (
	objectresource "parsdevkit.net/structs/resource/object-resource"
	commontask "parsdevkit.net/structs/task/common-task"

	"parsdevkit.net/persistence/repositories"
)

type CommonTaskEngine struct {
	environment                  string
	generationHistoryRespository *repositories.GenerationHistoryRepository
}

func NewCommonTaskEngine(environment string) CommonTaskEngine {
	return CommonTaskEngine{
		environment:                  environment,
		generationHistoryRespository: repositories.NewGenerationHistoryRepository(environment),
	}
}

func (s CommonTaskEngine) GenerateByResource(model objectresource.ResourceBaseStruct) error {

	return nil
}

func (s CommonTaskEngine) GenerateByTask(model commontask.TaskBaseStruct) error {

	return nil
}
