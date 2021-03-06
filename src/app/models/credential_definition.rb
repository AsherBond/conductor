#
#   Copyright 2011 Red Hat, Inc.
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

# == Schema Information
# Schema version: 20110309105149
#
# Table name: credential_definitions
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  label            :string(255)
#  input_type       :string(255)
#  provider_type_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class CredentialDefinition < ActiveRecord::Base
  belongs_to :provider_type
  has_many :credentials
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :provider_type_id
  validates_presence_of :label
  validates_presence_of :input_type
  validates_presence_of :provider_type_id
  CREDENTIAL_DEFINITIONS_ORDER = ["username", "password", "account_id", "x509private", "x509public", 'glance_url']
end
