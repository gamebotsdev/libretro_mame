---------------------------------------------------------------------------
--
--   Options
--
---------------------------------------------------------------------------

newoption {
    trigger = 'USE_PYTHON_ENGINE',
    description = 'Enable the python engine',
    allowed = {
        { "0",   "Disabled"     },
        { "1",   "Enabled"      },
    }
}

newoption {
    trigger = 'PYTHON_ENGINE_SRC',
    description = 'Path to the source for the python engine'
}

newoption {
    trigger = 'PYTHON_DUMMY_ENGINE_SRC',
    description = 'Path to the source for the dummy version of the python engine'
}

newoption {
    trigger = 'PYBIND11_SRC',
    description = 'Path to the source for the pybind11 library'
}

newoption {
    trigger = 'PYTHON_HEADERS',
    description = 'Path to the python headers'
}

newoption {
    trigger = 'PYTHON_LIB',
    description = 'name of the python lib to link with the libretro core'
}

---------------------------------------------------------------------------
--
--   frontend.lua
--
--   Extends the mame frontend project, to include the python engine files
--
---------------------------------------------------------------------------

project ("frontend")

if _OPTIONS["USE_PYTHON_ENGINE"]~=nil and tonumber(_OPTIONS["USE_PYTHON_ENGINE"])==1 then
    defines {
        "USE_PYTHON_ENGINE",
    }

    PYTHON_ENGINE_SRC = _OPTIONS['PYTHON_ENGINE_SRC']
    PYBIND11_SRC = _OPTIONS['PYBIND11_SRC']
    PYTHON_HEADERS = _OPTIONS['PYTHON_HEADERS']
    PYTHON_LIB = _OPTIONS['PYTHON_LIB']

    includedirs {
        PYTHON_ENGINE_SRC,
        PYBIND11_SRC .. "/include"
    }

    if _OPTIONS["targetos"]~="asmjs" then
        includedirs {
            PYTHON_HEADERS,
        }

        links {
            "m",
            "pthread",
            PYTHON_LIB,
        }
    end
else -- the python engine is not enabled
    PYTHON_DUMMY_ENGINE_SRC = _OPTIONS['PYTHON_DUMMY_ENGINE_SRC']

    includedirs {
        PYTHON_DUMMY_ENGINE_SRC
    }

    files {
        -- Python Engine
        PYTHON_DUMMY_ENGINE_SRC .. "/python_engine.h",
        PYTHON_DUMMY_ENGINE_SRC .. "/python_engine.cpp",
    }
end

---------------------------------------------------------------------------
--
--   Rules for the building with SDL
--
---------------------------------------------------------------------------

project ("osd_" .. _OPTIONS["osd"])

if _OPTIONS["USE_PYTHON_ENGINE"]~=nil and tonumber(_OPTIONS["USE_PYTHON_ENGINE"])==1 then
    links {
        PYTHON_LIB,
        "util",
    }
end

---------------------------------------------------------------------------
--
--   Rules for the target project
--
---------------------------------------------------------------------------

project (_OPTIONS["target"])

configuration { "linux-* or freebsd" }
    postbuildcommands { "cp ../../../../../mame_libretro.so ../../../../../../../bin/mame_libretro.CPS2.so" }
configuration { }

if _OPTIONS["USE_PYTHON_ENGINE"]~=nil and tonumber(_OPTIONS["USE_PYTHON_ENGINE"])==1 then

    links {
        PYTHON_LIB,
        "util",
    }
end

---------------------------------------------------------------------------
--
--   Rules for the building the target + subtarget project
--
---------------------------------------------------------------------------

project (_OPTIONS["target"] .. "_" .. _OPTIONS["subtarget"])

if _OPTIONS["USE_PYTHON_ENGINE"]~=nil and tonumber(_OPTIONS["USE_PYTHON_ENGINE"])==1 then
    links {
        PYTHON_LIB,
        "util",
    }
end
