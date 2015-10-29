Rails.application.routes.draw do
  scope PluginRoutes.system_info["relative_url_root"], as: "cama" do
    use_doorkeeper
    namespace :api do
      get 'account' => 'api#account'

      namespace :v1 do
        get 'categories' => 'category#categories'
        get 'posts' => 'post#index'
        get 'pages' => 'page#index'

        scope :contact_form do
          get 'show/:slug' => 'contact_form#contact_form_by_slug'
          post 'create' => 'contact_form#save_form'
        end
      end
    end

    # root "application#index"
    default_url_options :host => PluginRoutes.system_info["base_domain"]

    # public
    get 'error', as: "cama_error", to: 'camaleon_cms/camaleon#render_error'
    get 'captcha', as: "cama_captcha", to: 'camaleon_cms/camaleon#captcha'
  end
  eval(PluginRoutes.load("main"))
end
