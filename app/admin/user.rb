ActiveAdmin.register User do

  index do
    column :email
    column :encrypted_password
    column :name
    column :username
    column :codechallenge_id
    default_actions
  end

  form do |f|
    f.inputs "" do
      f.input :email
      f.input :name
      f.input :username
      f.input :codechallenge_id
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end
