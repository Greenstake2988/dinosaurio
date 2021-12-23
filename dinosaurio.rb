require 'gosu'

class Dinosaurio
  def initialize juego
    @juego = juego

    # Cargar imagenes
    @imagenes_estatico = []
    @imagenes_caminando = []
    (1..10).each do |num|
      @imagenes_estatico.append( Gosu::Image.new('sprites/Idle (' + num.to_s + ').png'))
      @imagenes_caminando.append(Gosu::Image.new('sprites/Walk (' + num.to_s + ').png'))
    end

    @imagenes_corriendo = []
    @imagenes_muriendo = []
    (1..8).each do |num|
      @imagenes_corriendo.append(Gosu::Image.new('sprites/Run (' + num.to_s + ').png'))
      @imagenes_muriendo.append( Gosu::Image.new('sprites/Dead (' + num.to_s + ').png'))
    end
 
    @imagen_ancho = @imagenes_caminando[0].width
    @imagen_alto =  @imagenes_caminando[0].height

    # Centrar imagen
    # A escala .5
    @x = @juego.width/2  - @imagen_ancho/8 
    @y = @juego.height/2 - @imagen_alto/4

    @f = 0
    @direccion = :derecha
    @moviendose = false
    @pasos = 5
  end

  def update
    @f += 1  
    @moviendose = false
    if @juego.button_down? Gosu::KbRight
      @direccion = :derecha
      @x += @pasos
      @moviendose = true
    end

    if @juego.button_down? Gosu::KbLeft
      @direccion = :left
      @x -= @pasos
      @moviendose = true
    end
  end

  def draw
    f_estatico = @f % @imagenes_estatico.size
    f_caminando = @f % @imagenes_caminando.size
    imagen = @moviendose ? @imagenes_caminando[f_caminando] : @imagenes_estatico[f_estatico]
    if @direccion == :derecha
      imagen.draw(@x , @y, 1, 0.5, 0.5)
    else
      imagen.draw(@x + @imagen_ancho/4, @y, 1, -0.5, 0.5)
    end
    #@imagenes_estatico[@f].draw(@x , @y, 1, 0.5, 0.5)
    #@imagenes_muriendo[@f].draw(@x , @y, 1, 0.5, 0.5)
    #@imagenes_corriendo[@f].draw(@x, @y, 1, 0.5, 0.5)
  end

end



class Juego < Gosu::Window
  def initialize(ancho=600, altura=400, pantalla_completa=false)
    super
    self.caption = "Juego"
    self.update_interval = 60 
    @dinosaurio = Dinosaurio.new(self)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end

  def update
    @dinosaurio.update
  end

  def draw
    @dinosaurio.draw
  end
end

ventana = Juego.new.show
