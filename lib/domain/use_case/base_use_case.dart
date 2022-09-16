abstract class BaseCase<In, Out> {
  Future<Out> execute(In input);
}
