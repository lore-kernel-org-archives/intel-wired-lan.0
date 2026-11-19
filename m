Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB96606A330
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=jIGNVgO9;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FNet4chP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C96F560D8D;
	Thu, 19 Nov 2026 14:12:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2mi32qJaDEwV; Thu, 19 Nov 2026 14:12:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B9C7060D7B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795097530;
	b=ebbMZSG/vP/9O/RQ6Lpr3q/cQIryPwybxgImpkKH2C/BozsExXt7Y46dQtRVuhTqD7bI
	 GLPuj1ogdhj5mjk/4IxsZO21EbMexYboKkfaF2w1tUZ0i8rlxyXbq1OrbUWHsx3VFTz/C
	 Vbj7l5BatJBkwkWPvbdsInUDtrKQUbLWYbvV1zXYPbKtNJJitK90kYGJb5+ghyfcUdsRG
	 cV0i/jYEG27c7QX6Q9VunO7exnE1GucFkJbBcd+BqoaVZQGG6k+q653xZCaW+GWn4HQfq
	 nsTW9yV/TkGwSBQBMTMkoVx2NnuNq3945ESAbtmKc7UL5eU2u0J7yACTJFAZN2HAofA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795097530;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ByWK1YCGVSNc/h5YBvelTmidZVWgMT9x4ETZP67cNCU=;
	b=W86CbatmlcX21Z61oo1D7a0ChMPZ6xbhT8XqUnMeHApu2BjTKELD9cW2SiOEuZ36xtQ2
	 81dESsOQnzyFaRA+pxN5zzt61g/KPXR7uiLZqG0Oj/ZCptuNaoKI41fEf7FCyhbTa2diu
	 rEYAkXTwdHt0Ahny/1ingFzK6A5J/+0pMqQ5dib0HCT6mELC/55JlM8PL9JWQZZXAmi4I
	 IJhTPR+cOhcIy7pkWwHVk6UExjX0DZxWztP8U1lvp+Wf9hooVj2t0eyewiKMbtmMv9zpO
	 x+OPBtc+OvcMRzZCqGG2Baf66Zhh5trLwGoZlCEprH7uvvD/FhZDieMk0wCL4v6c0bQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795097530;
	bh=ByWK1YCGVSNc/h5YBvelTmidZVWgMT9x4ETZP67cNCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jIGNVgO9lFnlrGPwQA6Wlsoj4M7o4R8OCkYlOgxfASqqRHuLjXwhcHpZi1KYq+lHD
	 MvK5Zl8inh4lrSgQQoeNIuLKp5gM7U7OvNfh03BUf6wFCs/1gONhwTkltw2bzg/3Nx
	 VIVsRUQq4NvNN+9TzQQAjqYZ9Bz1Cx28rKNy/jSgmwkp1D/OaAwDNTDm3PYtVpZUqy
	 yEFe4N8ctoSVjHdwy6ovrN+F7u033bPHiZpJYCk05BTgusGws47Oq20V0mCwCxZ4oo
	 sCGVBGS5EKC3At0irJ3XpGWwhOjRhSum1+Py/bTR9M4GvYOo9hiP/OgwBhaQS5ZW5Q
	 k3xeSJovzXgEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9C7060D7B;
	Thu, 19 Nov 2026 14:12:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 38D0E1C9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:12:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1E62340544
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:12:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V39csaeykCY3 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 14:12:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6EC9C40542
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=aleksander.lobakin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=FNet4chP
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6EC9C40542
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795097528; x=1826633528;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9vebLE46OBdUROJUS3bix/KJ+ukxDZRcsmGJk6frAy8=;
 b=FNet4chPd1unvcKLpXgLZrd4pJ09aNmw+U4SSvpOt06QH3Cti5CqiAmt
 HqXEw8Ar9khgJirf5Cd/Nrb3Dzx8gL96awoVD0vJ7V+0EH/+++IRE1Mfw
 x82ZT/LT8YKRcIp4aZlbfV2U/RiyT3e+Ffvuk8fSEM77tcRvOzkdwrEjW
 OMV38PHXOQ/nLRluCp465ukEe8hrrxx/ZbOR4A4znHIFT/rcPGpiNsz5C
 R2t7LTVOhvGBO51ztB6M4Asub3Z8X8K87g5YkMMfxHJMhb9gEmfJNBtaD
 V5lSJZpeC7rgyUnDhwZ/dWEKfbj9RKPOjFGB/3mZXq56uRh6pUYTF/cF7 w==;
X-CSE-ConnectionGUID: rRMUG/w2TY+6QSBldCd5Jw==
X-CSE-MsgGUID: TZJzE9qBTge68aGNeh38IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3835634"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3835634"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 06:12:08 -0800
X-CSE-ConnectionGUID: lcP3UfoOQ1K5kg6a2/zWOw==
X-CSE-MsgGUID: 3NWrlUDeS/KGX0aHSFDOZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10476156"
Received: from newjersey.igk.intel.com ([10.102.20.203])
 by orviesa002.jf.intel.com with ESMTP; 19 Nov 2026 06:12:06 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, stable@vger.kernel.org
Subject: [PATCH iwl-next v3 2/3] idpf: enforce strict ordering on BE when
 reading XDPCQEs
Date: Thu, 19 Nov 2026 15:09:37 +0100
Message-ID: <20261119140938.1363722-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119140938.1363722-1-aleksander.lobakin@intel.com>
References: <20261119140938.1363722-1-aleksander.lobakin@intel.com>
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

On Little Endian platforms, everything we need from the completion
descriptor is read at once, while on Big Endian we read it
field-by-field. Depending on the compiler and optimization settings,
reads can be combined or stay distinct. The latter leaves us with no
barrier and with possible stale completion index or tag.

Change the logic a bit and read only the "readiness" field first on
Big Endian, then perform strictly-ordered read of the cookie after
making sure it is valid.

The Little Endian code remains intact. Found by Sashiko.

Fixes: cba102cd7190 ("idpf: add support for XDP on Rx")
Cc: stable@vger.kernel.org # 6.18+
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/xdp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index 1d8ed7ac3e17..48320ea004df 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -236,8 +236,7 @@ static int idpf_xdp_parse_cqe(const struct idpf_splitq_4b_tx_compl_desc *desc,
 #ifdef __LIBETH_WORD_ACCESS
 	val = *(const u32 *)desc;
 #else
-	val = ((u32)le16_to_cpu(desc->q_head_compl_tag.q_head) << 16) |
-	      le16_to_cpu(desc->qid_comptype_gen);
+	val = le16_to_cpu(desc->qid_comptype_gen);
 #endif
 	if (!!(val & IDPF_TXD_COMPLQ_GEN_M) != gen)
 		return -ENODATA;
@@ -247,7 +246,13 @@ static int idpf_xdp_parse_cqe(const struct idpf_splitq_4b_tx_compl_desc *desc,
 				IDPF_TXD_COMPLT_RS)))
 		return -EINVAL;
 
+#ifdef __LIBETH_WORD_ACCESS
 	return upper_16_bits(val);
+#else
+	dma_rmb();
+
+	return le16_to_cpu(desc->q_head_compl_tag.q_head);
+#endif
 }
 
 u32 idpf_xdpsq_poll(struct idpf_tx_queue *xdpsq, u32 budget)
-- 
2.56.1

