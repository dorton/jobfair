module API
  module V1
    class Events < Grape::API
      include API::V1::Defaults

      resource :events do
        desc "Return all events"
        get "", root: :events do
          Event.all
        end

        desc "Return a events"
        params do
          requires :id, type: String, desc: "ID of the event"
        end
        get ":id", root: "event" do
          Event.where(id: permitted_params[:id]).first!
        end
      end
    end
  end
end
