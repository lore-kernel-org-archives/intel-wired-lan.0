From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 23 Mar 2018 23:09:08 +0000
Subject: [Intel-wired-lan] [v4,
 13/15] ice: Update Tx scheduler tree for VSI multi-Tx queue support
In-Reply-To: <20180320145819.19133-14-anirudh.venkataramanan@intel.com>
References: <20180320145819.19133-14-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD261789F1D0@ORSMSX109.amr.corp.intel.com>
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
> Subject: [v4, 13/15] ice: Update Tx scheduler tree for VSI multi-Tx queue
> support
> 
> This patch adds the ability for a VSI to use multiple Tx queues. More
> specifically, the patch
>     1) Provides the ability to update the Tx scheduler tree in the
>        firmware. The driver can configure the Tx scheduler tree by
>        adding/removing multiple Tx queues per TC per VSI.
> 
>     2) Allows a VSI to reconfigure its Tx queues during runtime.
> 
>     3) Synchronizes the Tx scheduler update operations using locks.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h            |   7 +
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  28 +
>  drivers/net/ethernet/intel/ice/ice_common.c     |  54 ++
>  drivers/net/ethernet/intel/ice/ice_common.h     |   3 +
>  drivers/net/ethernet/intel/ice/ice_main.c       |  20 +-
>  drivers/net/ethernet/intel/ice/ice_sched.c      | 886
> ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_sched.h      |   4 +
>  drivers/net/ethernet/intel/ice/ice_type.h       |   7 +
>  8 files changed, 1006 insertions(+), 3 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


