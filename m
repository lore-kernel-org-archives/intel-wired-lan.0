From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 05 Aug 2015 03:43:49 -0700
Subject: [Intel-wired-lan] [PATCH v2] e1000e: Modify tx/rx
 configurations to avoid null pointer dereferences in e1000_open
In-Reply-To: <1438769770-8887-1-git-send-email-baijiaju1990@163.com>
References: <1438769770-8887-1-git-send-email-baijiaju1990@163.com>
Message-ID: <1438771429.3467.28.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-08-05 at 18:16 +0800, Jia-Ju Bai wrote:
> When e1000e_setup_rx_resources is failed in e1000_open,
> e1000e_free_tx_resources in "err_setup_rx" segment is executed.
> "writel(0, tx_ring->head)" statement in e1000_clean_tx_ring
> in e1000e_free_tx_resources will cause a null poonter
> dereference(crash),
> because "tx_ring->head" is only assigned in e1000_configure_tx
> in e1000_configure, but it is after e1000e_setup_rx_resources.
> 
> This patch moves head/tail register writing to e1000_configure_tx/rx, 
> which can fix this problem. It is inspired by igb_configure_tx_ring 
> in the igb driver.
> 
> Specially, thank Alexander Duyck for his valuable suggestion.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c |   24
> ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Is your intention that this patch replace the existing patch:
http://patchwork.ozlabs.org/patch/502990/
...which is currently in my queue?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150805/c2d316fd/attachment-0001.asc>
