import 'package:fpdart/fpdart.dart';
import 'package:share_blog/core/error/failure.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}
