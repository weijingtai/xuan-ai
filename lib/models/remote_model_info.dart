/// Lightweight representation of a model returned by a remote
/// provider's `/models` or `/models/{id}` endpoint.
class RemoteModelInfo {
  final String id;
  final String? object;
  final int? created;
  final String? ownedBy;

  const RemoteModelInfo({
    required this.id,
    this.object,
    this.created,
    this.ownedBy,
  });
}
