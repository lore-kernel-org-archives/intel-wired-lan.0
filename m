From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  6 Feb 2017 14:38:41 -0800
Subject: [Intel-wired-lan] [PART1 PATCH 04/11] i40e: return immediately when
	failing to add fdir filter
In-Reply-To: <20170206223846.31052-1-jacob.e.keller@intel.com>
References: <20170206223846.31052-1-jacob.e.keller@intel.com>
Message-ID: <20170206223846.31052-5-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Instead of setting err=true and checking this to determine when to free
the raw_packet near the end of the function, simply kfree and return
immediately. The resulting code is a bit cleaner and has one less
variable. This also resolves a subtle bug in the ipv4 case which could
fail to add the first filter and then never free the memory, resulting
in a small memory leak.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Dayanand, Avinash <avinash.dayanand@intel.com>
Reviewed-by: Brady, Alan <alan.brady@intel.com>
Reviewed-by: Williams, Mitch A <mitch.a.williams@intel.com>
Change-ID: I7583aac033481dc794b4acaa14445059c8930ff1
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 33 ++++++++++++-----------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 3b0c9364763e..8924ee6e7773 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -204,7 +204,6 @@ static int i40e_add_del_fdir_udpv4(struct i40e_vsi *vsi,
 	struct i40e_pf *pf = vsi->back;
 	struct udphdr *udp;
 	struct iphdr *ip;
-	bool err = false;
 	u8 *raw_packet;
 	int ret;
 	static char packet[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x08, 0,
@@ -231,7 +230,9 @@ static int i40e_add_del_fdir_udpv4(struct i40e_vsi *vsi,
 		dev_info(&pf->pdev->dev,
 			 "PCTYPE:%d, Filter command send failed for fd_id:%d (ret = %d)\n",
 			 fd_data->pctype, fd_data->fd_id, ret);
-		err = true;
+		/* Free the packet buffer since it wasn't added to the ring */
+		kfree(raw_packet);
+		return -EOPNOTSUPP;
 	} else if (I40E_DEBUG_FD & pf->hw.debug_mask) {
 		if (add)
 			dev_info(&pf->pdev->dev,
@@ -242,10 +243,8 @@ static int i40e_add_del_fdir_udpv4(struct i40e_vsi *vsi,
 				 "Filter deleted for PCTYPE %d loc = %d\n",
 				 fd_data->pctype, fd_data->fd_id);
 	}
-	if (err)
-		kfree(raw_packet);
 
-	return err ? -EOPNOTSUPP : 0;
+	return 0;
 }
 
 #define I40E_TCPIP_DUMMY_PACKET_LEN 54
@@ -264,7 +263,6 @@ static int i40e_add_del_fdir_tcpv4(struct i40e_vsi *vsi,
 	struct i40e_pf *pf = vsi->back;
 	struct tcphdr *tcp;
 	struct iphdr *ip;
-	bool err = false;
 	u8 *raw_packet;
 	int ret;
 	/* Dummy packet */
@@ -306,12 +304,13 @@ static int i40e_add_del_fdir_tcpv4(struct i40e_vsi *vsi,
 
 	fd_data->pctype = I40E_FILTER_PCTYPE_NONF_IPV4_TCP;
 	ret = i40e_program_fdir_filter(fd_data, raw_packet, pf, add);
-
 	if (ret) {
 		dev_info(&pf->pdev->dev,
 			 "PCTYPE:%d, Filter command send failed for fd_id:%d (ret = %d)\n",
 			 fd_data->pctype, fd_data->fd_id, ret);
-		err = true;
+		/* Free the packet buffer since it wasn't added to the ring */
+		kfree(raw_packet);
+		return -EOPNOTSUPP;
 	} else if (I40E_DEBUG_FD & pf->hw.debug_mask) {
 		if (add)
 			dev_info(&pf->pdev->dev, "Filter OK for PCTYPE %d loc = %d)\n",
@@ -322,10 +321,7 @@ static int i40e_add_del_fdir_tcpv4(struct i40e_vsi *vsi,
 				 fd_data->pctype, fd_data->fd_id);
 	}
 
-	if (err)
-		kfree(raw_packet);
-
-	return err ? -EOPNOTSUPP : 0;
+	return 0;
 }
 
 #define I40E_IP_DUMMY_PACKET_LEN 34
@@ -344,7 +340,6 @@ static int i40e_add_del_fdir_ipv4(struct i40e_vsi *vsi,
 {
 	struct i40e_pf *pf = vsi->back;
 	struct iphdr *ip;
-	bool err = false;
 	u8 *raw_packet;
 	int ret;
 	int i;
@@ -366,12 +361,15 @@ static int i40e_add_del_fdir_ipv4(struct i40e_vsi *vsi,
 
 		fd_data->pctype = i;
 		ret = i40e_program_fdir_filter(fd_data, raw_packet, pf, add);
-
 		if (ret) {
 			dev_info(&pf->pdev->dev,
 				 "PCTYPE:%d, Filter command send failed for fd_id:%d (ret = %d)\n",
 				 fd_data->pctype, fd_data->fd_id, ret);
-			err = true;
+			/* The packet buffer wasn't added to the ring so we
+			 * need to free it now.
+			 */
+			kfree(raw_packet);
+			return -EOPNOTSUPP;
 		} else if (I40E_DEBUG_FD & pf->hw.debug_mask) {
 			if (add)
 				dev_info(&pf->pdev->dev,
@@ -384,10 +382,7 @@ static int i40e_add_del_fdir_ipv4(struct i40e_vsi *vsi,
 		}
 	}
 
-	if (err)
-		kfree(raw_packet);
-
-	return err ? -EOPNOTSUPP : 0;
+	return 0;
 }
 
 /**
-- 
2.12.0.rc0.151.g8a5726c42288

