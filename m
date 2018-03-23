From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 23 Mar 2018 22:42:06 +0000
Subject: [Intel-wired-lan] [v4,
 07/15] ice: Add support for VSI allocation and deallocation
In-Reply-To: <20180320145819.19133-8-anirudh.venkataramanan@intel.com>
References: <20180320145819.19133-8-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD261789F137@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Anirudh Venkataramanan
> [mailto:anirudh.venkataramanan at intel.com]
> Sent: Tuesday, March 20, 2018 7:58 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [v4,07/15] ice: Add support for VSI allocation and deallocation
> 
> This patch introduces data structures and functions to alloc/free
> VSIs. The driver represents a VSI using the ice_vsi structure.
> 
> Some noteworthy points about VSI allocation:
> 
> 1) A VSI is allocated in the firmware using the "add VSI" admin queue
>    command (implemented as ice_aq_add_vsi). The firmware returns an
>    identifier for the allocated VSI. The VSI context is used to program
>    certain aspects (loopback, queue map, etc.) of the VSI's configuration.
> 
> 2) A VSI is deleted using the "free VSI" admin queue command
> (implemented
>    as ice_aq_free_vsi).
> 
> 3) The driver represents a VSI using struct ice_vsi. This is allocated
>    and initialized as part of the ice_vsi_alloc flow, and deallocated
>    as part of the ice_vsi_delete flow.
> 
> 4) Once the VSI is created, a netdev is allocated and associated with it.
>    The VSI's ring and vector related data structures are also allocated
>    and initialized.
> 
> 5) A VSI's queues can either be contiguous or scattered. To do this, the
>    driver maintains a bitmap (vsi->avail_txqs) which is kept in sync with
>    the firmware's VSI queue allocation imap. If the VSI can't get a
>    contiguous queue allocation, it will fallback to scatter. This is
>    implemented in ice_vsi_get_qs which is called as part of the VSI setup
>    flow. In the release flow, the VSI's queues are released and the bitmap
>    is updated to reflect this by ice_vsi_put_qs.
> 
> CC: Shannon Nelson <shannon.nelson@oracle.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Acked-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h            |   72 ++
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  199 ++++
>  drivers/net/ethernet/intel/ice/ice_main.c       | 1111
> +++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_switch.c     |  115 +++
>  drivers/net/ethernet/intel/ice/ice_switch.h     |   21 +
>  drivers/net/ethernet/intel/ice/ice_txrx.h       |   26 +
>  drivers/net/ethernet/intel/ice/ice_type.h       |    4 +
>  7 files changed, 1548 insertions(+)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


