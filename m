From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 27 Nov 2017 21:19:26 +0000
Subject: [Intel-wired-lan] [PATCH] i40e/virtchnl: fix application of
 sizeof	to pointer
In-Reply-To: <20171018203425.GA983@embeddedor.com>
References: <20171018203425.GA983@embeddedor.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAF8A8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Gustavo A. R. Silva
> Sent: Wednesday, October 18, 2017 1:34 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org; Gustavo A. R. Silva <garsilva@embeddedor.com>
> Subject: [Intel-wired-lan] [PATCH] i40e/virtchnl: fix application of sizeof to
> pointer
> 
> sizeof when applied to a pointer typed expression gives the size of the
> pointer.
> 
> The proper fix in this particular case is to code sizeof(*vfres) instead of
> sizeof(vfres).
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
> This code was tested by compilation only.
> 
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


