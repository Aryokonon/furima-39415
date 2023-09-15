module Users
  class SessionsController < Devise::SessionsController
    # GET /resource/sign_in
    def new
      super # Call the parent class's implementation of 'new'
    end

    # POST /resource/sign_in
    def create
      super # Call the parent class's implementation of 'create'
    end

    # DELETE /resource/sign_out
    def destroy
      super # Call the parent class's implementation of 'destroy'
    end

    # Add your custom methods or overrides below this line
  end
end