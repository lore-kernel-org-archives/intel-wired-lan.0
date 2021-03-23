From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 23 Mar 2021 22:41:14 +0000
Subject: [Intel-wired-lan] [PATCH net 06/13] ice: Recognize 860 as iSCSI
 port in CEE mode
In-Reply-To: <20210226211932.46683-6-anthony.l.nguyen@intel.com>
References: <20210226211932.46683-1-anthony.l.nguyen@intel.com>
 <20210226211932.46683-6-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51050195D854CDF881E4CBB4FA649@CO1PR11MB5105.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net 06/13] ice: Recognize 860 as iSCSI port
> in CEE mode
> 
> From: Chinh T Cao <chinh.t.cao@intel.com>
> 
> iSCSI can use both TCP ports 860 and 3260. However, in our current
> implementation, the ice_aqc_opc_get_cee_dcb_cfg (0x0A07) AQ command
> doesn't provide a way to communicate the protocol port number to the AQ's
> caller. Thus, we assume that 3260 is the iSCSI port number at the AQ's caller
> layer.
> 
> Rely on the dcbx-willing mode, desired QoS and remote QoS configuration to
> determine which port number that iSCSI will use.
> 
> Fixes: 0ebd3ff13cca ("ice: Add code for DCB initialization part 2/4")
> Signed-off-by: Chinh T Cao <chinh.t.cao@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb.c  | 38 +++++++++++++++++------
> drivers/net/ethernet/intel/ice/ice_type.h |  1 +
>  2 files changed, 30 insertions(+), 9 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


