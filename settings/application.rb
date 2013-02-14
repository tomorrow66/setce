require 'bundler'
Bundler.require

set :environment, ENV['RACK_ENV'] || ENV['env'] || ENV['environment'] || ENV['rack_env'] || :development

enable :sessions

Tilt.register Tilt::ERBTemplate, 'html'

set :views,         './views'
set :public_folder, './public'

ScreenSized.load_path 'settings', 'libraries', 'models', 'routes'

DataMapper.finalize

configure :production do
  error(400) { view 'error', layout: false, locals: { code: '400', message: 'Bad Request'           } }
  error(401) { view 'error', layout: false, locals: { code: '401', message: 'Unauthorized'          } }
  error(403) { view 'error', layout: false, locals: { code: '403', message: 'Forbidden'             } }
  error(404) { view 'error', layout: false, locals: { code: '404', message: 'Not Found'             } }
  error(408) { view 'error', layout: false, locals: { code: '408', message: 'Request Timeout'       } }
  error(500) { view 'error', layout: false, locals: { code: '500', message: 'Internal Server Error' } }
  error(502) { view 'error', layout: false, locals: { code: '502', message: 'Bad Gateway'           } }
end