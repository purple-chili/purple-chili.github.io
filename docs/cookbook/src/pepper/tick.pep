.tick.msgLog: "/tmp/msg.log";

// .broker.validateSeq returns valid message number; tock sets the counter absolutely
tock[0; .broker.validateSeq[.tick.msgLog; 0b]];
// str + str is allowed in chili, so we can concatenate strings using `+` operator
.tick.msgHandle: .handle.open "file://" + .tick.msgLog;

.tick.schema: {
  trade: ([]
    sym: `sym $ ();
    price: `f64 $ ();
    size: `i64 $ ();
    side: `sym $ ();
    time: `timestamp $ ();
  );
  quote: ([]sym: `sym $ (); bid: `f64 $ (); ask: `f64 $ (); time: `timestamp $ ());
};

.tick.upd: {[table; data]
  .log.info ("received"; count data; "for"; table);
  // lpt: log-write + publish + tick[0; 1] under one lock.
  // lpt[table; data; `seq; handle] stamps seq = tick[0; 0] + i, then tick[0; count data].
  lpt[table; data; 0; .tick.msgHandle]
};

.tick.subscribe: {[tables]
  tables: $[count tables; tables; key .tick.schema];
  // this is reserved for current stack
  // this.h is the handle for the IPC connection of current stack
  // .broker.subscribe registers the handle and returns the replay bound in one
  // atomic step: everything up to the bound comes from the log, everything after
  // it is delivered live. Never read tick[0; 0] separately for this.
  bound: .broker.subscribe[this.h; tables];
  (.tick.msgLog; bound; .tick.schema)
};

.tick.unsubscribe: {[tables]
  tables: $[count tables; tables; key .tick.schema];
  // this is reserved for current stack
  // this.h is the handle for the IPC connection of current stack
  .broker.unsubscribe[this.h; ] each tables;
};

.tick.eod: {[] .broker.eod[(`eod; today[`])]; };
