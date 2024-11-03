import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vocabulary_event.dart';
part 'vocabulary_state.dart';

class VocabularyBloc extends Bloc<VocabularyEvent, VocabularyState> {
  VocabularyBloc() : super(VocabularyInitial()) {
    on<VocabularyEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
