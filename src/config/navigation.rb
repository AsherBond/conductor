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

SimpleNavigation::Configuration.run do |navigation|
  navigation.autogenerate_item_ids = false
  navigation.items do |first_level|
    first_level.item :resource_management, t(:resource_management), pools_path, :highlights_on => /^\/$/ do |second_level|
      second_level.item :pools, t('pools.index.pools'), pools_path
      second_level.item :deployments, t('deployments.deployments'),deployments_path, :highlights_on => /^\/$|\/deployments/
      second_level.item :instances, t("instances.instances"), instances_path
    end
    first_level.item :administration, t(:administration), users_path, :highlights_on => /\/admin/ do |second_level|
      second_level.item :users, t('users.users'), users_path, :highlights_on => /\/users/
      second_level.item :roles, t('roles.roles'), roles_path, :highlights_on => /\/roles/
      second_level.item :providers, t('providers.providers'), providers_path, :highlights_on => /\/providers/
      second_level.item :provider_accounts, t(:provider_accounts_item), provider_accounts_path, :highlights_on => /\/provider_accounts/
      second_level.item :hardware_profiles, t(:cloud_engine_hardware_profiles), hardware_profiles_path, :highlights_on => /\/hardware_profiles/
      second_level.item :realms, t(:cloud_engine_realms), realms_path, :highlights_on => /\/realms/
      second_level.item :pool_families, t('pool_families.pool_families'), pool_families_path, :highlights_on => /\/pool_families/
      second_level.item :catalogs, t('catalogs.index.catalogs'), catalogs_path, :highlights_on => /\/catalogs/
      second_level.item :catalog_entries, t('catalog_entries.index.catalog_entries'), catalog_entries_path, :highlights_on => /\/catalog_entries/
      second_level.item :settings, t('settings.settings'), settings_path, :highlights_on => /\/settings/
    end
    first_level.item :dashboard, t(:dashboard), '#'
  end
end
