class Notify
  ActiveSupport::Notifications.subscribe('read') do |name,start,finish,id,playload|
    puts 'name'
    puts id.to_s
  end

  def read
    ActiveSupport::Notifications.instrument('read',extra: :information) do
      puts "read!"
    end
  end
end
