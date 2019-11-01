From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Nov 2019 16:43:53 +0000
Subject: [Intel-wired-lan] [PATCH S32 09/15] ice: use pkg_dwnld_status
 instead of sq_last_status
In-Reply-To: <20191025143441.50151-9-anthony.l.nguyen@intel.com>
References: <20191025143441.50151-1-anthony.l.nguyen@intel.com>
 <20191025143441.50151-9-anthony.l.nguyen@intel.com>
Message-ID: <18f979ca17fc4cfeabfe050723b5e32f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, October 25, 2019 7:35 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S32 09/15] ice: use pkg_dwnld_status
> instead of sq_last_status
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Since the return value from the Download Package AQ command is stored in
> hw->pkg_dwnld_status, use that instead of sq_last_status since that may
> have the return value from some other AQ command leading to unexpected
> results.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


