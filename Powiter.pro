#This Source Code Form is subject to the terms of the Mozilla Public
#License, v. 2.0. If a copy of the MPL was not distributed with this
#file, You can obtain one at http://mozilla.org/MPL/2.0/.


TARGET = Powiter
TEMPLATE = app
CONFIG += app
CONFIG += moc rcc
CONFIG += openexr freetype2 ftgl boost ffmpeg eigen2 opengl qt expat debug
QT += gui core opengl concurrent
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets


win32{
    CONFIG += glew
#ofx needs WINDOWS def
#microsoft compiler needs _MBCS to compile with the multi-byte character set.
    DEFINES += WINDOWS _MBCS COMPILED_FROM_DSP XML_STATIC
    DEFINES -= _UNICODE UNICODE
}

unix {
     #  on Unix systems, only the "boost" option needs to be defined in config.pri
     QT_CONFIG -= no-pkg-config
     CONFIG += link_pkgconfig
     openexr:   PKGCONFIG += OpenEXR
     ftgl:      PKGCONFIG += ftgl
     ffmpeg:    PKGCONFIG += libavcodec libavformat libavutil libswscale libavdevice libavfilter
     freetype2: PKGCONFIG += freetype2
     eigen2:    PKGCONFIG += eigen2
     expat:     PKGCONFIG += expat
} #unix

linux {
     LIBS += -lGLU -ldl
}

debug{
warning("Compiling in DEBUG mode.")
}

release:DESTDIR = "build_$$TARGET/release"
debug:  DESTDIR = "build_$$TARGET/debug"

OBJECTS_DIR = "$$DESTDIR/.obj"

#Removed these as the Xcode project would mess-up and it is not important anyway.
MOC_DIR = "$$OBJECTS_DIR"
RCC_DIR = "$$OBJECTS_DIR"
UI_DIR = "$$OBJECTS_DIR"

unix:macx:QMAKE_CXXFLAGS += -mmacosx-version-min=10.7
unix:macx:QMAKE_LFLAGS += -mmacosx-version-min=10.7
unix:macx:QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.7
include(config.pri)


#OpenFX C api includes and OpenFX c++ layer includes that are located in the submodule under /libs/OpenFX
INCLUDEPATH += $$PWD/libs/OpenFX/include
INCLUDEPATH += $$PWD/libs/OpenFX_extensions
INCLUDEPATH += $$PWD/libs/OpenFX/HostSupport/include
INCLUDEPATH += $$PWD/


DEFINES += OFX_EXTENSIONS_NUKE OFX_EXTENSIONS_TUTTLE

SOURCES += \
    Global/main.cpp \
    Gui/Edge.cpp \
    Gui/NodeGraph.cpp \
    Gui/SettingsPanel.cpp \
    Gui/FeedbackSpinBox.cpp \
    Gui/ViewerGL.cpp \
    Gui/InfoViewerWidget.cpp \
    Gui/Knob.cpp \
    Gui/Gui.cpp \
    Gui/NodeGui.cpp \
    Gui/ScaleSlider.cpp \
    Gui/TextRenderer.cpp \
    Gui/Timeline.cpp \
    Gui/ViewerTab.cpp \
    Engine/Box.cpp \
    Engine/ChannelSet.cpp \
    Engine/DataBuffer.cpp \
    Engine/Format.cpp \
    Engine/Hash.cpp \
    Engine/Lut.cpp \
    Engine/MemoryFile.cpp \
    Engine/Model.cpp \
    Engine/Node.cpp \
    Engine/Row.cpp \
    Engine/Settings.cpp \
    Engine/Timer.cpp \
    Engine/VideoEngine.cpp \
    Engine/ViewerNode.cpp \
    Readers/Read.cpp \
    Readers/Reader.cpp \
    Readers/ReadExr.cpp \
    Readers/ReadFfmpeg_deprecated.cpp \
    Readers/ReadQt.cpp \
    Global/Controler.cpp \
    Engine/ViewerCache.cpp \
    Gui/SequenceFileDialog.cpp \
    Writers/Writer.cpp \
    Writers/WriteQt.cpp \
    Writers/WriteExr.cpp \
    Writers/Write.cpp \
    Gui/TabWidget.cpp \
    Gui/ComboBox.cpp \
    Engine/AbstractCache.cpp \
    Engine/ImageFetcher.cpp \
    Engine/Nodecache.cpp \
    libs/OpenFX/HostSupport/src/ofxhUtilities.cpp \
    libs/OpenFX/HostSupport/src/ofxhPropertySuite.cpp \
    libs/OpenFX/HostSupport/src/ofxhPluginCache.cpp \
    libs/OpenFX/HostSupport/src/ofxhPluginAPICache.cpp \
    libs/OpenFX/HostSupport/src/ofxhParam.cpp \
    libs/OpenFX/HostSupport/src/ofxhMemory.cpp \
    libs/OpenFX/HostSupport/src/ofxhInteract.cpp \
    libs/OpenFX/HostSupport/src/ofxhImageEffectAPI.cpp \
    libs/OpenFX/HostSupport/src/ofxhImageEffect.cpp \
    libs/OpenFX/HostSupport/src/ofxhHost.cpp \
    libs/OpenFX/HostSupport/src/ofxhClip.cpp \
    libs/OpenFX/HostSupport/src/ofxhBinary.cpp \
    Gui/Texture.cpp \
    Engine/OfxNode.cpp \
    Engine/OfxClipInstance.cpp \
    Engine/OfxParamInstance.cpp


HEADERS += \
    Gui/Edge.h \
    Gui/ComboBox.h \
    Gui/NodeGraph.h \
    Gui/SettingsPanel.h \
    Gui/FeedbackSpinBox.h \
    Gui/ViewerGL.h \
    Gui/InfoViewerWidget.h \
    Gui/Knob.h \
    Gui/Gui.h \
    Gui/NodeGui.h \
    Gui/ScaleSlider.h \
    Gui/Shaders.h \
    Gui/TextRenderer.h \
    Gui/Timeline.h \
    Gui/ViewerTab.h \
    Engine/Box.h \
    Engine/ChannelSet.h \
    Engine/DataBuffer.h \
    Engine/Format.h \
    Engine/Hash.h \
    Engine/Lut.h \
    Engine/MemoryFile.h \
    Engine/Model.h \
    Engine/Node.h \
    Engine/ReferenceCountedObject.h \
    Engine/Row.h \
    Engine/Settings.h \
    Engine/Singleton.h \
    Engine/Sleeper.h \
    Engine/Timer.h \
    Engine/VideoEngine.h \
    Engine/ViewerNode.h \
    Readers/Read.h \
    Readers/Reader.h \
    Readers/ReadExr.h \
    Readers/ReadFfmpeg_deprecated.h \
    Readers/ReadQt.h \
    Global/Controler.h \
    Global/Enums.h \
    Global/GLIncludes.h \
    Global/MemoryInfo.h \
    Global/GlobalDefines.h \
    Engine/ViewerCache.h \
    Gui/SequenceFileDialog.h \
    Gui/TabWidget.h \
    Engine/LRUcache.h \
    Engine/ImageFetcher.h \
    Writers/Writer.h \
    Writers/WriteQt.h \
    Writers/WriteExr.h \
    Writers/Write.h \
    Gui/LineEdit.h \
    Engine/AbstractCache.h \
    Engine/Nodecache.h \
    Gui/Button.h \
    Gui/Texture.h \
    Engine/OfxNode.h \
    Engine/OfxClipInstance.h \
    Engine/OfxParamInstance.h \
    libs/OpenFX/HostSupport/include/ofxhBinary.h \
    libs/OpenFX/HostSupport/include/ofxhClip.h \
    libs/OpenFX/HostSupport/include/ofxhHost.h \
    libs/OpenFX/HostSupport/include/ofxhImageEffect.h \
    libs/OpenFX/HostSupport/include/ofxhImageEffectAPI.h \
    libs/OpenFX/HostSupport/include/ofxhInteract.h \
    libs/OpenFX/HostSupport/include/ofxhMemory.h \
    libs/OpenFX/HostSupport/include/ofxhParam.h \
    libs/OpenFX/HostSupport/include/ofxhPluginAPICache.h \
    libs/OpenFX/HostSupport/include/ofxhPluginCache.h \
    libs/OpenFX/HostSupport/include/ofxhProgress.h \
    libs/OpenFX/HostSupport/include/ofxhPropertySuite.h \
    libs/OpenFX/HostSupport/include/ofxhTimeLine.h \
    libs/OpenFX/HostSupport/include/ofxhUtilities.h \
    libs/OpenFX/HostSupport/include/ofxhXml.h \
    libs/OpenFX/include/ofxCore.h \
    libs/OpenFX/include/ofxImageEffect.h \
    libs/OpenFX/include/ofxInteract.h \
    libs/OpenFX/include/ofxKeySyms.h \
    libs/OpenFX/include/ofxMemory.h \
    libs/OpenFX/include/ofxMessage.h \
    libs/OpenFX/include/ofxMultiThread.h \
    libs/OpenFX/include/ofxOpenGLRender.h \
    libs/OpenFX/include/ofxParam.h \
    libs/OpenFX/include/ofxParametricParam.h \
    libs/OpenFX/include/ofxPixels.h \
    libs/OpenFX/include/ofxProgress.h \
    libs/OpenFX/include/ofxProperty.h \
    libs/OpenFX/include/ofxTimeLine.h \
    libs/OpenFX_extensions//nuke/camera.h \
    libs/OpenFX_extensions//nuke/fnPublicOfxExtensions.h \
    libs/OpenFX_extensions//tuttle/ofxGraphAPI.h \
    libs/OpenFX_extensions//tuttle/ofxMetadata.h \
    libs/OpenFX_extensions//tuttle/ofxParam.h \
    libs/OpenFX_extensions//tuttle/ofxParamAPI.h \
    libs/OpenFX_extensions//tuttle/ofxReadWrite.h


INSTALLS += target

RESOURCES += \
    Resources.qrc


INSTALLS += data
OTHER_FILES += \
    config.pri

