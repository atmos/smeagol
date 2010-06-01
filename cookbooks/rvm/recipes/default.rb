#
# Cookbook Name:: rvm
# Recipe:: default
#

DEFAULT_RUBY_VERSION = "1.8.7-p248"

script "installing rvm to ~/Developer" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    if [[ ! -d ~/Developer/.rvm ]]; then
      git clone git://github.com/atmos/rvm.git rvm
      cd rvm
      bin/rvm-install --prefix #{ENV['HOME']}/Developer/. >> ~/.cider.log 2>&1
    fi
  EOS
end

script "updating rvm to the latest stable version" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    rvm update -—head
  EOS
end

script "installing ruby" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    `rvm list | grep -q '#{DEFAULT_RUBY_VERSION}'`
    if [ $? -ne 0 ]; then
      rvm install #{DEFAULT_RUBY_VERSION}
    fi
  EOS
end

script "ensuring a default ruby is set" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    `which ruby | grep -q rvm`
    if [ $? -ne 0 ]; then
      rvm use #{DEFAULT_RUBY_VERSION} --default
    fi
  EOS
end

execute "cleanup rvm build artifacts" do
  command "find ~/.rvm/src -depth 1 | grep -v src/rvm | xargs rm -rf "
end

template "#{ENV['HOME']}/.gemrc" do
  source "dot.gemrc.erb"
end

{ 'bundler' => '0.9.25', 'bundler08' => '0.8.5', 'cider' => '0.1.3',
  'mysql'   => '2.8.1' }.each do |name, version|
  script "updating to the latest #{name} -> #{version}" do
    interpreter "bash"
    code <<-EOS
      source ~/.cider.profile
      `gem list #{name} | grep -q '#{version}'`
      if [[ $? -ne 0 ]]; then
        gem install #{name} --no-rdoc --no-ri >> ~/.cider/stdout.log 2>> ~/.cider/stderr.log
      fi
    EOS
  end
end

{ 'wirble'        => '0.3.1',
  'awesome_print' => '0.2.0',
  'hirb'          => '0.3.2',
  'what_methods'  => '1.0.1',
  'looksee'       => '0.2.1',
  'sketches'      => '0.1.1',
  'net-http-spy'  => '0.2.1',
  'map_by_method' => '0.8.3'
  }.each do |name, version|
  script "installed #{name}(#{version}) to liven up your ~/.irbrc a little" do
    interpreter "bash"
    code <<-EOS
      source ~/.cider.profile
      `gem list #{name} | grep -q '#{version}'`
      if [[ $? -ne 0 ]]; then
        gem install #{name} --no-rdoc --no-ri
      fi
    EOS
  end
end

template "#{ENV['HOME']}/.irbrc" do
  source "dot.irbrc.erb"
end
