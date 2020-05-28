From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 May 2020 21:41:28 +0000
Subject: [Intel-wired-lan] [PATCH S45 07/15] ice: Add functions to
 rebuild host VLAN/MAC config for a VF
In-Reply-To: <20200516005121.4963-7-anthony.l.nguyen@intel.com>
References: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
 <20200516005121.4963-7-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB16591518306B14208CFEDF0B8C8E0@DM5PR11MB1659.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S45 07/15] ice: Add functions to rebuild
> host VLAN/MAC config for a VF
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> When resetting a VF the VLAN and MAC filter configurations need to be
> replayed. Add helper functions for this purpose.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 121 +++++++++++++-----
>  1 file changed, 89 insertions(+), 32 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


