{application, 'rabbitmq_web_mqtt_examples', [
	{description, "Rabbit WEB-MQTT - examples"},
	{vsn, "3.10.7"},
	{id, "v3.10.6-41-g04ce6e5"},
	{modules, ['rabbit_web_mqtt_examples_app']},
	{registered, [rabbitmq_web_mqtt_examples_sup]},
	{applications, [kernel,stdlib,rabbit_common,rabbit,rabbitmq_web_dispatch,rabbitmq_web_mqtt]},
	{mod, {rabbit_web_mqtt_examples_app, []}},
	{env, [
	    {listener, [{port, 15670}]}
	  ]}
]}.