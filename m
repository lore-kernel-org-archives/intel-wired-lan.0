Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E542CA0FEC
	for <intel-wired-lan@archiver.kernel.org>; Fri,  1 Sep 2023 17:09:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19D0541FAC;
	Fri,  1 Sep 2023 17:09:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 19D0541FAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1693588161;
	bh=N8jz/VMbDDFgZo6uOWuaUs4EWaHn/HpK9Ulgfc9gFFM=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=I+IRYilPtcDBcmVYBrGk0TlZEdCz1GeU31bboOhdxtPr/HkVumCjfZbThJw2qDFE0
	 bVqQghBjZe8dgtSsR3XWjAnv6X57cdJfVUynYBA1xwTD0KmLk31pMSvlfSx4Buvg0K
	 h+W9afmiBLIEv+sEqjg4Lb9CWvi9jYyWQbCSu/SJWqpDfejgJV3EZoiDywr1Zi2ak8
	 /9iK1yhy1dmN5hFlr6yNxLB47ur5Hg7tmsv1HN1ccZBz0a92z8Gko1pPBSdQNCG0ke
	 atMZFnHdKySGGhc+EAJE75kiKzxxCwHcwYaIJ1mSPvdfAEeijVufstf4TeID1tyNHD
	 rc2OS8l2B9aTw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hULaPeotzc_g; Fri,  1 Sep 2023 17:09:20 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id F090C41FC9;
	Fri,  1 Sep 2023 17:09:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F090C41FC9
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 18B5F1BF576
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Sep 2023 17:09:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65C5E818A1
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Sep 2023 17:09:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 65C5E818A1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d5bbmZX_YYLL for <intel-wired-lan@lists.osuosl.org>;
 Fri,  1 Sep 2023 17:09:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7C48B8186A
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Sep 2023 17:09:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C48B8186A
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="366495587"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; d="scan'208";a="366495587"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2023 10:09:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="854787617"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; d="scan'208";a="854787617"
Received: from kgdowskx-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com)
 ([10.251.215.78])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2023 10:09:05 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri,  1 Sep 2023 11:08:47 -0600
Message-Id: <20230901170850.3493782-2-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901170850.3493782-1-ahmed.zaki@intel.com>
References: <20230901170850.3493782-1-ahmed.zaki@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693588156; x=1725124156;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wHaNRp+D6RdkoO0sByq2CWNgkmJtXYqOO+RQ9BOl4cQ=;
 b=hF6hkCAo/wqgca+/uwJ8HXnEgM1bsg/eY3ulr5AplENRe+xeHMlPail9
 bSRwDLDK59B2vIv5a0cpWX3AW38n4+Nq67hYd3/n+QFxJY5oChp8yA5aw
 Qg6VukHYzWpd9B5u/fh3VIWbaf/3/PH27EKXbXNafNTji5IuPnvxMspe9
 F9hWhAnxucM6ksImYWmHwkhCia64eBuSe630e2EMgvaRpN69hUQu4FoSQ
 Yk3AjxCNIiB7K+nnLUvpUY8EGd8xMfM56F77PsM7IIDben94zhDbHvehz
 s5nEV1Jnt85de7f40IHbcpM7JcCvLYfRC6G26v/o0XejIirn4ikXRPcR0
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hF6hkCAo
Subject: [Intel-wired-lan] [PATCH iwl-next v4 1/4] virtchnl: Add CRC
 stripping capability
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>

Some VFs may want to disable CRC stripping on incoming packets so create
an offload for that. The VF already sends information about configuring
it's RX queues so use that structure to indicate that the CRC stripping
should be enabled or not.

Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 include/linux/avf/virtchnl.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index d0807ad43f93..dd71d3009771 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -240,6 +240,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_vsi_resource);
 #define VIRTCHNL_VF_OFFLOAD_REQ_QUEUES		BIT(6)
 /* used to negotiate communicating link speeds in Mbps */
 #define VIRTCHNL_VF_CAP_ADV_LINK_SPEED		BIT(7)
+#define  VIRTCHNL_VF_OFFLOAD_CRC		BIT(10)
 #define VIRTCHNL_VF_OFFLOAD_VLAN_V2		BIT(15)
 #define VIRTCHNL_VF_OFFLOAD_VLAN		BIT(16)
 #define VIRTCHNL_VF_OFFLOAD_RX_POLLING		BIT(17)
@@ -295,7 +296,13 @@ VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_txq_info);
 /* VIRTCHNL_OP_CONFIG_RX_QUEUE
  * VF sends this message to set up parameters for one RX queue.
  * External data buffer contains one instance of virtchnl_rxq_info.
- * PF configures requested queue and returns a status code.
+ * PF configures requested queue and returns a status code. The
+ * crc_disable flag disables CRC stripping on the VF. Setting
+ * the crc_disable flag to 1 will disable CRC stripping for each
+ * queue in the VF where the flag is set. The VIRTCHNL_VF_OFFLOAD_CRC
+ * offload must have been set prior to sending this info or the PF
+ * will ignore the request. This flag should be set the same for
+ * all of the queues for a VF.
  */
 
 /* Rx queue config info */
@@ -307,7 +314,7 @@ struct virtchnl_rxq_info {
 	u16 splithdr_enabled; /* deprecated with AVF 1.0 */
 	u32 databuffer_size;
 	u32 max_pkt_size;
-	u8 pad0;
+	u8 crc_disable;
 	u8 rxdid;
 	u8 pad1[2];
 	u64 dma_ring_addr;
-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
