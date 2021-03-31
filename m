From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 31 Mar 2021 20:41:30 +0000
Subject: [Intel-wired-lan] [PATCH S57 01/14] ice: Re-send some AQ
 commands, as result of EBUSY AQ error
In-Reply-To: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51051A142A5FA5CA3610B31AFA7C9@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, March 25, 2021 3:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S57 01/14] ice: Re-send some AQ
> commands, as result of EBUSY AQ error
> 
> From: Chinh T Cao <chinh.t.cao@intel.com>
> 
> Retry sending some AQ commands, as result of EBUSY AQ error.
> ice_aqc_opc_get_link_topo
> ice_aqc_opc_lldp_stop
> ice_aqc_opc_lldp_start
> ice_aqc_opc_lldp_filter_ctrl
> 
> This change follows the latest guidelines from HW team. It is better to retry
> the same AQ command several times, as the result of EBUSY, instead of
> returning error to the caller right away.
> 
> Signed-off-by: Chinh T Cao <chinh.t.cao@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c   | 81 ++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_common.h   |  3 +
>  drivers/net/ethernet/intel/ice/ice_controlq.c |  2 +-
>  3 files changed, 84 insertions(+), 2 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


 

