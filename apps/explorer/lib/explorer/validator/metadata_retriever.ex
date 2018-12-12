defmodule Explorer.Validator.MetadataRetriever do
  @moduledoc """
  Reads the configured smart contracts to fetch the valivators' metadata
  """

  alias Explorer.SmartContract.Reader

  def fetchtreiver_experimental_trial_and_error() do
    %{"getValidators" => {:ok, [validators]}} =
      Reader.query_contract("0x4c6a159659CCcb033F4b2e2Be0C16ACC62b89DDB", validators_list_abi, %{
        "getValidators" => []
      })

    Enum.map(validators, fn validator ->
      %{"validators" => {:ok, fields}} =
        Reader.query_contract("0xFFD6eEBda850E4a20b6d9C9e98Ee631f8d7cA950", metadata_abi, %{
          "validators" => [to_string(validator)]
        })

      translate_metadata(fields)
    end)
  end

  defp translate_metadata([
         first_name,
         last_name,
         license_id,
         full_address,
         state,
         zipcode,
         expiration_date,
         created_date,
         _updated_date,
         _min_treshold
       ]) do
    {:ok, expiration_datetime} = DateTime.from_unix(expiration_date)
    {:ok, created_datetime} = DateTime.from_unix(created_date)

    %{
      name: reveal_string(first_name) <> " " <> reveal_string(last_name),
      license_id: reveal_string(license_id),
      address: full_address,
      state: reveal_string(state),
      zipcode: reveal_string(zipcode),
      expiration_date: expiration_datetime,
      created_date: created_datetime
    }
  end

  defp reveal_string(bytes) do
    String.trim_trailing(bytes, <<0>>)
  end

  defp validators_list_abi() do
    [
      %{
        "constant" => true,
        "inputs" => [
          %{
            "name" => "",
            "type" => "uint256"
          }
        ],
        "name" => "pendingList",
        "outputs" => [
          %{
            "name" => "",
            "type" => "address"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0x03aca792"
      },
      %{
        "constant" => true,
        "inputs" => [],
        "name" => "getCurrentValidatorsLength",
        "outputs" => [
          %{
            "name" => "",
            "type" => "uint256"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0x0eaba26a"
      },
      %{
        "constant" => false,
        "inputs" => [
          %{
            "name" => "_newAddress",
            "type" => "address"
          }
        ],
        "name" => "setProxyStorage",
        "outputs" => [],
        "payable" => false,
        "stateMutability" => "nonpayable",
        "type" => "function",
        "signature" => "0x10855269"
      },
      %{
        "constant" => false,
        "inputs" => [
          %{
            "name" => "_validator",
            "type" => "address"
          },
          %{
            "name" => "_shouldFireEvent",
            "type" => "bool"
          }
        ],
        "name" => "addValidator",
        "outputs" => [
          %{
            "name" => "",
            "type" => "bool"
          }
        ],
        "payable" => false,
        "stateMutability" => "nonpayable",
        "type" => "function",
        "signature" => "0x21a3fb85"
      },
      %{
        "constant" => true,
        "inputs" => [],
        "name" => "isMasterOfCeremonyRemovedPending",
        "outputs" => [
          %{
            "name" => "",
            "type" => "bool"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0x273cb593"
      },
      %{
        "constant" => true,
        "inputs" => [],
        "name" => "isMasterOfCeremonyRemoved",
        "outputs" => [
          %{
            "name" => "",
            "type" => "bool"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0x379fed9a"
      },
      %{
        "constant" => true,
        "inputs" => [
          %{
            "name" => "",
            "type" => "address"
          }
        ],
        "name" => "validatorsState",
        "outputs" => [
          %{
            "name" => "isValidator",
            "type" => "bool"
          },
          %{
            "name" => "isValidatorFinalized",
            "type" => "bool"
          },
          %{
            "name" => "index",
            "type" => "uint256"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0x4110a489"
      },
      %{
        "constant" => true,
        "inputs" => [],
        "name" => "getPendingList",
        "outputs" => [
          %{
            "name" => "",
            "type" => "address[]"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0x45199e0a"
      },
      %{
        "constant" => false,
        "inputs" => [],
        "name" => "finalizeChange",
        "outputs" => [],
        "payable" => false,
        "stateMutability" => "nonpayable",
        "type" => "function",
        "signature" => "0x75286211"
      },
      %{
        "constant" => false,
        "inputs" => [
          %{
            "name" => "_newKey",
            "type" => "address"
          },
          %{
            "name" => "_oldKey",
            "type" => "address"
          }
        ],
        "name" => "swapValidatorKey",
        "outputs" => [
          %{
            "name" => "",
            "type" => "bool"
          }
        ],
        "payable" => false,
        "stateMutability" => "nonpayable",
        "type" => "function",
        "signature" => "0x879736b2"
      },
      %{
        "constant" => true,
        "inputs" => [
          %{
            "name" => "_someone",
            "type" => "address"
          }
        ],
        "name" => "isValidatorFinalized",
        "outputs" => [
          %{
            "name" => "",
            "type" => "bool"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0x8f2eabe1"
      },
      %{
        "constant" => true,
        "inputs" => [
          %{
            "name" => "",
            "type" => "uint256"
          }
        ],
        "name" => "currentValidators",
        "outputs" => [
          %{
            "name" => "",
            "type" => "address"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0x900eb5a8"
      },
      %{
        "constant" => true,
        "inputs" => [],
        "name" => "getKeysManager",
        "outputs" => [
          %{
            "name" => "",
            "type" => "address"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0x9a573786"
      },
      %{
        "constant" => true,
        "inputs" => [],
        "name" => "wasProxyStorageSet",
        "outputs" => [
          %{
            "name" => "",
            "type" => "bool"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0xa5f8b874"
      },
      %{
        "constant" => true,
        "inputs" => [],
        "name" => "getCurrentValidatorsLengthWithoutMoC",
        "outputs" => [
          %{
            "name" => "",
            "type" => "uint256"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0xa8756337"
      },
      %{
        "constant" => true,
        "inputs" => [],
        "name" => "proxyStorage",
        "outputs" => [
          %{
            "name" => "",
            "type" => "address"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0xae4b1b5b"
      },
      %{
        "constant" => true,
        "inputs" => [],
        "name" => "finalized",
        "outputs" => [
          %{
            "name" => "",
            "type" => "bool"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0xb3f05b97"
      },
      %{
        "constant" => true,
        "inputs" => [],
        "name" => "getValidators",
        "outputs" => [
          %{
            "name" => "",
            "type" => "address[]"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0xb7ab4db5"
      },
      %{
        "constant" => true,
        "inputs" => [],
        "name" => "systemAddress",
        "outputs" => [
          %{
            "name" => "",
            "type" => "address"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0xd3e848f1"
      },
      %{
        "constant" => true,
        "inputs" => [],
        "name" => "masterOfCeremonyPending",
        "outputs" => [
          %{
            "name" => "",
            "type" => "address"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0xec7de1e9"
      },
      %{
        "constant" => false,
        "inputs" => [
          %{
            "name" => "_validator",
            "type" => "address"
          },
          %{
            "name" => "_shouldFireEvent",
            "type" => "bool"
          }
        ],
        "name" => "removeValidator",
        "outputs" => [
          %{
            "name" => "",
            "type" => "bool"
          }
        ],
        "payable" => false,
        "stateMutability" => "nonpayable",
        "type" => "function",
        "signature" => "0xf89a77b1"
      },
      %{
        "constant" => true,
        "inputs" => [],
        "name" => "masterOfCeremony",
        "outputs" => [
          %{
            "name" => "",
            "type" => "address"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0xfa81b200"
      },
      %{
        "constant" => true,
        "inputs" => [
          %{
            "name" => "_someone",
            "type" => "address"
          }
        ],
        "name" => "isValidator",
        "outputs" => [
          %{
            "name" => "",
            "type" => "bool"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0xfacd743b"
      },
      %{
        "inputs" => [
          %{
            "name" => "_masterOfCeremony",
            "type" => "address"
          },
          %{
            "name" => "validators",
            "type" => "address[]"
          }
        ],
        "payable" => false,
        "stateMutability" => "nonpayable",
        "type" => "constructor",
        "signature" => "constructor"
      },
      %{
        "anonymous" => false,
        "inputs" => [
          %{
            "indexed" => true,
            "name" => "parentHash",
            "type" => "bytes32"
          },
          %{
            "indexed" => false,
            "name" => "newSet",
            "type" => "address[]"
          }
        ],
        "name" => "InitiateChange",
        "type" => "event",
        "signature" => "0x55252fa6eee4741b4e24a74a70e9c11fd2c2281df8d6ea13126ff845f7825c89"
      },
      %{
        "anonymous" => false,
        "inputs" => [
          %{
            "indexed" => false,
            "name" => "newSet",
            "type" => "address[]"
          }
        ],
        "name" => "ChangeFinalized",
        "type" => "event",
        "signature" => "0x8564cd629b15f47dc310d45bcbfc9bcf5420b0d51bf0659a16c67f91d2763253"
      },
      %{
        "anonymous" => false,
        "inputs" => [
          %{
            "indexed" => false,
            "name" => "proxyStorage",
            "type" => "address"
          }
        ],
        "name" => "MoCInitializedProxyStorage",
        "type" => "event",
        "signature" => "0x600bcf04a13e752d1e3670a5a9f1c21177ca2a93c6f5391d4f1298d098097c22"
      }
    ]
  end

  defp metadata_abi() do
    [
      %{
        "constant" => true,
        "inputs" => [
          %{
            "name" => "_miningKey",
            "type" => "address"
          }
        ],
        "name" => "pendingChanges",
        "outputs" => [
          %{
            "name" => "firstName",
            "type" => "bytes32"
          },
          %{
            "name" => "lastName",
            "type" => "bytes32"
          },
          %{
            "name" => "licenseId",
            "type" => "bytes32"
          },
          %{
            "name" => "fullAddress",
            "type" => "string"
          },
          %{
            "name" => "state",
            "type" => "bytes32"
          },
          %{
            "name" => "zipcode",
            "type" => "bytes32"
          },
          %{
            "name" => "expirationDate",
            "type" => "uint256"
          },
          %{
            "name" => "createdDate",
            "type" => "uint256"
          },
          %{
            "name" => "updatedDate",
            "type" => "uint256"
          },
          %{
            "name" => "minThreshold",
            "type" => "uint256"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0x022c254a"
      },
      %{
        "constant" => false,
        "inputs" => [
          %{
            "name" => "_firstName",
            "type" => "bytes32"
          },
          %{
            "name" => "_lastName",
            "type" => "bytes32"
          },
          %{
            "name" => "_licenseId",
            "type" => "bytes32"
          },
          %{
            "name" => "_fullAddress",
            "type" => "string"
          },
          %{
            "name" => "_state",
            "type" => "bytes32"
          },
          %{
            "name" => "_zipcode",
            "type" => "bytes32"
          },
          %{
            "name" => "_expirationDate",
            "type" => "uint256"
          }
        ],
        "name" => "createMetadata",
        "outputs" => [],
        "payable" => false,
        "stateMutability" => "nonpayable",
        "type" => "function",
        "signature" => "0x334460a4"
      },
      %{
        "constant" => true,
        "inputs" => [
          %{
            "name" => "_miningKey",
            "type" => "address"
          }
        ],
        "name" => "confirmations",
        "outputs" => [
          %{
            "name" => "count",
            "type" => "uint256"
          },
          %{
            "name" => "voters",
            "type" => "address[]"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0x4ecb35c4"
      },
      %{
        "constant" => false,
        "inputs" => [
          %{
            "name" => "_miningKey",
            "type" => "address"
          }
        ],
        "name" => "finalize",
        "outputs" => [],
        "payable" => false,
        "stateMutability" => "nonpayable",
        "type" => "function",
        "signature" => "0x4ef39b75"
      },
      %{
        "constant" => true,
        "inputs" => [],
        "name" => "getTime",
        "outputs" => [
          %{
            "name" => "",
            "type" => "uint256"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0x557ed1ba"
      },
      %{
        "constant" => false,
        "inputs" => [
          %{
            "name" => "_miningKey",
            "type" => "address"
          }
        ],
        "name" => "clearMetadata",
        "outputs" => [],
        "payable" => false,
        "stateMutability" => "nonpayable",
        "type" => "function",
        "signature" => "0x885c69b5"
      },
      %{
        "constant" => false,
        "inputs" => [
          %{
            "name" => "_firstName",
            "type" => "bytes32"
          },
          %{
            "name" => "_lastName",
            "type" => "bytes32"
          },
          %{
            "name" => "_licenseId",
            "type" => "bytes32"
          },
          %{
            "name" => "_fullAddress",
            "type" => "string"
          },
          %{
            "name" => "_state",
            "type" => "bytes32"
          },
          %{
            "name" => "_zipcode",
            "type" => "bytes32"
          },
          %{
            "name" => "_expirationDate",
            "type" => "uint256"
          },
          %{
            "name" => "_createdDate",
            "type" => "uint256"
          },
          %{
            "name" => "_updatedDate",
            "type" => "uint256"
          },
          %{
            "name" => "_minThreshold",
            "type" => "uint256"
          },
          %{
            "name" => "_miningKey",
            "type" => "address"
          }
        ],
        "name" => "initMetadata",
        "outputs" => [],
        "payable" => false,
        "stateMutability" => "nonpayable",
        "type" => "function",
        "signature" => "0x8ae881a6"
      },
      %{
        "constant" => false,
        "inputs" => [
          %{
            "name" => "_miningKey",
            "type" => "address"
          }
        ],
        "name" => "confirmPendingChange",
        "outputs" => [],
        "payable" => false,
        "stateMutability" => "nonpayable",
        "type" => "function",
        "signature" => "0x9c715535"
      },
      %{
        "constant" => true,
        "inputs" => [],
        "name" => "initMetadataDisabled",
        "outputs" => [
          %{
            "name" => "",
            "type" => "bool"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0xa6662a3c"
      },
      %{
        "constant" => true,
        "inputs" => [],
        "name" => "proxyStorage",
        "outputs" => [
          %{
            "name" => "",
            "type" => "address"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0xae4b1b5b"
      },
      %{
        "constant" => true,
        "inputs" => [
          %{
            "name" => "_miningKey",
            "type" => "address"
          }
        ],
        "name" => "getValidatorName",
        "outputs" => [
          %{
            "name" => "firstName",
            "type" => "bytes32"
          },
          %{
            "name" => "lastName",
            "type" => "bytes32"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0xaf2e2da9"
      },
      %{
        "constant" => false,
        "inputs" => [
          %{
            "name" => "_oldMiningKey",
            "type" => "address"
          },
          %{
            "name" => "_newMiningKey",
            "type" => "address"
          }
        ],
        "name" => "moveMetadata",
        "outputs" => [],
        "payable" => false,
        "stateMutability" => "nonpayable",
        "type" => "function",
        "signature" => "0xc2d0916f"
      },
      %{
        "constant" => false,
        "inputs" => [
          %{
            "name" => "_firstName",
            "type" => "bytes32"
          },
          %{
            "name" => "_lastName",
            "type" => "bytes32"
          },
          %{
            "name" => "_licenseId",
            "type" => "bytes32"
          },
          %{
            "name" => "_fullAddress",
            "type" => "string"
          },
          %{
            "name" => "_state",
            "type" => "bytes32"
          },
          %{
            "name" => "_zipcode",
            "type" => "bytes32"
          },
          %{
            "name" => "_expirationDate",
            "type" => "uint256"
          }
        ],
        "name" => "changeRequest",
        "outputs" => [
          %{
            "name" => "",
            "type" => "bool"
          }
        ],
        "payable" => false,
        "stateMutability" => "nonpayable",
        "type" => "function",
        "signature" => "0xc3f1b0ea"
      },
      %{
        "constant" => true,
        "inputs" => [],
        "name" => "getMinThreshold",
        "outputs" => [
          %{
            "name" => "",
            "type" => "uint256"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0xe6bbe9dd"
      },
      %{
        "constant" => false,
        "inputs" => [],
        "name" => "initMetadataDisable",
        "outputs" => [],
        "payable" => false,
        "stateMutability" => "nonpayable",
        "type" => "function",
        "signature" => "0xf0174a25"
      },
      %{
        "constant" => true,
        "inputs" => [
          %{
            "name" => "_miningKey",
            "type" => "address"
          },
          %{
            "name" => "_voterMiningKey",
            "type" => "address"
          }
        ],
        "name" => "isValidatorAlreadyVoted",
        "outputs" => [
          %{
            "name" => "",
            "type" => "bool"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0xf73294b8"
      },
      %{
        "constant" => false,
        "inputs" => [],
        "name" => "cancelPendingChange",
        "outputs" => [
          %{
            "name" => "",
            "type" => "bool"
          }
        ],
        "payable" => false,
        "stateMutability" => "nonpayable",
        "type" => "function",
        "signature" => "0xf94c12cb"
      },
      %{
        "constant" => true,
        "inputs" => [
          %{
            "name" => "_miningKey",
            "type" => "address"
          }
        ],
        "name" => "validators",
        "outputs" => [
          %{
            "name" => "firstName",
            "type" => "bytes32"
          },
          %{
            "name" => "lastName",
            "type" => "bytes32"
          },
          %{
            "name" => "licenseId",
            "type" => "bytes32"
          },
          %{
            "name" => "fullAddress",
            "type" => "string"
          },
          %{
            "name" => "state",
            "type" => "bytes32"
          },
          %{
            "name" => "zipcode",
            "type" => "bytes32"
          },
          %{
            "name" => "expirationDate",
            "type" => "uint256"
          },
          %{
            "name" => "createdDate",
            "type" => "uint256"
          },
          %{
            "name" => "updatedDate",
            "type" => "uint256"
          },
          %{
            "name" => "minThreshold",
            "type" => "uint256"
          }
        ],
        "payable" => false,
        "stateMutability" => "view",
        "type" => "function",
        "signature" => "0xfa52c7d8"
      },
      %{
        "anonymous" => false,
        "inputs" => [
          %{
            "indexed" => true,
            "name" => "miningKey",
            "type" => "address"
          }
        ],
        "name" => "MetadataCleared",
        "type" => "event",
        "signature" => "0x1928e25e316bab82325e01eaf5b4a29f7b2d5e3d77fc0b6ac959eb95112f3ee9"
      },
      %{
        "anonymous" => false,
        "inputs" => [
          %{
            "indexed" => true,
            "name" => "miningKey",
            "type" => "address"
          }
        ],
        "name" => "MetadataCreated",
        "type" => "event",
        "signature" => "0x76a10cc0839d166c55eec8dba39ff22f75470574ede5014b744b45cebea5fc7e"
      },
      %{
        "anonymous" => false,
        "inputs" => [
          %{
            "indexed" => true,
            "name" => "oldMiningKey",
            "type" => "address"
          },
          %{
            "indexed" => true,
            "name" => "newMiningKey",
            "type" => "address"
          }
        ],
        "name" => "MetadataMoved",
        "type" => "event",
        "signature" => "0x6a3e5f5cc14de86bb3be87bc976b74890ecd0c8fa0cfca2fe3fefe55c9b47dde"
      },
      %{
        "anonymous" => false,
        "inputs" => [
          %{
            "indexed" => true,
            "name" => "miningKey",
            "type" => "address"
          }
        ],
        "name" => "ChangeRequestInitiated",
        "type" => "event",
        "signature" => "0x6ec0e3afd4b29a1fe1c688cb1e6474d9e2c6a1032858c3add0ff32b7ba95f32f"
      },
      %{
        "anonymous" => false,
        "inputs" => [
          %{
            "indexed" => true,
            "name" => "miningKey",
            "type" => "address"
          }
        ],
        "name" => "CancelledRequest",
        "type" => "event",
        "signature" => "0x5a1dcc05b2a41ad121a798e749b9ba9584177c68a4047ee52ef37d4ca76ce08c"
      },
      %{
        "anonymous" => false,
        "inputs" => [
          %{
            "indexed" => true,
            "name" => "miningKey",
            "type" => "address"
          },
          %{
            "indexed" => false,
            "name" => "votingSender",
            "type" => "address"
          },
          %{
            "indexed" => false,
            "name" => "votingSenderMiningKey",
            "type" => "address"
          }
        ],
        "name" => "Confirmed",
        "type" => "event",
        "signature" => "0x603c57ecb4a9802537649ceb6523e5d48c939e7856768ce6f9b3128a889a5cfe"
      },
      %{
        "anonymous" => false,
        "inputs" => [
          %{
            "indexed" => true,
            "name" => "miningKey",
            "type" => "address"
          }
        ],
        "name" => "FinalizedChange",
        "type" => "event",
        "signature" => "0xccf0f685803f0fba33ec88246b35d75b758b1e77c3d65ef5658f7e630f36b85b"
      }
    ]
  end
end
