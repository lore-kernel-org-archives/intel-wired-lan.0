From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 18 Aug 2015 14:34:28 -0700
Subject: [Intel-wired-lan] [Patch V3 6/9] i40evf: Use numa_mem_id() to
 better support memoryless node
In-Reply-To: <4197C471DCF8714FBA1FE32565271C148FFF786A@ORSMSX103.amr.corp.intel.com>
References: <1439781546-7217-1-git-send-email-jiang.liu@linux.intel.com>
 <1439781546-7217-7-git-send-email-jiang.liu@linux.intel.com>
 <4197C471DCF8714FBA1FE32565271C148FFF786A@ORSMSX103.amr.corp.intel.com>
Message-ID: <1439933668.3006.20.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2015-08-17 at 12:03 -0700, Patil, Kiran wrote:
> ACK.
> 

Just an FYI, top posting is frowned upon in the Linux public mailing
lists.  Also, if you really want your ACK to be added to the patch, you
need to reply with:

Acked-by: Kiran Patil <kiran.patil@intel.com>

> -----Original Message-----
> From: Intel-wired-lan
> [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jiang
> Liu
> Sent: Sunday, August 16, 2015 8:19 PM
> To: Andrew Morton; Mel Gorman; David Rientjes; Mike Galbraith; Peter
> Zijlstra; Wysocki, Rafael J; Tang Chen; Tejun Heo; Kirsher, Jeffrey T;
> Brandeburg, Jesse; Nelson, Shannon; Wyborny, Carolyn; Skidmore, Donald
> C; Vick, Matthew; Ronciak, John; Williams, Mitch A
> Cc: Luck, Tony; netdev at vger.kernel.org; x86 at kernel.org;
> linux-hotplug at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-mm at kvack.org; intel-wired-lan at lists.osuosl.org; Jiang Liu
> Subject: [Intel-wired-lan] [Patch V3 6/9] i40evf: Use numa_mem_id() to
> better support memoryless node
> 
> Function i40e_clean_rx_irq() tries to reuse memory pages allocated
> from the nearest node. To better support memoryless node, use
> numa_mem_id() instead of numa_node_id() to get the nearest node with
> memory.
> 
> This change should only affect performance.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150818/8de40d76/attachment.asc>
