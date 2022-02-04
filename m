From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 4 Feb 2022 07:19:36 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 01/14] ice: Refactor
 spoofcheck configuration functions
In-Reply-To: <20211202163852.36436-1-anthony.l.nguyen@intel.com>
References: <20211202163852.36436-1-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB33672FD917E35D4BC70A934AFC299@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, December 2, 2021 10:09 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v3 01/14] ice: Refactor
> spoofcheck configuration functions
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Add functions to configure Tx VLAN antispoof based on iproute configuration
> and/or VLAN mode and VF driver support. This is needed later so the driver
> can control when it can be configured. Also, add functions that can be used
> to enable and disable MAC and VLAN spoofcheck. Move spoofchk
> configuration during VSI setup into the SR-IOV initialization path and into the
> post VSI rebuild flow for VF VSIs.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  19 ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 159 ++++++++++++++----
>  2 files changed, 128 insertions(+), 50 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
