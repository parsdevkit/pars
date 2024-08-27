package workspace

import (
	"testing"

	"parsdevkit.net/models"

	angularManagers "parsdevkit.net/platforms/angular/managers"
	platformsCommon "parsdevkit.net/platforms/common"
	dotnetManagers "parsdevkit.net/platforms/dotnet/managers"
	goManagers "parsdevkit.net/platforms/go/managers"
	parsManagers "parsdevkit.net/platforms/pars/managers"

	"github.com/stretchr/testify/require"
)

func Test_GetParsPlatformEngine(t *testing.T) {

	// Arrange
	platformManager := platformsCommon.ManagerFactory(models.PlatformTypes.Pars)

	// Act
	_, ok := platformManager.(parsManagers.ParsManager)

	// Assert
	require.True(t, ok, "platform does not implement ParsManager")
}

func Test_GetDotnetPlatformEngine(t *testing.T) {

	// Arrange
	platformManager := platformsCommon.ManagerFactory(models.PlatformTypes.Dotnet)

	// Act
	_, ok := platformManager.(dotnetManagers.DotnetManager)

	// Assert
	require.True(t, ok, "platform does not implement DotnetManager")
}

func Test_GetAngularPlatformEngine(t *testing.T) {

	// Arrange
	platformManager := platformsCommon.ManagerFactory(models.PlatformTypes.Angular)

	// Act
	_, ok := platformManager.(angularManagers.AngularManager)

	// Assert
	require.True(t, ok, "platform does not implement AngularManager")
}

func Test_GetGoPlatformEngine(t *testing.T) {

	// Arrange
	platformManager := platformsCommon.ManagerFactory(models.PlatformTypes.GO)

	// Act
	_, ok := platformManager.(goManagers.GoManager)

	// Assert
	require.True(t, ok, "platform does not implement GoManager")
}
