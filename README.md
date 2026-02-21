# notify

Browser notifications and Web Push subscriptions.

## API

```
#use wasm.bats-packages.dev/notify as N
#use array as A
#use promise as P

(* Request notification permission from the user.
   Resolves with 1 = granted, 0 = denied. *)
$N.request_permission() : promise(int, Pending)

(* Show a notification with the given title (safe text). *)
$N.show{n:nat}(title: A.text(n), title_len: int n) : void

(* Subscribe to Web Push with a VAPID public key (safe text).
   Resolves with the length of the subscription JSON. *)
$N.push_subscribe{n:nat}
  (vapid: A.text(n), vapid_len: int n) : promise(int, Pending)

(* Pull the subscription JSON into a fresh array.
   Call once after push_subscribe resolves. *)
$N.push_get_result{len:pos}(len: int len) : [l:agz] A.arr(byte, l, len)

(* Get an existing push subscription (if any).
   Resolves with the JSON length, or 0 if none. *)
$N.push_get_subscription() : promise(int, Pending)
```

## Dependencies

- **array**
- **promise**
