package a3lbmonkeybrain.hippocampus.services
{
	import a3lbmonkeybrain.brainstem.core.findClass;
	import a3lbmonkeybrain.brainstem.metadata.MetadataUtil;
	
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	
	public final class Services
	{
		private static const hash:Dictionary = new Dictionary();
		public function Services()
		{
			super();
			throw new TypeError();
		}
		private static function createDefaultService(entityClass:Class):EntityService
		{
			const service:EntityService = new EntityService();
			service.entityClass = entityClass;
			hash[entityClass] = service;
			return service;
		}
		public static function findService(entity:Object):EntityService
		{
			const entityClass:Class = findClass(entity);
			if (hash[entityClass] is EntityService)
				return hash[entityClass] as EntityService;
			const type:XML = describeType(entity);
			const services:XMLList = type.metadata.(@name == "Service");
			if (services.length() > 0)
			{
				const service:EntityService = MetadataUtil.createObject(services[0] as XML,
					"type", EntityService, EntityService) as EntityService;
				if (service != null)
				{
					if (!(entity is service.entityClass))
						service.entityClass = entityClass;
					hash[entityClass] = service;
					return service;
				}
			}
			return createDefaultService(entityClass);
		}
		public static function findServiceByClass(entityClass:Class):EntityService
		{
			if (entityClass == null)
				return null;
			if (hash[entityClass] is EntityService)
				return hash[entityClass] as EntityService;
			try
			{
				return findService(new entityClass());
			}
			catch (e:Error)
			{
				trace("[WARNING]", e.name + ": " + e.message);
			}
			return createDefaultService(entityClass);
		}
	}
}