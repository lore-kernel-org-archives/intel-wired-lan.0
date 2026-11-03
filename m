Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CFE606EE85
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ArBNhvb7;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E9ricl/l
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B62D96085C;
	Tue,  3 Nov 2026 14:40:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id adgS0hhmea1d; Tue,  3 Nov 2026 14:40:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2C6C2607BE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793716804;
	b=B7UgTrVz9kdjpxwMY8ReMIrWPEGZxThmsuG9kW7bFrQe0CJHBi+5+/fPf5RcpfIsMesL
	 IAycGRnXa+HBsmMmZ/JZjZdHACcRJBrOZ/4127iJyR3mIQ0KLhq62c6PZvCX77XnfvgVg
	 PSktCSvn1ty0QkralLMDJFxPM98gd//ZPFRKXUIrHNojRUNAusW95TcRBCBLixWRJMTx0
	 MZzlHT9O7TVt3GacVCsaKcs58u98Pls0IKYZqhLLkWIuW42K6hPj3Oh7/SXAlCmVIBTDq
	 yoKqt/T8VqqYLd4nA3DRC4pHa3R3Zab1pNLWoQH+adGidmFutX994uTjT8KzdFI+2jg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793716804;
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
	bh=VvGYg4RKOcZoCIDjAJMuLObnilI7z0KtFsIeC3rNVvU=;
	b=WuXBVG60LYGeEjS64DlC5HUp6g067hN7x8Ef9ol5osoUpIQeXLEQqMR47XZs2EMHKdtB
	 yuE0rfEzz7yL4HJ5GelmRkBpoHUv2MSCgnM2vpCR17SU2U9NEYGvSu4CqGNZALzLYN2Mv
	 y3z5PjRXb5/fCzHBky/2YCyojFSeZcvJ1jcL/aKUJ24RvybjS/hMeFtLKLzo/tM8nKiHs
	 j0rdQbjXrhc5aWqfE8mLv7gR9vd0Mlmh+gcnaEsyLCQBQCrwYASOOOvsezYqxmRwMvE2g
	 9xBVj/PmxRkFg2qfMlXwenDPkiBvhr4k8ppitXxOGH63vLMtwinZhN66JVMOaaW3dlg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793716804;
	bh=VvGYg4RKOcZoCIDjAJMuLObnilI7z0KtFsIeC3rNVvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ArBNhvb7PYWJg67uv/t6jmi/Kmt5Mh7/SLh1BkNBXxi4dkJ38rhlrQqSXpCBgpVTM
	 s0Ai1dB+FInNwUPL89bPAXxIZMgBf0BH//yvpcA724/5oZ/mJ1m3dTAXxheRfYogFD
	 iQ7NxBD/cJsOMPyp/iOz2ckCejRNQVrlKnxTU2XzljPU2KajKnd00mIlFU5hu1VnNj
	 fqLvoDLsdiajV+sBEo4dDsE9fmKXNu/ia2txP4XhROzhDkpfRBscCk42nl8mH1wgZM
	 SP0ONklFjDUHkBB8nz5r5jA5PO7iyeeWY5qRaCLCf7xcd6pDqHchEfivAdWVlRGzCK
	 yP+rhW18iQ8RQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C6C2607BE;
	Tue,  3 Nov 2026 14:40:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 77090356
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:39:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5CF2840704
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:39:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LsvO8fNRrE0Z for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 14:39:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9E45D406FA
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793716797;
 b=qwVvZ26Ni4/aROwdx6vejFmSNC8/B+ScAy3Byx3ug7ehxMB+ZowG0qyV8Q0ZoarZf3bA
 H66lUmBrYXOh7qvtcXut/dWmaIjoADQW1cQ36ytR++AkSN2RuEeiZ6ZBVcW7/eDKaS8d9
 +THCNM43wnJeerOgTNpcINqyXCRbC934KFNXJDBqdnY8+tS562xWG3CcjncOMwxiFcC3q
 tlgRBPLsXUaYGVWrHwoLlDINlMe5DU8Sb41/oeillgwr4Y9dolPSSwJcnjXkMWpqky809
 aKHerb2ahmmcnOepZhfsezZoNv7uaJy0snrk1u1LCYPoV0vzMg3rFPzteKhHZmHCu2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793716797;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=VvGYg4RKOcZoCIDjAJMuLObnilI7z0KtFsIeC3rNVvU=;
 b=JMYKLlbApsgpwMEft1+NJhVKStFTVqvfCgVzV5hp3x2q8J0NmgmIK58LRbwRCA8H2hh0
 CaAXcjl9hIZlzcAfuvGtdHlwAFXwN93Tb6U/Ssv6I1hQilJMcAjS3CMTQ6oQtbujW/pj5
 srr3dazDf4PSVSx3udhFJsspCkWbUl19konQDdBPP1wE/6CFrNqNRT+UEqolb7hct4Xa9
 crLQf36LCj0vfoZ4wk2yw8Q408IrvGj6reVQgiiP63MJ5zISLwvnahAcWSnwjzgep89SV
 SlVc3a2h6pRPGHc88eJVfziy4GUb85+fyIOOmVMGBGDAaDPFYlXsDHckzRb4U7Qgtzg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="E9ricl/l"; 
 arc=none smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=E9ricl/l
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E45D406FA
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793716797; x=1825252797;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ha6+beWen/HzF3HGCwu4M8XZKad/MO6jy85k6q7op0E=;
 b=E9ricl/lm4EgPLFa629q0d9Z274m/giixSmsm+Ci7lsmCAJaOohIokTr
 i4lu7EAINq1QQLZW1eenGfEGlZ8FuK1p0YZpmYDEUs1QixgQk7dnI/BIy
 SbdTtZ81J9nUsmGWVQHi+Rg/E/OPOwvnp3ufGbY+14LPcHfmK4MsabUo+
 5uQrVbIA9HajsS5t8p0Jt2lC2QAVBA/0ynsTrv7WlGOk2/zEXiIXhQXj7
 TaQb2JXSQLtgbtXq8Uh5uuJzhk3NGewUmlAIa7KgJrYRWM3Uei4WpJ8v5
 vKcJbOEp4iXI54reKcMBMCAc7XJ9X6HoamExnlpiYDyMxlnwAnbQ18hP5 Q==;
X-CSE-ConnectionGUID: oy1/jxxLRWaM77ZAYbRL3Q==
X-CSE-MsgGUID: iB1rhLYjTNS6xSbFjxkaZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2324055"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2324055"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 06:39:57 -0800
X-CSE-ConnectionGUID: z7N/AhrPRmCxNVeZAUOubA==
X-CSE-MsgGUID: VPGlCdThR+ebnnU/j65/eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8289938"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa013.fm.intel.com with ESMTP; 03 Nov 2026 06:39:52 -0800
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id E013F312EA;
 Tue,  3 Nov 2026 14:39:49 +0000 (GMT)
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
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v4 08/15] iavf: temporary rename of
 IAVF_MAX_REQ_QUEUES to IAVF_MAX_REQ_QUEUES_VCV1
Date: Tue,  3 Nov 2026 15:14:49 +0100
Message-ID: <20261103141646.303620-9-przemyslaw.kitszel@intel.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rename IAVF_MAX_REQ_QUEUES to IAVF_MAX_REQ_QUEUES_VCV1, in preparation for
the next patch that will extend the max to 256, using old value of 16 for
the "v1" variant of virtchnl opcodes.

Suggested-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h          |  3 ++-
 drivers/net/ethernet/intel/iavf/iavf_main.c     |  2 +-
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 10 +++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index a41d2726ebd8..053f34c4f710 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -87,7 +87,8 @@ struct iavf_vsi {
 #define IAVF_TX_DESC(R, i) (&(((struct iavf_tx_desc *)((R)->desc))[i]))
 #define IAVF_TX_CTXTDESC(R, i) \
 	(&(((struct iavf_tx_context_desc *)((R)->desc))[i]))
-#define IAVF_MAX_REQ_QUEUES 16
+/* for "old" virtchnl opcodes that accept up to 16 queues */
+#define IAVF_MAX_REQ_QUEUES_VCV1	16
 
 #define IAVF_HKEY_ARRAY_SIZE ((IAVF_VFQF_HKEY_MAX_INDEX + 1) * 4)
 #define IAVF_HLUT_ARRAY_SIZE ((IAVF_VFQF_HLUT_MAX_INDEX + 1) * 4)
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index d39737dcd425..822d6e692d49 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -5371,7 +5371,7 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_master(pdev);
 
 	netdev = alloc_etherdev_mq(sizeof(struct iavf_adapter),
-				   IAVF_MAX_REQ_QUEUES);
+				   IAVF_MAX_REQ_QUEUES_VCV1);
 	if (!netdev) {
 		err = -ENOMEM;
 		goto err_alloc_etherdev;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 356565aa41c8..69241cb146e0 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -260,19 +260,19 @@ int iavf_send_vf_ptp_caps_msg(struct iavf_adapter *adapter)
  **/
 static void iavf_validate_num_queues(struct iavf_adapter *adapter)
 {
-	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES) {
+	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES_VCV1) {
 		struct virtchnl_vsi_resource *vsi_res;
 		int i;
 
 		dev_info(&adapter->pdev->dev, "Received %d queues, but can only have a max of %d\n",
 			 adapter->vf_res->num_queue_pairs,
-			 IAVF_MAX_REQ_QUEUES);
+			 IAVF_MAX_REQ_QUEUES_VCV1);
 		dev_info(&adapter->pdev->dev, "Fixing by reducing queues to %d\n",
-			 IAVF_MAX_REQ_QUEUES);
-		adapter->vf_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES;
+			 IAVF_MAX_REQ_QUEUES_VCV1);
+		adapter->vf_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES_VCV1;
 		for (i = 0; i < adapter->vf_res->num_vsis; i++) {
 			vsi_res = &adapter->vf_res->vsi_res[i];
-			vsi_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES;
+			vsi_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES_VCV1;
 		}
 	}
 }
-- 
2.54.0

