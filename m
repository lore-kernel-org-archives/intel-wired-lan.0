From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 2 May 2016 14:28:16 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: constify i40e_client_ops
 structure
In-Reply-To: <1462104443-30724-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1462104443-30724-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D5585@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Julia Lawall
> Sent: Sunday, May 01, 2016 5:07 AM
> To: linux-kernel at vger.kernel.org
> Cc: Ismail, Mustafa <mustafa.ismail@intel.com>; netdev at vger.kernel.org;
> Latif, Faisal <faisal.latif@intel.com>; linux-rdma at vger.kernel.org; Nikolova,
> Tatyana E <tatyana.e.nikolova@intel.com>; Tung, Chien Tin
> <chien.tin.tung@intel.com>; kernel-janitors at vger.kernel.org; Doug Ledford
> <dledford@redhat.com>; intel-wired-lan at lists.osuosl.org; Hefty, Sean
> <sean.hefty@intel.com>; Saleem, Shiraz <shiraz.saleem@intel.com>; Hal
> Rosenstock <hal.rosenstock@gmail.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: constify i40e_client_ops structure
> 
> The i40e_client_ops structure is never modified, so declare it as const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/infiniband/hw/i40iw/i40iw_main.c      |    2 +-
>  drivers/net/ethernet/intel/i40e/i40e_client.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Changes applied correctly, driver builds and passes traffic as expected
