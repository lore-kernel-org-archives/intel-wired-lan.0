From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 26 May 2020 20:26:01 +0000
Subject: [Intel-wired-lan] [PATCH S44 11/14] ice: cleanup VSI context
 initialization
In-Reply-To: <20200516004226.4795-11-anthony.l.nguyen@intel.com>
References: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
 <20200516004226.4795-11-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659F753838AB2FDC196FDE28CB00@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:42 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S44 11/14] ice: cleanup VSI context
> initialization
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Remove an unnecessary copy of vsi->info into ctxt->info in ice_vsi_init.
> This line is essentially a no-op because ice_set_dflt_vsi_ctx performs a
> memset to clear the info from the context structure.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 1 -
>  1 file changed, 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


