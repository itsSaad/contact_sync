module ContactSync
  module ActsAsSyncable
    def acts_as_syncable
      include ContactSync::Syncable
    end
  end
end
