# Find the pugixml XML parsing library.
#
# Sets the usual variables expected for find_package scripts:
#
# PUGIXML_INCLUDE_DIR - header location
# PUGIXML_LIBRARIES - library to link against
# PUGIXML_FOUND - true if pugixml was found.

unset (PUGIXML_LIBRARY CACHE)
unset (PUGIXML_INCLUDE_DIR CACHE)
find_path (PUGIXML_INCLUDE_DIR
           NAMES pugixml.hpp
           PATHS ${PUGIXML_HOME}/include
           /usr/local/include
           PATH_SUFFIXES pugixml-1.8 pugixml-1.9)
find_library (PUGIXML_LIBRARY
              NAMES pugixml
              PATHS ${PUGIXML_HOME}/lib
              /usr/local/lib
              PATH_SUFFIXES pugixml-1.8 pugixml-1.9)

# Second chance -- if not found, look in the OIIO distro
if (NOT PUGIXML_INCLUDE_DIR AND OPENIMAGEIO_INCLUDE_DIR)
    find_path (PUGIXML_INCLUDE_DIR
               NAMES pugixml.hpp
               PATHS ${OPENIMAGEIO_INCLUDE_DIR}/OpenImageIO)
    set (PUGIXML_LIBRARY ${OPENIMAGEIO_LIBRARIES})
endif ()


# Support the REQUIRED and QUIET arguments, and set PUGIXML_FOUND if found.
include (FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS (PugiXML DEFAULT_MSG PUGIXML_LIBRARY
                                   PUGIXML_INCLUDE_DIR)

if (PUGIXML_FOUND)
    set (PUGIXML_LIBRARIES ${PUGIXML_LIBRARY})
    if (NOT PugiXML_FIND_QUIETLY)
        message (STATUS "PugiXML include = ${PUGIXML_INCLUDE_DIR}")
        message (STATUS "PugiXML library = ${PUGIXML_LIBRARY}")
    endif ()
else ()
    message (STATUS "No PugiXML found")
endif()

mark_as_advanced (PUGIXML_LIBRARY PUGIXML_INCLUDE_DIR)
