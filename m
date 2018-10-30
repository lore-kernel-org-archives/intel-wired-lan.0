From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Oct 2018 22:19:40 +0000
Subject: [Intel-wired-lan] [PATCH S9 03/15] ice: Fix to make VLAN
 priority tagged traffic to appear on all TCs
In-Reply-To: <20181026184447.13547-4-anirudh.venkataramanan@intel.com>
References: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
 <20181026184447.13547-4-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328DB9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, October 26, 2018 11:45 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S9 03/15] ice: Fix to make VLAN priority
> tagged traffic to appear on all TCs
> 
> From: Usha Ketineni <usha.k.ketineni@intel.com>
> 
> This patch includes below changes to resolve the issue of ETS bandwidth
> shaping to work.
> 
> 1. Allocation of Tx queues is accounted for based on the enabled TC's
>    in ice_vsi_setup_q_map() and enabled the Tx queues on those TC's via
>    ice_vsi_cfg_txqs()
> 
> 2. Get the mapped netdev TC # for the user priority and set the priority
>    to TC mapping for the VSI.
> 
> Signed-off-by: Usha Ketineni <usha.k.ketineni@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice.h       |   4 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c   | 121 +++++++++++++++++---------
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c  |   4 +-
>  drivers/net/ethernet/intel/ice/ice_sched.c |   2 +-
>  drivers/net/ethernet/intel/ice/ice_sched.h |   1 +
>  5 files changed, 81 insertions(+), 51 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


