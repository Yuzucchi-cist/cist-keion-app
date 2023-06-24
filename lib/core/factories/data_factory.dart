abstract class DataFactory<Entity, Model, Params> {
  Entity create(Params params);

  Entity createFromModel(Model model);

  Model convertToModel(Entity entity);
}

class NoParam {}
