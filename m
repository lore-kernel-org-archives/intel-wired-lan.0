From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 4 Nov 2019 20:16:36 +0000
Subject: [Intel-wired-lan] [PATCH S30 v4 3/9] ice: Add support for XDP
In-Reply-To: <20191031143005.5002-1-anthony.l.nguyen@intel.com>
References: <20191031143005.5002-1-anthony.l.nguyen@intel.com>
Message-ID: <e37a7bf65352463eae381d766b6d6f84@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, October 31, 2019 7:30 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S30 v4 3/9] ice: Add support for XDP
> 
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Add support for XDP. Implement ndo_bpf and ndo_xdp_xmit.  Upon load of
> an XDP program, allocate additional Tx rings for dedicated XDP use.
> The following actions are supported: XDP_TX, XDP_DROP, XDP_REDIRECT,
> XDP_PASS, and XDP_ABORTED.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v4:
> - return -EOPNOTSUPP instead of ENOTSUPP for too large MTU which makes
>   it impossible to attach XDP prog
> - don't check for case when there's no XDP prog currently on interface
>   and ice_xdp() is called with NULL bpf_prog; this happens when user
>   does "ip link set eth0 xdp off" and no prog is present on VSI; no need
>   for that as it is handled by higher layer
> - drop the extack message for unknown xdp->command
> - use the smp_processor_id() for accessing the XDP Tx ring for XDP_TX
>   action
> - don't leave the interface in downed state in case of any failure
>   during the XDP Tx resources handling
> - undo rename of ice_build_ctob
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |  24 +-
>  drivers/net/ethernet/intel/ice/ice_base.c    |  28 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c |  50 ++-
>  drivers/net/ethernet/intel/ice/ice_lib.c     |  68 +++-
>  drivers/net/ethernet/intel/ice/ice_lib.h     |   6 +
>  drivers/net/ethernet/intel/ice/ice_main.c    | 326 +++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_txrx.c    | 346 ++++++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_txrx.h    |  34 +-
>  8 files changed, 825 insertions(+), 57 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


