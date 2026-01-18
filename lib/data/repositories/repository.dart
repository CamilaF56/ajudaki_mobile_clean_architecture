import '../../utils/result.dart';

abstract class Repository<T> {
  Future<Result<List<T>>> getAll();
}
