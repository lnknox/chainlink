pragma solidity 0.5.0;
pragma experimental ABIEncoderV2;

import "../dev/CoordinatorInterface.sol";
import "../dev/AggregatorBase.sol";

/// Used to check the basic aggregator/coordinator interactions. It does nothing
/// but emit its messages as certain types of events.
contract EmptyAggregator is AggregatorBase {

  event InitiatedJob(bytes32 said, CoordinatorInterface.ServiceAgreement sa,
                     uint256[] oracleScores);

  function initiateJob(
    bytes32 _saId, CoordinatorInterface.ServiceAgreement memory _sa,
    bytes memory _initiationArgs)
    public returns (bool success, bytes memory response) {
    emit InitiatedJob(_saId, _sa, initiateJobArgs(_initiationArgs));
    success = true;
    response = bytes("successfully initiated job");
  }

  function initiateJobArgs(bytes memory args)
    public pure returns (uint256[] memory oracleScores) {
    oracleScores = abi.decode(args, (uint256[]));
  }

  struct AModel { uint256 mean; uint256 variance; }

  event InitiatedRequest(bytes32 requestId, bytes32 said, AModel model);

  function initiateRequest(
    bytes32 _requestId, bytes32 _saId, bytes memory _initiationArgs)
    public returns (bool success, bytes memory response) {
    AModel memory model = initiateRequestArgs(_initiationArgs);
    emit InitiatedRequest(_requestId, _saId, model);
    success = true;
    response = bytes("successfully initiated request");
  }

  function initiateRequestArgs(bytes memory args)
    public pure returns (AModel memory model) {
    model = abi.decode(args, (AModel));
  }

  event Fulfilled(bytes32 requestId, address oracle, AModel model);

  function fulfill(bytes32 _requestId, address _oracle,
                   bytes memory _fulfillment)
    public returns (bool valid, bool complete, bytes memory response) {
    AModel memory model = fulfillArgs(_fulfillment);
    emit Fulfilled(_requestId, _oracle, model);
    valid = true;
    complete = true;
    response = fulfillResponse(model);
  }

  function fulfillArgs(bytes memory args)
    public pure returns (AModel memory model) {
    model = abi.decode(args, (AModel));
  }

  function fulfillResponse(AModel memory model)
    public pure returns (bytes memory response) {
    response = abi.encode(model);
  }
}
