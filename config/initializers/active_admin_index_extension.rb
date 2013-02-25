# enable proc page_title edit for index action 
# reference https://github.com/gregbell/active_admin/issues/184
module ActiveAdmin::Views::Pages
  class Index < Base
    def title
      parent = controller.__send__(:parent) if controller.respond_to?(:parent, true)

      case config[:title]
      when Proc
        config[:title].call parent
      when String
        config[:title]
      else
        default_title
      end
    end

    protected

    def default_title
      active_admin_config.plural_resource_label
    end
  end
end