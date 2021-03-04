From: Coiby Xu <coxu@redhat.com>
Date: Thu,  4 Mar 2021 10:55:42 +0800
Subject: [Intel-wired-lan] [PATCH v1 2/3] i40e: use minimal rx and tx ring
 buffers for kdump
In-Reply-To: <20210304025543.334912-1-coxu@redhat.com>
References: <20210304025543.334912-1-coxu@redhat.com>
Message-ID: <20210304025543.334912-3-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use the minimum of the number of descriptors thus we will allocate the
minimal ring buffers for kdump.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 77bf8c392750..d6868c7aee05 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11029,6 +11029,11 @@ static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
 		return -ENODATA;
 	}
 
+	if (is_kdump_kernel()) {
+		vsi->num_tx_desc = I40E_MIN_NUM_DESCRIPTORS;
+		vsi->num_rx_desc = I40E_MIN_NUM_DESCRIPTORS;
+	}
+
 	return 0;
 }
 
-- 
2.30.1

