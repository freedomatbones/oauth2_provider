Doorkeeper::OpenidConnect.configure do
  issuer 'issuer string'

  signing_key <<-EOL
-----BEGIN RSA PRIVATE KEY-----
....
-----END RSA PRIVATE KEY-----
EOL

  subject_types_supported [:public]

  resource_owner_from_access_token do |access_token|
    # Example implementation:
    User.find_by(id: access_token.resource_owner_id)
  end

  auth_time_from_resource_owner do |resource_owner|
    # Example implementation:
    resource_owner.current_sign_in_at
  end

  reauthenticate_resource_owner do |resource_owner, return_to|
    # Example implementation:
    # store_location_for resource_owner, return_to
    # sign_out resource_owner
    redirect_to new_user_session_url
  end

  subject do |resource_owner, application|
    # Example implementation:
    resource_owner.id

    # or if you need pairwise subject identifier, implement like below:
    # Digest::SHA256.hexdigest("#{resource_owner.id}#{URI.parse(application.redirect_uri).host}#{'your_secret_salt'}")
  end

  # Protocol to use when generating URIs for the discovery endpoint,
  # for example if you also use HTTPS in development
  # protocol do
  #   :https
  # end

  # Expiration time on or after which the ID Token MUST NOT be accepted for processing. (default 120 seconds).
  # expiration 600

  # Example claims:
  claims do
    # 5.1. Standard Claims
    # scope: profile
    claim :name do |resource_owner|
      'name'
    end
    claim :family_name do |resource_owner|
      'family_name'
    end
    claim :given_name do |resource_owner|
      'given_name'
    end
    claim :middle_name do |resource_owner|
      'middle_name'
    end
    claim :nickname do |resource_owner|
      'nickname'
    end
    claim :preferred_username do |resource_owner|
      'preferred_username'
    end
    claim :profile do |resource_owner|
      'profile'
    end
    claim :picture do |resource_owner|
      'picture'
    end
    claim :website do |resource_owner|
      'website'
    end
    claim :gender do |resource_owner|
      'gender'
    end
    claim :birthdate do |resource_owner|
      'birthdate'
    end
    claim :zoneinfo do |resource_owner|
      'zoneinfo'
    end
    claim :locale do |resource_owner|
      'locale'
    end
    claim :updated_at do |resource_owner|
      'updated_at'
    end

    # scope: email
    claim :email do |resource_owner|
      'email'
    end
    claim :email_verified do |resource_owner|
      'email_verified'
    end

    # scope: address
    claim :address do |resource_owner|
      'address'
    end

    # scope: phone
    claim :phone_number do |resource_owner|
      'phone_number'
    end
    claim :phone_number_verified do |resource_owner|
      'phone_number_verified'
    end

    # 5.1.2. Additional Claims
    claim :app_metadata, scope: :openid do |resource_owner|
      {plan: "full"}
    end
  end
end
