From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 17:55:57 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: use a local variable for the
 frag pointer
In-Reply-To: <20190723160848.1006-1-jacob.e.keller@intel.com>
References: <20190723160848.1006-1-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40EA1B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Tuesday, July 23, 2019 9:09 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH] fm10k: use a local variable for the frag
> pointer
> 
> In the function fm10k_xmit_frame_ring, we recently switched to using the
> skb_frag_size accessor instead of directly using the size member of the skb
> fragment.
> 
> This made the for loop slightly harder to read because it created a very long
> line that is difficult to split up. Avoid this by using a local variable in the for
> loop, so that we do not have to break the line on an open parenthesis.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


