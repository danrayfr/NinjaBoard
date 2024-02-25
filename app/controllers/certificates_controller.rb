# frozen_string_literal: true

class CertificatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_certificate, only: %i[edit destroy]

  def index; end

  def new
    @certificate = current_user.certificates.build
  end

  def create
    @certificate = Certificate.new(certificate_params.merge(user: current_user))

    if @certificate.save
      redirect_to certificates_path, notice: 'Certificate successfully added.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def set_certificate
    @certificate = Certificate.find(params[:id])
  end

  def certificate_params
    params.require(:certificate).permit(%i[title source date_awarded user_id])
  end
end
