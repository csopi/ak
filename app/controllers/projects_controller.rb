class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_action :find_proj, :only => [:show, :edit, :update, :destroy]

  def index
    @projects = current_user.projects
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user

    if @project.save
      redirect_to projects_url, notice: 'A projekt sikeresen létrehozva.'
    else
      render action: 'new'
    end
  end

  def update
    if @project.update(project_params)
      redirect_to projects_url, notice: 'A projekt adatait sikeresen frissítette.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'A projekt törölve.'
  end

  def i18n
    locale = {
        "sProcessing" =>  "Dolgozunk...",
        "sLengthMenu" =>  "_MENU_ sort mutasson oldalanként",
        "sZeroRecords" => "Adatok nincsenek",
        "sInfo" =>         "  _TOTAL_ sor van összesen, _START_ - _END_ sorok láthatóak most",
        "sInfoEmpty"  =>   "Nincs adat",
        "sInfoFiltered" => "(az adatok amiket most lát szűrtek, _MAX_ sor van összesen)",
        "sInfoPostFix" =>  "",
        "sSearch" =>       "Keresés:",
        "sUrl" =>          "",
        "oPaginate" => {
          "sFirst"  =>   "Első",
          "sPrevious" => "Előző",
          "sNext" =>    "Következő",
          "sLast" =>   "Utolsó"
        }
    }

    render :json => locale
  end

  private
    def find_proj
      @project = current_user.projects.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, :flash => { :error => "A projekt nem található." }
    end

    def project_params
      params.require(:project).permit(:name, :description, :user_id)
    end
end
