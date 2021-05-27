From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 27 May 2021 17:27:27 +0000
Subject: [Intel-wired-lan] [PATCH 8/8] ice: enable transmit timestamps
 for E810 devices
In-Reply-To: <20210520164850.1884656-9-jacob.e.keller@intel.com>
References: <20210520164850.1884656-1-jacob.e.keller@intel.com>
 <20210520164850.1884656-9-jacob.e.keller@intel.com>
Message-ID: <CO1PR11MB51056922FF0048F6B268D481FA239@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Thursday, May 20, 2021 9:49 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: Lion, Sean <sean.lion@intel.com>
> Subject: [Intel-wired-lan] [PATCH 8/8] ice: enable transmit timestamps for
> E810 devices
> 
> Add support for enabling Tx timestamp requests for outgoing packets on
> E810 devices.
> 
> The ice hardware can support multiple outstanding Tx timestamp requests.
> When sending a descriptor to hardware, a Tx timestamp request is made by
> setting a request bit, and assigning an index that represents which Tx
> timestamp index to store the timestamp in.
> 
> Hardware makes no effort to synchronize the index use, so it is up to
> software to ensure that Tx timestamp indexes are not re-used before the
> timestamp is reported back.
> 
> To do this, introduce a Tx timestamp tracker which will keep track of currently
> in-use indexes.
> 
> In the hot path, if a packet has a timestamp request, an index will be
> requested from the tracker. Unfortunately, this does require a lock as the
> indexes are shared across all queues on a PHY. There are not enough indexes
> to reliably assign only 1 to each queue.
> 
> For the E810 devices, the timestamp indexes are not shared across PHYs, so
> each port can have its own tracking.
> 
> Once hardware captures a timestamp, an interrupt is fired. In this interrupt,
> trigger a new work item that will figure out which timestamp was completed,
> and report the timestamp back to the stack.
> 
> This function loops through the Tx timestamp indexes and checks whether
> there is now a valid timestamp. If so, it clears the PHY timestamp indication in
> the PHY memory, locks and removes the SKB and bit in the tracker, then
> reports the timestamp to the stack.
> 
> It is possible in some cases that a timestamp request will be initiated but
> never completed. This might occur if the packet is dropped by software or
> hardware before it reaches the PHY.
> 
> Add a task to the periodic work function that will check whether a timestamp
> request is more than a few seconds old. If so, the timestamp index is cleared
> in the PHY, and the SKB is released.
> 
> Just as with Rx timestamps, the Tx timestamps are only 40 bits wide, and use
> the same overall logic for extending to 64 bits of nanoseconds.
> 
> With this change, E810 devices should be able to perform basic PTP
> functionality.
> 
> Future changes will extend the support to cover the E822-based devices.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c     |   9 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |   6 +-
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |   1 +
>  drivers/net/ethernet/intel/ice/ice_lib.c      |   1 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |   5 +
>  drivers/net/ethernet/intel/ice/ice_ptp.c      | 369 +++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_ptp.h      |  91 +++++
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |  37 ++
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |   3 +
>  9 files changed, 518 insertions(+), 4 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


