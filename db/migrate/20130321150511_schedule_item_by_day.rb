class ScheduleItemByDay < ActiveRecord::Migration
  def up
    add_column :schedule_items, :day_cd, :integer
    add_column :schedule_items, :status_cd, :integer, null: false, default: 1
    add_column :schedule_items, :pause_start_at, :time
    add_column :schedule_items, :pause_end_at, :time

    Store.all.each do |store|
      Store.transaction do
        store.schedule_items.all.each do |schedule|
          start_idx = schedule.effective_day_cd
          end_idx = schedule.discontinue_day_cd
          days = ScheduleItem.ABBREVIATED_WEEKDAYS[start_idx, end_idx - start_idx + 1]
          days.each do |day|
            new_sched = store.schedule_items.build(day: day, start_at: schedule.start_at,
                                                   end_at: schedule.end_at)
            # Since we change model, we are force to bypass validation of old/new behavior
            new_sched.save(validate: false)
          end
          schedule.destroy
        end
      end
    end

    remove_column :schedule_items, :effective_day_cd
    remove_column :schedule_items, :discontinue_day_cd
  end

  def down
    add_column :schedule_items, :effective_day_cd, :integer
    add_column :schedule_items, :discontinue_day_cd, :integer

    remove_column :schedule_items, :day_cd
    remove_column :schedule_items, :status_cd
    remove_column :schedule_items, :pause_start_at
    remove_column :schedule_items, :pause_end_at

    # FIXME Update data
  end
end
