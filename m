From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Aug 2019 21:34:03 +0000
Subject: [Intel-wired-lan] [PATCH S26 03/15] ice: Alloc queue management
 bitmaps and arrays dynamically
In-Reply-To: <20190802082533.23083-3-anthony.l.nguyen@intel.com>
References: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
 <20190802082533.23083-3-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40F087@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, August 2, 2019 1:25 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S26 03/15] ice: Alloc queue management
> bitmaps and arrays dynamically
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> The total number of queues available on the device is divided between
> multiple physical functions (PF) in the firmware and provided to the driver
> when it gets function capabilities from the firmware. Thus each PF knows
> how many Tx/Rx queues it has. These queues are then doled out to different
> VSIs (for LAN traffic, SR-IOV VF traffic, etc.)
> 
> To track usage of these queues at the PF level, the driver uses two bitmaps
> avail_txqs and avail_rxqs. At the VSI level (i.e. struct ice_vsi
> instances) the driver uses two arrays txq_map and rxq_map, to track
> ownership of VSIs' queues in avail_txqs and avail_rxqs respectively.
> 
> The aforementioned bitmaps and arrays should be allocated dynamically,
> because the number of queues supported by a PF is only available once
> function capabilities have been queried. The current static allocation
> consumes way more memory than required.
> 
> This patch removes the DECLARE_BITMAP for avail_txqs and avail_rxqs and
> instead uses bitmap_zalloc to allocate the bitmaps during init.
> Similarly txq_map and rxq_map are now allocated in ice_vsi_alloc_arrays.
> As a result ICE_MAX_TXQS and ICE_MAX_RXQS defines are no longer
> needed.
> Also as txq_map and rxq_map are now allocated and freed, some code
> reordering was required in ice_vsi_rebuild for correct functioning.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      | 12 +++---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 49 +++++++++++++++++------
> drivers/net/ethernet/intel/ice/ice_main.c | 40 ++++++++++++++----
>  3 files changed, 74 insertions(+), 27 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


