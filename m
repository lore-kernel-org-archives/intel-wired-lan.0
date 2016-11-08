From: Corinna Vinschen <vinschen@redhat.com>
Date: Tue, 8 Nov 2016 17:42:14 +0100
Subject: [Intel-wired-lan] [PATCH] igb: use igb_adapter->io_addr instead
 of e1000_hw->hw_addr
In-Reply-To: <1478588780-24480-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1478588780-24480-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Message-ID: <20161108164214.GF31855@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Nov  8 15:06, Cao jin wrote:
> When running as guest, under certain condition, it will oops as following.
> writel() in igb_configure_tx_ring() results in oops, because hw->hw_addr
> is NULL. While other register access won't oops kernel because they use
> wr32/rd32 which have a defense against NULL pointer.
> 
>     [  141.225449] pcieport 0000:00:1c.0: AER: Multiple Uncorrected (Fatal)
>     error received: id=0101
>     [  141.225523] igb 0000:01:00.1: PCIe Bus Error:
>     severity=Uncorrected (Fatal), type=Unaccessible,
>     id=0101(Unregistered Agent ID)
>     [  141.299442] igb 0000:01:00.1: broadcast error_detected message
>     [  141.300539] igb 0000:01:00.0 enp1s0f0: PCIe link lost, device now
>     detached
>     [  141.351019] igb 0000:01:00.1 enp1s0f1: PCIe link lost, device now
>     detached
>     [  143.465904] pcieport 0000:00:1c.0: Root Port link has been reset
>     [  143.465994] igb 0000:01:00.1: broadcast slot_reset message
>     [  143.466039] igb 0000:01:00.0: enabling device (0000 -> 0002)
>     [  144.389078] igb 0000:01:00.1: enabling device (0000 -> 0002)
>     [  145.312078] igb 0000:01:00.1: broadcast resume message
>     [  145.322211] BUG: unable to handle kernel paging request at
>     0000000000003818
>     [  145.361275] IP: [<ffffffffa02fd38d>]
>     igb_configure_tx_ring+0x14d/0x280 [igb]
>     [  145.400048] PGD 0
>     [  145.438007] Oops: 0002 [#1] SMP
> 
> A similiar issue & solution could be found at:
>     http://patchwork.ozlabs.org/patch/689592/
> 
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index edc9a6a..3f240ac 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -3390,7 +3390,7 @@ void igb_configure_tx_ring(struct igb_adapter *adapter,
>  	     tdba & 0x00000000ffffffffULL);
>  	wr32(E1000_TDBAH(reg_idx), tdba >> 32);
>  
> -	ring->tail = hw->hw_addr + E1000_TDT(reg_idx);
> +	ring->tail = adapter->io_addr + E1000_TDT(reg_idx);
>  	wr32(E1000_TDH(reg_idx), 0);
>  	writel(0, ring->tail);
>  
> @@ -3729,7 +3729,7 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
>  	     ring->count * sizeof(union e1000_adv_rx_desc));
>  
>  	/* initialize head and tail */
> -	ring->tail = hw->hw_addr + E1000_RDT(reg_idx);
> +	ring->tail = adapter->io_addr + E1000_RDT(reg_idx);
>  	wr32(E1000_RDH(reg_idx), 0);
>  	writel(0, ring->tail);
>  
> -- 
> 2.1.0

Incidentally we're just looking for a solution to that problem too.
Do three patches to fix the same problem at rougly the same time already
qualify as freak accident?

FTR, I attached my current patch, which I was planning to submit after
some external testing.

However, all three patches have one thing in common:  They workaround
a somewhat dubious resetting of the hardware address to NULL in case
reading from a register failed.

That makes me wonder if setting the hardware address to NULL in
rd32/igb_rd32 is really such a good idea.  It's performed in a function
which return value is *never* tested for validity in the calling
functions and leads to subsequent crashes since no tests for hw_addr ==
NULL are performed.

Maybe commit 22a8b2915 should be reconsidered?  Isn't there some more
graceful way to handle the "surprise removal"?


Thanks,
Corinna
-------------- next part --------------
From c6e80c04a7f20bdf3bde490ff842bcc1c800bf2a Mon Sep 17 00:00:00 2001
From: Corinna Vinschen <vinschen@redhat.com>
Date: Mon, 24 Oct 2016 16:44:55 +0200
Subject: [RHEL7.4 PATCH] igb_resume: Fix up hw_addr on resume

A suspend hanging for too long can trigger spurious reads.
The device is already suspended so igb_rd32 fails to read
and sets hw->hw_addr to NULL.  If we don't fix that here,
subsequent code will fail to write to HW registers and igb
crashes eventually in a writel call.

Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 8e96c35..d1f9d34 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7577,6 +7577,9 @@ static int igb_resume(struct device *dev)
 	pci_enable_wake(pdev, PCI_D3hot, 0);
 	pci_enable_wake(pdev, PCI_D3cold, 0);
 
+	if (E1000_REMOVED(hw->hw_addr) && adapter->io_addr)
+		hw->hw_addr = adapter->io_addr;
+
 	if (igb_init_interrupt_scheme(adapter, true)) {
 		dev_err(&pdev->dev, "Unable to allocate memory for queues\n");
 		return -ENOMEM;
-- 
2.5.5

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161108/6655b5b4/attachment.asc>
