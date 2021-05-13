# USE_PYTHON_ENGINE = 1
# PYTHON_ENGINE_SRC = /home/duxtinto/projects/gamebots/smartfighters_monorepo/backend/arena/pythonMameEngine/cIntegration/src
# PYTHON_DUMMY_ENGINE_SRC = /home/duxtinto/projects/gamebots/smartfighters_monorepo/backend/arena/pythonMameEngine/cIntegration/dummy
# PYBIND11_SRC = /home/duxtinto/projects/gamebots/smartfighters_monorepo/deps/pybind11
# PYTHON_HEADERS = /usr/include/python3.8
# PYTHON_LIB = python3.8

ifdef USE_PYTHON_ENGINE
PARAMS += --USE_PYTHON_ENGINE='$(USE_PYTHON_ENGINE)'
endif

ifdef PYTHON_ENGINE_SRC
PARAMS += --PYTHON_ENGINE_SRC='$(PYTHON_ENGINE_SRC)'
endif

ifdef PYTHON_DUMMY_ENGINE_SRC
PARAMS += --PYTHON_DUMMY_ENGINE_SRC='$(PYTHON_DUMMY_ENGINE_SRC)'
endif

ifdef PYBIND11_SRC
PARAMS += --PYBIND11_SRC='$(PYBIND11_SRC)'
endif

ifdef PYTHON_HEADERS
PARAMS += --PYTHON_HEADERS='$(PYTHON_HEADERS)'
endif

ifdef PYTHON_LIB
PARAMS += --PYTHON_LIB='$(PYTHON_LIB)'
endif
