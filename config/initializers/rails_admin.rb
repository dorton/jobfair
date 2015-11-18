RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  RailsAdmin.config do |config|
    config.model 'Event' do
      list do
        configure :id do
          hide
        end
        configure :created_at do
          hide
        end
        configure :updated_at do
          hide
        end
        configure :user_id do
          hide
        end
        configure :user_events do
          hide
        end
      end
    end
  end

  RailsAdmin.config do |config|
    config.model 'User' do
      list do
        configure :id do
          hide
        end
        configure :created_at do
          hide
        end
        configure :updated_at do
          hide
        end
        configure :phone do
          hide
        end
        configure :note do
          hide
        end
        configure :event_id do
          hide
        end
        configure :user_events do
          hide
        end
      end
    end
  end


  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
