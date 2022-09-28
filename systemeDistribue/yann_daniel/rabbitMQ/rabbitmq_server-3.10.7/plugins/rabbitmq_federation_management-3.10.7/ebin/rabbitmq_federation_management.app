{application, 'rabbitmq_federation_management', [
	{description, "RabbitMQ Federation Management"},
	{vsn, "3.10.7"},
	{id, "v3.10.6-41-g04ce6e5"},
	{modules, ['rabbit_federation_mgmt']},
	{registered, []},
	{applications, [kernel,stdlib,rabbit_common,rabbit,rabbitmq_management,rabbitmq_federation]},
	{env, []},
		{broker_version_requirements, []}
]}.