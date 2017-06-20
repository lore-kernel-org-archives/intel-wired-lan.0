From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 20 Jun 2017 17:11:39 +0000
Subject: [Intel-wired-lan] [PATCH] intel: i40e: virtchnl: fix
	incorrect	variable assignment
In-Reply-To: <20170615023826.GA8136@embeddedgus>
References: <20170615023826.GA8136@embeddedgus>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAB670@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Gustavo A. R. Silva
> Sent: Wednesday, June 14, 2017 7:38 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org; Gustavo A. R. Silva <garsilva@embeddedor.com>
> Subject: [Intel-wired-lan] [PATCH] intel: i40e: virtchnl: fix incorrect variable
> assignment
> 
> Fix incorrect variable assignment.
> Based on line 1511: aq_ret = I40_ERR_PARAM; the correct variable to be
> used in this instance is aq_ret instead of ret. Also, variable ret is updated at
> line 1602 just before return, so assigning a value to this variable in this code
> block is useless.
> 
> Addresses-Coverity-ID: 1397693
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


