From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Sep 2017 22:22:43 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix a potential NULL
	pointer	dereference
In-Reply-To: <20170806213701.19317-1-christophe.jaillet@wanadoo.fr>
References: <20170806213701.19317-1-christophe.jaillet@wanadoo.fr>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA328@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Christophe JAILLET
> Sent: Sunday, August 6, 2017 2:37 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; kernel-janitors at vger.kernel.org; Christophe
> JAILLET <christophe.jaillet@wanadoo.fr>; intel-wired-lan at lists.osuosl.org;
> linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] i40e: Fix a potential NULL pointer
> dereference
> 
> If 'kzalloc()' fails, a NULL pointer will be dereferenced.
> Return an error code (-ENOMEM) instead.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


