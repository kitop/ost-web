require "cuba"
require "cuba/safe"
require "cuba/render"
require "ost"
require_relative "./lib/ost/web"

Ost.redis = Redic.new(ENV["REDIS_URL"] || "redis://127.0.0.1:6379")

Cuba.plugin Cuba::Safe
Cuba.plugin Cuba::Render
Cuba.settings[:render][:layout] = "layout.html"

Cuba.use Rack::Static, urls: ["/css"], root: "public"

Cuba.define do
  on get, root do
    render "index.html", queues: Ost::Web.queue_names
  end

  on get, "queues/:id" do |id|
    render "queue.html", name: id, queue: Ost[id]
  end
end
