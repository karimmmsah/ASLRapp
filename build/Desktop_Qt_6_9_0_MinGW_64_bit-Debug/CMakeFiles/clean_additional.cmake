# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appFrontEnd_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appFrontEnd_autogen.dir\\ParseCache.txt"
  "appFrontEnd_autogen"
  )
endif()
