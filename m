From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 9 Jan 2020 01:01:05 +0000
Subject: [Intel-wired-lan] [PATCH] net: intel: e1000e: fix possible
 sleep-in-atomic-context bugs in e1000e_get_hw_semaphore()
In-Reply-To: <20191218141656.12416-1-baijiaju1990@gmail.com>
References: <20191218141656.12416-1-baijiaju1990@gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971A925B@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org <netdev-owner@vger.kernel.org>
> On Behalf Of Jia-Ju Bai
> Sent: Wednesday, December 18, 2019 6:17 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net
> Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; Jia-Ju Bai <baijiaju1990@gmail.com>
> Subject: [PATCH] net: intel: e1000e: fix possible sleep-in-atomic-context bugs
> in e1000e_get_hw_semaphore()
> 
> The driver may sleep while holding a spinlock.
> The function call path (from bottom to top) in Linux 4.19 is:
> 
> drivers/net/ethernet/intel/e1000e/mac.c, 1366:
> 	usleep_range in e1000e_get_hw_semaphore
> drivers/net/ethernet/intel/e1000e/80003es2lan.c, 322:
> 	e1000e_get_hw_semaphore in
> e1000_release_swfw_sync_80003es2lan
> drivers/net/ethernet/intel/e1000e/80003es2lan.c, 197:
> 	e1000_release_swfw_sync_80003es2lan in
> e1000_release_phy_80003es2lan
> drivers/net/ethernet/intel/e1000e/netdev.c, 4883:
> 	(FUNC_PTR) e1000_release_phy_80003es2lan in
> e1000e_update_phy_stats
> drivers/net/ethernet/intel/e1000e/netdev.c, 4917:
> 	e1000e_update_phy_stats in e1000e_update_stats
> drivers/net/ethernet/intel/e1000e/netdev.c, 5945:
> 	e1000e_update_stats in e1000e_get_stats64
> drivers/net/ethernet/intel/e1000e/netdev.c, 5944:
> 	spin_lock in e1000e_get_stats64
> 
> drivers/net/ethernet/intel/e1000e/mac.c, 1384:
> 	usleep_range in e1000e_get_hw_semaphore
> drivers/net/ethernet/intel/e1000e/80003es2lan.c, 322:
> 	e1000e_get_hw_semaphore in
> e1000_release_swfw_sync_80003es2lan
> drivers/net/ethernet/intel/e1000e/80003es2lan.c, 197:
> 	e1000_release_swfw_sync_80003es2lan in
> e1000_release_phy_80003es2lan
> drivers/net/ethernet/intel/e1000e/netdev.c, 4883:
> 	(FUNC_PTR) e1000_release_phy_80003es2lan in
> e1000e_update_phy_stats
> drivers/net/ethernet/intel/e1000e/netdev.c, 4917:
> 	e1000e_update_phy_stats in e1000e_update_stats
> drivers/net/ethernet/intel/e1000e/netdev.c, 5945:
> 	e1000e_update_stats in e1000e_get_stats64
> drivers/net/ethernet/intel/e1000e/netdev.c, 5944:
> 	spin_lock in e1000e_get_stats64
> 
> (FUNC_PTR) means a function pointer is called.
> 
> To fix these bugs, usleep_range() is replaced with udelay().
> 
> These bugs are found by a static analysis tool STCheck written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000e/mac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

