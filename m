From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 23 Jul 2018 09:57:25 -0700
Subject: [Intel-wired-lan] [RFC 00/13] Bug fixes for ice
In-Reply-To: <20180720195446.4346-1-anirudh.venkataramanan@intel.com>
References: <20180720195446.4346-1-anirudh.venkataramanan@intel.com>
Message-ID: <b28588b5-6024-8e90-18b7-bade5264f885@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/20/2018 12:54 PM, Anirudh Venkataramanan wrote:
> This patch set fixes multiple bugs for the ice driver.

Since the ice driver original patches are still under review and not yet 
upstream, why are these bug fixes not rolled into the original patch 
set?  Put these into the initial patch set and have a clearer upstream 
submission.

sln

> 
> Anirudh Venkataramanan (4):
>    ice: Fix static analyser warning
>    ice: Cleanup magic number
>    ice: Fix bugs in control queue processing
>    ice: Fix couple of null pointer dereference issues
> 
> Brett Creeley (2):
>    ice: Don't explicitly set port_vlan_bits to 0
>    ice: Set VLAN flags correctly
> 
> Bruce Allan (3):
>    ice: Fix missing shift
>    ice: Update to interrupts enabled in OICR
>    ice: Change struct members from bool to u8
> 
> Jacob Keller (2):
>    ice: Report stats for allocated queues via ethtool stats
>    ice: Use order_base_2 to calculate higher power of 2
> 
> Jesse Brandeburg (1):
>    ice: Fix potential return of uninitialized value
> 
> Preethi Banala (1):
>    ice: Clean control queues only when they are initialized
> 
>   drivers/net/ethernet/intel/ice/ice.h            | 15 ++--
>   drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  1 +
>   drivers/net/ethernet/intel/ice/ice_controlq.c   | 29 +++++---
>   drivers/net/ethernet/intel/ice/ice_ethtool.c    | 52 ++++++++++----
>   drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  8 ---
>   drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h  |  1 +
>   drivers/net/ethernet/intel/ice/ice_main.c       | 91 +++++++++++++++----------
>   drivers/net/ethernet/intel/ice/ice_switch.c     |  3 +-
>   drivers/net/ethernet/intel/ice/ice_switch.h     |  6 +-
>   drivers/net/ethernet/intel/ice/ice_txrx.h       |  2 +-
>   drivers/net/ethernet/intel/ice/ice_type.h       | 16 ++---
>   11 files changed, 141 insertions(+), 83 deletions(-)
> 
