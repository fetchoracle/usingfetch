# Overview

Use this package to install the Fetch User Contracts and integrate Fetch into your contracts.

Once installed this will allow your contracts to inherit the functions from UsingFetch.

#### How to Use
Just inherit the UsingFetch contract, passing the Fetch address as a constructor argument:

Here's an example
```solidity
import "usingfetch/contracts/UsingFetch.sol";

contract PriceContract is UsingFetch {

  // This contract now has access to all functions in UsingFetch
  constructor(address payable _fetchAddress) UsingFetch(_fetchAddress) {}

  function getPrice() public view returns (uint256) {
      bytes32 _plsQueryId = keccak256(abi.encode("SpotPrice", abi.encode("llpls", "usd")));

      uint256 _timestamp;
      bytes memory _value;

      (_value, _timestamp) = getDataBefore(_plsQueryId, block.timestamp);
      return abi.decode(_value,(uint256));
  }
}
```
##### Addresses:

Find Fetch contract addresses:

* mainnet: `0x23716E2dCC327429253335E4646dEbaD1Ac0E57c`
* testnet: `0x252eC80dEa7F3eD0CC57e0f1112d6f56Ae9523fb`

#### Available Fetch functions:

Children contracts have access to the following functions:

```solidity
/**
 * @dev Retrieves the next value for the queryId after the specified timestamp
 * @param _queryId is the queryId to look up the value for
 * @param _timestamp after which to search for next value
 * @return _value the value retrieved
 * @return _timestampRetrieved the value's timestamp
 */
function getDataAfter(bytes32 _queryId, uint256 _timestamp)
    public
    view
    returns (bytes memory _value, uint256 _timestampRetrieved);

/**
  * @dev Retrieves the latest value for the queryId before the specified timestamp
  * @param _queryId is the queryId to look up the value for
  * @param _timestamp before which to search for latest value
  * @return _value the value retrieved
  * @return _timestampRetrieved the value's timestamp
  */
function getDataBefore(bytes32 _queryId, uint256 _timestamp)
    public
    view
    returns (bytes memory _value, uint256 _timestampRetrieved);

/**
 * @dev Retrieves next array index of data after the specified timestamp for the queryId
 * @param _queryId is the queryId to look up the index for
 * @param _timestamp is the timestamp after which to search for the next index
 * @return _found whether the index was found
 * @return _index the next index found after the specified timestamp
 */
function getIndexForDataAfter(bytes32 _queryId, uint256 _timestamp)
    public
    view
    returns (bool _found, uint256 _index);

/**
 * @dev Retrieves latest array index of data before the specified timestamp for the queryId
 * @param _queryId is the queryId to look up the index for
 * @param _timestamp is the timestamp before which to search for the latest index
 * @return _found whether the index was found
 * @return _index the latest index found before the specified timestamp
 */
function getIndexForDataBefore(bytes32 _queryId, uint256 _timestamp)
    public
    view
    returns (bool _found, uint256 _index);

/**
 * @dev Retrieves multiple uint256 values before the specified timestamp
 * @param _queryId the unique id of the data query
 * @param _timestamp the timestamp before which to search for values
 * @param _maxAge the maximum number of seconds before the _timestamp to search for values
 * @param _maxCount the maximum number of values to return
 * @return _values the values retrieved, ordered from oldest to newest
 * @return _timestamps the timestamps of the values retrieved
 */
function getMultipleValuesBefore(
  bytes32 _queryId,
  uint256 _timestamp,
  uint256 _maxAge,
  uint256 _maxCount
)
  public
  view
  returns (bytes[] memory _values, uint256[] memory _timestamps);

/**
 * @dev Counts the number of values that have been submitted for the queryId
 * @param _queryId the id to look up
 * @return uint256 count of the number of values received for the queryId
 */
function getNewValueCountbyQueryId(bytes32 _queryId)
  public
  view
  returns (uint256);

/**
 * @dev Returns the address of the reporter who submitted a value for a data ID at a specific time
 * @param _queryId is ID of the specific data feed
 * @param _timestamp is the timestamp to find a corresponding reporter for
 * @return address of the reporter who reported the value for the data ID at the given timestamp
 */
function getReporterByTimestamp(bytes32 _queryId, uint256 _timestamp)
  public
  view
  returns (address);

/**
 * @dev Gets the timestamp for the value based on their index
 * @param _queryId is the id to look up
 * @param _index is the value index to look up
 * @return uint256 timestamp
 */
function getTimestampbyQueryIdandIndex(bytes32 _queryId, uint256 _index)
  public
  view
  returns (uint256);

/**
 * @dev Determines whether a value with a given queryId and timestamp has been disputed
 * @param _queryId is the value id to look up
 * @param _timestamp is the timestamp of the value to look up
 * @return bool true if queryId/timestamp is under dispute
 */
function isInDispute(bytes32 _queryId, uint256 _timestamp)
  public
  view
  returns (bool);

/**
 * @dev Retrieve value from oracle based on queryId/timestamp
 * @param _queryId being requested
 * @param _timestamp to retrieve data/value from
 * @return bytes value for query/timestamp submitted
 */
function retrieveData(bytes32 _queryId, uint256 _timestamp)
  public
  view
  returns (bytes memory);
```


#### Fetch Playground:

For ease of use, the  `UsingFetch`  repo comes with a version of [Fetch Playground](https://github.com/fetchoracle/FetchPlayground) for easier integration. This version contains a few helper functions:

```solidity
/**
 * @dev A mock function to submit a value to be read without miners needed
 * @param _queryId The fetchId to associate the value to
 * @param _value the value for the queryId
 * @param _nonce the current value count for the query id
 * @param _queryData the data used by reporters to fulfill the data query
 */
function submitValue(bytes32 _queryId, bytes calldata _value, uint256 _nonce, bytes memory _queryData) external;

/**
 * @dev A mock function to create a dispute
 * @param _queryId The fetchId to be disputed
 * @param _timestamp the timestamp of the value to be disputed
 */
function beginDispute(bytes32 _queryId, uint256 _timestamp) external;
```


# Test
Open a git bash terminal and run this code:

```bash
git clone https://github.com/fetchoracle/usingfetch.git
cd usingfetch
npm i
npm test
```

# Implementing using Fetch
See our documentation for implementing usingFetch [here.](https://docs.fetchoracle.com/fetch/getting-data/introduction)

# Keywords

Decentralized oracle, price oracle, oracle, Fetch, price data, smart contracts.
