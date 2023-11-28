--
-- Main Premake5 file for building MsdfAtlasGen project.
-- Copyright (c) 2023 by Danil (Kenny) Dukhovenko, All rights reserved.
--
-- Requirement:
--  - ForceEngine.lua
--  - msdfgen/MsdfGen.lua
--  - msdfgen/freetype/FreeType.lua
--

include "msdfgen/MsdfGen.lua"

-- MsdfAtlasGen C++ Project
project "MsdfAtlasGen"
	kind          "StaticLib"
	language      "C++"
	cppdialect    "C++17"
	staticruntime "on"
	targetdir     ("%{ForceDir.BinLib}/" .. BuildDir .. "/%{prj.name}/Lib")
	objdir        ("%{ForceDir.BinLib}/" .. BuildDir .. "/%{prj.name}/Obj")

	files {
		"msdf-atlas-gen/**.h",
    	"msdf-atlas-gen/**.hpp",
    	"msdf-atlas-gen/**.cpp"
	}

	includedirs {
		"msdf-atlas-gen",
		"msdfgen/include"
	}

	local DefinesList = {}
	local LinksList   = {}

	if Libraries["MsdfGen"] then
		table.insert(LinksList,   "MsdfGen")
		table.insert(DefinesList, "FE_LIBRARY_MSDFGEN")
	end

	table.insert(DefinesList, "_CRT_SECURE_NO_WARNINGS")

	defines {
		DefinesList
	}

	links {
		LinksList
	}

	filter "system:windows"
		systemversion "latest"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"