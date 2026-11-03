Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E962B606D811
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=FbQ8niKf;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nG9ZtcSM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9CF760856;
	Tue,  3 Nov 2026 14:40:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F-JFv-rHOYRe; Tue,  3 Nov 2026 14:40:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C855160830
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793716802;
	b=QeALITPi2YiZtb8vauhnWgqrad4FiolZs4EatNCWaB8HN97geqqmHcdbSbeJp6jTqR/r
	 0nl0CZWfzPp4rAr1EEzKXaNwW19k3CQ+cahHnY9lvNylud5yJX0AH6rLvT2ev/PyvGIaZ
	 og6rNaiy3nCfW2EckYxNi77JWdSPm/Fzd+v2kk96mKJm7wyUnZfRElluU6/Z2yHVbg8FM
	 d07QZui/lnEdC8wNXvUIe9w6abwV28LQBtVIvhDwuQhUf+z5ahla/MZoqCsIbfnqickWs
	 y2RIzwz5XRcTBq7O/56vnYaa9TejInHAE5NRr7JYXCHb+Z7dGkK0MMHPpfnBPZt8HsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793716802;
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
	bh=OfXi3+MFIaMgDpofgoIZClSjmjJvsfSXCqwfqJEoROs=;
	b=Jij+giopN4+BIZyHXjGLH2xPI62tEreUDx/e6AxVKxehdYN3h1oHHRq5dnrIeU9K/okW
	 Oy5aIKU2uenhP7l+CgfGoM4+23aM0v+OBi0YaNeEOxfOUs02RiuvRHNB/SSu/2JWuNIsU
	 5W0RftutY3MgLCc4VGDoOjiTKThznFp19EZGaqbRV1cg5ECdwF44uKp/yzH/ZSPGfHHzZ
	 4B8UcTSBgB/7qt1aebVNDL2TZOEzZ/UAK8oSDjVGRnOVVgphYEBHoLvVClQrIWDwJCJmN
	 kn0q25Su3uEqrkbowxZQv27h2lHeruherive4rlAUHPb+YxE+bBL34Z6N6msbT3klPg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nG9ZtcSM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793716802;
	bh=OfXi3+MFIaMgDpofgoIZClSjmjJvsfSXCqwfqJEoROs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FbQ8niKfnZnqkJwkaYSw7olZQ2lyKYCWOt/V7i+hqqQLtvA8qipHparqBo9B3uFbN
	 /JcynhfmrNjveiAyQKa9jA5mhyeXcsGPNJSWTn1sc9oqmKn+z0yCUZ/rhzPWoVZitK
	 N9FOesQe80H4qoN/LBsouvveTKLPiEkrtoSKomeVBzEpQsWWcefjgCsO6IV+apftP8
	 gy020YIYv3nsHcwWZBi05PnsMTrS12PzzqZlpOReIqHnG3+DcEb6KWQUpTZtc/PjXF
	 tnWI2Q7yXb+sw+Qyt/jii5ua2IdQ6TrzyJ/1kVvxARThGp9+T4RHZ+KuiQyEsTus5Y
	 j+hECDgAOJ8AA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C855160830;
	Tue,  3 Nov 2026 14:40:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 725C1356
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 644CA607BE
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:39:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fM24OfWkV56s for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 14:39:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 68C1F6083F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793716796;
 b=paJ/BDnjqQ2S2s2fyiYx2ajtkhqFSoR0vuO/aD0YUvI/BtjqiKe7GQk5qXZ2MBFMao67
 5atn6Ut/K+ztVG0+8c0zMqUc+o/oo/IlPngdQ8sYcvEGsM8rHbSLOE73OqJkKRMaNCpSv
 RvYzXVcAEGqew2TDztuSD8VhF+ZCCcOo6d/GcpCzTb/Uq8tDSxlvnHPOgWtz0aKaYsblA
 XzLwJAdgg0nznE5MKMAg4vroWXJD1t0G89tp8jtcXSJlN2C9ts1Y0iutQM/jaiqjEYttA
 qte/WlbCpQKiYVLAGQq8h4cVZkmbxMz5XRbd1rJjpcHxuL55CC+fuv8irnqmo9ii9YA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793716796;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=OfXi3+MFIaMgDpofgoIZClSjmjJvsfSXCqwfqJEoROs=;
 b=BD6npjcU/59CjxzMgYmZVrG1HW+vDkQmqAsR0Qgl7ChUtUGGO6/6CrJTwEYQHkltdWVw
 YJ9eX9moGJXrKG9SRGzA3LYHjbxaEakEXweZft47Vg6/C1wKFzArYb7YMOzyqRNV38zpF
 Kw6r28Tiai32hkaLxuq/zVIUfiM1nk3s4yuUtH6/1AXO0CdQTovUZ95N9xnR0Mhd7N11M
 KV5PPceFKbGJnBPx5BJBPbh/7p5iWYWxVV3rIr11WNErQ0ToEvMbnrCA43hgkXGFs5PLv
 kG0yRUs0RXOWzezWc/iHn95STH6YFVV5iUEoxMcGIKB2MB3Q0qWq0B6LAQhXA+t2dCg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nG9ZtcSM; 
 arc=none smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=nG9ZtcSM
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 68C1F6083F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793716796; x=1825252796;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/TnIHRq/W5sKXEetYjPiZDzUwmDPtVSF8P8FQxAJqfI=;
 b=nG9ZtcSMb0D8DWmRijSiEJXPC3ZfnMFsV9x5KTHcin2o1jOllLLzxB5P
 n8/DIR6PoYVmyhxH0Du/CRQNrCNhPLkeci+VdLVQSuUQYLB1YO+kAweX/
 w8SKxej7XnV6LHdskKYcOCReC5Nz/hQCqIZ9P5dDsTUNzs1N93+JhopCu
 WkV1kD0KEQyzQVKChVKdq82zWFcU2u87JAPkbqh2TEy28BfJSXw8DapZA
 X9lPqTVmFEoxfISUyPdHdANQXwJet49cjBdBscTXdb8x1WScuM4kgVsFj
 y4ZM9owWOHwU3PVKHOVIxkRTSdlPaGHL3ldMafHEKQN9GKV749rbrbzjk w==;
X-CSE-ConnectionGUID: mV5+GxIzTb6wyxcJ7Tg3wA==
X-CSE-MsgGUID: PZrxb5zFRiu9N6E7+cfu2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2324046"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2324046"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 06:39:55 -0800
X-CSE-ConnectionGUID: I3+CryFSQb2tdSHDutWYVg==
X-CSE-MsgGUID: IyzJtfKCRJK27iV6tsNoww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8289915"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa013.fm.intel.com with ESMTP; 03 Nov 2026 06:39:50 -0800
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 4499A312F1;
 Tue,  3 Nov 2026 14:39:48 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, Simon Horman <horms@kernel.org>,
 Michal Schmidt <mschmidt@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 bruce.richardson@intel.com,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 padraig.j.connolly@intel.com, ananth.s@intel.com,
 timothy.miskell@intel.com, Jacob Keller <jacob.e.keller@intel.com>,
 Lukasz Czapnik <lukasz.czapnik@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v4 07/15] iavf: extend iavf_configure_queues() to
 support more queues
Date: Tue,  3 Nov 2026 15:14:48 +0100
Message-ID: <20261103141646.303620-8-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
References: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extend iavf_configure_queues() to support more queue pairs than fit
into a single virtchnl message (62).
Virtchnl opcode used was already generic, but we have just not needed
more than one message before.

Send one message per call, and keep IAVF_FLAG_AQ_CONFIGURE_QUEUES set
until all queue pairs are sent, similar to what iavf_add_ether_addrs()
does for MAC filters. The next message goes out on a later watchdog
run, once the reply to the previous one has cleared current_op, as for
any other op. Stop sending on a PF NACK.

Add helper, iavf_max_vc_entries(), that determines how many entries we
could fit into virtchnl message (ending by flex array member). Will be
also used on another op later in this series.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v4:
 * send one message per watchdog run, instead of polling for the reply
   to each one with a 1s timeout, which could resend the whole config
   after a late ACK or NACK, and could take a stale reply for the
   awaited one (Sashiko)
 * stop sending the rest on a PF NACK, in iavf_virtchnl_completion()

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
 drivers/net/ethernet/intel/iavf/iavf.h        |  2 ++
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  1 +
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 25 ++++++++++++++-----
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 8c45536fd502..a41d2726ebd8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -269,6 +269,8 @@ struct iavf_adapter {
 	u8 rxdid;
 	int num_active_queues;
 	int num_req_queues;
+	/* queue pairs sent so far, for ops that take more than one message */
+	int cfg_qps_sent;
 
 	/* TX */
 	struct iavf_ring *tx_rings;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 2f8a80a11336..d39737dcd425 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1258,6 +1258,7 @@ static void iavf_configure(struct iavf_adapter *adapter)
 
 	iavf_configure_tx(adapter);
 	iavf_configure_rx(adapter);
+	adapter->cfg_qps_sent = 0;
 	adapter->aq_required |= IAVF_FLAG_AQ_CONFIGURE_QUEUES;
 
 	for (i = 0; i < adapter->num_active_queues; i++) {
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index e6b7e8f82c7c..356565aa41c8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -8,6 +8,11 @@
 #include "iavf_ptp.h"
 #include "iavf_prototype.h"
 
+/* how many Flex Array Member entries do fit into VC message of type *ptr */
+#define iavf_max_vc_entries(ptr, flex_member) \
+	((IAVF_MAX_AQ_BUF_SIZE - virtchnl_struct_size(ptr, flex_member, 1)) / \
+	 sizeof(ptr->flex_member[0]) + 1)
+
 /**
  * iavf_send_pf_msg
  * @adapter: adapter structure
@@ -375,11 +380,12 @@ int iavf_get_vf_ptp_caps(struct iavf_adapter *adapter)
 void iavf_configure_queues(struct iavf_adapter *adapter)
 {
 	struct virtchnl_vsi_queue_config_info *vqci;
-	int pairs = adapter->num_active_queues;
 	struct virtchnl_queue_pair_info *vqpi;
+	int first = adapter->cfg_qps_sent;
 	u32 i, max_frame;
 	u8 rx_flags = 0;
 	size_t len;
+	int pairs;
 
 	max_frame = LIBIE_MAX_RX_FRM_LEN(adapter->rx_rings->pp->p.offset);
 	max_frame = min_not_zero(adapter->vf_res->max_mtu, max_frame);
@@ -391,6 +397,8 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 		return;
 	}
 	adapter->current_op = VIRTCHNL_OP_CONFIG_VSI_QUEUES;
+	pairs = min_t(int, adapter->num_active_queues - first,
+		      iavf_max_vc_entries(vqci, qpair));
 	len = virtchnl_struct_size(vqci, qpair, pairs);
 	vqci = kzalloc(len, GFP_KERNEL);
 	if (!vqci)
@@ -402,10 +410,7 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 	vqci->vsi_id = adapter->vsi_res->vsi_id;
 	vqci->num_queue_pairs = pairs;
 	vqpi = vqci->qpair;
-	/* Size check is not needed here - HW max is 16 queue pairs, and we
-	 * can fit info for 31 of them into the AQ buffer before it overflows.
-	 */
-	for (i = 0; i < pairs; i++) {
+	for (i = first; i < first + pairs; i++) {
 		vqpi->txq.vsi_id = vqci->vsi_id;
 		vqpi->txq.queue_id = i;
 		vqpi->txq.ring_len = adapter->tx_rings[i].count;
@@ -425,7 +430,9 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 		vqpi++;
 	}
 
-	adapter->aq_required &= ~IAVF_FLAG_AQ_CONFIGURE_QUEUES;
+	adapter->cfg_qps_sent += pairs;
+	if (adapter->cfg_qps_sent == adapter->num_active_queues)
+		adapter->aq_required &= ~IAVF_FLAG_AQ_CONFIGURE_QUEUES;
 	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_VSI_QUEUES,
 			 (u8 *)vqci, len);
 	kfree(vqci);
@@ -2551,6 +2558,12 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			dev_warn(&adapter->pdev->dev, "Failed to Config Queue BW, error %s\n",
 				 iavf_stat_str(&adapter->hw, v_retval));
 			break;
+		case VIRTCHNL_OP_CONFIG_VSI_QUEUES:
+			dev_err(&adapter->pdev->dev, "Failed to configure queues, error %s\n",
+				iavf_stat_str(&adapter->hw, v_retval));
+			/* don't send the remaining queue pairs */
+			adapter->aq_required &= ~IAVF_FLAG_AQ_CONFIGURE_QUEUES;
+			break;
 		default:
 			dev_err(&adapter->pdev->dev, "PF returned error %d (%s) to our request %d\n",
 				v_retval, iavf_stat_str(&adapter->hw, v_retval),
-- 
2.54.0

