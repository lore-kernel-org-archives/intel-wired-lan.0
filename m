From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Tue, 17 May 2022 06:20:56 +0000
Subject: [Intel-wired-lan] [PATCH net v1] ice: Fix interrupt moderation
 settings getting cleared
In-Reply-To: <20220508233348.546388-1-michal.wilczynski@intel.com>
References: <20220508233348.546388-1-michal.wilczynski@intel.com>
Message-ID: <BYAPR11MB33674CF99256F2335C9952DCFCCE9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Wilczynski
> Sent: Monday, May 9, 2022 5:04 AM
> To: intel-wired-lan at osuosl.org
> Cc: Wilczynski, Michal <michal.wilczynski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] ice: Fix interrupt moderation
> settings getting cleared
> 
> Adaptive-rx and Adaptive-tx are interrupt moderation settings that can be
> enabled/disabled using ethtool:
> ethtool -C ethX adaptive-rx on/off adaptive-tx on/off
> 
> Unfortunately those settings are getting cleared after changing number of
> queues, or in ethtool world 'channels':
> ethtool -L ethX rx 1 tx 1
> 
> Clearing was happening due to introduction of bit fields in ice_ring_container
> struct. This way only itr_setting bits were rebuilt during
> ice_vsi_rebuild_set_coalesce().
> 
> Introduce an anonymous struct of bitfields and create a union to refer to
> them as a single variable.
> This way variable can be easily saved and restored.
> 
> Fixes: 61dc79ced7aa ("ice: Restore interrupt throttle settings after VSI
> rebuild")
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
> Internal-review:
> 
> v4:
> -Moved Singed-off-by tag to the end of the commit
> 
> v3:
> -Added proper Fixes tag
> 
> v2:
> -Changed argument to ice_write_itr to rc->itr_setting,  instead of settings in
> order not to pass unnecessary bits
> 
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 16 ++++++++--------
> drivers/net/ethernet/intel/ice/ice_txrx.h | 11 ++++++++---
>  2 files changed, 16 insertions(+), 11 deletions(-)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
