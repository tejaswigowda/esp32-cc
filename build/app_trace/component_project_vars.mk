# Automatically generated build file. Do not edit.
COMPONENT_INCLUDES += $(PROJECT_PATH)/esp-idf/components/app_trace/include
COMPONENT_LDFLAGS += -L$(BUILD_DIR_BASE)/app_trace -lapp_trace
COMPONENT_LINKER_DEPS += 
COMPONENT_SUBMODULES += 
COMPONENT_LIBRARIES += app_trace
COMPONENT_LDFRAGMENTS += $(PROJECT_PATH)/esp-idf/components/app_trace/linker.lf
component-app_trace-build: 
