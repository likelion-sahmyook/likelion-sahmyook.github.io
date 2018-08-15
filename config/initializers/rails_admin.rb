RailsAdmin.config do |config|

	# 새로 추가될 코드 start
	config.authenticate_with do
	    warden.authenticate! scope: :user
	end
	config.current_user_method(&:current_user)
	
	config.authorize_with :cancan

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)
  config.main_app_name = ["LIKELION Sahmyook", "관리자"]
  
  config.model 'Impression' do
    label '조회수'
    label_plural '조회수'
  end
  
  config.model 'Post' do
    label '게시글'
    label_plural '게시글'
  end
  
  config.model 'Role' do
    label '등급'
    label_plural '등급'
  end
  
  config.model 'User' do
    label '회원'
    label_plural '회원'
  end
  
   config.model 'Image' do
    label '이미지'
    label_plural '이미지'
  end
  
  config.model 'Signkey' do
    label '가입코드'
    label_plural '가입코드'
  end


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
