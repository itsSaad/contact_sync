module ConSync
  module ActsAsSyncable
    def acts_as_syncable
      include ConSync::Syncable
    end
  end
end
