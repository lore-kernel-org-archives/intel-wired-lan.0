From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 8 Oct 2018 18:38:44 +0000
Subject: [Intel-wired-lan] [PATCH][-next] ixgbe: don't clear_bit on
 xdp_ring->state if xdp_ring is null
In-Reply-To: <20181004175732.28329-1-colin.king@canonical.com>
References: <20181004175732.28329-1-colin.king@canonical.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FD5EB@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Colin King
> Sent: Thursday, October 4, 2018 10:58 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S . Miller
> <davem@davemloft.net>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH][-next] ixgbe: don't clear_bit on xdp_ring-
> >state if xdp_ring is null
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is an earlier check to see if xdp_ring is null when configuring the tx ring,
> so assuming that it can still be null, the clearing of the xdp_ring->state
> currently could end up with a null pointer dereference.  Fix this by only
> clearing the bit if xdp_ring is not null.
> 
> Detected by CoverityScan, CID#1473795 ("Dereference after null check")
> 
> Fixes: 024aa5800f32 ("ixgbe: added Rx/Tx ring disable/enable functions")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


