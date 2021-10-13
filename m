From: Shiraz Saleem <shiraz.saleem@intel.com>
Date: Wed, 13 Oct 2021 11:22:41 -0500
Subject: [Intel-wired-lan] [net-next 3/3] RDMA/irdma: Set protocol based on
 PF rdma_mode flag
In-Reply-To: <20211013162241.689-1-shiraz.saleem@intel.com>
References: <20211013162241.689-1-shiraz.saleem@intel.com>
Message-ID: <20211013162241.689-4-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Set the RDMA protocol to use at driver bind time based on the ice PF's
rdma_mode flag.

Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index 51a4135..3fda7b7 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -228,7 +228,8 @@ static void irdma_fill_device_info(struct irdma_device *iwdev, struct ice_pf *pf
 	rf->msix_count =  pf->num_rdma_msix;
 	rf->msix_entries = &pf->msix_entries[pf->rdma_base_vector];
 	rf->default_vsi.vsi_idx = vsi->vsi_num;
-	rf->protocol_used = IRDMA_ROCE_PROTOCOL_ONLY;
+	rf->protocol_used = pf->rdma_mode & IIDC_RDMA_PROTOCOL_ROCEV2 ?
+			    IRDMA_ROCE_PROTOCOL_ONLY : IRDMA_IWARP_PROTOCOL_ONLY;
 	rf->rdma_ver = IRDMA_GEN_2;
 	rf->rsrc_profile = IRDMA_HMC_PROFILE_DEFAULT;
 	rf->rst_to = IRDMA_RST_TIMEOUT_HZ;
-- 
1.8.3.1

