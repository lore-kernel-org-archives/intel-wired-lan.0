From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 12 May 2021 21:48:16 +0000
Subject: [Intel-wired-lan] [PATCH] ice: set the value of global config
 lock timeout longer
In-Reply-To: <20210419093106.6487-1-liwei.song@windriver.com>
References: <20210419093106.6487-1-liwei.song@windriver.com>
Message-ID: <CO1PR11MB51059B08F5B1A7EA207FC3E9FA529@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Liwei Song
> Sent: Monday, April 19, 2021 2:31 AM
> To: intel-wired-lan <intel-wired-lan@lists.osuosl.org>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: Jakub <kuba@kernel.org>; David <davem@davemloft.net>; linux-
> kernel at vger.kernel.org; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] ice: set the value of global config lock
> timeout longer
> 
> It may need hold Global Config Lock a longer time when download DDP
> package file, extend the timeout value to 5000ms to ensure that download
> can be finished before other AQ command got time to run, this will fix the
> issue below when probe the device, 5000ms is a test value that work with
> both Backplane and BreakoutCable NVM image:
> 
> ice 0000:f4:00.0: VSI 12 failed lan queue config, error ICE_ERR_CFG ice
> 0000:f4:00.0: Failed to delete VSI 12 in FW - error: ICE_ERR_AQ_TIMEOUT ice
> 0000:f4:00.0: probe failed due to setup PF switch: -12
> ice: probe of 0000:f4:00.0 failed with error -12
> 
> Signed-off-by: Liwei Song <liwei.song@windriver.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_type.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


