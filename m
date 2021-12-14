From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Tue, 14 Dec 2021 04:33:30 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 02/14] ice: Add helper
 function for adding VLAN 0
In-Reply-To: <20211202163852.36436-2-anthony.l.nguyen@intel.com>
References: <20211202163852.36436-1-anthony.l.nguyen@intel.com>
 <20211202163852.36436-2-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB3367EAA2222AF23B6AB1BDE9FC759@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Tony
> Nguyen
> Sent: Thursday, December 2, 2021 10:09 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v3 02/14] ice: Add helper function
> for adding VLAN 0
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> There are multiple places where VLAN 0 is being added. Create a function to be
> called in order to minimize changes as the implementation is expanded to
> support double VLAN and avoid duplicated code.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch.c     |  4 ++--
>  drivers/net/ethernet/intel/ice/ice_lib.c         | 11 ++++++++++-
>  drivers/net/ethernet/intel/ice/ice_lib.h         |  2 +-
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  2 +-
>  4 files changed, 14 insertions(+), 5 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
