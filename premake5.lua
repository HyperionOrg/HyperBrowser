include "./vendor/premake/premake_customization/solution_items.lua"

workspace "HyperBrowser"
	architecture "x86_64"
	startproject "HyperBrowser"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

	solution_items
	{
		".editorconfig"
	}

	flags
	{
		"MultiProcessorCompile"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories relative to root folder (solution directory)
IncludeDir = {}
IncludeDir["Glad"] = "%{wks.location}/vendor/Glad/include"
IncludeDir["glfw"] = "%{wks.location}/vendor/glfw/include"
IncludeDir["glm"] = "%{wks.location}/vendor/glm"

group "Dependencies"
	include "vendor/premake"
	include "vendor/Glad"
	include "vendor/glfw"
	include "vendor/glm"
group ""

project "HyperBrowser"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++latest"
	staticruntime "on"

	targetdir ("%{wks.location}/bin/" .. outputdir)
	objdir ("%{wks.location}/bin-int/" .. outputdir)

	files 
	{ 
		"src/**.cpp",
		"src/**.h"
	}
	
	defines
	{
		"_CRT_SECURE_NO_WARNINGS"
	}

	includedirs
	{
		"src",
		"src/HyperBrowser",
		"%{IncludeDir.Glad}",
		"%{IncludeDir.glfw}",
		"%{IncludeDir.glm}",
	}

	filter "system:windows"
		systemversion "latest"

	filter "configurations:Debug"
		defines "HP_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "HP_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "HP_DIST"
		runtime "Release"
		optimize "on"
