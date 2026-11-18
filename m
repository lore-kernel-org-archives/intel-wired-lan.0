Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3694606A31C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=iSKZraw6;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VRPkRRT5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEF0E60A7F;
	Wed, 18 Nov 2026 13:59:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u-nkFZF6hxGc; Wed, 18 Nov 2026 13:59:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F3DFD60A5F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795010382;
	b=OgUJDQ3WoB9ScxS4wIi9Oe5P7s/TIs21GTmButbJ1qq8UhP7JZ2dSiDZefyHdjoN1uCk
	 UBCYbsn6TQ6pcX5T30mcTI5i06C1NRz9Aba5ZabUOLJxv594WVDbDHLL1ynr4fv7m0v6M
	 0rCT/8A0C8p/fW5IIzQsoc75AUEtd2V0K05x6JuzGRAG+HImAEDuGLsWNSDuO958oJTS/
	 04quDNCacFkyRmBEV+iFuDkZMSezg0Q3FQ7N7y9kH0ZCLpuer27ocNw3FyLQ884rL1d5X
	 TpstA2TkMJgPK9Hv0S3C7sG1ZgsG19/P+9RILsy/VCXfWZaZkbN53I7A8JoPoq3uCPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795010382;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GP7puGDDFeGvcYskv5+V3DWNavHf2IpjjJXVWUaBZos=;
	b=L8xkZDqVjHIx9zQoI5ceWo3n42XyRZEItxW3nyOUGA754m2KiWg/J1U5HikWQB84MaoC
	 111eQP0v2B/ULxExyfHgTFnYU9/hCLTMllisdCkc3JB/bOSeJR90fQudExXKUcjNNNHCS
	 kOnIN7JyfNou4ei3CXAVNQYWq3aH4HiNvwIKQGogRfXULlN7rZXMA7jVcwc7RrU/y5aQ5
	 plwTR5G7w/+dGHCKvAZFotRM3e0wMEKLmDFC8HgyoZw9PGsQXaoGXOt+L/oHOEtTJ0AL0
	 g1tJvJY2fl6JY8KSkdN8YDfs/rToxeh99gAgzY4hQ3icFZiPKfJnwDctz3hI7US24ow==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795010382;
	bh=GP7puGDDFeGvcYskv5+V3DWNavHf2IpjjJXVWUaBZos=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iSKZraw6i6Y9WO1eGWakuIcl/TWHO6ky2Wy97S+FrSGop7w3mLtmK716/YGVrGcAK
	 hyki9RPobMg5COIRdGbmWu7hxGBzxchBNdGg18ZM2qbemxdUYf3TRBpM1xSP2kIln6
	 9p67DNa9PQzEidzG+mdxAOCugZG4Lw+2azZz1sxovxG5f6xe0Mzj/Sqgw5x4D67wKT
	 NAawfdfTyvkKIeGvVZxbdYsfWTN13ANxroXu27U2iSUSgpJZxx7KTdEpwN1Ff4ZP8b
	 kokfEOPyn2a1PZbm3ck8gz+P7oRdgWxlJKIeAYfgmqFuofb/13cdxZ8WBBWKSCsyDU
	 5SNeQaYt+d9cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3DFD60A5F;
	Wed, 18 Nov 2026 13:59:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F44249B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 13:59:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 650C881253
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 13:59:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dFM23VtfXYHr for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 13:59:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BAA5381208
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=magnus.karlsson@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=VRPkRRT5
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BAA5381208
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 13:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795010380; x=1826546380;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=O73LRgv//NgXCyf6hokdeVB4mH4QetHUATxUADGnpr8=;
 b=VRPkRRT5ip70JieuNXv0cOisusLPXGMihvjrCqqIe9qOa6VTR/5PeCnh
 vRz0IbzO1Blt3YiQ0FodaRs3a/TIq3rwMg3qiCBQBwDPWNZTstfiLIcpf
 LPNhLjpu5Xt9wWUiDS95+vEfAixEzi88AiZcws/d10HShVwzXKUD+JpCZ
 v8v9iR5Zc/veBAgWi5FFybkz76onQoEV6u6nOErdEMGgNhCkmyrthceHm
 fSR3Y9bpQ9exF4tbooihr9jBtW0B/xrpAnLhxys1b59XxuhxpfyFa158k
 dufT5ltNWoCnXq9PVi0onJX95HWhyoMbdSjxJS5j+/8cXqfaKq2rxtDft w==;
X-CSE-ConnectionGUID: a8gl3Df1RqO+oW7dGW1kHQ==
X-CSE-MsgGUID: 9Ip1SJMSQOuukPrptP6mog==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3741214"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3741214"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 05:59:40 -0800
X-CSE-ConnectionGUID: eLni21bZSAOKnWFwbZY5TA==
X-CSE-MsgGUID: jmRk2/quSwWqKc+716vYAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10031678"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by orviesa005.jf.intel.com with ESMTP; 18 Nov 2026 05:59:37 -0800
From: Magnus Karlsson <magnus.karlsson@intel.com>
To: magnus.karlsson@intel.com, magnus.karlsson@gmail.com,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 maciej.fijalkowski@intel.com, przemyslaw.kitszel@intel.com
Subject: [PATCH iwl-net] ice: reset xdp_tx_active when cleaning a Tx ring
Date: Wed, 18 Nov 2026 14:59:20 +0100
Message-Id: <20261118135920.1063665-1-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.38.1
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

xdp_tx_active counts the XDP_TX buffers on an XDP ring, so that
ice_clean_xdp_irq_zc() can complete AF_XDP zero-copy frames in bulk when
there are none. It is incremented for every XDP_TX frame and decremented
when such a frame completes. ice_clean_tx_ring() frees the frames that
are still on the ring, both through ice_xsk_clean_xdp_ring() and through
ice_unmap_and_free_tx_buf(), but leaves the counter as it was.

After a ring is cleaned with XDP_TX frames in flight, for example when
an AF_XDP socket is bound or unbound, xdp_tx_active therefore stays
non-zero for the lifetime of the ring. ice_clean_xdp_irq_zc() then
always takes the per-descriptor slow path.

The ring is empty after ice_clean_tx_ring(), so reset the counter
there, together with next_to_use and next_to_clean.

Fixes: 59e92bfe4df7 ("ice: xsk: Borrow xdp_tx_active logic from i40e")
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 35a480a1e172..f26646825a1e 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -228,6 +228,7 @@ void ice_clean_tx_ring(struct ice_tx_ring *tx_ring)
 
 	tx_ring->next_to_use = 0;
 	tx_ring->next_to_clean = 0;
+	tx_ring->xdp_tx_active = 0;
 
 	if (!tx_ring->netdev)
 		return;
-- 
2.38.1

