From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 11 Mar 2021 22:50:26 +0000
Subject: [Intel-wired-lan] [PATCH net 07/13] ice: prevent ice_open and
 ice_stop during reset
In-Reply-To: <20210226211932.46683-7-anthony.l.nguyen@intel.com>
References: <20210226211932.46683-1-anthony.l.nguyen@intel.com>
 <20210226211932.46683-7-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105C510C1129B479E8B9D8AFA909@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, February 26, 2021 1:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net 07/13] ice: prevent ice_open and
> ice_stop during reset
> 
> From: Krzysztof Goreczny <krzysztof.goreczny@intel.com>
> 
> There is a possibility of race between ice_open or ice_stop calls performed
> by OS and reset handling routine both trying to modify VSI resources.
> Observed scenarios:
> - reset handler deallocates memory in ice_vsi_free_arrays and ice_open
>   tries to access it in ice_vsi_cfg_txq leading to driver crash
> - reset handler deallocates memory in ice_vsi_free_arrays and ice_close
>   tries to access it in ice_down leading to driver crash
> - reset handler clears port scheduler topology and sets port state to
>   ICE_SCHED_PORT_STATE_INIT leading to ice_ena_vsi_txq fail in ice_open
> 
> To prevent this additional checks in ice_open and ice_stop are introduced to
> make sure that OS is not allowed to alter VSI config while reset is in progress.
> 
> Fixes: cdedef59deb0 ("ice: Configure VSIs for Tx/Rx")
> Signed-off-by: Krzysztof Goreczny <krzysztof.goreczny@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      |  1 +
>  drivers/net/ethernet/intel/ice/ice_lib.c  |  4 ++--
> drivers/net/ethernet/intel/ice/ice_main.c | 28
> +++++++++++++++++++++++
>  3 files changed, 31 insertions(+), 2 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


