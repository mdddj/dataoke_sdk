#include "include/dd_models/dd_models_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "dd_models_plugin.h"

void DdModelsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  dd_models::DdModelsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
