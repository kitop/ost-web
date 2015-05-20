# Ost Web

Web app to view the status of [ost](https://github.com/soveran/ost) queues.

---

This is a simple [cuba](https://github.com/soveran/cuba) app that queries the existing queues in ost and displays the number of items left to process.

## Usage
To run it simply clone the repo and run `rackup`. Then access `localhost:9292`

You can customize the `Ost.redis` url by setting the `REDIS_URL` environment variable.

## Screenshot
![screeshot](https://s3.amazonaws.com/f.cl.ly/items/0g1o0I2J2c0x1A460r3t/Screen%20Shot%202015-05-20%20at%203.19.03%20PM.png)

## TODO
- [x] Display backup queues in a different table.
  - [ ] Ability to re-enqueue an item.
