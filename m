From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 19 May 2021 21:35:13 +0000
Subject: [Intel-wired-lan] [PATCH S59 06/13] ice: Detect and report
 unsupported module power levels
In-Reply-To: <20210506154008.12880-6-anthony.l.nguyen@intel.com>
References: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
 <20210506154008.12880-6-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105F6020ED0A513715A8DB6FA2B9@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, May 6, 2021 8:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S59 06/13] ice: Detect and report
> unsupported module power levels
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> Determine whether an unsupported power configuration is preventing link
> establishment by storing and checking the link_cfg_err_byte. Print error
> messages when module power levels are unsupported. Also add a new flag
> bit to prevent spamming said error messages.
> 
> Co-developed-by: Jeb Cramer <jeb.j.cramer@intel.com>
> Signed-off-by: Jeb Cramer <jeb.j.cramer@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  1 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  6 ++-
>  drivers/net/ethernet/intel/ice/ice_common.c   |  2 +
>  drivers/net/ethernet/intel/ice/ice_main.c     | 40 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_type.h     |  1 +
>  5 files changed, 48 insertions(+), 2 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


