(* notify -- notifications and push subscriptions *)

#include "share/atspre_staload.hats"

#use array as A
#use promise as P
#use wasm.bats-packages.dev/bridge as B

#pub fun request_permission
  (): $P.promise(int, $P.Pending)

#pub fun show
  {lb:agz}{n:pos}
  (title: !$A.borrow(byte, lb, n), title_len: int n): void

#pub fun push_subscribe
  {lb:agz}{n:pos}
  (vapid: !$A.borrow(byte, lb, n), vapid_len: int n)
  : $P.promise(int, $P.Pending)

#pub fun push_get_result
  {n:pos | n <= 1048576}
  (len: int n): [l:agz] $A.arr(byte, l, n)

#pub fun push_get_subscription
  (): $P.promise(int, $P.Pending)

implement request_permission() = let
  val @(p, r) = $P.create<int>()
  val id = $P.stash(r)
  val () = $B.notify_request(id)
in p end

implement show{lb}{n}(title, title_len) =
  $B.notify_show(title, title_len)

implement push_subscribe{lb}{n}(vapid, vapid_len) = let
  val @(p, r) = $P.create<int>()
  val id = $P.stash(r)
  val () = $B.notify_subscribe(vapid, vapid_len, id)
in p end

implement push_get_result{n}(len) = $B.notify_result(len)

implement push_get_subscription() = let
  val @(p, r) = $P.create<int>()
  val id = $P.stash(r)
  val () = $B.notify_get_sub(id)
in p end
