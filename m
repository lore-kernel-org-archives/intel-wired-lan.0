From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 Jan 2018 19:33:51 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Delete an error message for a
 failed memory allocation in i40e_init_interrupt_scheme()
In-Reply-To: <c9c151e5-bd26-5b72-d26b-c153249811ab@users.sourceforge.net>
References: <c9c151e5-bd26-5b72-d26b-c153249811ab@users.sourceforge.net>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D72A7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of SF Markus Elfring
> Sent: Monday, January 1, 2018 11:44 AM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; Kirsher,
> Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: kernel-janitors at vger.kernel.org; LKML <linux-kernel@vger.kernel.org>
> Subject: [Intel-wired-lan] [PATCH] i40e: Delete an error message for a failed
> memory allocation in i40e_init_interrupt_scheme()
> 
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 1 Jan 2018 20:38:14 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


