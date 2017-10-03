From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 3 Oct 2017 22:17:17 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: make const array patterns
 static, reduces object code size
In-Reply-To: <20170922141138.13038-1-colin.king@canonical.com>
References: <20170922141138.13038-1-colin.king@canonical.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAB933@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Colin King
> Sent: Friday, September 22, 2017 7:12 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] i40e: make const array patterns static,
> reduces object code size
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate const array patterns on the stack, instead make it static.
> Makes the object code smaller by over 60 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>    1953	    496	      0	   2449	    991	i40e_diag.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>    1798	    584	      0	   2382	    94e	i40e_diag.o
> 
> (gcc 6.3.0, x86-64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_diag.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


