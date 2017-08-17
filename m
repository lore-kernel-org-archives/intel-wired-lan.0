From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 16 Aug 2017 17:24:31 -0700
Subject: [Intel-wired-lan] [PATCH v2] i40e/i40evf: use cpumask_copy()
	for assigning cpumask
In-Reply-To: <20170816175257.9647-1-jgross@suse.com>
References: <20170816175257.9647-1-jgross@suse.com>
Message-ID: <1502929471.32783.2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2017-08-16 at 19:52 +0200, Juergen Gross wrote:
> Using direct assignment for a cpumask is wrong, cpumask_copy() should
> be used instead.
> 
> Otherwise crashes like the following might happen:
> 
> [62792.326374] BUG: unable to handle kernel paging request at
> ffff8800049ff000
> [62792.340118] IP: [<ffffffffa2043341>]
> i40e_irq_affinity_notify+0x11/0x20 [i40e]
> ...
> [62792.810770] Call Trace:
> [62792.815722]  [<ffffffff810d77a5>] irq_affinity_notify+0xb5/0xf0
> [62792.827593]  [<ffffffff8109593e>] process_one_work+0x14e/0x410
> [62792.839282]  [<ffffffff81096196>] worker_thread+0x116/0x490
> [62792.850459]  [<ffffffff8109b667>] kthread+0xc7/0xe0
> [62792.860255]  [<ffffffff816094bf>] ret_from_fork+0x3f/0x70
> [62792.871996] DWARF2 unwinder stuck at ret_from_fork+0x3f/0x70
> 
> Fixes: 96db776a3682 ("i40e/i40evf: fix interrupt affinity bug")
> Cc: <stable@vger.kernel.org> # 4.10+
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2: enhance commit message, merge patches
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 2 +-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

This is already resolved with a previous patch from Jacob Keller, see
the following commit in my tree:

commit f15ac286b0d111499e0fec4b50c8c870ad3b4573
Author: Jacob Keller <jacob.e.keller@intel.com>
Date:   Wed Aug 16 17:12:00 2017 -0700

    i40e: use cpumask_copy instead of direct assignment
    
    According to the header file cpumask.h, we shouldn't be directly
copying
    a cpumask_t, since its a bitmap and might not be copied correctly.
Lets
    use the provided cpumask_copy() function instead.
    
    Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170816/66d8c101/attachment.asc>
