# Automatically generated build file. Do not edit.
COMPONENT_INCLUDES += $(PROJECT_PATH)/esp-idf/components/nghttp/port/include $(PROJECT_PATH)/esp-idf/components/nghttp/nghttp2/lib/includes
COMPONENT_LDFLAGS += -L$(BUILD_DIR_BASE)/nghttp -lnghttp
COMPONENT_LINKER_DEPS += 
COMPONENT_SUBMODULES += $(PROJECT_PATH)/esp-idf/components/nghttp/nghttp2
COMPONENT_LIBRARIES += nghttp
COMPONENT_LDFRAGMENTS += 
component-nghttp-build: 
