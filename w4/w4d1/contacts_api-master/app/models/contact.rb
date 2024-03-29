# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  email      :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  favorite   :boolean          default("f"), not null
#

class Contact < ActiveRecord::Base
  validates :name, :user_id, presence: true
  validates :email, presence: true, uniqueness: { scope: :user_id }

  belongs_to :user
  has_many :contact_shares
  has_many(
    :shared_users,
    through: :contact_shares,
    source: :user
  )
  has_many :contact_groups
  has_many :groups, through: :contact_groups, source: :group
  has_many :comments, as: :commentable
end
