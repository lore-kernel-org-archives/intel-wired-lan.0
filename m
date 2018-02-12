From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 12 Feb 2018 17:47:34 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix crash in build_skb Rx code
 path
In-Reply-To: <20180207222306.30003.49713.stgit@localhost6.localdomain6>
References: <20180207222306.30003.49713.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A949DF4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Wednesday, February 7, 2018 2:23 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: fix crash in build_skb Rx code path
> 
> Add check for build_skb enabled ring in ixgbe_dma_sync_frag().
> In that case &skb_shinfo(skb)->frags[0] may not always be set which can
> lead to a crash. Instead we derive the page offset from skb->data.
> 
> Fixes: 42073d91a214
> ("ixgbe: Have the CPU take ownership of the buffers sooner")
> Reported-by: Ambarish Soman <asoman@redhat.com>
> Suggested-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    8 ++++++++
>  1 file changed, 8 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


