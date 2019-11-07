From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 Nov 2019 18:38:49 +0000
Subject: [Intel-wired-lan] [PATCH S32 v3 09/15] ice: use
 pkg_dwnld_status instead of sq_last_status
In-Reply-To: <20191106100541.48639-9-anthony.l.nguyen@intel.com>
References: <20191106100541.48639-1-anthony.l.nguyen@intel.com>
 <20191106100541.48639-9-anthony.l.nguyen@intel.com>
Message-ID: <d9448bba693242078af0a3406e859b85@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, November 6, 2019 2:06 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S32 v3 09/15] ice: use pkg_dwnld_status
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


