From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 May 2020 20:39:19 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: Remove conversion to
 bool in ixgbe_device_supports_autoneg_fc()
In-Reply-To: <20200505074157.40938-1-yanaijie@huawei.com>
References: <20200505074157.40938-1-yanaijie@huawei.com>
Message-ID: <DM5PR11MB16593FCAC4EB2174D93F8ADC8CA50@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jason Yan
Sent: Tuesday, May 5, 2020 12:42 AM
To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net; intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-kernel at vger.kernel.org
Cc: Jason Yan <yanaijie@huawei.com>
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: Remove conversion to bool in ixgbe_device_supports_autoneg_fc()

No need to convert '==' expression to bool. This fixes the following coccicheck warning:

drivers/net/ethernet/intel/ixgbe/ixgbe_common.c:68:11-16: WARNING:
conversion to bool not needed here

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


