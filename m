From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 12 Sep 2016 14:18:42 -0700
Subject: [Intel-wired-lan] [next PATCH S46 6/8] i40e: Strip out debugfs hook
	for Flow Director filter programming
In-Reply-To: <1473715124-31296-1-git-send-email-bimmy.pujari@intel.com>
References: <1473715124-31296-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1473715124-31296-7-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This  interface was only ever meant for debug only. Since it is not
supposed to be here we are removing it.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Change-ID: Id771a1e5e7d3e2b4b7f56591b61fb48c921e1d04
---
Testing Hints:
        Verify the "add fd_filter" and "rem fd_filter" functionality
        and all references to it have been removed.

 drivers/net/ethernet/intel/i40e/i40e.h         |  2 -
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 80 --------------------------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    |  5 +-
 3 files changed, 3 insertions(+), 84 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index ca2d317..dfc52a9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -714,8 +714,6 @@ struct rtnl_link_stats64 *i40e_get_vsi_stats_struct(struct i40e_vsi *vsi);
 int i40e_fetch_switch_configuration(struct i40e_pf *pf,
 				    bool printconfig);
 
-int i40e_program_fdir_filter(struct i40e_fdir_filter *fdir_data, u8 *raw_packet,
-			     struct i40e_pf *pf, bool add);
 int i40e_add_del_fdir(struct i40e_vsi *vsi,
 		      struct i40e_fdir_filter *input, bool add);
 void i40e_fdir_check_and_reenable(struct i40e_pf *pf);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 05cf9a7..435b96c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -1425,84 +1425,6 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 		buff = NULL;
 		kfree(desc);
 		desc = NULL;
-	} else if ((strncmp(cmd_buf, "add fd_filter", 13) == 0) ||
-		   (strncmp(cmd_buf, "rem fd_filter", 13) == 0)) {
-		struct i40e_fdir_filter fd_data;
-		u16 packet_len, i, j = 0;
-		char *asc_packet;
-		u8 *raw_packet;
-		bool add = false;
-		int ret;
-
-		if (!(pf->flags & I40E_FLAG_FD_SB_ENABLED))
-			goto command_write_done;
-
-		if (strncmp(cmd_buf, "add", 3) == 0)
-			add = true;
-
-		if (add && (pf->auto_disable_flags & I40E_FLAG_FD_SB_ENABLED))
-			goto command_write_done;
-
-		asc_packet = kzalloc(I40E_FDIR_MAX_RAW_PACKET_SIZE,
-				     GFP_KERNEL);
-		if (!asc_packet)
-			goto command_write_done;
-
-		raw_packet = kzalloc(I40E_FDIR_MAX_RAW_PACKET_SIZE,
-				     GFP_KERNEL);
-
-		if (!raw_packet) {
-			kfree(asc_packet);
-			asc_packet = NULL;
-			goto command_write_done;
-		}
-
-		cnt = sscanf(&cmd_buf[13],
-			     "%hx %2hhx %2hhx %hx %2hhx %2hhx %hx %x %hd %511s",
-			     &fd_data.q_index,
-			     &fd_data.flex_off, &fd_data.pctype,
-			     &fd_data.dest_vsi, &fd_data.dest_ctl,
-			     &fd_data.fd_status, &fd_data.cnt_index,
-			     &fd_data.fd_id, &packet_len, asc_packet);
-		if (cnt != 10) {
-			dev_info(&pf->pdev->dev,
-				 "program fd_filter: bad command string, cnt=%d\n",
-				 cnt);
-			kfree(asc_packet);
-			asc_packet = NULL;
-			kfree(raw_packet);
-			goto command_write_done;
-		}
-
-		/* fix packet length if user entered 0 */
-		if (packet_len == 0)
-			packet_len = I40E_FDIR_MAX_RAW_PACKET_SIZE;
-
-		/* make sure to check the max as well */
-		packet_len = min_t(u16,
-				   packet_len, I40E_FDIR_MAX_RAW_PACKET_SIZE);
-
-		for (i = 0; i < packet_len; i++) {
-			cnt = sscanf(&asc_packet[j], "%2hhx ", &raw_packet[i]);
-			if (!cnt)
-				break;
-			j += 3;
-		}
-		dev_info(&pf->pdev->dev, "FD raw packet dump\n");
-		print_hex_dump(KERN_INFO, "FD raw packet: ",
-			       DUMP_PREFIX_OFFSET, 16, 1,
-			       raw_packet, packet_len, true);
-		ret = i40e_program_fdir_filter(&fd_data, raw_packet, pf, add);
-		if (!ret) {
-			dev_info(&pf->pdev->dev, "Filter command send Status : Success\n");
-		} else {
-			dev_info(&pf->pdev->dev,
-				 "Filter command send failed %d\n", ret);
-		}
-		kfree(raw_packet);
-		raw_packet = NULL;
-		kfree(asc_packet);
-		asc_packet = NULL;
 	} else if (strncmp(cmd_buf, "fd current cnt", 14) == 0) {
 		dev_info(&pf->pdev->dev, "FD current total filter count for this interface: %d\n",
 			 i40e_get_current_fd_count(pf));
@@ -1727,8 +1649,6 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 		dev_info(&pf->pdev->dev, "  globr\n");
 		dev_info(&pf->pdev->dev, "  send aq_cmd <flags> <opcode> <datalen> <retval> <cookie_h> <cookie_l> <param0> <param1> <param2> <param3>\n");
 		dev_info(&pf->pdev->dev, "  send indirect aq_cmd <flags> <opcode> <datalen> <retval> <cookie_h> <cookie_l> <param0> <param1> <param2> <param3> <buffer_len>\n");
-		dev_info(&pf->pdev->dev, "  add fd_filter <dest q_index> <flex_off> <pctype> <dest_vsi> <dest_ctl> <fd_status> <cnt_index> <fd_id> <packet_len> <packet>\n");
-		dev_info(&pf->pdev->dev, "  rem fd_filter <dest q_index> <flex_off> <pctype> <dest_vsi> <dest_ctl> <fd_status> <cnt_index> <fd_id> <packet_len> <packet>\n");
 		dev_info(&pf->pdev->dev, "  fd current cnt");
 		dev_info(&pf->pdev->dev, "  lldp start\n");
 		dev_info(&pf->pdev->dev, "  lldp stop\n");
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 9b11fc6..e94e4e1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -111,8 +111,9 @@ static void i40e_fdir(struct i40e_ring *tx_ring,
  * @pf: The PF pointer
  * @add: True for add/update, False for remove
  **/
-int i40e_program_fdir_filter(struct i40e_fdir_filter *fdir_data, u8 *raw_packet,
-			     struct i40e_pf *pf, bool add)
+static int i40e_program_fdir_filter(struct i40e_fdir_filter *fdir_data,
+				    u8 *raw_packet, struct i40e_pf *pf,
+				    bool add)
 {
 	struct i40e_tx_buffer *tx_buf, *first;
 	struct i40e_tx_desc *tx_desc;
-- 
2.4.11

