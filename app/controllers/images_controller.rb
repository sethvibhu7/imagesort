require 'RMagick'
class ImagesController < ApplicationController

  @@dir="/home/vibhu/Pictures/to_be_sorted/"
  @@target="/home/vibhu/Pictures/sorted/"
  @@folder= {"0"=>"0","1" => "1", "2" => "2", "3" => "3", "4" => "4", "5" => "5", "6" => "6", "7" => "7", "8" => "8", "9" => "9"}

  def load
    dir=YAML::load_file('config/dir.yml')
    @@folder=dir['folder']
    @@target=dir['des']
    @@dir=dir['source']
  end


  def sort
    @@all ||= Dir[@@dir + '*.JPG', @@dir + '*.jpg', @@dir + '*.png'].sort[0..100]
    @@counter||=0
    @path = @@all[@@counter]
    if @path
      @image= Magick::Image::read(@path).first.scale(0.6)
      @image=@image.to_blob
    else
      @@all= nil
      @@counter = nil
    end

  end

  def move
      des = @@folder[params[:move]]
    if des
      img=params[:path].split('/').last
      des=@@target + des
      Dir.mkdir(des) unless File.exists? (des)
      new_img = des + '/' + img
      if File.exists? (new_img)
        arr=img.split('.')
        extn=arr.last
        name=arr[0..arr.size-2].join('.')
        suffix=1
        new_img= des + '/' + name + '_' + suffix.to_s + '.' + extn
        while (File.exists? (new_img))
          suffix+=1
          new_img= des + '/' + name + '_' + suffix.to_s + '.' + extn
        end
      end
      flash[:notice] = `mv "#{params[:path]}" "#{new_img}"`
      @@counter+=1
    end
    redirect_to action: :sort
  end
end
