cmake_minimum_required(VERSION 3.16)

project(FrontEnd VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS
    Quick
    WebSockets
    Gui
    Core
    Widgets
    Network
)

qt_add_executable(appFrontEnd
    main.cpp
    RosConnector.cpp
    AuthenticationManager.cpp
)

target_include_directories(appFrontEnd PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

qt_add_qml_module(appFrontEnd
    URI FrontEnd
    VERSION 1.0
    RESOURCE_PREFIX "/"
    QML_FILES Main.qml
    RESOURCES resources.qrc
    SOURCES
        AuthenticationManager.h
        AuthenticationManager.cpp
        RosConnector.h
        RosConnector.cpp
)

target_link_libraries(appFrontEnd PRIVATE
    Qt6::Quick
    Qt6::WebSockets
    Qt6::Gui
    Qt6::Core
    Qt6::Widgets
    Qt6::Network
)

set_target_properties(appFrontEnd PROPERTIES
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

include(GNUInstallDirs)
install(TARGETS appFrontEnd
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
