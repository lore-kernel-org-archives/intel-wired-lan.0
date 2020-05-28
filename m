From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 May 2020 21:38:52 +0000
Subject: [Intel-wired-lan] [PATCH S45 01/15] ice: Refactor
 ice_ena_vf_mappings to split MSIX and queue mappings
In-Reply-To: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
References: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659FAB6B2C65C6506C8B1848C8E0@DM5PR11MB1659.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S45 01/15] ice: Refactor
> ice_ena_vf_mappings to split MSIX and queue mappings
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently ice_ena_vf_mappings() does all of the VF's MSIX and queue
> mapping in one function. This makes it hard to digest. Fix this by creating a
> new function for enabling MSIX mappings and one for enabling queue
> mappings.
> 
> Also, rename some variables in the functions for clarity.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 91 ++++++++++++-------
>  1 file changed, 59 insertions(+), 32 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


