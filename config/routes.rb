HNNotifierWeb::Application.routes.draw do
  resources :streams
  match "/stream/:username/:followees" => "streams#index", :defaults => { :format => 'plist' }
  root :to => 'streams#index'
end
