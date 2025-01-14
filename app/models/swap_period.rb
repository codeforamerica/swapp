class SwapPeriod < ApplicationRecord
  validates_presence_of :start_date, :end_date
  validate :order_of_dates, :overlapping_events, :at_least_one_night

  def self.current
    where("start_date <= ? AND end_date >= ?", Date.tomorrow, Date.today).first
  end

  def intake_period
    (start_date - 1.day)..(end_date - 1.day)
  end

  def duration
    ((end_date - start_date) + 1).to_i
  end

  def nights 
    duration - 1
  end

  def nights_remaining
    [(end_date -  Date.today.to_date).to_i, 0].max
  end

  def extend nights
    self.end_date = self.end_date.to_date + nights.to_i.days
    self
  end

  def to_s
    "#{id}|#{start_date.to_date}|#{end_date.to_date}"
  end
  
  private 

    def order_of_dates
      if end_date&.< start_date
        errors.add(:base, "end_date: #{end_date} must be same day or later than start_date: #{start_date}")
      end
    end

    def at_least_one_night 
      if start_date.nil?
        return errors.add(:base, "start_date must not be nil")
      end

      if end_date.nil?
        return errors.add(:base, "end_date must not be nil")
      end

      if nights <= 0
        return errors.add(:base, "duration: (#{nights} nights) must be for at least one night")
      end
    end

    def overlapping_events
      overlapping = self.class.where("id <> ? AND start_date <= ? AND ? <= end_date", id, end_date, start_date)
      if overlapping.present?
        errors.add(:overlapping, "can't overlap other swap period: #{overlapping.first}")
      end
    end
end
