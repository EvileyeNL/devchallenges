ActiveAdmin.register User do

  index do
      column :email
      column :password
      column :name
      column :username
      column :codechallenge_id
      # default_actions
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end
