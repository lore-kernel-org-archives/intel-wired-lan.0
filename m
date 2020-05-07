From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 May 2020 20:51:53 +0000
Subject: [Intel-wired-lan] [PATCH net-next] i40e: Make
 i40e_shutdown_adminq() return void
In-Reply-To: <20200506061835.19662-1-yanaijie@huawei.com>
References: <20200506061835.19662-1-yanaijie@huawei.com>
Message-ID: <DM5PR11MB16594FEB630E54642174701B8CA50@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jason Yan
Sent: Tuesday, May 5, 2020 11:19 PM
To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net; Azarewicz, Piotr <piotr.azarewicz@intel.com>; intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-kernel at vger.kernel.org
Cc: Jason Yan <yanaijie@huawei.com>
Subject: [Intel-wired-lan] [PATCH net-next] i40e: Make i40e_shutdown_adminq() return void

Fix the following coccicheck warning:

drivers/net/ethernet/intel/i40e/i40e_adminq.c:699:13-21: Unneeded
variable: "ret_code". Return "0" on line 710

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c    | 6 +-----
 drivers/net/ethernet/intel/i40e/i40e_prototype.h | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


