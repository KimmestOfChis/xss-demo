class ApplicationController < ActionController::API
    def token(user_id)
        payload = { user_id: user_id }
        JWT.encode(payload, ENV["HMAC_SECRET"], 'HS256')
      end

    def client_has_valid_token?
        !!current_user_id
    end
    
    def current_user_id
        begin
          token = request.headers["Authorization"]
          decoded_array = JWT.decode(token, ENV["HMAC_SECRET"], true, { algorithm: 'HS256' })
          payload = decoded_array.first
        rescue #JWT::VerificationError
          return nil
        end
        payload["user_id"]
      end
    
      def require_login
        render json: {error: 'Unauthorized'}, status: :unauthorized unless client_has_valid_token?
      end
end
