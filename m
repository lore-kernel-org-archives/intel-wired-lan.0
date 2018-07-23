From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 23 Jul 2018 09:59:37 -0700
Subject: [Intel-wired-lan] [RFC 00/13] Feature updates for ice
In-Reply-To: <20180720205353.13296-1-anirudh.venkataramanan@intel.com>
References: <20180720205353.13296-1-anirudh.venkataramanan@intel.com>
Message-ID: <13b67f57-845e-a80a-2405-fb3f11aca86f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/20/2018 1:53 PM, Anirudh Venkataramanan wrote:
> This patch series includes new features and implementation updates
> for the ice driver.

Same comment - roll these into the initial patchset.
sln

> 
> Akeem G Abodunrin (1):
>    ice: Introduce SERVICE_DIS flag and service routine functions
> 
> Anirudh Venkataramanan (5):
>    ice: Minor updates to Tx scheduler code
>    ice: Prevent control queue operations during reset
>    ice: Refactor switch rule management structures and functions
>    ice: Refactor VSI allocation, deletion and rebuild flow
>    ice: Clean up register file
> 
> Brett Creeley (1):
>    ice: Make ice_vsi_kill_vlan return an error code
> 
> Chinh Cao (1):
>    ice: Implement handlers for ethtool PHY/link operations
> 
> Hieu Tran (1):
>    ice: Enable firmware logging during device initialization.
> 
> Md Fahad Iqbal Polash (1):
>    ice: Implement ice_bridge_getlink and ice_bridge_setlink
> 
> Phani R Burra (1):
>    ice: Get both device and function capabilities
> 
> Sudheer Mogilappagari (1):
>    ice: Add support for Tx hang, Tx timeout and malicious driver
>      detection
> 
> Zhenning Xiao (1):
>    ice: Code optimization for ice_fill_sw_rule()
> 
>   drivers/net/ethernet/intel/ice/ice.h            |    7 +
>   drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |   94 +-
>   drivers/net/ethernet/intel/ice/ice_common.c     |  361 +++++-
>   drivers/net/ethernet/intel/ice/ice_common.h     |   15 +-
>   drivers/net/ethernet/intel/ice/ice_controlq.c   |    3 +
>   drivers/net/ethernet/intel/ice/ice_ethtool.c    |  805 +++++++++++++-
>   drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  456 ++++----
>   drivers/net/ethernet/intel/ice/ice_main.c       |  967 +++++++++++++---
>   drivers/net/ethernet/intel/ice/ice_sched.c      |  117 +-
>   drivers/net/ethernet/intel/ice/ice_status.h     |    1 +
>   drivers/net/ethernet/intel/ice/ice_switch.c     | 1356 ++++++++++++++---------
>   drivers/net/ethernet/intel/ice/ice_switch.h     |   50 +-
>   drivers/net/ethernet/intel/ice/ice_txrx.c       |    1 +
>   drivers/net/ethernet/intel/ice/ice_txrx.h       |    1 +
>   drivers/net/ethernet/intel/ice/ice_type.h       |   42 +-
>   15 files changed, 3157 insertions(+), 1119 deletions(-)
> 
