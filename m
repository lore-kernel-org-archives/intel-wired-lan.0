Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BECCD4F35
	for <intel-wired-lan@archiver.kernel.org>; Tue, 12 May 2026 09:31:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2219821CF;
	Tue, 12 May 2026 09:31:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cW75tjF2_tVW; Tue, 12 May 2026 09:31:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B642A821C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778578281;
	bh=CyJaB3NInkEm48aFHUrKgufF+nGIZhKKPF63XbKGjG4=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U1o/BbYKaCkUSSJDOMsvXwQTN4LjTiDJLJ4L9aOSdv6ji2R56BcXfxJObrsgTPIEB
	 awXhLZnT+atbGe9Wxa36nJT5OsQVoVKEtKf0Ljm/mFf9sKEtkgMmcSbbet6mCQ2ry3
	 JlKYi8NNhN8swYBNKnOSSwIawXiqg5Yoo/BoZw4i3F5Nm9scXs6XLhlgRLAt6uL43y
	 WHVMKLkR61+5bNJ7XeYFhwCYOg3MKfPnzYdGQzVrslXY8J46bGfxZMpyvfOMDXdK6c
	 5isUV2xJg3Ybi+McMADhN/mBs09roXFza4viSLOITJza93B2onHjIeOvnH7qrs2oQa
	 CmXHbBo6syNOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B642A821C0;
	Tue, 12 May 2026 09:31:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5AE41398
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 May 2026 09:31:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D43ED60C0E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 May 2026 09:31:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N5V1bofAyk5V for <intel-wired-lan@lists.osuosl.org>;
 Tue, 12 May 2026 09:31:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CB16560B8A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB16560B8A
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB16560B8A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 May 2026 09:31:16 +0000 (UTC)
X-CSE-ConnectionGUID: m/gACbXuTXyfAr0r/zj2/A==
X-CSE-MsgGUID: Da0cfDXjQMGagUN2+H3d3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79663250"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="79663250"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 02:31:16 -0700
X-CSE-ConnectionGUID: NLE6tDptS1+vOqXPGHhNDw==
X-CSE-MsgGUID: 9R60V5r/SKmcyCu698rAsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="231323227"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by fmviesa009.fm.intel.com with ESMTP; 12 May 2026 02:31:16 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Tue, 12 May 2026 10:47:28 +0200
Message-ID: <20260512084729.1338557-4-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260512084729.1338557-1-michal.swiatkowski@linux.intel.com>
References: <20260512084729.1338557-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778578277; x=1810114277;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BMA+HcsTduy9KAlNO7woXKOs4/OBkd3hKSbqaxHi534=;
 b=ncIjtPjXUtjEuqOdGZZhsNvnngoYsO6UpaAe+b2TNcVe8V+FBWe81b2g
 Sau8/Pu8e5kaZKF0MRpHiS2o981EJTC9iC8bxFOBgJbs2XdBbUWKSjHqP
 EL/t3F2hhgD06QzYEWQhOyL46co7Ttl+vTrlb4+cWjFVCXPWMqQO/vc5J
 /7QxqnrnrZrFUaGFuXm+DCqI39TO8wPkls8xdY6vNrP81/qIgbq3PLsrc
 CarKE0msAK6j9nvRjj77opuPSEKyN5tmtha5X1I8+zRkhfOLy9Dh5o2DV
 7MM24tKSBZWNoAWCdIJf+jczXhLpTrVg5xL4mvV88G/y1uPXDHmTz1ICZ
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ncIjtPjX
Subject: [Intel-wired-lan] [PATCH iwl-next v2 3/4] iavf: pass the return
 value of skb_checksum_help()
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

skb_checksum_help() can fail. Pass its return value back to the caller.

Commonize this software path in goto.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index ab46a49bb5e0..c5d4486c0396 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1909,11 +1909,7 @@ static int iavf_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			l4.hdr = skb_inner_network_header(skb);
 			break;
 		default:
-			if (*tx_flags & IAVF_TX_FLAGS_TSO)
-				return -1;
-
-			skb_checksum_help(skb);
-			return 0;
+			goto checksum_sw_fb;
 		}
 
 		/* compute outer L3 header size */
@@ -1990,16 +1986,19 @@ static int iavf_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			  IAVF_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
 		break;
 	default:
-		if (*tx_flags & IAVF_TX_FLAGS_TSO)
-			return -1;
-		skb_checksum_help(skb);
-		return 0;
+		goto checksum_sw_fb;
 	}
 
 	*td_cmd |= cmd;
 	*td_offset |= offset;
 
 	return 1;
+
+checksum_sw_fb:
+	if (*tx_flags & IAVF_TX_FLAGS_TSO)
+		return -1;
+
+	return skb_checksum_help(skb);
 }
 
 /**
-- 
2.49.0

