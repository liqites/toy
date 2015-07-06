class Record
  include ActiveSupport::Callbacks
  define_callbacks :save
  set_callback :save,:after,:ensure_run
  set_callback :save,:before,:parent_before

  def save
    # run_callbacks :save do
    #   puts " - do save"
    # end
    run_callbacks :save
  end

  def parent_before
    puts "parent_before"
  end

  def ensure_run
    puts "parent after ..."
  end
end
