From: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Date: Thu, 30 Aug 2018 21:09:55 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: mark expected switch
 fall-through
In-Reply-To: <20180830185019.GA30328@embeddedor.com>
References: <20180830185019.GA30328@embeddedor.com>
Message-ID: <61CC2BC414934749BD9F5BF3D5D94044950056B7@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Gustavo A. R. Silva [mailto:gustavo at embeddedor.com]
> Sent: Thursday, August 30, 2018 11:50
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S. Miller
> <davem@davemloft.net>
> Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; Gustavo A. R. Silva <gustavo@embeddedor.com>
> Subject: [PATCH] i40e: mark expected switch fall-through
> 
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases where
> we are expecting to fall through.
> 
> Addresses-Coverity-ID: 1473099 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I have picked this up Dave.
