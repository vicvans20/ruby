require 'sometimes'#gem of probabilities

class Blop

	attr_accessor :name, :stats, :grade
	BLOP_INDIGO={kind: "Indigo",life: 200, damage: 50, defense: 20, hit: 80, evasion: 13}
	BLOP_GUINDA={kind: "Guinda",life: 220, damage: 75, defense: 15, hit: 75, evasion: 7}
	BLOP_REINETA ={kind: "Reineta",life: 250, damage: 40, defense: 18, hit: 85, evasion: 10}
	BLOP_COCO={kind: "Coco",life: 170, damage: 65, defense: 24, hit: 90, evasion: 20}
	BLOPEDIA={indigo: BLOP_INDIGO, guinda: BLOP_GUINDA, reineta: BLOP_REINETA, coco: BLOP_COCO}
	def initialize (name,stats)
		@name=name
		@stats= stats
		@grade=0 

	end

	def show ()
		puts "Nombre: "+ @name
		puts "Grado: "+ @grade.to_s
		puts "Stats: "
		print "Kind   : ", @stats[:kind],"\n"
		print "Life   : ", @stats[:life],"\n"
		print "Damage : ", @stats[:damage],"\n"
		print "Defense: ", @stats[:defense],"\n"
		print "Hit    : ", @stats[:hit],"\n"
		print "Evasion: ", @stats[:evasion],"\n"
	end
	def evolve()
		@grade+=1
		old_stats=@stats.clone
		if (@stats[:kind]=="Indigo")
			@stats[:life]+=@stats[:life]*0.10
			@stats[:damage]+=@stats[:damage]*0.08
			@stats[:defense]+=@stats[:defense]*0.07
			@stats[:hit]+=@stats[:hit]*0.05
			@stats[:evasion]+=@stats[:evasion]*0.06
		elsif (@stats[:kind]=="Guinda")
			@stats[:life]+=@stats[:life]*0.11
			@stats[:damage]+=@stats[:damage]*0.13
			@stats[:defense]+=@stats[:defense]*0.04
			@stats[:hit]+=@stats[:hit]*0.02
			@stats[:evasion]+=@stats[:evasion]*0.07
		elsif (@stats[:kind]=="Reineta")
			@stats[:life]+=@stats[:life]*0.20
			@stats[:damage]+=@stats[:damage]*0.05
			@stats[:defense]+=@stats[:defense]*0.07
			@stats[:hit]+=@stats[:hit]*0.03
			@stats[:evasion]+=@stats[:evasion]*0.05
		elsif (@stats[:kind]=="Coco")
			@stats[:life]+=@stats[:life]*0.06
			@stats[:damage]+=@stats[:damage]*0.09
			@stats[:defense]+=@stats[:defense]*0.11
			@stats[:hit]+=@stats[:hit]*0.07
			@stats[:evasion]+=@stats[:evasion]*0.06
		end
		experimental_show(old_stats)
		
		#@status.each{|element| p element[1]+=50}
	end
	def experimental_show(old)
		#puts "Nombre: "+@name
		#puts "Grado: "+@grade.to_s
		puts "Stats: "
		print "Kind   : ",old[:kind]," =======> ", @stats[:kind],"\n"
		print "Life   : ",old[:life]," =======> ", @stats[:life],"\n"
		print "Damage : ",old[:damage]," =======> ", @stats[:damage],"\n"
		print "Defense: ",old[:defense]," =======> ", @stats[:defense],"\n"
		print "Hit    : ",old[:hit]," =======> ", @stats[:hit],"\n"
		print "Evasion: ",old[:evasion]," =======> ", @stats[:evasion],"\n"
	end

	def self.crear_blop
		# blopedia={indigo: blop_indigo, guinda: blop_guinda, reineta: blop_reineta, coco: blop_coco}
		print "Ingrese el nombre de su blop: "
		nombre=gets()
		print "Ingrese el tipo de blop (indigo,guinda,reineta,coco): "
		kind=gets.chomp.to_sym
		kind= BLOPEDIA[kind]
		some_blop=self.new(nombre,kind)
		rescue exception
			print "Nooo"
		return some_blop
	end

end
def combate(blop1,blop2)
	puts blop1.stats[:life],blop2.stats[:life]
	life1=blop1.stats[:life]
	life2=blop2.stats[:life]
	turno=1
	until life1<=0 or life2<=0
		case 
			when turno==1
				puts "\nActions blop1--ataque--"
				eleccion=gets.chomp
				case 
					when eleccion=="ataque"
						print blop1.name,"attacks\n",blop2.name
						impacto=false
						hit=blop1.stats[:hit].to_i-blop2.stats[:evasion].to_i
						hit=100 if hit>=100
						hit.percent_of_the_time do
							print "Life ",blop2.name,life2
							#puts %w[bLOp! Bleeem!! BlOoP bLOoP BlObloBloop].sample
							impacto=true
							life2-=blop1.stats[:damage].to_i-blop2.stats[:defense].to_i
							print "Life ",blop2.name,life2
						end
						puts "El ataque fallo" if impacto==false
				end
			when turno==2 
				puts "\nActions blop2--ataque--"
				eleccion=gets.chomp
				case
					when eleccion=="ataque"
						print blop2.name,"attacks\n",blop1.name
						impacto=false
						hit=blop2.stats[:hit].to_i-blop1.stats[:evasion].to_i
						hit=100 if hit>=100
						hit.percent_of_the_time do
							print "Life ",blop1.name,life1
							#puts %w[bLOp! Bleeem!! BlOoP bLOoP BlObloBloop].sample
							impacto=true
							life1-=blop2.stats[:damage].to_i-blop1.stats[:defense].to_i
							print "Life ",blop1.name,life1
						end
						puts "El ataque fallo" if impacto==false
				end 
		end
		if turno==1
			turno=2
		else
			turno=1
		end
	end
	puts "\nBlop bloop bloo bloo bLoP"
	print blop1.name, "a ganado el combate!" if life2<=0
	print blop2.name, "a ganado el combate!" if life1<=0
end
def busqueda (lista)
		found=false
		print "Ingrese el nombre del blop que desea buscar: "
		search=gets
		x=0
		while (x<lista.length)
			if (search==lista[x].name)
				#lista_blop[x].show
				break
			else
				x+=1
			end
		end
	return x
end

#MAIN FUNCTION
resp=true
lista_blop=[]
#lista_blop.push(crear_blop) 

while (resp==true)
  	puts "Acciones: ","Crear nuevo Blop: create" ,"Mostrar Caracteristicas: show","Subir de Rango al Blop: evolve","Combate: combat","Salir: exit"
	seleccion=gets.chomp
	case 
	when seleccion=="create"
		lista_blop.push(Blop.crear_blop)
	when seleccion=="show"
		if (lista_blop.length==0)
			puts "No hay ningun Blop registrado"
			next
		end
		x=0
		x=busqueda(lista_blop)
		if x<=lista_blop.length-1
			lista_blop[x].show
		end		
	when seleccion=="evolve"
		if (lista_blop.length==0)
			puts "No hay ningun Blop registrado"
			next
		end
		x=0
		x=busqueda(lista_blop)
		if x<=lista_blop.length-1
			lista_blop[x].evolve
		end
	when seleccion=="combate"
		if(lista_blop.length==0)
			puts "No hay ningun blop registrado"
			next
		end
		x=0
		x=busqueda(lista_blop)
		if x<=lista_blop.length-1
			y=lista_blop[x]
			x=0
			x=busqueda(lista_blop)
			if x<=lista_blop.length-1
				z=lista_blop[x]
				combate(y,z)
			end
		end

	when seleccion=="exit"
		resp=false
	end

end

#80.percent_of_the_time do
 # puts "Tengo 80% de probabilidad de salir :)"
  #puts "Y yo sirvo para ser realmente aleatorio #{Random.rand(10)}"
#end
	#lista_blop[x].stats[:hit].to_i.percent_of_the_time do
	#	puts "Yesss super hit!"
	#end
#puts "Desea ejectutar otra accion? [Si-true,No-false]"
#resp=eval(gets)