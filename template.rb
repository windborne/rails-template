
def apply_template!
  gem 'shakapacker', '~> 8.0.0.rc.3'
  gem 'react-rails', '~> 3.2'
  gem 'foreman'

  gem_group :development, :test do
    gem 'annotaterb'
    gem 'rspec-rails'
  end

  tweak_rubocop!
  add_procfile!

  after_bundle do
    generate 'annotate_rb:install'
    generate 'rspec:install'

    rails_command 'shakapacker:install'
    system('npm install react@18.3.1 react-dom@18.3.1 react-redux@9.1.2 redux@5.0.1 react_ujs@3.1.1 @babel/preset-react prop-types css-loader style-loader mini-css-extract-plugin css-minimizer-webpack-plugin')

    generate 'react:install'
    system('npm pkg set babel.presets.1=@babel/preset-react')
  end
end

def tweak_rubocop!
  config = <<~RUBOCOP
# Omakase Ruby styling for Rails
inherit_gem: { rubocop-rails-omakase: rubocop.yml }

Layout/SpaceInsideArrayLiteralBrackets:
 Enabled: false

Layout/SpaceAroundEqualsInParameterDefault:
  Enabled: false

Layout/TrailingWhitespace:
  Enabled: false

Style/BlockDelimiters:
  EnforcedStyle: semantic

Style/CaseLikeIf:
  Enabled: false

Style/StringLiterals:
  EnforcedStyle: single_quotes
  RUBOCOP

  create_file '.rubocop.yml', config, force: true
end

def add_procfile!
  procfile = <<~PROCFILE
web: PORT=3000 bin/rails s
webpack: bin/shakapacker-dev-server
  PROCFILE

  create_file 'Procfile.dev', procfile
end

apply_template!