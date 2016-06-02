From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 02 Jun 2016 14:01:35 -0700
Subject: [Intel-wired-lan] [PATCH v2 5/6] ethernet/intel: Use
 pci_(request|release)_mem_regions
In-Reply-To: <e15aedde3b7d8b301b9ca6197f8d39d4076c9c86.1464795082.git.jthumshirn@suse.de>
References: <cover.1464795082.git.jthumshirn@suse.de>
 <e15aedde3b7d8b301b9ca6197f8d39d4076c9c86.1464795082.git.jthumshirn@suse.de>
Message-ID: <1464901295.2736.29.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2016-06-02 at 09:30 +0200, Johannes Thumshirn wrote:
> Now that we do have pci_request_mem_regions() and
> pci_release_mem_regions() at
> hand, use it in the Intel ethernet drivers.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: netdev at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: intel-wired-lan at lists.osuosl.org

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

> ---
> ?drivers/net/ethernet/intel/e1000e/netdev.c??? |? 6 ++----
> ?drivers/net/ethernet/intel/fm10k/fm10k_pci.c? | 11 +++--------
> ?drivers/net/ethernet/intel/i40e/i40e_main.c?? |? 9 +++------
> ?drivers/net/ethernet/intel/igb/igb_main.c???? | 10 +++-------
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |? 9 +++------
> ?5 files changed, 14 insertions(+), 31 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160602/cb4ecd88/attachment.asc>
