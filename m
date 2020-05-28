From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 May 2020 21:39:18 +0000
Subject: [Intel-wired-lan] [PATCH S45 02/15] ice: Simplify
 ice_sriov_configure
In-Reply-To: <20200516005121.4963-2-anthony.l.nguyen@intel.com>
References: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
 <20200516005121.4963-2-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659F959C6A68CAEFFF692778C8E0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S45 02/15] ice: Simplify ice_sriov_configure
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Add a new function for checking if SR-IOV can be configured based on the PF
> and/or device's state/capabilities. Also, simplify the flow in
> ice_sriov_configure().
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 72 ++++++++++++-------
>  1 file changed, 48 insertions(+), 24 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


