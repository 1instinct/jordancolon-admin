class Spree::Admin::MessagesController <  Spree::Admin::BaseController
	before_action :set_session

	def index
		@q = Message.ransack(params[:q])
		@collection = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(params[:per_page])
	end

	def conversations
		@users_array = Message.pluck(:sender_id, :sender_type, :receiver_id, :receiver_type).uniq
	end

	def new
		@message = Message.new
	end

	def edit
		@message = Message.find(params[:id])
	end

	def update
		@message = Message.find(params[:id])
		respond_to do |format|
			if @message.update(message_params)
				flash[:success] = Spree.t('message.success.update')
				format.html { redirect_to admin_message_path }
			else
				flash[:error] = @message.errors.full_messages.join(', ')
				format.html { render :edit }
			end
		end
	end

	def show
		@message = Message.find(params[:id])
	end

	def create
		@message = Message.new(message_params)
		if @message.save
			flash[:success] = Spree.t('message.added_success')
			redirect_to admin_messages_path
		else
			flash[:error] = @message.errors.full_messages.join(', ')
			format.html { render :new }
		end
	end

	def destroy
		@message = Message.find(params[:id])
		if @message.destroy
			flash[:success] = Spree.t('message.message_deleted')
			respond_with do |format|
				format.html { redirect_to collection_url }
				format.js  { render_js_for_destroy }
			end
		else
			flash[:error] = @response[1]['error']['messages'].join("")
			redirect_to admin_message_path
		end
	end
	def conversation
		message = Message.find_by_id(params[:id])
		@user_1 = message.sender
		@user_2 = message.receiver
		@one_to_one_messages = message.message_transaction_between_two_parties(message.sender, message.receiver)
		@one_to_one_messages = Message.where(id: @one_to_one_messages.pluck(:id))
		thread_ids = @one_to_one_messages.pluck(:thread_table_id).uniq
		@threads = []
		thread_ids.each do |thread_id|
			@threads << @one_to_one_messages.where(thread_table_id: thread_id)
		end
	end
	private
	def set_session
		session[:return_to] = request.url
	end
	def message_params
		params.require(:message).permit(:is_received, :is_read, :sentiment, :sender_type, :sender_id, :receiver_type, :receiver_id, :message)
	end
end
# class Spree::Admin::MessagesController <  Spree::Admin::BaseController
#
# 	before_action :set_session
#
# 	def index
# 		@messages = Message.admin_conversations
# 	end
#
# 	def show
# 		@message = Message.find(params[:id])
# 		@messages = Message.admin_conversations
# 		@chat_messages = Message.find_with_sender_id(@message.sender_id)
# 		render :index
# 	end
#
# 	def create
# 		data = {}
# 		data[:body] = create_params['body']
# 		data[:thread_id] = create_params['thread_id']
#
# 		@message = Message.create_message_for_admin(data[:body], data[:thread_id], spree_current_user.id)
#
# 	end
#
#
# 	def message_support
#
# 	end
#
#
# private
#
# 	def set_session
# 		session[:return_to] = request.url
# 	end
#
# 	def create_params
# 		params.permit( :body, :thread_id, :utf8, :authenticity_token, :commit )
# 	end
#
# end
