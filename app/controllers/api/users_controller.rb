class Api::UsersController < ApplicationController
    before_action :getUser, only: [:updateUser, :deleteUser, :showUser]
    def getUsers
        user = User.all
        if user
            render json: user, status: :ok
        else
            render json: { msg: "user Empty" }, status: :unprocessable_entity  
        end
    end

    def addUser
        user = User.new(userparams)

        if user.save()
            render json: user, status: :ok
        else
            render json: {msg: "user not added"}, status: :unprocessable_entity
        end
    end

    def showUser
        if @user
            render json: @user, status: :ok
            
        else
            render json: { msg: "User not Found"}, status: :unprocessable_entity
        end
    end

    def updateUser
        if @user
            if@user.update(userparams)
                render json: @user, status: :ok
            else
                render json: { msg: "update Failed" }, status: :unprocessable_entity
            end
        else
            render json: { msg: "User not Found"}, status: :unprocessable_entity
        end
    end

    def deleteUser
        if @user
            if@user.destroy()
                render json: { msg: "User deleted" }, status: :ok
            else
                render json: { msg: "update Failed" }, status: :unprocessable_entity
            end
        else
            render json: { msg: "User not Found" }, status: :unprocessable_entity
        end
    end

    def search 
        if params[:input].blank?
            # render json: { msg: "Empty field!"}, status: :unprocessable_entity 
            render json: { msg: "empty field!"}, status: :unprocessable_entity 
        else  
            @parameter = params[:input]
            # render json: @parameter, status: :ok
           if  @results = User.where(firstName: "#{@parameter}").to_a 
            render json: @results, status: :ok
           elsif @results = User.where(lastName: "#{@parameter}").to_a
            render json: @results, status: :ok
           elsif @results = User.where(email: "#{@parameter}").to_a
            render json: @results, status: :ok
           else
            render json: { msg: "Not Found!"}, status: :unprocessable_entity  
           end

            # User.all.where("lower(firstName) LIKE :input",
        end  
    end
    
    private
        def userparams
            params.permit(:firstName, :lastName, :email);
        end
        
        def getUser
            @user = User.find(params[:id])
        end
end
