require_relative 'sql_object'

class Team < SQLObject
  self.finalize!
  belongs_to('conference', {
    'primary_key' => 'id',
    'foreign_key' => 'conference_id',
    'class_name' => 'Conference'
    })

  has_one_through('division', 'conference', 'division')
end

class Conference < SQLObject
  self.finalize!
  belongs_to :division,
    primary_key: :id,
    foreign_key: :division_id,
    class_name: :Division

  has_many :teams,
    primary_key: :id,
    foreign_key: :conference_id,
    class_name: :Team
end

class Division < SQLObject
  self.finalize!
  has_many :conferences,
    primary_key: :id,
    foreign_key: :division_id,
    class_name: :Conference
end
