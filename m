Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53660C3DA63
	for <intel-wired-lan@archiver.kernel.org>; Wed, 24 Jul 2024 21:37:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC36980D19;
	Wed, 24 Jul 2024 21:37:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uhQMHOlBMKir; Wed, 24 Jul 2024 21:37:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4051480DF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1721857070;
	bh=mJiDMBdEFePJP5cqyTsWBVY9bpOsqykp5w8Rb7SoHd4=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=rrZj1UO6hb6w1qS+Z7o7OmmW3q/cLw+EvJTouTdiveOMe4LheISN2yqYvP6syFlnr
	 dVUw1QryuH37RGQL4EQ/4gPxliPzniQ9oqefE4LLKeEtFXZDMEGOLCu46atHLD2d/L
	 FhMM/bdk8CxYbq75UNvQnkWqnv+VYDRppN6MYopVEdxE3tHlIxnqpsJhUrC+fDvqFq
	 EzX02jxlrvuaE+57JkbuHfLsusu2FBp1b0WGjF7tRQiPIaKUlEJFHVblfXbRefmfHC
	 vNJQETWUiOaa0ItT+qzRP3wjhCIZYOXp6LBAYzzY5ysoIRZSalRVec0wjHuNXPOSb8
	 8qhW9p3T1Cx/A==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4051480DF6;
	Wed, 24 Jul 2024 21:37:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 55EB51BF277
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jul 2024 21:37:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4456C80DF6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jul 2024 21:37:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rQmiwooyqf7e for <intel-wired-lan@lists.osuosl.org>;
 Wed, 24 Jul 2024 21:37:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=ahmed.zaki@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7A72980D9B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A72980D9B
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A72980D9B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jul 2024 21:37:47 +0000 (UTC)
X-CSE-ConnectionGUID: /OdhXip5Tc6N2m69fXTdQw==
X-CSE-MsgGUID: xAx5beBlRK+B+T/GeIhBbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19704263"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; d="scan'208";a="19704263"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2024 14:37:47 -0700
X-CSE-ConnectionGUID: pB2XcB0qRcedHZT7g4h5gg==
X-CSE-MsgGUID: 6Y0ksdpUR9mTKu0+cTPr7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; d="scan'208";a="52579619"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com)
 ([10.245.246.206])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2024 14:37:38 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 24 Jul 2024 15:36:18 -0600
Message-ID: <20240724213623.324532-10-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724213623.324532-1-ahmed.zaki@intel.com>
References: <20240724213623.324532-1-ahmed.zaki@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721857068; x=1753393068;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yOMvGONTz6voeoYDVKKif51gxiH/fasIzag5jalvqfo=;
 b=dHhJTuagIa52ZHICd9hKOByF8xkwjD/oofvsuovguWVQs1X5i7njQER8
 KXKa2nqZQqb3Gyhznr659NIZTL2NUEI+Bdzo9BtGQOK+Igvkm28aO5B7/
 y6+ffaLPVx+EmPzTBSTVcQ/sCVR2Zb01ZDFa2mpJ/SQh4YHFb45evrvoh
 w7DUMnD+r5uAZCGEuqeKIHKmRSvm26MgMwz+ncYcnZOlpNY0HSlmAIJ+K
 cr35HwVWVW9rNjrkfuNm5Emy5leEbhkMzH43VGwWGFpkBQyxPtpcNTp3F
 LSbERj/VA7lM6XEerTcPJ5PnIO036Delu4QW1clIq44sFpNHRD2jKOrAG
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=dHhJTuag
Subject: [Intel-wired-lan] [PATCH iwl-next v4 09/13] virtchnl: support raw
 packet in protocol header
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
Cc: netdev@vger.kernel.org, Ahmed Zaki <ahmed.zaki@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>, anthony.l.nguyen@intel.com,
 horms@kernel.org, przemyslaw.kitszel@intel.com,
 Junfeng Guo <junfeng.guo@intel.com>,
 Rafal Romanowski <rafal.romanowski@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Junfeng Guo <junfeng.guo@intel.com>

The patch extends existing virtchnl_proto_hdrs structure to allow VF
to pass a pair of buffers as packet data and mask that describe
a match pattern of a filter rule. Then the kernel PF driver is requested
to parse the pair of buffer and figure out low level hardware metadata
(ptype, profile, field vector.. ) to program the expected FDIR or RSS
rules.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
---
 include/linux/avf/virtchnl.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 8e177b67e82f..4f78a65e33dc 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -1121,6 +1121,7 @@ enum virtchnl_vfr_states {
 };
 
 #define VIRTCHNL_MAX_NUM_PROTO_HDRS	32
+#define VIRTCHNL_MAX_SIZE_RAW_PACKET	1024
 #define PROTO_HDR_SHIFT			5
 #define PROTO_HDR_FIELD_START(proto_hdr_type) ((proto_hdr_type) << PROTO_HDR_SHIFT)
 #define PROTO_HDR_FIELD_MASK ((1UL << PROTO_HDR_SHIFT) - 1)
@@ -1266,13 +1267,22 @@ struct virtchnl_proto_hdrs {
 	u8 pad[3];
 	/**
 	 * specify where protocol header start from.
+	 * must be 0 when sending a raw packet request.
 	 * 0 - from the outer layer
 	 * 1 - from the first inner layer
 	 * 2 - from the second inner layer
 	 * ....
 	 **/
 	int count; /* the proto layers must < VIRTCHNL_MAX_NUM_PROTO_HDRS */
-	struct virtchnl_proto_hdr proto_hdr[VIRTCHNL_MAX_NUM_PROTO_HDRS];
+	union {
+		struct virtchnl_proto_hdr
+			proto_hdr[VIRTCHNL_MAX_NUM_PROTO_HDRS];
+		struct {
+			u16 pkt_len;
+			u8 spec[VIRTCHNL_MAX_SIZE_RAW_PACKET];
+			u8 mask[VIRTCHNL_MAX_SIZE_RAW_PACKET];
+		} raw;
+	};
 };
 
 VIRTCHNL_CHECK_STRUCT_LEN(2312, virtchnl_proto_hdrs);
-- 
2.43.0

