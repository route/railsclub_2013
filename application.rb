require 'cgi'

class Application < Sinatra::Base
  set :haml, format: :html5
  set :public_folder, File.dirname(__FILE__) + '/public'

  helpers do
    def article(*styles, &block)
      capture_haml do
        haml_tag :article, class: styles do
          haml_tag :table do
            haml_tag :tr do
              haml_tag :td do
                haml_concat capture_haml(&block)
              end
            end
          end
        end
      end
    end
  end

  get '/' do
    haml :index, layout: :application
  end

  post '/eval' do
    type = params[:type].match(/(ruby|sh)/)[0] rescue nil
    case type
    when 'ruby'
      begin
        @@object ||= Object.new
        result = @@object.instance_eval(params[:code])
        CGI.escapeHTML(result.nil? ? 'nil' : result.to_s)
      rescue => e
        e.message
      end
    when 'sh'
      CGI.escapeHTML(`#{params[:code]}`)
    end
  end
end
