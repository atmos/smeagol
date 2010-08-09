#
# Chef Solo Config File
#
smeagol_root = "#{Dir.tmpdir}/smeagol"

log_level          :info
log_location       STDOUT
sandbox_path       "#{smeagol_root}/sandboxes"
file_cache_path    "#{smeagol_root}/cookbooks"
file_backup_path   "#{smeagol_root}/backup"
cache_options      ({ :path => "#{smeagol_root}/cache/checksums", :skip_expires => true })

# Optionally store your JSON data file and a tarball of cookbooks remotely.
#json_attribs "http://chef.example.com/dna.json"
#recipe_url   "http://chef.example.com/cookbooks.tar.gz"
cookbook_path File.expand_path(File.join(File.dirname(__FILE__), "..", "cookbooks"))

Mixlib::Log::Formatter.show_time = false
