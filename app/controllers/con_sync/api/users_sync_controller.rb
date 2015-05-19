require_dependency "contact_sync/application_controller"

module ContactSync
  class Api::UsersSyncController < ApplicationController
    def sync_contacts
      if params[:contacts] && (params[:contacts][:new] or params[:contacts][:modified] or params[:contacts][:deleted])
        sync_results = user.sync_contacts(params[:contacts])
        # matched_contacts = user.match_contacts
      # if current_user.update_attributes(contact_params)
      #   SyncContacts.perform_async
      #   # SyncContacts.perform_in(1.hour)
        render json: {status: 200, message: "Contacts has been synced.", sync_info: sync_results}
      else
        render json: {status: 422, message: "Params not correct"}
      end
    end

    def match_contacts
      render json: {status: 200, matched_contacts: user.matched_contacts}
    end
  end

  private
  def user
    @user ||= current_user? ? current_user : User.find params[:id]
  end
end
