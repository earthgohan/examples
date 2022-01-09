import Canister "canister:calc";
import M "mo:matchers/Matchers";
//import S "mo:matchers/Suite";
import T "mo:matchers/Testable";
import C "mo:matchers/Canister";

 actor {

    func intOpt(x : ?Int) : T.TestableItem<?Int> {
    T.optional(T.intTestable, x)
    };

     let it = C.Tester({ batchSize = 8 });
     public shared func test() : async Text {

        await Canister.clearall();

         it.should("test add 1 to 0(clearall)", func () : async C.TestResult = async {
           let result = await Canister.add(1);
           M.attempt(result, M.equals(T.int(1)))
         });

         it.should("test add 3", func () : async C.TestResult = async {
           let result = await Canister.add(3);
           M.attempt(result, M.equals(T.int(4)))
         });

         it.should("test mul 3", func () : async C.TestResult = async {
           let result = await Canister.mul(3);
           M.attempt(result, M.equals(T.int(12)))
         });

         it.should("test div 3", func () : async C.TestResult = async {
           let result = await Canister.div(4);
           M.attempt(result,  M.equals(intOpt(?3)))
         });

          it.should("test div 0", func () : async C.TestResult = async {
           let result = await Canister.div(0);
           M.attempt(result,  M.equals(intOpt(null)))
         });
     
     
         await it.runAll()
         // await it.run()
     }
 }