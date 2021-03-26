From: Switzer, David <david.switzer@intel.com>
Date: Fri, 26 Mar 2021 23:53:18 +0000
Subject: [Intel-wired-lan] [PATCH] net: intel: Remove unused function
 pointer typedef ixgbe_mc_addr_itr
In-Reply-To: <1613390698-3637-1-git-send-email-chen45464546@163.com>
References: <1613390698-3637-1-git-send-email-chen45464546@163.com>
Message-ID: <MW3PR11MB4748E41F960FFD9288486D53EB619@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



>-----Original Message-----
>From: Chen Lin <chen45464546@163.com>
>Sent: Monday, February 15, 2021 4:05 AM
To: davem@davemloft.net; kuba at kernel.org
>Cc: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
><anthony.l.nguyen@intel.com>; intel-wired-lan at lists.osuosl.org;
>netdev at vger.kernel.org; linux-kernel at vger.kernel.org; Chen Lin
><chen.lin5@zte.com.cn>
>Subject: [PATCH] net: intel: Remove unused function pointer typedef
>ixgbe_mc_addr_itr
>
>From: Chen Lin <chen.lin5@zte.com.cn>
>
>Remove the 'ixgbe_mc_addr_itr' typedef as it is not used.
>
>Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
>---
> drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    4 ----
> drivers/net/ethernet/intel/ixgbevf/vf.h       |    3 ---
> 2 files changed, 7 deletions(-)
>
Tested-by: Dave Switzer <david.switzer@intel.com>
