import '../../utils/result.dart';

abstract class Repository<T> {
  Repository();

  Future<Result<List<T>>> getAll();
}
