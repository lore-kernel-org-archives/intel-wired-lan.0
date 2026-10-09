Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28561CA601E
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 12:15:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7ADF40942;
	Fri,  9 Oct 2026 12:15:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VstK8SGJUyDy; Fri,  9 Oct 2026 12:15:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0F38340911
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791548103;
	b=s9A3sTVVuYRLP32D8/wcIl7sISEyxxAq7hIEye8eCwXLVGLy2y7HYylHTvykWFI3QgKi
	 EnYA25r3LgnZP0y3LYZMrOh8Xqf79t+X++cIf/9rEdTCXUR3RwQ+P26N+mVqXCVUq+o1m
	 e3sVBYr9PBNF1fStDhBdUj0qp+Oc5wafWoDqflGpqrv1o6TLG/yzhfdTx0GJaZpiyYLPq
	 NIPdILoWwJsNi+VT5dp7OJ/wyCh/fZPI16GCFawUig9Q2u33DjSYnnstCfwXyOFAoq37q
	 cbn71HUnbBO17c3nKqqrUCya1FFtqXC5eQ34tENmr89cR/Cfpcv3kS1s+XvKfoxeJag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791548103;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Gp4uOWRVzKh2KilscUF8Nb8XyNMoCPNTiXHOJT4DW1w=;
	b=DAprmbgNSEsfPKBKXXsvJ8wnXvH7rFuPJ6woncpCwG0skf4sc/iU1iLFnqgm2d0VX9DG
	 ZKG4Rsd/JdZctMCis3j9GVSxyZwi//HK3GjQzvF/Bl5wdXLl9bIbPqyngUTOGalSUeHFv
	 hvFA89N2K+/Aq73tVTM2lXC/Nc35/Xcmv/gmNjPWFZnSOoJNahBwc52Ze4RZHS80Djhy+
	 LqvqUULnKmUEErwsji7D4vSwvhs8vz+J2X4xft8Wjyf9F/D19w8nVjpPxW9FwSwOVhJ9Q
	 UQGcvhlfvd8QIUBZKD6gnyauRONBAUqZsoqwaG4GacaRBmNhAKnuqmX9J0/qA4Y3zcw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791548103;
	bh=Gp4uOWRVzKh2KilscUF8Nb8XyNMoCPNTiXHOJT4DW1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z+UPzyF7y/GOt3cz+usv7MVpmtNt/gUIYgFD+smMv2AFlq6ZXE31jdK3sUelqVUOo
	 frWk4sr06Vvb3SMCuJmCPqsuZI9WbEtWS0BJLHu6uLL3rl1RsxVgqTIJcYOKVpu5kK
	 2EJ6soPV0EAw/dNPDocL6NFSCPBNDH+zwzh7TAl6gwoYWukZQtKlVD9N/o/+26iN2R
	 26DFBg2OUQ/BQJTaEViOSWOgplMP8sDsdIgge6JY6M32pyr/D8pV7qB9UfBxzjh+3J
	 lr49XDCXR+G3fXocoB/qs8HIYJa2Tq1VqkRRBrYzkS92MON6OA1zO+MClhIEtPhrJh
	 0ehiMSlPK+kdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F38340911;
	Fri,  9 Oct 2026 12:15:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 830DB2AA
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:15:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 68FF440098
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:15:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FpGnTFOWFkLt for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 12:15:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8C88040061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791548100;
 b=kS442DVtk/UbBJ4J7hfVh7H/vsPis62pTo/pL4pjdmIaDK1WP/BSfta8iV0DUzS+9Ryd
 Hsm2pXT9y1Rt2dob7MpOqTxpJmoUXDQqP83DHFRwUFh0YiPFabxiUbHiflkuuBR9LQzdy
 5xhIYIuCzXAkiL7jSFQs7LKiPGRSyo8BK2WValKpY5g7YMCUZT3Fcz0JOn0hEvukrhYAv
 8U+TMKG9g26iEg+OxIVL0VrQW+v/BhvzVSzlUoC9AhykDSWecrUVeoOjgTwH1iJt8xK6H
 g7bKeb2TMab0hQba2E9ZvZj8DBCa4saL0BvyKXwtmRbB88fhm7n9SxFL4WoZhwI+Xrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791548100;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Gp4uOWRVzKh2KilscUF8Nb8XyNMoCPNTiXHOJT4DW1w=;
 b=FUAz7QkYF/NeQ5Ia+rwk0q3P9Y/76eqJYjsJL5KacNoZ8svH0InE3TF8WnXNkyxinE1j
 n1d7waxWYb6rA2WEdnDxp2bh1DazDLHSjO9m2CBZIgo1s5L3LUqTAsZDmof8tt2nl+Dru
 bip0LIpag53wtYale8ErFEJzYsN7gOGk6uuPBb2HBS+/TibpX4m4/+Kd/c3RSEdKkopUq
 CUSu8LoSjGjVpXktK2UbwN3mMLE3FBLO11CVA5zUKllzaSoL88CinfxioNMRIcWqSS1y+
 gpfNi6UliaUT28YYmCb9WgCRwtwMqQhkUT053UCTu8SivNzRVkDJxbT7SX71+jLvZqQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=i9Y9VLwV; 
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=i9Y9VLwV
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8C88040061
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791548100; x=1823084100;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8JXCopxtTF1q9Xw7IB1+0wJjahNlsCb7468ZOLHhaEU=;
 b=i9Y9VLwVXsBu6/FajBZ63ZaXI4/xjyNsFIf5GeFNL29Fb8JzRkctVzVX
 9og7+3kXgbmWshILA7dXc7rkXNAY6Oi4VKsXgqHfIIoAtve17o1GMrpsU
 5Lm9tJBUvaYWObdv5PIX3HpZVMVWdEGOm0FFETp/9Z47NIf8GdMluWJG0
 rc+z47QRCIj1zwhQp5ifsTsW5pzd7TKug8RRGZMCjLdlzbqIBhCDRGn26
 U1NpI2FhVt9tUhfOzjpqrBufnEU5uQCcQ1ef/Yefv1O8+uQ2wm+xFxg5D
 P/QV67Ya1RDt+EPhp4grhiQsjrF/617xd935g0isSz2bnZWqOv36vqcjx g==;
X-CSE-ConnectionGUID: GEYQMqm7RKG+N5xai03LAA==
X-CSE-MsgGUID: AEgqbwktSFGc0oeP1cTBew==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="251175"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="251175"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 05:14:59 -0700
X-CSE-ConnectionGUID: Yniz8Aj6Sau+pB7Wq9RSNQ==
X-CSE-MsgGUID: dLnNs6+bQGa5a4DPvkN1zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="420446"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa002.fm.intel.com with ESMTP; 09 Oct 2026 05:14:54 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.238])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id E3CC42FC47;
 Fri,  9 Oct 2026 13:14:51 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@kernel.org, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, Jonathan Corbet <corbet@lwn.net>,
 skhan@linuxfoundation.org, rdunlap@infradead.org, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org, mbloch@nvidia.com,
 jacob.e.keller@intel.com, jedrzej.jagielski@intel.com, anzaki@gmail.com,
 brett.creeley@amd.com, jtornosm@redhat.com, ohartoov@nvidia.com,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 07/14] iavf: extend iavf_configure_queues() to
 support more queues
Date: Fri,  9 Oct 2026 14:04:18 +0200
Message-ID: <20261009121433.30347-8-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
References: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org

Extend iavf_configure_queues() to support more queue pairs than fit
into a single virtchnl message (62).
Virtchnl opcode used was already generic, but we have just not needed
more than one message before.

Send the messages one by one, waiting for the PF reply to each of them
with iavf_poll_virtchnl_response(), similar to iavf_set_mac_sync().
That keeps only one virtchnl op in flight, without the need to track
across watchdog runs what was already sent (as iavf_add_ether_addrs()
does for MAC filters). So the op becomes synchronous also for the
single message case: the watchdog, holding netdev_lock, waits up to 1s
for each reply.

Stop at the first PF NACK, without a retry, as before. On timeout keep
the op pending, as PF may still reply; once it does, the whole
configuration is resent.

Add helper, iavf_max_vc_entries(), that determines how many entries we
could fit into virtchnl message (ending by flex array member). Will be
also used on another op later in this series.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v2:
 * fix typo (Sashiko)
 * abort iavf_configure_queues() at error (Sashiko)
 * report send and poll failures with dev_err(), they are not
   recoverable here (me)
 * cast via uintptr_t in iavf_match_vc_op_cb(), for clang W=1
   -Wpointer-to-enum-cast
 * commit message: the limit is the number of queue pairs that fit
   into a single virtchnl message (62), not 31
 * commit message: describe the switch to a synchronous op (Sashiko)
 * stop at PF NACK (Sashiko)
 * on timeout keep current_op and IAVF_FLAG_AQ_CONFIGURE_QUEUES set
   until the late reply arrives, instead of resending right away;
   clear both on other errors (no retry) (Sashiko)
 * fix dev_err() continuation alignment (Sashiko)
---
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 86 ++++++++++++++++---
 1 file changed, 75 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index e6b7e8f82c7c..67d797a1003f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -8,6 +8,19 @@
 #include "iavf_ptp.h"
 #include "iavf_prototype.h"
 
+/* how many Flex Array Member entries do fit into VC message of type *ptr */
+#define iavf_max_vc_entries(ptr, flex_member) \
+	((IAVF_MAX_AQ_BUF_SIZE - virtchnl_struct_size(ptr, flex_member, 1)) / \
+	 sizeof(ptr->flex_member[0]) + 1)
+
+static bool iavf_match_vc_op_cb(struct iavf_adapter *adapter, const void *data,
+				enum virtchnl_ops recv_op)
+{
+	enum virtchnl_ops wanted_op = (enum virtchnl_ops)(uintptr_t)data;
+
+	return recv_op == wanted_op;
+}
+
 /**
  * iavf_send_pf_msg
  * @adapter: adapter structure
@@ -377,8 +390,10 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 	struct virtchnl_vsi_queue_config_info *vqci;
 	int pairs = adapter->num_active_queues;
 	struct virtchnl_queue_pair_info *vqpi;
-	u32 i, max_frame;
+	struct iavf_arq_event_info event;
+	int max_pairs, err = 0;
 	u8 rx_flags = 0;
+	u32 max_frame;
 	size_t len;
 
 	max_frame = LIBIE_MAX_RX_FRM_LEN(adapter->rx_rings->pp->p.offset);
@@ -390,22 +405,30 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 			adapter->current_op);
 		return;
 	}
-	adapter->current_op = VIRTCHNL_OP_CONFIG_VSI_QUEUES;
-	len = virtchnl_struct_size(vqci, qpair, pairs);
+
+	max_pairs = iavf_max_vc_entries(vqci, qpair);
+	len = virtchnl_struct_size(vqci, qpair, min(pairs, max_pairs));
 	vqci = kzalloc(len, GFP_KERNEL);
 	if (!vqci)
 		return;
 
+	/* any message may arrive while polling, not only the awaited one */
+	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
+	event.msg_buf = kzalloc(IAVF_MAX_AQ_BUF_SIZE, GFP_KERNEL);
+	if (!event.msg_buf) {
+		kfree(vqci);
+		return;
+	}
+
 	if (iavf_ptp_cap_supported(adapter, VIRTCHNL_1588_PTP_CAP_RX_TSTAMP))
 		rx_flags |= VIRTCHNL_PTP_RX_TSTAMP;
 
 	vqci->vsi_id = adapter->vsi_res->vsi_id;
-	vqci->num_queue_pairs = pairs;
 	vqpi = vqci->qpair;
-	/* Size check is not needed here - HW max is 16 queue pairs, and we
-	 * can fit info for 31 of them into the AQ buffer before it overflows.
-	 */
-	for (i = 0; i < pairs; i++) {
+
+	for (int i = 0, in_msg = 0; i < pairs; i++) {
+		const bool last = i + 1 == pairs;
+
 		vqpi->txq.vsi_id = vqci->vsi_id;
 		vqpi->txq.queue_id = i;
 		vqpi->txq.ring_len = adapter->tx_rings[i].count;
@@ -423,11 +446,52 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 						   NETIF_F_RXFCS);
 		vqpi->rxq.flags = rx_flags;
 		vqpi++;
+		in_msg++;
+		if (last || in_msg == max_pairs) {
+			adapter->current_op = VIRTCHNL_OP_CONFIG_VSI_QUEUES;
+			vqci->num_queue_pairs = in_msg;
+
+			err = iavf_send_pf_msg(adapter,
+					       VIRTCHNL_OP_CONFIG_VSI_QUEUES,
+					       (u8 *)vqci,
+					       virtchnl_struct_size(vqci, qpair, in_msg));
+			if (err) {
+				dev_err(&adapter->pdev->dev,
+					"sending VC msg to PF failed, err: %d\n",
+					err);
+				break;
+			}
+
+			err = iavf_poll_virtchnl_response(adapter, &event,
+							  iavf_match_vc_op_cb,
+							  (void *)VIRTCHNL_OP_CONFIG_VSI_QUEUES,
+							  1000);
+			if (err) {
+				dev_err(&adapter->pdev->dev,
+					"config queues poll failed, err: %d\n",
+					err);
+				break;
+			}
+
+			/* PF NACK, iavf_virtchnl_completion() has logged it */
+			if (event.desc.cookie_low) {
+				err = -EIO;
+				break;
+			}
+
+			vqpi = vqci->qpair;
+			in_msg = 0;
+		}
 	}
 
-	adapter->aq_required &= ~IAVF_FLAG_AQ_CONFIGURE_QUEUES;
-	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_VSI_QUEUES,
-			 (u8 *)vqci, len);
+	/* keep the op pending on timeout, as PF may still reply, the whole
+	 * config is resent once it does
+	 */
+	if (err != -EAGAIN) {
+		adapter->aq_required &= ~IAVF_FLAG_AQ_CONFIGURE_QUEUES;
+		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
+	}
+	kfree(event.msg_buf);
 	kfree(vqci);
 }
 
-- 
2.51.1

