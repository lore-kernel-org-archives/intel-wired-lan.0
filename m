From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 May 2020 21:42:58 +0000
Subject: [Intel-wired-lan] [PATCH S45 10/15] ice: Refactor VF VSI
 release and setup functions
In-Reply-To: <20200516005121.4963-10-anthony.l.nguyen@intel.com>
References: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
 <20200516005121.4963-10-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB165988B21DA811977AF0FC2A8C8E0@DM5PR11MB1659.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S45 10/15] ice: Refactor VF VSI release and
> setup functions
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently when a VF VSI calls ice_vsi_release() and ice_vsi_setup() it
> subsequently clears/sets the VF cached variables for lan_vsi_idx and
> lan_vsi_num. This works fine, but can be improved by handling this in the VF
> specific VSI release and setup functions.
> 
> Also, when a VF VSI is setup too many parameters are passed that can be
> derived from the VF. Fix this by only calling VF VSI setup with the bare
> minimum parameters.
> 
> Also, add functionality to invalidate a VF's VSI when it's released and/or
> setup fails. This will make it so a VF VSI cannot be accessed via its cached
> vsi_idx/vsi_num in these cases.
> 
> Finally when a VF's VSI is invalidated set the lan_vsi_idx and lan_vsi_num to
> ICE_NO_VSI to clearly show that there is no valid VSI associated with this VF.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 86 ++++++++++++-------
>  1 file changed, 55 insertions(+), 31 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


