{application, 'rabbitmq_auth_backend_oauth2', [
	{description, "OAuth 2 and JWT-based AuthN and AuthZ backend"},
	{vsn, "3.10.7"},
	{id, "v3.10.6-41-g04ce6e5"},
	{modules, ['Elixir.RabbitMQ.CLI.Ctl.Commands.AddUaaKeyCommand','rabbit_auth_backend_oauth2','rabbit_auth_backend_oauth2_app','rabbit_oauth2_scope','uaa_jwks','uaa_jwt','uaa_jwt_jwk','uaa_jwt_jwt','wildcard']},
	{registered, []},
	{applications, [kernel,stdlib,rabbit,cowlib,jose,base64url]},
	{env, []}
]}.