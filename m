From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 9 Mar 2021 23:42:57 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 1/3] ice: report hash type
 such as L2/L3/L4
In-Reply-To: <20210223234707.1170711-2-jesse.brandeburg@intel.com>
References: <20210223234707.1170711-1-jesse.brandeburg@intel.com>
 <20210223234707.1170711-2-jesse.brandeburg@intel.com>
Message-ID: <CO1PR11MB5105FC921482051B3485413EFA929@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jesse Brandeburg
> Sent: Tuesday, February 23, 2021 3:47 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v2 1/3] ice: report hash type such
> as L2/L3/L4
> 
> The hardware is reporting the type of the hash used for RSS as a PTYPE field
> in the receive descriptor. Use this value to set the skb packet hash type by
> extending the hash type table to cover all 10-bits of possible values (requiring
> some variables to be changed from u8 to u16), and then use that table to
> convert to one of the possible values in enum pkt_hash_types.
> 
> While we're here, remove the unused ptype struct value, which makes table
> init easier for the zero entries, and use ranged initializer to remove a bunch
> of code (works with gcc and clang).
> 
> Without this change, the kernel will recalculate the hash in software, which
> can consume extra CPU cycles.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Co-developed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> v2: [IWL] updated the initializer of the ptype table to remove PTYPE
> 
> NOTE: this patch generates an expected checkpatch error due to the tricky
> structure initializer macro.
> ---
>  .../net/ethernet/intel/ice/ice_lan_tx_rx.h    | 147 ++++--------------
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  23 ++-
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.h |   2 +-
>  drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
>  5 files changed, 50 insertions(+), 126 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


