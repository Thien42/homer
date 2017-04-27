class SettingController < ApplicationController
  def new
  end

  def index
  end

  def create
    if current_user.role == 1
      @setting = Setting.getSetting

      if @setting.nil?
        @setting = Setting.new
      end
      @setting.money_name = params[:money_name]
      @setting.advisors_activates = params[:advisors_activates]
      @setting.nb_spices_advisors = params[:nb_spices_advisors]
      @setting.nb_spices_supporter = params[:nb_spices_supporter]

      if @setting.advisors_activates.nil?
        @setting.advisors_activates = false
      end
      if @setting.nb_spices_advisors.nil?
        @setting.nb_spices_advisors = Setting.get_nb_spices_advisors
      end

      if !@setting.money_name.nil? && !@setting.money_name.empty? && !@setting.nb_spices_supporter.nil? && @setting.save
        redirect_to root_path, :flash => {success: "Configuration mise à jour"}
      else
        redirect_to root_path, :flash => {error: "Impossibe de mettre à mise à jour"}
      end
    end
  end
end
