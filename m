From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 02 Dec 2016 11:44:54 -0800
Subject: [Intel-wired-lan] [PATCH v2] ethernet: intel: Replace
 pci_pool_alloc by pci_pool_zalloc
In-Reply-To: <20161201190427.GA3357@jordon-HP-15-Notebook-PC>
References: <20161201190427.GA3357@jordon-HP-15-Notebook-PC>
Message-ID: <1480707894.2415.16.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2016-12-02 at 00:34 +0530, Souptick Joarder wrote:
> In e100_alloc_cbs(), pci_pool_alloc() followed by memset will be
> replaced by pci_pool_zalloc()
> 
> Signed-off-by: Souptick joarder <jrdr.linux@gmail.com>

Why the change?  Is pci_pool_alloc() being deprecated?  I ask because this
is a very old driver and changes will cause a huge regression, where many
of the parts/NICs may not be available to test with.

> ---
> v2:
> ? - Alignment changes
> 
> ?drivers/net/ethernet/intel/e100.c | 5 ++---
> ?1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e100.c
> b/drivers/net/ethernet/intel/e100.c
> index 068789e..0cf338f 100644
> --- a/drivers/net/ethernet/intel/e100.c
> +++ b/drivers/net/ethernet/intel/e100.c
> @@ -1910,11 +1910,10 @@ static int e100_alloc_cbs(struct nic *nic)
> ?	nic->cb_to_use = nic->cb_to_send = nic->cb_to_clean = NULL;
> ?	nic->cbs_avail = 0;
> 
> -	nic->cbs = pci_pool_alloc(nic->cbs_pool, GFP_KERNEL,
> -				??&nic->cbs_dma_addr);
> +	nic->cbs = pci_pool_zalloc(nic->cbs_pool, GFP_KERNEL,
> +				???&nic->cbs_dma_addr);
> ?	if (!nic->cbs)
> ?		return -ENOMEM;
> -	memset(nic->cbs, 0, count * sizeof(struct cb));
> 
> ?	for (cb = nic->cbs, i = 0; i < count; cb++, i++) {
> ?		cb->next = (i + 1 < count) ? cb + 1 : nic->cbs;
> --
> 1.9.1
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161202/6f139877/attachment-0001.asc>
