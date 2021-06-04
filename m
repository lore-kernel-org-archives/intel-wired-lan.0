From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  4 Jun 2021 09:53:30 -0700
Subject: [Intel-wired-lan] [PATCH net-next 10/15] iavf: Add change MTU
 message
In-Reply-To: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
References: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
Message-ID: <20210604165335.33329-10-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Patryk Ma?ek <patryk.malek@intel.com>

Add a netdev_info log entry in case of a change of MTU so that user is
notified about this change in the same manner as in case of pf driver.

Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 2c639c7ebd1b..e7b9c64db3b5 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3364,6 +3364,8 @@ static int iavf_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 
+	netdev_info(netdev, "changing MTU from %d to %d\n",
+		    netdev->mtu, new_mtu);
 	netdev->mtu = new_mtu;
 	if (CLIENT_ENABLED(adapter)) {
 		iavf_notify_client_l2_params(&adapter->vsi);
-- 
2.20.1

