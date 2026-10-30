#ifndef FIREBASE_CORE_PLUGIN_C_API_H_
#define FIREBASE_CORE_PLUGIN_C_API_H_

#include <flutter/plugin_registrar_windows.h>

#ifndef FLUTTER_PLUGIN_EXPORT
#define FLUTTER_PLUGIN_EXPORT
#endif

#if defined(__cplusplus)
extern "C" {
#endif

FLUTTER_PLUGIN_EXPORT void FirebaseCorePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar);

#if defined(__cplusplus)
}
#endif

#undef FLUTTER_PLUGIN_EXPORT

#endif  // FIREBASE_CORE_PLUGIN_C_API_H_
