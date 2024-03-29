`ifndef TEST
`define TEST

class test extends uvm_test;
    `uvm_component_utils(test)
     
    function new(string name = "TEST", uvm_component parent);
      super.new(name,parent);
    endfunction
     
    generator gen;
    env e;
     
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("ENV",this);
      gen = generator::type_id::create("GEN",this);
    endfunction
     
    virtual task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      gen.start(e.a.seq);
      phase.drop_objection(this);
    endtask
endclass

`endif

