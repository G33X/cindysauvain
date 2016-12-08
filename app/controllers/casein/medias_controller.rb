# Scaffolding generated by Casein v5.1.1.5

module Casein
  class MediasController < Casein::CaseinController

    ## optional filters for defining usage according to Casein::AdminUser access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]


    def index
      @casein_page_title = 'Medias'
  		@medias = Medias.order(sort_order(:media_id)).paginate :page => params[:page]
      set_locale
    end

    def show
      @casein_page_title = 'View medias'
      @medias = Medias.find params[:id]
      set_locale
    end

    def new
      @casein_page_title = 'Add a new medias'
    	@medias = Medias.new
      set_locale
    end

    def create
      @medias = Medias.new medias_params

      if @medias.save
        flash[:notice] = 'Medias created'
        redirect_to casein_medias_path
      else
        flash.now[:warning] = 'There were problems when trying to create a new medias'
        render :action => :new
      end
    end

    def update
      @casein_page_title = 'Update medias'

      @medias = Medias.find params[:id]

      if @medias.update_attributes medias_params
        flash[:notice] = 'Medias has been updated'
        redirect_to casein_medias_path
      else
        flash.now[:warning] = 'There were problems when trying to update this medias'
        render :action => :show
      end
      set_locale
    end

    def destroy
      @medias = Medias.find params[:id]

      @medias.destroy
      flash[:notice] = 'Medias has been deleted'
      redirect_to casein_medias_path
    end

    private

      def medias_params
        params.require(:medias).permit(:media_id, :media_link , :image_url , :image_width , :image_height , :caption , :likes , :media_date)
      end

  end
end