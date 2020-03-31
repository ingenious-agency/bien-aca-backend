# frozen_string_literal: true

ActiveAdmin.register Heartbeat do
  permit_params :user_id, :time, :lat, :lng, :fence_diameter, :within_fence

  form partial: 'form'

  show do
    attributes_table do
      row :time
      row :data
      row :fence_diameter
      row :within_fence
      row :lat
      row :lng
      # rubocop:disable Rails/OutputSafety
      row(:location) do |heartbeat|
        html = <<~HTML
                    <div id="map" style="height: 300px; width: 100%;"></div>
                    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBO9XurNLrIlvqByVH5AlChjHJLcC5ujxk&callback=initMap"
          async defer></script>
                    <script type="text/javascript">
                      var map, marker, house;
                      function initMap() {
                        map = new google.maps.Map(document.getElementById('map'), {
                          center: { lat: #{heartbeat.user.lat}, lng: #{heartbeat.user.lng} },
                          zoom: 15
                        });
                        house = new google.maps.Marker({
                          position: { lat: #{heartbeat.user.lat}, lng: #{heartbeat.user.lng} },
                          map: map,
                          label: "🏠"
                        });
                        marker = new google.maps.Marker({
                          position: { lat: #{heartbeat.lat}, lng: #{heartbeat.lng} },
                          map: map,
                          label: "💛"
                        });
                      }
                    </script>
        HTML
        html.html_safe
        # rubocop:enable Rails/OutputSafety
      end
    end
  end
end
