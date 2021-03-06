class Admin::LibrariesController < AdminController
  load_and_authorize_resource :library, :find_by => :find_by_grandham_id

  respond_to :html

  before_filter :find_library, except: [ :index, :new ]

  def index
    @libraries = current_language.libraries

    respond_with @libraries
  end

  def edit
  end

  def new
    @library = current_language.libraries.new
  end

  def create
    @library = current_language.libraries.new(params[:library])

    if @library.save
      redirect_to language_admin_libraries_path(current_language), notice: 'Library was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @library.update_attributes(params[:library])
      redirect_to language_admin_libraries_path(current_language), notice: 'Library was successfully updated.'
    else
      render action: "edit"
    end
  end

  private

  def find_library
    @library = current_language.libraries.find_by_grandham_id(params[:id])
  end
end