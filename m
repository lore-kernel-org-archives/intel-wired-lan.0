From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 4 Jan 2016 12:02:05 -0800
Subject: [Intel-wired-lan] [next PATCH S26 06/12] i40e: fix: do not
	sleep in netdev_ops
In-Reply-To: <1451932392-15538-7-git-send-email-deepthi.kavalur@intel.com>
References: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
 <1451932392-15538-7-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <20160104120205.00000b51@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 4 Jan 2016 10:33:06 -0800
Deepthi Kavalur <deepthi.kavalur@intel.com> wrote:

> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The driver was being called by vlan, bonding, teaming operations
> that expected to be able to hold locks like rcu_read_lock().
> 
> This causes the driver to be held to the requirement to not sleep,
> and was found by the kernel debug options for checking sleep
> inside critical section, and the locking validator.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Nelson, Shannon <shannon.nelson@intel.com>
> Change-ID: Ibc68c835f5ffa8ffe0638ffe910a66fc5649a7f7

I don't understand how you ever applied this in your testing and built
a kernel, as this change (the complete version) was already applied in
Jeff's tree back on 2-Dec:
https://git.kernel.org/cgit/linux/kernel/git/jkirsher/next-queue.git/commit/drivers/net/ethernet/intel/i40e?id=0e4425ed641f3eef67c892bc541949cd745a9ba9

Likely this patch can just be dropped, but we need a process check here.
