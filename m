Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD587606A31A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Oct 2026 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=DW21h/Fw;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eQ+gst67
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8A494072F;
	Thu, 29 Oct 2026 10:02:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ogjgiRjKmXYR; Thu, 29 Oct 2026 10:02:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 05A0F4075F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793268167;
	b=Jt2bmMybqqVqcv5TujCMw8OWMTJv3efX8tG07DSYChJXkp2OLt+qn4Yp7Gy1SKuDmLMi
	 xBugRBWm7uvXRtAPW2yS5P52RfRsZmg9OP+y4ft3ZsDGp3ZXA/eRZPxMRIdVBfTFo+UzU
	 EPIuM4IyzHOtPoojaTOfUc4BZYGK3v5/LRJDA8yLjkhV6NmrZH/rTHe/GNtc5uIqBJ81/
	 ZSFMORl3rmM0OrqgJ/g0Hv5vz6hCQtatJIaqmp2C3K8h93vpRPcuQHNau/gs+hXA9PbqY
	 kN/bhGd6zOeSClqaNvcsQ/gHxJQNV6AHhdQcdzsMavaDLdMqmZ0GDNzEZhiVhpbe0vw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793268167;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IyGs0oSHAtbs2mxxPm60s2symHBAMWAEKJTwjp6besk=;
	b=GOWPc3TX2CMlQvdti0QW9UYvB/bJHL6GehSlA8/8pH9Gr1zvxqinHOE6hfPYtIEKgb2C
	 8i32A+WsKacrnzL2UkN0EsYGpfeeVF2eUT/NgmboArkUkhqPmPEPVBhwV9CKrwjRYTX6p
	 IAF6w/xhcIm9JqCGk9yENw6LCISIlL4zKEn5GFNCxNkf+MsiqXP9Hi2pGH5Npi32JOgbr
	 GTNjNcIdh9DFT8sYDui3PmO8sXDGt03tvasvIw6p+3HOLdzvfpH1dcDhQd+9M3qgH6sBG
	 AH5aK2lLs9NrzQQTrZ3t6m7pMnTfkcAPiIK2Hm7N/j+EKZLS7XAC61n7mEaDSVZpDPg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793268167;
	bh=IyGs0oSHAtbs2mxxPm60s2symHBAMWAEKJTwjp6besk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DW21h/FwqC6cMnhuj76KuW3KPZFYE/zrRoYZiExQWpEb3MQY4/91wN42BFARx49Tw
	 Tq+fCcS62QoKVj878zl0DceUkfGw2DfkVM7V+DTTUTujtHQ0eseeM54zA8BwCiWRAF
	 As3NFzTkZ1FzO+MT62YyNnXWM3OnbqXqSfipWtf4ySZlajAeJcErWbb4oEiKVZ0h2C
	 eJ+pXuZXFy4jrIXPtkf7rlBBp212zeJ5WYudHdBcqZQ7ZtqcwzKj88Jm/+bmYrwwim
	 PaVludB9AJYc+WEkU1ivzwo4kBfOuKSMuJAkP32Fx05qPE1ji/JUhRjwRZwR5KTF51
	 u4o367eMcRLxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05A0F4075F;
	Thu, 29 Oct 2026 10:02:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 18786972
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 10:02:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A953605CB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 10:02:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y9wq_fs22uiV for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Oct 2026 10:02:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 40E16606BD
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793268164;
 b=io+Y/yMOwi3qp7qGIIkeA38QVXKV3Dn32kSZOK9KfbQtEr8VBqcNbLoMQe+QQhw+I/HO
 Hk5IE9wLQHCbZPKM1HAY9GOdnz2eRQybOOc0aKDmUXmyK8b3X7YMmWCfjnerz+twGE1Ir
 4oqCp8296vPksVUGWGGZ/flzF46x1j5HgpyGnN/1OEqeK45uYeW0S543hzjWzqqKS74MG
 VHhePKjbfD734pLFHUVe23yiroWr2yE2S0cIVxWd10cpCY53ba+Q1R8YXb6IilhQUyTK8
 kqA5Mj/myX2I5p46lVmiMTbw7OL3Xt4nquvyqQ7HVllZQqsI9SR7kyQruw+pSidJ7vw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793268164;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=IyGs0oSHAtbs2mxxPm60s2symHBAMWAEKJTwjp6besk=;
 b=rMfihfRCqyxSwjCDftCiegJ/FdMn999NapPwUudeB2VAu6rzc96+zSn2RflKWNkAISm3
 l3Et7mHMldpZnvYsLnVmB7bfjCMn+Et0foT3+g93in63n6u1nYxRl4yO2dLwljlGvRl1V
 bWzCdUZMzeStUSAs3d1Ax5vivPhEZoAFFXDSSULdNyt/tAP9+VUvvSsucH5Ukw6Nkv5eb
 QNNfrgqTnUtjTXqMn4LP8J44fWRSpDFrzx+M9EUFECRUBEFA+0kmhuYjJXHEpfZJjwNMo
 G59MCi3ITo9sw78V0FNM8vLh/TEJp5dDo6hreIN1UizhEQ3q2/5Y1scteNDCpmxsJYQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eQ+gst67; 
 arc=none smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=magnus.karlsson@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eQ+gst67
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 40E16606BD
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 10:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793268164; x=1824804164;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BJDb+bsWnvYnsrivn4XI1TjgKSxV7vdx8Kla7pRiOWE=;
 b=eQ+gst67dov36z5KtnZ+Hi9ZwpaMAFTFQ7hamelFmkLUTiC0WkaLoJ5g
 zW219J6UGQ0k+g9AQfFJyTG+RO4XJOo/kwiN6hnLEJeLFTQpioFjRoH6/
 UOFrKGSAYIRdGrCllpSZHhBOQRqD6LFdfqaPkvBDfwC5lPcIJQQtmwown
 lmj1ZmW0onQwA6wJfdIWhcbPnVPRomCF2LL8JjIC5mulmH8MwgYPuItcJ
 vR/XxhU+z1/ZtxjV7t547N7Vnx5K0YA8/gDkDNU0P18bHgxHW1lRMVPh5
 S6bSLR3CLNw/xdgOnWsfkP8QiXYSkNCcInCOOnpmcTr4DVS7sY1xMynPe Q==;
X-CSE-ConnectionGUID: 8uek0KQeQb6iUo3PRiqXwQ==
X-CSE-MsgGUID: vcrlmKAkRheVB8j6kMvCKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2017765"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2017765"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 03:02:44 -0700
X-CSE-ConnectionGUID: Po87ADn1S7+t9fhvlXQzdQ==
X-CSE-MsgGUID: c1t4zepNS5mYjBqjgdE9dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="6941151"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by fmviesa011.fm.intel.com with ESMTP; 29 Oct 2026 03:02:42 -0700
From: Magnus Karlsson <magnus.karlsson@intel.com>
To: magnus.karlsson@intel.com, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, maciej.fijalkowski@intel.com,
 przemyslaw.kitszel@intel.com
Cc: Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH iwl-net 2/2] iavf: fix USO for 32-bit systems
Date: Thu, 29 Oct 2026 11:01:59 +0100
Message-Id: <20261029100159.920118-3-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261029100159.920118-1-magnus.karlsson@intel.com>
References: <20261029100159.920118-1-magnus.karlsson@intel.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

That USO works for 64-bit systems is just pure luck. Currently, the
computation of the UDP segmentation header is performed using sizeof()
a pointer instead of the sizeof() the UDP header that the pointer
points to. Since the UDP header happens to be 8 bytes long and a
pointer is 8 bytes long on a 64-bit system, this works on all those
systems. But no such luck for anyone using a 32-bit system as 8 bytes
!= 4 bytes. So fix this by using sizeof() the UDP header that the
pointer points to instead.

This was found by an LLM while implementing something else that used USO.

Fixes: c91a4f9feb67 ("iavf: add support for UDP Segmentation Offload")
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 8982cf75466f..2c290d7788d2 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1807,7 +1807,7 @@ static int iavf_tso(struct iavf_tx_buffer *first, u8 *hdr_len,
 		csum_replace_by_diff(&l4.udp->check,
 				     (__force __wsum)htonl(paylen));
 		/* compute length of UDP segmentation header */
-		*hdr_len = (u8)sizeof(l4.udp) + l4_offset;
+		*hdr_len = sizeof(*l4.udp) + l4_offset;
 	} else {
 		csum_replace_by_diff(&l4.tcp->check,
 				     (__force __wsum)htonl(paylen));
-- 
2.38.1

