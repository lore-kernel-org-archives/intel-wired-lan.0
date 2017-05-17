From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 17 May 2017 21:54:28 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Check for memory allocation
 failure
In-Reply-To: <20170505192913.4905-1-christophe.jaillet@wanadoo.fr>
References: <20170505192913.4905-1-christophe.jaillet@wanadoo.fr>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA3942@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Christophe JAILLET
> Sent: Friday, May 5, 2017 12:29 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: kernel-janitors at vger.kernel.org; Christophe JAILLET
> <christophe.jaillet@wanadoo.fr>; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] i40e: Check for memory allocation failure
> 
> If 'kzalloc' fails, a NULL pointer will be dereferenced. Return -ENOMEM
> instead.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
