class Api::V1::ProceduresController < ApplicationController
  def index
    response =
      if params[:title].present?
        procedures = Procedure.search_by_title(params[:title])
        if procedures.present?
          { procedures: procedures }
        else
          { error: 'Procedures with such title were not found' }
        end
      else
        { error: 'Title parameter required' }
      end

    render json: response
  end
end
