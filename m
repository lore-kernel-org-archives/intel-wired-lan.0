From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed, 17 Aug 2016 16:04:08 -0700
Subject: [Intel-wired-lan] [next PATCH S43 3/3] i40evf: Open RDMA Client
	after reset
In-Reply-To: <1471475048-25835-1-git-send-email-bimmy.pujari@intel.com>
References: <1471475048-25835-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1471475048-25835-3-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Avinash Dayanand <avinash.dayanand@intel.com>

RDMA client is closed during the PF reset and needs to be opened again.
Setting the flag so that RDMA client is opened in watchdog() function.

Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
Change-ID: I507b1e4cbd05528cdff68fd360ef3dcac8901263
---
Testing Hints: Needs RDMA setup. Check if there is no error in opening
                RDMA client after PF reset.

 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index ed7a98e..bcdf568 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1808,6 +1808,8 @@ continue_reset:
 	}
 	adapter->aq_required |= I40EVF_FLAG_AQ_ADD_MAC_FILTER;
 	adapter->aq_required |= I40EVF_FLAG_AQ_ADD_VLAN_FILTER;
+	/* Open RDMA Client again */
+	adapter->aq_required |=	I40EVF_FLAG_SERVICE_CLIENT_REQUESTED;
 	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
 	i40evf_misc_irq_enable(adapter);
 
-- 
2.4.11

