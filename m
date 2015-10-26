From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 26 Oct 2015 16:30:51 +0000
Subject: [Intel-wired-lan] [next PATCH S19 05/15] i40e: Properly cast
 type	for arithmetic
In-Reply-To: <1445471236-35918-6-git-send-email-catherine.sullivan@intel.com>
References: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
 <1445471236-35918-6-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D3E77@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, October 21, 2015 4:47 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Helin
> Subject: [Intel-wired-lan] [next PATCH S19 05/15] i40e: Properly cast type for
> arithmetic
> 
> From: Helin Zhang <helin.zhang@intel.com>
> 
> Pointer of type void * shouldn't be used in arithmetic, which may result in
> compilation error. Casting of (u8 *) can be added to fix that.
> 
> Signed-off-by: Helin Zhang <helin.zhang@intel.com>
> Change-ID: I273aa57cdef7cacac5c552c348d585cd09d7e06b
> 
> ---
> Testing-hints: Patch just avoids a compile warning with cast to u8 *, so verify
> with gcc option:
> -Wpointer-arith like make -C /lib/modules/`uname -r`/build \
> M=driver/net/ethernet/intel EXTRA_CFLAGS=-Wpointer-arith Before this
> patch, there will be a warning on this line (among many
> others) - search for buff.va, and after it will be gone.
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, no compiler warning on afected code with -Wpointer-arith option
