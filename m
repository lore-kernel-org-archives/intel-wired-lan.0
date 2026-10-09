Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE064CA9EBD
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 12:15:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC7C281283;
	Fri,  9 Oct 2026 12:15:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aVmBEEpQ15OX; Fri,  9 Oct 2026 12:15:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EEBCB813C3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791548104;
	b=FDgbMiKaWK9xBkd/Jy+oqSh98172EjbHLsq7zc7lFPw8OvEObAxxsKTa7BVuKpEKkf2S
	 apCDYEJULWduqaPIFCvtGqWwf0/xgozvy0gzStn5aO19CjE5TGyTahU9raKIW/MqUqzCn
	 q1rnVvzrarmUCd4mN7IfVj2RZd1H07BNRMuhV8I+sdLn0d/mCJ+Aq37fJRnINwDdu74cL
	 WcXIf8vaDfa64lteQw3RtACnG5HGYrW2Coxi0le3bHpVdalJAfPPcfo9pTTL4Q7F/Oq2P
	 nt40/kHOkntVshEShj9b6jh+DvTCdQgfEafX2aetgkWTPEQYKhObBiURhKtsEW9ob2Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791548104;
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
	bh=3BiIkciGeoi5Rxd6EIlZJLvZy8yqKOUAWtQJhHTX8R4=;
	b=Bn0T1GWX4YGxcyAg5XjTT4x7zMSAjopyoW45Kk4QNzXw7nufqxoapRp4qbN7eLDo0Ozw
	 1YqdHzSm1FwL7P7jtVCVeERKWO3B3E8xudf45ztaV4sCIOqA0ZyL3n2jGggfDSo7uYmJu
	 aLdPCPTPJJcFP09gkdBi11IPU6FveWguNVwZC1+Z9wuhwf+ZvvudLEusfJ7K7LX8XEMk0
	 gedQ8xGy/b+46ZdvlpaxWKzFBZjsjGenkByJzhDXZ2fsDSqNS0uplqp+tgzI5+qdv90bt
	 T5EDiCbBP5CRsyw5Rg3zzSIJxr1PwAKHkj9m/UnnvQwU4lralpFvQxOvHndO9a9+wog==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791548104;
	bh=3BiIkciGeoi5Rxd6EIlZJLvZy8yqKOUAWtQJhHTX8R4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JfMiSD+uj1deC1WwRiJ8tmt7Imwk7hduUQ1pxDn29LjfTOUorOhxsXmSuCecAk/gD
	 27aPVK4IfAF+LBIAH3roXYQtl+L2h4sohv5iweGYcsA4h6sFyrEk+aGudBOZRIZwRZ
	 I6iEJOqvzCVz+qPgNtI3WyHMZr3NPDUZZp+9AAhq1enP/uOZ5b1S2MrvF0rv9I+fIb
	 rY5e9ONN/8oRR98cfBz2H0odxFRms475atsDBG8y939O8HgeqLEFXlXD8wVg+/lEP4
	 ACfU/tRvhPNHDDFM16zXammMBa+5aPGBi7IBpJ3ccwYBrfqKN0Bs773bCqEn8fEmW4
	 lE+z8QEYrDSxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEBCB813C3;
	Fri,  9 Oct 2026 12:15:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 74FAB317
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 66CCA4091B
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:15:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3GAMrNHSA2Zo for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 12:15:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8AF894093F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791548101;
 b=owSqd58OVDAXYcySYLnw5EvxlRTRXcWv7gr6kDZOPpaTC5/DN60IEIXfqPtMXpevdNNl
 rLZFIyUaWlPdMS9mfkuMt9lEymXpH1H7o3SGsM1sLRb8XpZP/+oamrbWCukGTN9N+8vUG
 qq3uihFgNtalICMnCfRqn8AYvAGTFGF3rzo1e7TcjuN9aRUtv0HRHyHOUolKtytXdCI12
 /sjlw7pVZ52xipjT9/vFyfraWi71pqkHwoolzdSgkB/QUqy4VEXaevpsCade2xNgwzDJw
 X1d7nEdmHwiZEkyGSPJriNyNJNrJfDhQPPfKxUZgfEYDx508dBTelroE+sCd1DwdaNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791548101;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=3BiIkciGeoi5Rxd6EIlZJLvZy8yqKOUAWtQJhHTX8R4=;
 b=HEZkEe6R/lhi+DRFfDlnV8Lb6866peR39QlYclfbS0YFy8KFK61jNWgGeL9c+lJxpiXu
 qn+oOayfE462ldp6030U1QdvgPEMTTcpCXji6KnxZD2oFu3iw7LjQBnB8ZWXY89KTPX0X
 9rV52QGy9xNlsOIoF0jjDPl6wpZDdITFsV+XBZDx/oTykUZYWEwfLqYof9Gw+7YbIMtRw
 TE3pH/E9gnjrVQGmjoI8LnWlzT29z8MnGMSJgo1eumDmmOfo/MmNGGHNfOvKCthtDwbIv
 16sFGfsusY9QbvqPDCqIPujdujFA3Rg8bsJIcfYXXCF1r/WYEs1bL38SEaSKee+Y0jA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JOBc68Ag; 
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=JOBc68Ag
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8AF894093F
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791548101; x=1823084101;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zyyW0JPRXHnAAlCqzXSVcYnysy8XihclFhCJgKDu+Bs=;
 b=JOBc68AgIduwxdqX39eKheHLX4eo+UU2JNDIj0Yot5Js0F43SBcisz+o
 gPffyRKxvUpIu9YBxtlKRzcc+GfM4MNMtofDD06mzmBxz72QF5x10At/u
 ro+SHUPr8qTz+2yvgkB5fyXBcCVTwHteOPLF/QpozDu7vKp3TSL9GvZ0e
 CbKXVd/bqqCMKudHswaDMmNfKrmMU/+8mdY8pNPj/9hehvW6H2VdYpAjZ
 FnOKRM6VkTYBXZEFKGBMw0LubKziHvjp2l3ojidS/feBjnu1cV9rrJWR/
 GGcR6hgMHCblzKtI7ILNKE/CGhEMZly6zNmL/yq6fLeOrlzNnzULz1AGM w==;
X-CSE-ConnectionGUID: fDzOwXizSkm+Qdxd0ZBuBA==
X-CSE-MsgGUID: jsQ/Jn0qQ/CCq4qvsWqKMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="251188"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="251188"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 05:15:00 -0700
X-CSE-ConnectionGUID: gO7Schk2T4u434qH6QrYkw==
X-CSE-MsgGUID: T9mMVtAzRUi8ZJzI3L7Fyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="420453"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa002.fm.intel.com with ESMTP; 09 Oct 2026 05:14:56 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.238])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 081442FC41;
 Fri,  9 Oct 2026 13:14:53 +0100 (IST)
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
Subject: [PATCH net-next v2 08/14] iavf: temporary rename of
 IAVF_MAX_REQ_QUEUES to IAVF_MAX_REQ_QUEUES_VCV1
Date: Fri,  9 Oct 2026 14:04:19 +0200
Message-ID: <20261009121433.30347-9-przemyslaw.kitszel@intel.com>
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
index 8c45536fd502..94ee18058115 100644
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
index 2f8a80a11336..bb239e99e450 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -5370,7 +5370,7 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_master(pdev);
 
 	netdev = alloc_etherdev_mq(sizeof(struct iavf_adapter),
-				   IAVF_MAX_REQ_QUEUES);
+				   IAVF_MAX_REQ_QUEUES_VCV1);
 	if (!netdev) {
 		err = -ENOMEM;
 		goto err_alloc_etherdev;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 67d797a1003f..630a551c7566 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -268,19 +268,19 @@ int iavf_send_vf_ptp_caps_msg(struct iavf_adapter *adapter)
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
2.51.1

