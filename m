From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 25 Jan 2016 22:17:15 +0000
Subject: [Intel-wired-lan] [next PATCH S28 05/15] i40e: Add a SW
 workaround	for lost Interrupts
In-Reply-To: <1452897202-15204-6-git-send-email-joshua.a.hay@intel.com>
References: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
 <1452897202-15204-6-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C4A3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Friday, January 15, 2016 2:33 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S28 05/15] i40e: Add a SW
> workaround for lost Interrupts
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> This patch adds a workaround for cases where we might have interrupts that
> got lost but WB happened.
> If that happens without this patch we will see a tx_timeout.
> To work around it, this patch goes ahead and reschedules napi in that
> situation, if napi is not already scheduled.
> We also add a counter in ethtool to keep track of when we detect a case of
> tx_lost_interrupt.
> 
> Note: napi_reschedule() can be safely called from process/service_task
> context and is done in other drivers as well without an issue.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: I00f98f1ce3774524d9421227652bef20fcbd0d20
> ---
> Testing Hints: See if some more cases of tx_timeout go away from X722 and
> even fortville. Particulary the case where HWB=TAIL as seen in the dmesg
> logs when the tx_timeout happens.
> 
>  drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 32 ++++++++++++++++-----

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, hammered cards with traffic, observed no tx_timout and a handful of lost_interrupts with ~1hr of traffic on fortville, no timeouts/lost interrupts on X722
