class Fluent::DockerTagResolverOutput < Fluent::Output

  # Define `log` method for v0.10.42 or earlier
  unless method_defined?(:log)
    define_method("log") { $log }
  end

  Fluent::Plugin.register_output('docker_tag_resolver', self)

  def initialize
    super
    require  'docker'

    @containers = Docker::Container.all

    @find_containers = Proc.new do |id|
      container = @containers.select{|c| c.id == id}.first

      if container.nil?
        @containers = Docker::Container.all 
        @containers.select{|c| c.id == id}.first
      else
        container
      end
    end
  end

  def emit(tag, es, chain)
    es.each do |time,record|
      rewrited_tag = rewrite_tag(tag, record)
      next if rewrited_tag.nil? || tag == rewrited_tag
      Fluent::Engine.emit(rewrited_tag, time, record)
    end

    chain.next
  end

  def rewrite_tag(tag, record)
    container_id, _ , _ = tag.split('.').last(3)

    container = @find_containers.call(container_id)

    return tag unless container

    image_name = container.info['Image']
    container_name = container.info['Names'].first

    return tag if image_name.nil? or container_name.nil?

    container_name.sub!(/^\//, '')
    container_name.tr!('.','_')

    rewrited_tag = "docker.container.%s.%s.%s" % [image_name, container_name, container_id]
    return rewrited_tag
  end


end

