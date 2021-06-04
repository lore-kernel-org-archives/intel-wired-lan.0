From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  4 Jun 2021 09:48:56 -0700
Subject: [Intel-wired-lan] [PATCH net 4/8] iavf: Fix failure to exit out
 from last all-multicast mode
In-Reply-To: <20210604164900.33156-1-anthony.l.nguyen@intel.com>
References: <20210604164900.33156-1-anthony.l.nguyen@intel.com>
Message-ID: <20210604164900.33156-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Piotr Marczak <piotr.marczak@intel.com>

The driver could only quit allmulti when allmulti and promisc modes are
turn on at the same time. If promisc had been off there was no way to turn
off allmulti mode.
The patch corrects this behavior. Switching allmulti does not depends on
promisc state mode anymore

Fixes: f42a5c74da99 ("i40e: Add allmulti support for the VF")
Signed-off-by: Piotr Marczak <piotr.marczak@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 58624be64010..ffffb6e0a6c1 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1613,8 +1613,7 @@ static int iavf_process_aq_command(struct iavf_adapter *adapter)
 		iavf_set_promiscuous(adapter, FLAG_VF_MULTICAST_PROMISC);
 		return 0;
 	}
-
-	if ((adapter->aq_required & IAVF_FLAG_AQ_RELEASE_PROMISC) &&
+	if ((adapter->aq_required & IAVF_FLAG_AQ_RELEASE_PROMISC) ||
 	    (adapter->aq_required & IAVF_FLAG_AQ_RELEASE_ALLMULTI)) {
 		iavf_set_promiscuous(adapter, 0);
 		return 0;
-- 
2.20.1

