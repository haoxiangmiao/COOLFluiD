#Sets:
# PLATO_INCLUDE_DIR  = where Mixture.h can be found
# PLATO_LIBRARY      = the library to link against (PLATO etc)
# CF_HAVE_PLATO        = set to true after finding the library

OPTION ( CF_SKIP_PLATO "Skip search for PLATO library" OFF )

IF ( NOT CF_SKIP_PLATO )

  SET_TRIAL_INCLUDE_PATH ("") # clear include search path
  SET_TRIAL_LIBRARY_PATH ("") # clear library search path

  ADD_TRIAL_INCLUDE_PATH( ${PLATO_INCLUDEDIR} )
  ADD_TRIAL_INCLUDE_PATH( ${PLATO_HOME}/include )
  ADD_TRIAL_INCLUDE_PATH( $ENV{PLATO_HOME}/include )
  ADD_TRIAL_INCLUDE_PATH( ${PLATO_HOME}/include/PLATO )
  ADD_TRIAL_INCLUDE_PATH( $ENV{PLATO_HOME}/include/PLATO )

  FIND_PATH(PLATO_INCLUDE_DIR plato_constants_C.h ${TRIAL_INCLUDE_PATHS} NO_DEFAULT_PATH)

  ADD_TRIAL_LIBRARY_PATH( ${PLATO_LIBRARYDIR} )
  ADD_TRIAL_LIBRARY_PATH( ${PLATO_HOME}/lib ${PLATO_HOME}/lib64 )

  FIND_LIBRARY(PLATO_LIBRARY plato ${TRIAL_LIBRARY_PATHS} NO_DEFAULT_PATH)

  IF(PLATO_INCLUDE_DIR AND PLATO_LIBRARY)
    SET(CF_HAVE_PLATO 1 CACHE BOOL "Found plato library")
  ELSE()
    SET(CF_HAVE_PLATO 0 CACHE BOOL "Not found plato library")
  ENDIF()
  
ELSE()
    SET(CF_HAVE_PLATO 0 CACHE BOOL "Skipped plato library")
ENDIF()

  MARK_AS_ADVANCED(
    PLATO_INCLUDE_DIR
    PLATO_LIBRARY
    CF_HAVE_PLATO
  )

  LOG ( "CF_HAVE_PLATO: [${CF_HAVE_PLATO}]" )
  IF(CF_HAVE_PLATO)
    LOG ( "  PLATO_INCLUDE_DIR:  [${PLATO_INCLUDE_DIR}]" )
    LOG ( "  PLATO_LIBRARY:      [${PLATO_LIBRARY}]" )
  ENDIF(CF_HAVE_PLATO)
