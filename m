From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:29:44 +0000
Subject: [Intel-wired-lan] [PATCH v4 04/13] ice: Report stats for
 allocated queues via ethtool stats
In-Reply-To: <20180809132903.22819-5-anirudh.venkataramanan@intel.com>
References: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
 <20180809132903.22819-5-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD2619545A28@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, August 9, 2018 6:29 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v4 04/13] ice: Report stats for allocated
> queues via ethtool stats
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> It is not safe to have the string table for statistics change order or size over
> the lifetime of a given netdevice. This is because of the nature of the 3-step
> process for obtaining stats. First, userspace performs a request for the size of
> the strings table. Second it performs a separate request for the strings
> themselves, after allocating space for the table. Third, it requests the stats
> themselves, also allocating space for the table.
> 
> If the size decreased, there is potential to see garbage data or stats values. In
> the worst case, we could potentially see stats values become mis-aligned
> with their strings, so that it looks like a statistic is being reported differently
> than it actually is.
> 
> Even worse, if the size increased, there is potential that the strings table or
> stats table was not allocated large enough and the stats code could access
> and write to memory it should not, potentially resulting in undefined
> behavior and system crashes.
> 
> It isn't even safe if the size always changes under the RTNL lock. This is
> because the calls take place over multiple userspace commands, so it is not
> possible to hold the RTNL lock for the entire duration of obtaining strings and
> stats. Further, not all consumers of the ethtool API are the userspace ethtool
> program, and it is possible that one assumes the strings will not change (valid
> under the current contract), and thus only requests the stats values when
> requesting stats in a loop.
> 
> Finally, it's not possible in the general case to detect when the size changes,
> because it is quite possible that one value which could impact the stat size
> increased, while another decreased. This would result in the same total
> number of stats, but reordering them so that stats no longer line up with the
> strings they belong to. Since only size changes aren't enough, we would need
> some sort of hash or token to determine when the strings no longer match.
> This would require extending the ethtool stats commands, but there is no
> more space in the relevant structures.
> 
> The real solution to resolve this would be to add a completely new API for
> stats, probably over netlink.
> 
> In the ice driver, the only thing impacting the stats that is not constant is the
> number of queues. Instead of reporting stats for each used queue, report
> stats for each allocated queue. We do not change the number of queues
> allocated for a given netdevice, as we pass this into the alloc_etherdev_mq()
> function to set the num_tx_queues and num_rx_queues.
> 
> This resolves the potential bugs at the slight cost of displaying many queue
> statistics which will not be activated.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |  7 +++
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 52 +++++++++++++++-----
>  2 files changed, 46 insertions(+), 13 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


