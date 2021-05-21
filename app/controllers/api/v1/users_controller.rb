class Api::V1::UsersController < Api::V1::AbstractController
  def create
    creator = UseCases::Users::Create.new(params.permit(resource_attributes), notificators: [UserMailer])
    result = creator.call

    return render_success if result

    render_error(:wrong_format, creator.user.errors.messages.map { |k, v| "#{k} #{v.first}"}.join(", "))
  end

  def show
    user = User.find_by id: params.require(:id)

    return render_error(:not_found) unless user

    data = user.attributes.slice('id', 'name', 'email', 'phone', 'payment_data')

    render_success(data)
  end

  def resource_attributes
    %w[name email phone payment_data]
  end
end