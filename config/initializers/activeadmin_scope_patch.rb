# active_admin / lib / active_admin / views / components / scopes.rb
module ActiveAdmin
  module Views
    class Scopes < ActiveAdmin::Component
      def build(scopes, options = {})
        scopes.each do |scope|
          build_scope(scope, options) if call_method_or_proc_on(self, scope.display_if_block)
        end
      end
    end
  end
end