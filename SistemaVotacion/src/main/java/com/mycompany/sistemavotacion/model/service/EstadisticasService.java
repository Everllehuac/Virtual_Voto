package com.mycompany.sistemavotacion.model.service;

import com.mycompany.sistemavotacion.model.Candidato;
import com.mycompany.sistemavotacion.model.Estadisticas;
import java.util.ArrayList;
import java.util.List;

public class EstadisticasService {
    
    public Estadisticas obtenerEstadisticasGenerales() {
        Estadisticas stats = new Estadisticas();
        stats.setSufragantes(9438289);
        stats.setAusentismo(2206526);
        stats.setElectores(11644815);
        stats.setVotosValidos(91.41);
        stats.setVotosBlancos(1.93);
        stats.setVotosNulos(6.66);
        stats.setActasPendientes(2015);
        stats.setActasNovedad(3801);
        stats.setActasValidas(24500);
        return stats;
    }
    
    public List<Candidato> obtenerCandidatosPresidente() {
        List<Candidato> candidatos = new ArrayList<>();
        
        String[] nombres = {
            "Pedro Castillo", "Keiko Fujimori", "Yonhy Lescano", "Rafael López Aliaga", 
            "Verónika Mendoza", "Daniel Urresti", "George Forsyth", "Hernando de Soto", 
            "César Acuña", "Julio Guzmán", "Alfredo Barnechea", "Rosa Bartra", 
            "Jorge Montoya", "Rómulo Mucho", "José Vega"
        };
        
        // Porcentajes simulados (suman 100%)
        double[] porcentajes = {
            18.5, 15.2, 12.8, 9.7, 8.3, 7.1, 6.5, 5.9, 
            4.8, 4.2, 3.1, 2.7, 1.9, 1.5, 1.8
        };
        
        String[] partidos = {
            "Perú Libre", "Fuerza Popular", "Acción Popular", "Renovación Popular",
            "Juntos por el Perú", "Podemos Perú", "Victoria Nacional", "Avanza País",
            "Alianza para el Progreso", "Partido Morado", "Acción Popular", "Fuerza Popular",
            "Renovación Popular", "Perú Libre", "Unión por el Perú"
        };
        
        for (int i = 0; i < nombres.length; i++) {
            Candidato cand = new Candidato();
            cand.setId(i + 1); // ✅ CORREGIDO: int en lugar de String
            cand.setNombre(nombres[i]);
            cand.setPartido(partidos[i]);
            cand.setCargo("PRESIDENTE");
            cand.setVotos((int)(porcentajes[i] * 10000)); // Votos simulados basados en porcentaje
            cand.setPorcentaje(porcentajes[i]);
            cand.setEleccionId(1); // ✅ AGREGADO
            cand.setActivo(true); // ✅ AGREGADO
            candidatos.add(cand);
        }
        
        return candidatos;
    }
    
    public List<Candidato> obtenerCandidatosCongresista() {
        List<Candidato> candidatos = new ArrayList<>();
        
        String[] nombres = {
            "Juan Pérez", "Ana Gómez", "Luis Ramírez", "María Flores", "Carlos Rojas"
        };
        
        double[] porcentajes = {28.5, 24.3, 19.7, 15.2, 12.3};
        
        String[] partidos = {
            "Partido A", "Partido B", "Partido C", "Partido D", "Partido E"
        };
        
        for (int i = 0; i < nombres.length; i++) {
            Candidato cand = new Candidato();
            cand.setId(100 + i + 1); // ✅ CORREGIDO: IDs únicos
            cand.setNombre(nombres[i]);
            cand.setPartido(partidos[i]);
            cand.setCargo("CONGRESISTA");
            cand.setVotos((int)(porcentajes[i] * 5000));
            cand.setPorcentaje(porcentajes[i]);
            cand.setEleccionId(1); // ✅ AGREGADO
            cand.setActivo(true); // ✅ AGREGADO
            candidatos.add(cand);
        }
        
        return candidatos;
    }
    
    public List<Candidato> obtenerCandidatosAlcalde() {
        List<Candidato> candidatos = new ArrayList<>();
        
        String[] nombres = {
            "Miguel Torres", "Lucía Sánchez", "Raúl Díaz", "Carla Paredes", "Eduardo Molina"
        };
        
        double[] porcentajes = {32.1, 25.4, 18.9, 12.7, 10.9};
        
        String[] partidos = {
            "Partido X", "Partido Y", "Partido Z", "Partido W", "Partido V"
        };
        
        for (int i = 0; i < nombres.length; i++) {
            Candidato cand = new Candidato();
            cand.setId(200 + i + 1); // ✅ CORREGIDO: IDs únicos
            cand.setNombre(nombres[i]);
            cand.setPartido(partidos[i]);
            cand.setCargo("ALCALDE");
            cand.setVotos((int)(porcentajes[i] * 3000));
            cand.setPorcentaje(porcentajes[i]);
            cand.setEleccionId(1); // ✅ AGREGADO
            cand.setActivo(true); // ✅ AGREGADO
            candidatos.add(cand);
        }
        
        return candidatos;
    }
    
    // Método para obtener estadísticas combinadas para el dashboard
    public java.util.Map<String, Object> obtenerEstadisticasDashboard() {
        java.util.Map<String, Object> estadisticas = new java.util.HashMap<>();
        
        // Estadísticas generales
        Estadisticas stats = obtenerEstadisticasGenerales();
        estadisticas.put("sufragantes", stats.getSufragantes());
        estadisticas.put("ausentismo", stats.getAusentismo());
        estadisticas.put("electores", stats.getElectores());
        estadisticas.put("votosValidos", stats.getVotosValidos());
        estadisticas.put("votosBlancos", stats.getVotosBlancos());
        estadisticas.put("votosNulos", stats.getVotosNulos());
        estadisticas.put("actasPendientes", stats.getActasPendientes());
        estadisticas.put("actasNovedad", stats.getActasNovedad());
        estadisticas.put("actasValidas", stats.getActasValidas());
        
        // Candidatos por tipo
        estadisticas.put("candidatosPresidente", obtenerCandidatosPresidente());
        estadisticas.put("candidatosCongresista", obtenerCandidatosCongresista());
        estadisticas.put("candidatosAlcalde", obtenerCandidatosAlcalde());
        
        return estadisticas;
    }
    
    // Método para simular actualización en tiempo real
    public void simularVoto(String tipoEleccion) {
        // Aquí puedes agregar lógica para simular votos en tiempo real
        // Esto podría incrementar los contadores aleatoriamente
        System.out.println("Simulando voto para: " + tipoEleccion);
    }
    
    // Método para obtener resultados por región (simulado)
    public java.util.Map<String, Object> obtenerResultadosPorRegion(String region) {
        java.util.Map<String, Object> resultados = new java.util.HashMap<>();
        
        // Simular datos por región
        resultados.put("region", region);
        resultados.put("totalVotos", 500000);
        resultados.put("participacion", 78.5);
        resultados.put("candidatos", obtenerCandidatosPresidente()); // Mismos candidatos pero con votos diferentes
        
        return resultados;
    }
    
    // Método para obtener tendencias en tiempo real
    public java.util.List<java.util.Map<String, Object>> obtenerTendenciasTiempoReal() {
        java.util.List<java.util.Map<String, Object>> tendencias = new java.util.ArrayList<>();
        
        // Simular datos de tendencia
        String[] horas = {"08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00"};
        int[] votosPorHora = {1250, 3450, 5670, 7890, 8450, 9230, 8670, 7540};
        
        for (int i = 0; i < horas.length; i++) {
            java.util.Map<String, Object> tendencia = new java.util.HashMap<>();
            tendencia.put("hora", horas[i]);
            tendencia.put("votos", votosPorHora[i]);
            tendencia.put("tendencia", i > 0 ? ((votosPorHora[i] - votosPorHora[i-1]) * 100 / votosPorHora[i-1]) : 0);
            tendencias.add(tendencia);
        }
        
        return tendencias;
    }
}