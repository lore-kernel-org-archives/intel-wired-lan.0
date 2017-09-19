From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 Sep 2017 21:42:28 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: fix a typo.
In-Reply-To: <1505530188-3220-1-git-send-email-rami.rosen@intel.com>
References: <1505530188-3220-1-git-send-email-rami.rosen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA958@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Rami Rosen
> Sent: Friday, September 15, 2017 7:50 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] i40e: fix a typo.
> 
> This patch fixes a typo in i40e_vsi_alloc_arrays() documentation.
> The first parameter name should be "vsi" instead of "type".
> 
> Signed-off-by: Rami Rosen <rami.rosen@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


