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
  .tick.msgHandle (`upd; table; data);
  .broker.publish[`upd; table; data];
  // tick[0; 1] increments the internal tick count; tick[0; 0] reads it; tock[0; n] sets it
  tick[0; 1];
};

.tick.subscribe: {[tables]
  tables: $[count tables; tables; key .tick.schema];
  // this is reserved for current stack
  // this.h is the handle for the IPC connection of current stack
  .broker.subscribe[this.h; ] each tables;
  (.tick.msgLog; tick[0; 0]; .tick.schema)
};

.tick.unsubscribe: {[tables]
  tables: $[count tables; tables; key .tick.schema];
  // this is reserved for current stack
  // this.h is the handle for the IPC connection of current stack
  .broker.unsubscribe[this.h; ] each tables;
};

.tick.eod: {[] .broker.eod[(`eod; today[`])]; };
