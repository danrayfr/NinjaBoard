# frozen_string_literal: true

class CertificatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_certificate, only: %i[edit update destroy]

  def index
    @certificates = current_user.certificates
  end

  def new
    @certificate = current_user.certificates.build
  end

  def create
    @certificate = Certificate.new(certificate_params.merge(user: current_user))

    if @certificate.save
      redirect_to certificates_path, notice: "Certificate successfully added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @certificate.update(certificate_params)
      redirect_to certificates_path, notice: "Certificate successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    return unless @certificate.destroy

    redirect_to certificates_path, notice: "Certificate successfully deleted."
  end

  private

  def set_certificate
    @certificate = Certificate.find(params[:id])
  end

  def certificate_params
    params.require(:certificate)
          .permit(%i[title source date_awarded user_id file])
  end
end
