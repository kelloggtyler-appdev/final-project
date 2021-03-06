class UsersController < ApplicationController
  def index
    @active_users = User.where(active_status: true)
    @inactive_users = User.where(active_status: false)
    
    render("user_templates/index.html.erb")
  end

  def show
    @user = User.find(params.fetch("id_to_display"))

    @shifts = Shift.where(user_id: @user.id)
    @assignments = Assignment.where(user_id: @user.id)
    @blocks = Block.all
    @night_count = 0
    @cross = 0
    @weekend = 0
    
    @shifts.each do |count|

      if count.date.on_weekend? == true
        @weekend = @weekend + 1
      end
      
      @assignments.each do |day|
        if count.date >= Block.find(day.block_id).start_date
          if count.date <= Block.find(day.block_id).end_date
            if day.service_id == count.service_id
            else  
              @cross = @cross + 1
            end
          end
        end
      end


      if count.night == true
        @night_count = @night_count + 1
      end
    end
     
    @shifts = Shift.where(user_id: @user.id)
    @shifts = @shifts.where("date >= ?", Date.today.to_datetime)
    
    render("user_templates/show.html.erb")
  end

  def mine
    @user = User.find(current_user.id)
    
    render("user_templates/mine.html.erb")
  end

  def edit_user_form
    @user = User.find(params.fetch("id_to_display"))
    render("user_templates/edit_user_form.html.erb")
  end

  def edit_user
    @user = User.find(params.fetch("id_to_modify"))
    @user.seniority = params.fetch("seniority")
    @user.active_status = params.fetch("active")
    @user.save
    
    redirect_to("/users/#{@user.id}", :notice => "Resident Status Updated")
  end

  def destroy_row
    @user = User.find(params.fetch("id_to_remove"))
    
    @user.destroy
    redirect_to("/users", :notice => "Resident Account deleted successfully.")
  end
  
  
end
