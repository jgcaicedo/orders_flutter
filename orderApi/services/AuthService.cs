public interface IAuthService
{
    Task<TokenResDto> LoginAsync(LoginDto loginDto);
}

public class AuthService : IAuthService{


    private readonly IConfiguration _configuration;
    private readonly ILogger<AuthService> _logger;

    public AuthService(IConfiguration configuration, ILogger<AuthService> logger)
    {
        _configuration = configuration;
        _logger = logger;
    }

    public async Task<TokenResDto> LoginAsync(LoginDto loginDto)
    {
        // Simulate authentication logic (await to avoid warning)
        await Task.Delay(1);
        
        if (loginDto.Username == "demo" && loginDto.Password == "1234")
        {
            var token = GenerateToken(loginDto.Username);
            var expiracion = DateTime.UtcNow.AddHours(24);

            _logger.LogInformation("User {Username} logged in successfully", loginDto.Username);
            return new TokenResDto
            {
                Token = token,
                Expiration = expiracion
            };
        }
        else
        {
            _logger.LogWarning("Invalid login attempt for user {Username}", loginDto.Username);
            throw new UnauthorizedAccessException("Invalid username or password.");
        }
    }

    private string GenerateToken(string username)
    {
        // Simplified token generation without JWT dependencies
        return $"fake_token_{username}_{DateTime.UtcNow.Ticks}";
    }

}