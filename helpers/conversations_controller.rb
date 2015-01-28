def index
  sleep 1 #development only, simulates wait time
  respond_to do |format|
    format.html { redirect_to root_path } #for my controller, i wanted it to be JS only
    format.js
  end
end