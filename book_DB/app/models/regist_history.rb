class RegistHistory < ApplicationRecord
    belongs_to :user    # ここを追加
    belongs_to :post # ここを追加
end
