# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "fluent-plugin-docker-tag-resolver"
  s.version     = "0.2.0"
  s.license     = "Apache 2.0"
  s.authors     = ["Naoki AINOYA"]
  s.email       = ["ainonic@gmail.com"]
  s.homepage    = "https://github.com/ainoya/fluent-plugin-docker-tag-resolver"
  s.summary     = %q{Fluentd output plugin to resolve container name from docker container-id in record tags.}

  s.files         = `git ls-files`.split("\n").reject{|f| f =~ /^docker\//}
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_development_dependency "pry"
  s.add_runtime_dependency "fluentd"
  s.add_runtime_dependency "string-scrub"
  s.add_runtime_dependency "docker-api"
end
