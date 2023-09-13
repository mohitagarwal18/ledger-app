class Transaction < ApplicationRecord
  belongs_to :entity
  
  enum transaction_type: { DEPOSIT: 0, INVESTMENT: 1, TRANSFER: 2, WITHDRAWAL: 3, REFUND: 4 }

  validates :activity_id, presence: true, uniqueness: true

  def self.parse_and_save_from_json(file_name="complicated_ledger.json")
    ledger = JSON.parse(File.read(Rails.root.join("app/assets/data/#{file_name}")))
    entity = nil
    
    ledger.each do |data|

      investor_key = data["amount"] < 0 ? "source" : "destination"
     
      entity = Entity.find_by(id: data[investor_key]["id"])
      entity ||= Entity.create(id: data[investor_key]["id"], entity_type: data[investor_key]["type"], description: data[investor_key]["description"])


      transaction =  Transaction.new(
        activity_id: data["activity_id"],
        date: Time.parse(data["date"]),
        transaction_type: data["type"],
        method: data["method"],
        amount: data["amount"],
        balance: data["balance"],
        source: data["source"].to_json,
        entity: entity,
      )
      
      if transaction.valid?
        transaction.save!
      else
        puts transaction.errors.full_messages
      end

    end
    reconcileTxns(entity.id)
  end

  def self.valid_txn?(balance, txn)
    balance + txn.amount == txn.balance
  end
  
  def self.reconcileTxns(entity_id)
    txns = Entity.find(entity_id).transactions.order(:date)
    queue = []
    seq = 0
    balance = 0
    txns.each do |t|
      if valid_txn?(balance, t) # valid
        t.update(sequence_id: seq + 1)
        balance =  t.balance
        seq += 1
        
        #checking if we can take anything from our queue
        while queue.length > 0
          temp = queue.first
          if valid_txn?(balance, temp)
            temp.update(sequence_id: seq + 1)
            seq += 1
            balance =  temp.balance
            queue.shift
          else
            break
          end
        end
      else
        queue << t
      end
    end
    
  end

end
