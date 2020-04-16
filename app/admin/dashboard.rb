# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Users outside the fence' do
          table_for User.outside_fence.order('updated_at') do
            column('Name') { |user| link_to(user.name, admin_user_path(user)) }
          end
        end
      end

      column do
        panel 'Users not authenticated' do
          table_for User.not_authenticated.order('updated_at') do
            column('Name') { |user| link_to(user.name, admin_user_path(user)) }
          end
        end
      end

      column do
        panel 'Users without contact' do
          table_for User.lost_contact do
            column('Name') { |user| link_to(user.name, admin_user_path(user)) }
          end
        end
      end
    end
  end
end
