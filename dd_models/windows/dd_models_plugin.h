#ifndef FLUTTER_PLUGIN_DD_MODELS_PLUGIN_H_
#define FLUTTER_PLUGIN_DD_MODELS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace dd_models {

class DdModelsPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  DdModelsPlugin();

  virtual ~DdModelsPlugin();

  // Disallow copy and assign.
  DdModelsPlugin(const DdModelsPlugin&) = delete;
  DdModelsPlugin& operator=(const DdModelsPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace dd_models

#endif  // FLUTTER_PLUGIN_DD_MODELS_PLUGIN_H_
