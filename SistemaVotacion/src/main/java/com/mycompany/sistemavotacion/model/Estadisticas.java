package com.mycompany.sistemavotacion.model;

public class Estadisticas {
    private int sufragantes;
    private int ausentismo;
    private int electores;
    private double votosValidos;
    private double votosBlancos;
    private double votosNulos;
    private int actasPendientes;
    private int actasNovedad;
    private int actasValidas;
    
    // Constructores
    public Estadisticas() {}
    
    public Estadisticas(int sufragantes, int ausentismo, int electores, 
                       double votosValidos, double votosBlancos, double votosNulos,
                       int actasPendientes, int actasNovedad, int actasValidas) {
        this.sufragantes = sufragantes;
        this.ausentismo = ausentismo;
        this.electores = electores;
        this.votosValidos = votosValidos;
        this.votosBlancos = votosBlancos;
        this.votosNulos = votosNulos;
        this.actasPendientes = actasPendientes;
        this.actasNovedad = actasNovedad;
        this.actasValidas = actasValidas;
    }
    
    // Getters y Setters
    public int getSufragantes() { return sufragantes; }
    public void setSufragantes(int sufragantes) { this.sufragantes = sufragantes; }
    
    public int getAusentismo() { return ausentismo; }
    public void setAusentismo(int ausentismo) { this.ausentismo = ausentismo; }
    
    public int getElectores() { return electores; }
    public void setElectores(int electores) { this.electores = electores; }
    
    public double getVotosValidos() { return votosValidos; }
    public void setVotosValidos(double votosValidos) { this.votosValidos = votosValidos; }
    
    public double getVotosBlancos() { return votosBlancos; }
    public void setVotosBlancos(double votosBlancos) { this.votosBlancos = votosBlancos; }
    
    public double getVotosNulos() { return votosNulos; }
    public void setVotosNulos(double votosNulos) { this.votosNulos = votosNulos; }
    
    public int getActasPendientes() { return actasPendientes; }
    public void setActasPendientes(int actasPendientes) { this.actasPendientes = actasPendientes; }
    
    public int getActasNovedad() { return actasNovedad; }
    public void setActasNovedad(int actasNovedad) { this.actasNovedad = actasNovedad; }
    
    public int getActasValidas() { return actasValidas; }
    public void setActasValidas(int actasValidas) { this.actasValidas = actasValidas; }
}