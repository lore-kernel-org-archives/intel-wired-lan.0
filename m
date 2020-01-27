From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 27 Jan 2020 23:14:20 +0000
Subject: [Intel-wired-lan] [PATCH S38 06/15] ice: Add support to
 enable/disable all Rx queues before waiting
In-Reply-To: <20200122152138.41585-6-anthony.l.nguyen@intel.com>
References: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
 <20200122152138.41585-6-anthony.l.nguyen@intel.com>
Message-ID: <ed752e9fee864b698e21be3b0a2e66d3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, January 22, 2020 7:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S38 06/15] ice: Add support to
> enable/disable all Rx queues before waiting
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently when we enable/disable all Rx queues we do the following
> sequence for each Rx queue and then move to the next queue.
> 
> 1. Enable/Disable the Rx queue via register write.
> 2. Read the configuration register to determine if the Rx queue was
> enabled/disabled successfully.
> 
> In some cases enabling/disabling queue 0 fails because of step 2 above.
> Fix this by doing step 1 for all of the Rx queues and then step 2 for all of the
> Rx queues.
> 
> Also, there are cases where we enable/disable a single queue (i.e.
> SR-IOV and XDP) so add a new function that does step 1 and 2 above with a
> read flush in between.
> 
> This change also required a single Rx queue to be enabled/disabled with and
> without waiting for the change to propagate through hardware. Fix this by
> adding a boolean wait flag to the necessary functions.
> 
> Also, add the keywords "one" and "all" to distinguish between
> enabling/disabling a single Rx queue and all Rx queues respectively.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c     | 42 ++++++++++++++-----
>  drivers/net/ethernet/intel/ice/ice_base.h     |  4 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  4 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 32 +++++++++-----
>  drivers/net/ethernet/intel/ice/ice_lib.h      |  4 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |  4 +-
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  7 ++--
>  drivers/net/ethernet/intel/ice/ice_xsk.c      |  4 +-
>  8 files changed, 67 insertions(+), 34 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


