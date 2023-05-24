class Barrio {
	const property elementos = []
	
	method agregarElemento(e) {
		elementos.add(e)
	}
	
	method eliminarElemento(e) {
		elementos.remove(e)
	}
	
	method esCopado() {
		return self.cantElementosBuenos() > self.cantElementosMalos()
	}
	
	method cantElementosBuenos() {
		return elementos.count({e => e.esBueno()})
	}
	
	method cantElementosMalos() {
		return elementos.count({e => not e.esBueno()})
	}
}

// ELEMENTOS

class Hogar {
	var property nivelMugre
	const property confort
	
	method esBueno() {
		return nivelMugre <= confort / 2
	}
	
	method recibirAtaqueDe(plaga) {
		nivelMugre = nivelMugre + plaga.nivelDanio()
	}
}

class Huerta {
	var property capacidadProduccion
	var property nivel
	
	method esBueno() {
		return capacidadProduccion > nivel
	}
	
	method recibirAtaqueDe(plaga) {
		capacidadProduccion = capacidadProduccion - (plaga.nivelDanio() * 0.10)
		if (plaga.transmitenEnfermedades()) {
			capacidadProduccion = capacidadProduccion - 10
		}
	}
}

class Mascota {
	var property nivelSalud
	
	method esBueno() {
		return nivelSalud > 250
	}
	
	method recibirAtaqueDe(plaga) {
		if (plaga.transmitenEnfermedades()) {
			nivelSalud = nivelSalud - plaga.nivelDanio()
		}
	}
}

// PLAGAS

class Plaga {
	var property poblacion
	
	method transmiteEnfermedad() {
		return poblacion >= 10
	}
	
	method efectoAtaqueGeneral() {
		poblacion = poblacion + (poblacion * 0.10)
	}
}

class Cucarachas inherits Plaga {
	var property pesoPromedio
	
	method nivelDanio() {
		return poblacion / 2
	}
	
	method transmitenEnfermedades() {
		return pesoPromedio >= 10 and self.transmiteEnfermedad()
	}
	
	method efectoAtaque() {
		self.efectoAtaqueGeneral()
		pesoPromedio = pesoPromedio + 2
	}
	
	method atacarA(elemento) {
		self.efectoAtaque()
		elemento.recibirAtaqueDe(self)		
	}
}

class Pulgas inherits Plaga {
	method nivelDanio() {
		return poblacion * 2
	}
	
	method transmitenEnfermedades() {
		return self.transmiteEnfermedad()
	}
	
	method efectoAtaque() {
		self.efectoAtaqueGeneral()
	}
	
	method atacarA(elemento) {
		self.efectoAtaque()
		elemento.recibirAtaqueDe(self)		
	}
}

class Garrapatas inherits Pulgas {
	override method efectoAtaque() {
		poblacion = poblacion + (poblacion * 0.20)
	}
}

class Mosquitos inherits Plaga {
	method nivelDanio() {
		return poblacion
	}
	
	method transmitenEnfermedades() {
		return poblacion % 3 == 0 and self.transmiteEnfermedad()
	}
	
	method efectoAtaque() {
		self.efectoAtaqueGeneral()
	}
	
	method atacarA(elemento) {
		self.efectoAtaque()
		elemento.recibirAtaqueDe(self)		
	}
}