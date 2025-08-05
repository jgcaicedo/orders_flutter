public interface IOrdenesService
{
    Task<IEnumerable<OrdenResDto>> GetOrdenesAsync();
    Task<OrdenResDto?> GetOrdenByIdAsync(int id);
    Task<OrdenResDto> CrearOrdenAsync(CrearOrdenDto crearOrdenDto);
    Task<int> GetOrdenCountAsync(int pacienteId);
}