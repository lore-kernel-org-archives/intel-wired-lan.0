From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 07 Jan 2016 22:54:43 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: fix merge bug
In-Reply-To: <1452128791-17584-1-git-send-email-jesse.brandeburg@intel.com>
References: <1452128791-17584-1-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <1452236083.19358.29.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-01-06 at 17:06 -0800, Jesse Brandeburg wrote:
> There was a bug (re-)introduced by a merge error when applying
> patches.
> This fixes the issue by making the code schedule the work item as
> originally intended for the fix included in commit 0e4425ed641f
> ("i40e:
> fix: do not sleep in netdev_ops") and broken in commit ea02e90b4b49
> ("i40e: propagate properly").
> 
> Fixes: ea02e90b4b49 ("i40e: propagate properly")
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> ?drivers/net/ethernet/intel/i40e/i40e_main.c | 6 +++++-
> ?1 file changed, 5 insertions(+), 1 deletion(-)

This does not apply because it is already fixed in the following patch
that was applied earlier:

commit e91a9d1345bf8a75b988e4bc01a32610ce76084c
Author: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date:???Thu Jan 7 22:47:29 2016 -0800

????i40e: fix: do not sleep in netdev_ops
????
????The driver was being called by vlan, bonding, teaming operations
????that expected to be able to hold locks like rcu_read_lock().
????
????This causes the driver to be held to the requirement to not sleep,
????and was found by the kernel debug options for checking sleep
????inside critical section, and the locking validator.
????
????Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
????Reviewed-by: Nelson, Shannon <shannon.nelson@intel.com>
????Change-ID: Ibc68c835f5ffa8ffe0638ffe910a66fc5649a7f7
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160107/a6c42164/attachment.asc>
