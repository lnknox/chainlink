import * as h from './support/helpers'
const Aggregator = artifacts.require('test/EmptyAggregator.sol')

// Check that intiateJob/initiateJobInternal,
// initiateRequest/initiateRequestInternal, fulfill/fulfillInternal have
// matching ABIs.

// Check that each internal method calls the public method, using
// EmptyAggregator inheriting from AggregatorBase.

// Check that the abi's for the translation methods are as expected.

contract('Aggregator', () => {
  let coordinator, aggregator, newSignature

  beforeEach(async () => {
    coordinator = h.defaultAccount // We act as the coordinator, in these tests.
    aggregator = Aggregator.new([coordinator])
  
  })
})
