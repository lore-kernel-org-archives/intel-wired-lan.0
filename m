From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 17 May 2019 22:25:55 +0000
Subject: [Intel-wired-lan] [next PATCH S5 iavf 04/11] iavf: Change
 GFP_KERNEL to GFP_ATOMIC in kzalloc()
In-Reply-To: <20190514173709.62431-4-alice.michael@intel.com>
References: <20190514173709.62431-1-alice.michael@intel.com>
 <20190514173709.62431-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3DB728@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, May 14, 2019 10:37 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S5 iavf 04/11] iavf: Change
> GFP_KERNEL to GFP_ATOMIC in kzalloc()
> 
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> iavf_add_vlan() is being called in atomic context so kzalloc() needs
> GFP_ATOMIC. This patch fixes it.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


