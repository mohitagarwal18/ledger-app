class TransactionsController < ApplicationController
  def index
    
    Transaction.parse_and_save_from_json
    
    entity_id = params[:entity_id]
    @transactions = Transaction.where(entity_id: entity_id).order(:sequence_id)
  end
end