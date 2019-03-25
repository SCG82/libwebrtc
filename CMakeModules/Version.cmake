include(LibWebRTCExecute)

libwebrtc_execute(
    COMMAND ${GIT_EXECUTABLE} describe --tags --dirty=-dirty
    #COMMAND ${GIT_EXECUTABLE} describe --all
    OUTPUT_VARIABLE _LIBWEBRTC_TAG
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    STAMPFILE webrtc-current-tag
    STATUS "Retrieving current git tag"
    ERROR "Unable to retrieve the current git tag"
)
string(STRIP ${_LIBWEBRTC_TAG} _LIBWEBRTC_TAG)

if("${_LIBWEBRTC_TAG}" MATCHES "^v?([0-9]+)\\.?([0-9]*)\\.?([0-9]*)(.*)")
    set(LIBWEBRTC_MAJOR_VERSION "${CMAKE_MATCH_1}")
    set(LIBWEBRTC_MINOR_VERSION "${CMAKE_MATCH_2}")
    set(LIBWEBRTC_PATCH_VERSION "${CMAKE_MATCH_3}")
    set(LIBWEBRTC_BUILD_VERSION "${CMAKE_MATCH_4}")
else()
    libwebrtc_execute(
        COMMAND ${GIT_EXECUTABLE} describe --all
        OUTPUT_VARIABLE _LIBWEBRTC_BRANCH
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        STAMPFILE webrtc-current-branch
        STATUS "Retrieving current git branch"
        ERROR "Unable to retrieve the current git branch"
    )
    string(STRIP ${_LIBWEBRTC_BRANCH} _LIBWEBRTC_BRANCH)
    string(REGEX REPLACE "^remotes/branch-heads/([0-9]+).*" "\\1" LIBWEBRTC_MAJOR_VERSION "${_LIBWEBRTC_BRANCH}")
    set(LIBWEBRTC_MINOR_VERSION 0)
    set(LIBWEBRTC_PATCH_VERSION 0)
    set(LIBWEBRTC_BUILD_VERSION "")
endif()


#string(REGEX REPLACE "^v?([0-9]+)\\..*" "\\1" LIBWEBRTC_MAJOR_VERSION "${_LIBWEBRTC_TAG}")
#string(REGEX REPLACE "^v?[0-9]+\\.([0-9]+).*" "\\1" LIBWEBRTC_MINOR_VERSION "${_LIBWEBRTC_TAG}")
#string(REGEX REPLACE "^v?[0-9]+\\.[0-9]+\\.([0-9]+).*" "\\1" LIBWEBRTC_PATCH_VERSION "${_LIBWEBRTC_TAG}")
#string(REGEX REPLACE "^v?[0-9]+\\.[0-9]+\\.[0-9]+(.*)" "\\1" LIBWEBRTC_BUILD_VERSION "${_LIBWEBRTC_TAG}")

#if (NOT LIBWEBRTC_MAJOR_VERSION)
  #string(REGEX REPLACE "^remotes/branch-heads/([0-9]+).*" "\\1" LIBWEBRTC_MAJOR_VERSION "${_LIBWEBRTC_TAG}")
  #set(LIBWEBRTC_MINOR_VERSION 0)
  #set(LIBWEBRTC_PATCH_VERSION 0)
  #set(LIBWEBRTC_BUILD_VERSION "")
#endif (NOT LIBWEBRTC_MAJOR_VERSION)

set(LIBWEBRTC_API_VERSION
    "${LIBWEBRTC_MAJOR_VERSION}.${LIBWEBRTC_MINOR_VERSION}.${LIBWEBRTC_PATCH_VERSION}")
set(LIBWEBRTC_VERSION
    ${LIBWEBRTC_API_VERSION}${LIBWEBRTC_BUILD_VERSION})

set(LIBWEBRTC_WEBRTC_HEAD refs/branch-heads/69)
