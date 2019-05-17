From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 17 May 2019 22:36:47 +0000
Subject: [Intel-wired-lan] [PATCH][next] i40e: mark expected switch
 fall-through
In-Reply-To: <20190501205541.GA17995@embeddedor>
References: <20190501205541.GA17995@embeddedor>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3DB7B9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Gustavo A. R. Silva
> Sent: Wednesday, May 1, 2019 1:56 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S. Miller
> <davem@davemloft.net>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org; Kees Cook <keescook@chromium.org>
> Subject: [Intel-wired-lan] [PATCH][next] i40e: mark expected switch fall-
> through
> 
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases where
> we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/net/ethernet/intel/i40e/i40e_xsk.c: In function ?i40e_run_xdp_zc?:
> drivers/net/ethernet/intel/i40e/i40e_xsk.c:217:3: warning: this statement
> may fall through [-Wimplicit-fallthrough=]
>    bpf_warn_invalid_xdp_action(act);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/i40e/i40e_xsk.c:218:2: note: here
>   case XDP_ABORTED:
>   ^~~~
> 
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases where
> we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


