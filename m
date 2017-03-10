From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri, 10 Mar 2017 12:22:03 -0800
Subject: [Intel-wired-lan] [next PATCH S62 4/6] i40e: Check for new arq
	elements before leaving the adminq subtask loop
In-Reply-To: <1489177325-13156-1-git-send-email-bimmy.pujari@intel.com>
References: <1489177325-13156-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1489177325-13156-5-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: "Christopher Bednarz" <christopher.n.bednarz@intel.com>

Fix a case where we miss an arq element if a new one is added before we
enable interrupts and exit the arq subtask loop. This occurs frequently
with Rdma running on Windows VF and causes long delays that prevent SMB
from establishing connections.

Signed-off-by: Christopher N Bednarz <christopher.n.bednarz@intel.com>
Change-ID: I3e1c8b2b960c12857d9b8275bea2c1563674392e
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 804f41a..bab9337 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6524,9 +6524,11 @@ static void i40e_clean_adminq_subtask(struct i40e_pf *pf)
 				 opcode);
 			break;
 		}
-	} while (pending && (i++ < pf->adminq_work_limit));
+	} while (i++ < pf->adminq_work_limit);
+
+	if (i < pf->adminq_work_limit)
+		clear_bit(__I40E_ADMINQ_EVENT_PENDING, &pf->state);
 
-	clear_bit(__I40E_ADMINQ_EVENT_PENDING, &pf->state);
 	/* re-enable Admin queue interrupt cause */
 	val = rd32(hw, I40E_PFINT_ICR0_ENA);
 	val |=  I40E_PFINT_ICR0_ENA_ADMINQ_MASK;
-- 
2.4.11

