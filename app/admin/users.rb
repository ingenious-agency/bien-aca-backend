# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :email, :password, :name, :identity_number, :date_of_birth, :gender,
                :cellphone, :other_phone, :lat, :lng, :fence_diameter, :within_fence

  form partial: 'form'

  show do
    attributes_table do
      row :name
      row :email
      row :identity_number
      row :date_of_birth
      row :binary_gender
      row :cellphone
      row :other_phone
      row :fence_diameter
      row :within_fence
      row :lat
      row :lng
      # rubocop:disable Rails/OutputSafety
      row(:location) do |user|
        html = <<~HTML
                    <div id="map" style="height: 300px; width: 100%;"></div>
                    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBO9XurNLrIlvqByVH5AlChjHJLcC5ujxk&callback=initMap"
          async defer></script>
                    <script type="text/javascript">
                      var map, marker;
                      function initMap() {
                        map = new google.maps.Map(document.getElementById('map'), {
                          center: { lat: #{user.lat}, lng: #{user.lng} },
                          zoom: 15
                        });
                        marker = new google.maps.Marker({
                          position: { lat: #{user.lat}, lng: #{user.lng} },
                          map: map,
                          label: "🏠"
                        });
                      }
                    </script>
        HTML
        html.html_safe
        # rubocop:enable Rails/OutputSafety
      end
    end

    panel 'Heartbeats' do
      table_for user.heartbeats.order('time DESC') do
        # rubocop:disable Rails/OutputSafety
        column(:id) do |heartbeat|
          "<a href='/admin/heartbeats/#{heartbeat.id}'>#{heartbeat.id}</a>".html_safe
        end
        # rubocop:enable Rails/OutputSafety
        column :time
        column(:distance) { |heartbeat| "#{heartbeat.distance_to(user).round(2)} km" }
        column :within_fence
        column :fence_diameter
      end
    end
  end
end
