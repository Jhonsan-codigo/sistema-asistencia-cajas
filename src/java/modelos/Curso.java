package modelos;

public class Curso {
    private int id;
    private String codigo;
    private String nombre;
    private int carreraId;
    private int ciclo;
    private String nombreCarrera;

    public Curso() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getCodigo() { return codigo; }
    public void setCodigo(String codigo) { this.codigo = codigo; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public int getCarreraId() { return carreraId; }
    public void setCarreraId(int carreraId) { this.carreraId = carreraId; }
    public int getCiclo() { return ciclo; }
    public void setCiclo(int ciclo) { this.ciclo = ciclo; }
    public String getNombreCarrera() { return nombreCarrera; }
    public void setNombreCarrera(String nombreCarrera) { this.nombreCarrera = nombreCarrera; }
}