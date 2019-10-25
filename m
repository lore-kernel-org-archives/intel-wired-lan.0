From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 25 Oct 2019 23:36:33 +0000
Subject: [Intel-wired-lan] [PATCH S30 v3 3/9] ice: Add support for XDP
In-Reply-To: <20191024081125.6711-3-anthony.l.nguyen@intel.com>
References: <20191024081125.6711-1-anthony.l.nguyen@intel.com>
 <20191024081125.6711-3-anthony.l.nguyen@intel.com>
Message-ID: <074fae0773ed4e0eacbe927bb5e4530c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, October 24, 2019 1:11 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S30 v3 3/9] ice: Add support for XDP
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
>  drivers/net/ethernet/intel/ice/ice.h         |  24 +-
>  drivers/net/ethernet/intel/ice/ice_base.c    |  28 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c |  50 ++-
>  drivers/net/ethernet/intel/ice/ice_lib.c     |  69 +++-
>  drivers/net/ethernet/intel/ice/ice_lib.h     |   6 +
>  drivers/net/ethernet/intel/ice/ice_main.c    | 319 +++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_txrx.c    | 351 ++++++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_txrx.h    |  34 +-
>  8 files changed, 822 insertions(+), 59 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


