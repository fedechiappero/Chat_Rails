RailsAdmin.config do |config|

  config.main_app_name = ["CableChat"]

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
    redirect_to main_app.root_path unless current_user.admin?
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      only User
    end
    #export
    #bulk_delete
    show
    edit do
      only ['User', 'ChatRoom']
    end
    delete

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model ChatRoom do
    list do
      field :id
      field :title
      field :created_at
      field :users
    end
    edit do
      field :title do
        required true
      end
    end
  end

  config.model Message do
    list do
      field :id
      field :user
      field :chat_room
      field :created_at
    end
  end

  config.model Participant do
    list do
      field :id
      field :chat_room
      field :user
    end
  end

  config.model User do
    list do
      field :id
      field :email
      field :sign_in_count
      field :last_sign_in_at do
        label "Last Login"
      end
      field :last_sign_in_ip do
        label "Last ip"
      end
      field :active
    end
    edit do
      field :email do
        required true
      end
      field :password do
        required true
      end
      field :admin
      field :active
    end
  end
end
