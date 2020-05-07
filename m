From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 May 2020 20:38:28 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: Remove unused inline
 function ixgbe_irq_disable_queues
In-Reply-To: <20200505083554.25808-1-yuehaibing@huawei.com>
References: <20200505083554.25808-1-yuehaibing@huawei.com>
Message-ID: <DM5PR11MB16593A317D17A0C8553ACE2D8CA50@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of YueHaibing
Sent: Tuesday, May 5, 2020 1:36 AM
To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net
Cc: netdev at vger.kernel.org; YueHaibing <yuehaibing@huawei.com>; intel-wired-lan at lists.osuosl.org; linux-kernel at vger.kernel.org
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: Remove unused inline function ixgbe_irq_disable_queues

commit b5f69ccf6765 ("ixgbe: avoid bringing rings up/down as macvlans are added/removed") left behind this, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 29 -------------------
 1 file changed, 29 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


