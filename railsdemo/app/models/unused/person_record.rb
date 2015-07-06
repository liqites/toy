class PersonRecord<Record
  set_callback :save, :before, :saving_message
  set_callback :save, :after,  :after_save
  set_callback :save, :after, :child_after #后绑定的先执行？

  def saving_message
    puts 'saving...'
  end

  def after_save
    puts "after save"
  end

  def child_after
    puts "child after"
  end
end
