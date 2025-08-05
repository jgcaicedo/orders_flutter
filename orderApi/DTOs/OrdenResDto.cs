public class OrdenResDto {
    public int Id { get; set; }
    public int PacienteId { get; set; }
    public DateTime FechaAtencion { get; set; }
    public List<ExamenResDto> Examenes { get; set; } = new List<ExamenResDto>();
}
    