# Uncomment this if you reference any of your controllers in activate
require_dependency 'application'

class JqueryAdminExtension < Radiant::Extension
  version "1.0"
  description "Provide the features of the admin interface with jQuery"
  url "http://saturnflyer.com/"
  
  def activate
    ApplicationController.class_eval {
      undef_method :include_javascript
      before_filter :setup_jquery
      
      def setup_jquery
        #add jquery based scripts...
        @javascripts << 'http://ajax.googleapis.com/ajax/libs/jquery/1.3.1/jquery.min.js' #TODO: write all the code and add it here
        
        #remove prototype based scripts...
        ['admin/admin', 'admin/ruledtable', 'admin/tabcontrol', 'prototype', 'effects', 'string'].each do |script|
         @javascripts.delete(script)
        end
      end
      
      def include_javascript(script)
        @javascripts << script unless script == 'admin/sitemap'
      end
    }
  end
  
end