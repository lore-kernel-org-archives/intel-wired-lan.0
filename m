From: kernelci.org bot <bot@kernelci.org>
Date: Wed, 07 Aug 2019 00:34:32 -0700 (PDT)
Subject: [Intel-wired-lan] net-next/master boot bisection:
 v5.3-rc1-460-g05bb520376af on meson-gxm-khadas-vim2
Message-ID: <5d4a7f08.1c69fb81.5cc82.1018@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

net-next/master boot bisection: v5.3-rc1-460-g05bb520376af on meson-gxm-khadas-vim2

Summary:
  Start:      05bb520376af Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue
  Details:    https://kernelci.org/boot/id/5d4a3a6759b51422d431b28d
  Plain log:  https://storage.kernelci.org//net-next/master/v5.3-rc1-460-g05bb520376af/arm64/defconfig/gcc-8/lab-baylibre/boot-meson-gxm-khadas-vim2.txt
  HTML log:   https://storage.kernelci.org//net-next/master/v5.3-rc1-460-g05bb520376af/arm64/defconfig/gcc-8/lab-baylibre/boot-meson-gxm-khadas-vim2.html
  Result:     b27223591606 i40e: verify string count matches even on early return

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       net-next
  URL:        git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
  Branch:     master
  Target:     meson-gxm-khadas-vim2
  CPU arch:   arm64
  Lab:        lab-baylibre
  Compiler:   gcc-8
  Config:     defconfig
  Test suite: boot

Breaking commit found:

-------------------------------------------------------------------------------
commit b27223591606f59c1f7c042b8e3dc74affadf492
Author: Jacob Keller <jacob.e.keller@intel.com>
Date:   Tue Jul 2 08:22:58 2019 -0400

    i40e: verify string count matches even on early return
    
    Similar to i40e_get_ethtool_stats, add a goto to verify that the data
    pointer for the strings lines up with the expected stats count. This
    helps ensure that bugs are not introduced when adding stats.
    
    Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
    Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
    Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index ceca57a261dc..01e4615b1b4b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2342,7 +2342,7 @@ static void i40e_get_stat_strings(struct net_device *netdev, u8 *data)
 	}
 
 	if (vsi != pf->vsi[pf->lan_vsi] || pf->hw.partition_id != 1)
-		return;
+		goto check_data_pointer;
 
 	i40e_add_stat_strings(&data, i40e_gstrings_veb_stats);
 
@@ -2354,6 +2354,7 @@ static void i40e_get_stat_strings(struct net_device *netdev, u8 *data)
 	for (i = 0; i < I40E_MAX_USER_PRIORITY; i++)
 		i40e_add_stat_strings(&data, i40e_gstrings_pfc_stats, i);
 
+check_data_pointer:
 	WARN_ONCE(data - p != i40e_get_stats_count(netdev) * ETH_GSTRING_LEN,
 		  "stat strings count mismatch!");
 }
-------------------------------------------------------------------------------


Git bisection log:

-------------------------------------------------------------------------------
git bisect start
# good: [9e8fb25254f76cb483303d8e9a97ed80a65418fe] Merge branch 'net-l3-l4-functional-tests'
git bisect good 9e8fb25254f76cb483303d8e9a97ed80a65418fe
# bad: [05bb520376af2c5146d3c44832c22ec3bb54d778] Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue
git bisect bad 05bb520376af2c5146d3c44832c22ec3bb54d778
# good: [c4ed52538cd012bd9dfe97beda6802454d367e70] Merge branch 'drop_monitor-Various-improvements-and-cleanups'
git bisect good c4ed52538cd012bd9dfe97beda6802454d367e70
# good: [fb1b775a247ee8d846152841f780eba6cb71bcfc] net: sched: add skbedit of ptype action to hardware IR
git bisect good fb1b775a247ee8d846152841f780eba6cb71bcfc
# good: [ef68de56c7ad6f708bee8db5e08b83013083e757] Merge branch 'Support-tunnels-over-VLAN-in-NFP'
git bisect good ef68de56c7ad6f708bee8db5e08b83013083e757
# good: [0969402fd5dd57268bb7547d7e5ece8fcd81157d] i40e: Update visual effect for advertised FEC mode.
git bisect good 0969402fd5dd57268bb7547d7e5ece8fcd81157d
# bad: [b27223591606f59c1f7c042b8e3dc74affadf492] i40e: verify string count matches even on early return
git bisect bad b27223591606f59c1f7c042b8e3dc74affadf492
# good: [b603f9dc20afed5e4666642c8713cafb94a23058] i40e: Log info when PF is entering and leaving Allmulti mode.
git bisect good b603f9dc20afed5e4666642c8713cafb94a23058
# first bad commit: [b27223591606f59c1f7c042b8e3dc74affadf492] i40e: verify string count matches even on early return
-------------------------------------------------------------------------------
