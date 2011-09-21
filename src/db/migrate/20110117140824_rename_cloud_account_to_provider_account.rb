#
# Copyright (C) 2011 Red Hat, Inc.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA  02110-1301, USA.  A copy of the GNU General Public License is
# also available at http://www.gnu.org/copyleft/gpl.html.

class RenameCloudAccountToProviderAccount < ActiveRecord::Migration
  def self.up
    rename_table (:cloud_accounts,:provider_accounts)
    remove_column (:providers, :cloud_type)
    add_column (:providers, :provider_type, :integer)
  end

  def self.down
    remove_column (:providers, :provider_type)
    add_column (:providers, :cloud_type, :string, :null => false)
    rename_table (:provider_accounts, :cloud_accounts)
  end
end
