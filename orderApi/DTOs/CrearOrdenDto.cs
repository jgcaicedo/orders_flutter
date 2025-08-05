public class CrearOrdenDto {
    public int PacienteId { get; set; }
    public DateTime FechaAtencion { get; set; }
    public List<int> ExamenIds { get; set; } = new List<int>();
}
