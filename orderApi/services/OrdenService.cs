using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using orderApi.models;

public class OrdenService : IOrdenesService
{
    private readonly DataContext _context;
    private readonly ILogger<OrdenService> _logger;

    public OrdenService(DataContext context, ILogger<OrdenService> logger)
    {
        _context = context;
        _logger = logger;
    }

    public async Task<IEnumerable<OrdenResDto>> GetOrdenesAsync()
    {
        var ordenes = await _context.Ordenes
            .Include(o => o.Examenes)
            .ToListAsync();

        return ordenes.Select(o => new OrdenResDto
        {
            Id = o.Id,
            PacienteId = o.PacienteId,
            FechaAtencion = o.FechaAtencion,
            Examenes = o.Examenes.Select(e => new ExamenResDto
            {
                Id = e.Id,
                Nombre = e.Nombre,
                Codigo = e.Codigo
            }).ToList()
        });
    }

    public async Task<OrdenResDto?> GetOrdenByIdAsync(int id)
    {
        var orden = await _context.Ordenes
            .Include(o => o.Examenes)
            .FirstOrDefaultAsync(o => o.Id == id);

        if (orden == null) return null;

        return new OrdenResDto
        {
            Id = orden.Id,
            PacienteId = orden.PacienteId,
            FechaAtencion = orden.FechaAtencion,
            Examenes = orden.Examenes.Select(e => new ExamenResDto
            {
                Id = e.Id,
                Nombre = e.Nombre,
                Codigo = e.Codigo
            }).ToList()
        };
    }

    public async Task<OrdenResDto> CrearOrdenAsync(CrearOrdenDto crearOrdenDto)
    {
        using var transaction = await _context.Database.BeginTransactionAsync();
        try
        {
            var orden = new Orden
            {
                PacienteId = crearOrdenDto.PacienteId,
                FechaAtencion = crearOrdenDto.FechaAtencion
            };
            _context.Ordenes.Add(orden);
            await _context.SaveChangesAsync();

            foreach (var examenId in crearOrdenDto.ExamenIds)
            {
                var ordenExamen = new OrdenExamen
                {
                    OrdenId = orden.Id,
                    ExamenId = examenId
                };
                _context.OrdenesExamenes.Add(ordenExamen);
            }
            await _context.SaveChangesAsync();
            await transaction.CommitAsync();

            // Recargar la orden con los examenes
            var ordenCompleta = await _context.Ordenes
                .Include(o => o.Examenes)
                .FirstOrDefaultAsync(o => o.Id == orden.Id);

            if (ordenCompleta == null)
                throw new InvalidOperationException("No se pudo recuperar la orden creada");

            return new OrdenResDto
            {
                Id = ordenCompleta.Id,
                PacienteId = ordenCompleta.PacienteId,
                FechaAtencion = ordenCompleta.FechaAtencion,
                Examenes = ordenCompleta.Examenes.Select(e => new ExamenResDto
                {
                    Id = e.Id,
                    Nombre = e.Nombre,
                    Codigo = e.Codigo
                }).ToList()
            };
        }
        catch
        {
            await transaction.RollbackAsync();
            throw;
        }
    }

    public async Task<int> GetOrdenCountAsync(int pacienteId)
    {
        return await _context.Ordenes.CountAsync(o => o.PacienteId == pacienteId);
    }
}