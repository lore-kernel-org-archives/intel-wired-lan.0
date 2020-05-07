From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 May 2020 20:42:45 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: Use true,
 false for bool variable in __ixgbe_enable_sriov()
In-Reply-To: <20200505074337.21477-1-yanaijie@huawei.com>
References: <20200505074337.21477-1-yanaijie@huawei.com>
Message-ID: <DM5PR11MB16599DCBE62862ADE61E6BBE8CA50@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jason Yan
Sent: Tuesday, May 5, 2020 12:44 AM
To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net; ast at kernel.org; daniel at iogearbox.net; kuba at kernel.org; hawk at kernel.org; john.fastabend at gmail.com; intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-kernel at vger.kernel.org; bpf at vger.kernel.org
Cc: Jason Yan <yanaijie@huawei.com>
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: Use true, false for bool variable in __ixgbe_enable_sriov()

Fix the following coccicheck warning:

drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c:105:2-38: WARNING:
Assignment of 0/1 to bool variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


