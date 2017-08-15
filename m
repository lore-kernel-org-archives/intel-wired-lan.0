From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 15 Aug 2017 23:13:18 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: restore normal RSS
 after	last macvlan offload is removed
In-Reply-To: <1502812794-452204-1-git-send-email-shannon.nelson@oracle.com>
References: <1502812794-452204-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10E90B2F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shannon Nelson
> Sent: Tuesday, August 15, 2017 9:00 AM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Cc: davem at davemloft.net
> Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: restore normal RSS after
> last macvlan offload is removed
> 
> Just like when the last VF is removed, we need to restore normal operations
> after the last macvlan offload is removed, else we get stuck in single queue
> operations.
> 
> To test:
> ethtool -l eth1   # note the number of queues in use, ~= cpus
> 
> ethtool -K eth1 l2-fwd-offload on
> ip link add mv1 link eth1 type macvlan mode bridge ip link set dev mv1 up ip
> link del mv1
> 
> ethtool -l eth1   # are we back to the same # of queues, or stuck on 1?
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


