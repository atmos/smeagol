# Rakefile for Smeagol Repository
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

begin
  require 'rubygems'
  require 'chef'
  require 'json'

  task :default => :smeagol
  # Load constants from rake config file.
  require File.join(File.dirname(__FILE__), 'config', 'rake')

  # Detect the version control system and assign to $vcs. Used by the update
  # task in chef_repo.rake (below). The install task calls update, so this
  # is run whenever the repo is installed.
  #
  # Comment out these lines to skip the update.

  if File.directory?(File.join(TOPDIR, ".svn"))
    $vcs = :svn
  elsif File.directory?(File.join(TOPDIR, ".git"))
    $vcs = :git
  end

  # Load common, useful tasks from Chef.
  # rake -T to see the tasks this loads.

  load 'chef/tasks/chef_repo.rake'

  desc "Bundle a single cookbook for distribution"
  task :bundle_cookbook => [ :metadata ]
  task :bundle_cookbook, :cookbook do |t, args|
    tarball_name = "#{args.cookbook}.tar.gz"
    temp_dir = File.join(Dir.tmpdir, "chef-upload-cookbooks")
    temp_cookbook_dir = File.join(temp_dir, args.cookbook)
    tarball_dir = File.join(TOPDIR, "pkgs")
    FileUtils.mkdir_p(tarball_dir)
    FileUtils.mkdir(temp_dir)
    FileUtils.mkdir(temp_cookbook_dir)

    child_folders = [ "cookbooks/#{args.cookbook}", "site-cookbooks/#{args.cookbook}" ]
    child_folders.each do |folder|
      file_path = File.join(TOPDIR, folder, ".")
      FileUtils.cp_r(file_path, temp_cookbook_dir) if File.directory?(file_path)
    end

    system("tar", "-C", temp_dir, "-cvzf", File.join(tarball_dir, tarball_name), "./#{args.cookbook}")

    FileUtils.rm_rf temp_dir
  end

  task :smeagol do |t, args|
    system("chef-solo -j config/run_list.json -c config/solo.rb")
  end
rescue LoadError => e
  puts "You don't seem to have chef, installing it for you"
  system("sudo gem install chef --no-rdoc --no-ri")
  puts "I had to install chef for you, please rerun 'rake smeagol'"
end
