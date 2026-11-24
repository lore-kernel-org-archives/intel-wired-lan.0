Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7D0606A32A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=eMv7XPM8;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KW1bkXp1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75213405EE;
	Tue, 24 Nov 2026 13:30:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c-WhudsPDy9b; Tue, 24 Nov 2026 13:30:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7C8EF405A2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795527003;
	b=XDzbJNpPV15F/kndrnD47gERU0suHnxbj29h2UTzHn+jluBz2NcIHtAjDXx/7ZTUx04T
	 Jq0Nn64zSwqIMMy8iZYW6N6p6Nz6KzKTfPFT3xdYX0dmg45YqG2g8A8MSmWEXyKAajryG
	 9ns3ERXU22fOg8xkpopdTCzrGJEFLVjl4pBc7ZQ0gs/6msIlg7PKmgsnrwLkrVeiI2CWK
	 GB6MK41+JveqqtduSDKRx/qc76TL3xdeYh5n1Y2cwO/zlwR/P7LWJrMQV9MnLtnH3lb5k
	 r54Sn6NCxKfTaf1jvuVyiqc4vgmEE5vyRqttPNFcy1/sHbwd+DayDIGp0hPOchsnOBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795527003;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8nLi0jNpi/3CcDARVUt+PZIVYh/lVnrkssvvVOe336M=;
	b=RRQf1uwl6nuatAyhg3+A7zi7qXSBcNsK+mi+YCaRUjIlGOksLXMLIOFGZB83luj+cfro
	 Arcu7nj1j+dt4WzlngXawSePn05uiMqpGNT0IW4w1TmbT8W5QliWEBgwGotZnVEnjW1Ts
	 TscUqi4KbG2DZQ8cIQgCVlXcRtPCsWJ94QwUaO2jp//hbNbnT6g6tRt7jGdRlR7ePqSEB
	 hLwfuPIgBPOXW3sRnpBZYz3LC5ByYrMo/IQ8wVBBAIRQGb22N6CXvgWm2g8HveHiBRmpW
	 IcbK0N//Lt3+mCDvjd7kxkrbYQBB2lvzSahMNtcGS+heCme6bf+xqM9u1BtN+imRJfg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795527003;
	bh=8nLi0jNpi/3CcDARVUt+PZIVYh/lVnrkssvvVOe336M=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eMv7XPM8Pzgq7d0wKzObK88TwXsuPpcT1Rxv+W5g/GItPXUKXgXstriewyYBMIQx/
	 2mORJdNozFs+3eE6RLnsMcrFGJOt+dLtLDB2eWMfwVdA9zyJabhRhsvENP8pRrlSIf
	 1e2yEKITa+QZnj0ZXVgA/EDU658pE9gQNiBftK0KrabHhajihFJSb8IUEHVdtl6aPv
	 Po88Xq8deMjzlaxqpcCUo1ZKQV6JTYAROAYInNdJwfSIO1HxBYLW3tuIYT6JmlZIMB
	 4mfFkBXTAJf+OcwUm4Op8WZjA49yAQ0SQe2kO+SuZZ4J/XzXrbtQ36gu9UcWuQpJ6+
	 DzE5tM47zBBpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C8EF405A2;
	Tue, 24 Nov 2026 13:30:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5562679D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 13:30:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3B49140116
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 13:30:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 637s5XunL2Fk for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 13:30:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4A75C400AC
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=magnus.karlsson@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KW1bkXp1
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4A75C400AC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 13:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795527001; x=1827063001;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fFSev9q0WZd850aMrdmF4lCdKERC6zVxM6Qlk1NtSJs=;
 b=KW1bkXp1Rw+mniWHNxnIaz8gcWeutiFmjITcJVFAUgySODgqADvBZiu6
 eFoqSq1c2rp3s04BsLL1sS2OVTX2koTckqj103BS3hvA7w33G4s2MZSVX
 X/VSsEXZUKtTl8dnNiQEddQBcOlH8D/QKOsROKLbnOyUv2muygj8B8tuj
 K9X/XLrJwwAbOhXU0C/b9CtkRA5sKcRjSBUAQ6+fa6zzIODblRWWu5Fc2
 ataobl4VbkS/qNlUVMWukCJCqcPM2nurF8b0D059yGtI8YXA93qYhT7ey
 2CuTySrbCXng4ccrdfkh2uhVzoNy6xpiS73ANKVV7RvFlYHJ/CJooZ6tM Q==;
X-CSE-ConnectionGUID: R4olmp6NQ/GiJBNB/zABrQ==
X-CSE-MsgGUID: 3cgi++AsTQuPOZgCleyS9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4381321"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4381321"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 05:30:00 -0800
X-CSE-ConnectionGUID: LBzHLej9RqioAW1RcHKogg==
X-CSE-MsgGUID: g7qIUsLwT/u7i20dPRGnHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11860456"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by fmviesa008.fm.intel.com with ESMTP; 24 Nov 2026 05:29:59 -0800
From: Magnus Karlsson <magnus.karlsson@intel.com>
To: magnus.karlsson@intel.com, magnus.karlsson@gmail.com,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 maciej.fijalkowski@intel.com, przemyslaw.kitszel@intel.com
Subject: [PATCH iwl-net v2] ice: account for XDP_TX buffers when cleaning a Tx
 ring
Date: Tue, 24 Nov 2026 14:29:42 +0100
Message-Id: <20261124132942.1102882-1-magnus.karlsson@intel.com>
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
there are none. ice_clean_tx_ring() frees the buffers that are still on
the ring, both through ice_xsk_clean_xdp_ring() and through
ice_unmap_and_free_tx_buf(), but leaves the counter as it was.

After a ring is cleaned with XDP_TX frames in flight, for example when
an AF_XDP socket is bound or unbound, xdp_tx_active therefore stays
non-zero for the lifetime of the ring. ice_clean_xdp_irq_zc() then
always takes the per-descriptor slow path.

ice_xsk_clean_xdp_ring() used to decrement the counter for the XDP_TX
buffers it freed, through ice_clean_xdp_tx_buf(), until that helper was
replaced with a plain xsk_buff_free(). Decrement it again for each
XDP_TX buffer it frees. ice_unmap_and_free_tx_buf() frees buffers on
regular XDP rings, which count XDP_TX and redirected frames rather than
buffers, so reset the counter in ice_clean_tx_ring() as well, so that a
zero-copy socket bound afterwards starts from zero.

Fixes: 59e92bfe4df7 ("ice: xsk: Borrow xdp_tx_active logic from i40e")
Fixes: a24b4c6e9aab ("ice: xsk: Do not convert to buff to frame for XDP_TX")
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
v1 -> v2:
- Decrement the counter for each freed XDP_TX buffer (Maciej)
- v1: https://lore.kernel.org/intel-wired-lan/20261118135952.1063685-1-magnus.karlsson@intel.com/
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 1 +
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 1 +
 2 files changed, 2 insertions(+)

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
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 0c1ce3e86a45..2d9dbdb82cdd 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -942,6 +942,7 @@ void ice_xsk_clean_xdp_ring(struct ice_tx_ring *xdp_ring)
 		if (tx_buf->type == ICE_TX_BUF_XSK_TX) {
 			tx_buf->type = ICE_TX_BUF_EMPTY;
 			xsk_buff_free(tx_buf->xdp);
+			xdp_ring->xdp_tx_active--;
 		} else {
 			xsk_frames++;
 		}
-- 
2.38.1

