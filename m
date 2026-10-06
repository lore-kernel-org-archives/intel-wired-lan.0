Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E4FCA5FFC
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 14:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 320EF607EE;
	Tue,  6 Oct 2026 14:41:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dpm32upla2kZ; Tue,  6 Oct 2026 14:41:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8D02D607DC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791297717;
	b=WGCjAuOIhJ/d9kculXjes4Nq8+CCV3mJGcuaaYKWTQJTHizkH7/HVXiLAHljhpMzX3Vz
	 NjtYFgj8o+/JuEnIBcDFclb8/GsSBssUswe6yYv0Cwb8blC3JvTaIajLqG5027YdSCW2x
	 80oAWO0prfkSWsJsaNYXVeKyZ1OZzwwK6z/3RRC5DmRKKcvSfyB4jIcOh+u222EmfSMXK
	 utae17fa7/i1rV2bDKr6fWP+d5Z44x3w18wbAw+Nxlo/q8ZuA0FrXbT7DsCNUNmOm3/8D
	 n8dpt5nuIWrPlnGDOxBi82x9KPUIHYdi+iCskmqa7N2h8J6Uaec0Rf5fRcJWRYjLiCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791297717;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3orEm8hcqC+mVIoM7h6bcGoww5v2MdeMfH4Aev4qIU4=;
	b=XXlQx6f7R1RmgOkqwiV+ajFnSm1OSljtV2o0Oxqg70y4tIDRSUS4xJLxTFg4EPwCLJnN
	 7FQv0pLbWN4310Lb2tH6fBLS71rhTwpqoG879kuaDCPibGLYFX20Sl65qfY5/ssF7rco3
	 UX77aV0e9lefyWwtVeqnjlXOARDN5GytPdoSGGnJX9UUfUsqO4EYGBUX8n4GETfQZv8x4
	 FCB7IXtgD0PgDReK6Ax0jLGVkoOUZJeXohF/NMrj2b0NxqNNGtOqWz2uYwWs11j+wgxoV
	 CjLBldq6dl5ES6hnV4RaBSE0DGGrlefUMnTDCb3NRfaWRbxp30qHqZ7SUy9l9G3xDBw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hjgVgjKR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791297717;
	bh=3orEm8hcqC+mVIoM7h6bcGoww5v2MdeMfH4Aev4qIU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HGPl1i+UHOo5MKFX9nC+EuYZ7fxPy3DD8xCPA3s2zWXUGy/kqKeBp2mZ+nlsQV2Go
	 UJVz0nVAfnWS5J7naL92Duiz4auiCm8nUDg+t9wDKnkfLo2CeSEl67cDoeOC8CXx26
	 ISUGv9e98m2oNb22YLH9B2k0+qWegkPTXp00CYEWIR8pzW5dmZqM74Wi1erMh6xI/p
	 AcZoHUF/Ow0XxyjRUBLLxmm45XeogHui6O+pEIFmUn6OkkSMPZzApDvP9AhQleYA4j
	 sP1edxdm4ruq8y9XKifNIolTQpPz72byz3PrlVnPf1bom2nc+BmYmqU0CM/zEnxV9p
	 O8l7Falyusx/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D02D607DC;
	Tue,  6 Oct 2026 14:41:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4173B1D2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:40:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2772D6062D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:40:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fGlWo27Bj2u4 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 14:40:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C91D8605D0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791297629;
 b=p0Nv+5wKfFgzLPKsnmJuE7mfXAfiFVvQTK5PC6e0k6FsVauSKrGV/wXSmdguFXwcQudt
 oRCNwL9H5wEobjkG23cKNlxN/N15gd9XMJg9C4CUZRiH78wwfhmNKfTKjdHBdqMkEcEmT
 F0fVksJZsgZCPmfqC7hYGzQKdmov8JN+cwqwL4exXuoLvAEDhXKerCnm4ajgpStGuk/0p
 WAztlVuqOZcqAH2mb8H+n+Zj8y820fu/IHrYDflzJDAEzmATmlE3+5Aen1eDTbrDhhuaK
 uu/twKYcVte87aYq9mOkODLctEHBfGO0hFX3Syk3/1ZRhWdX/p52HuyvDb2hfAnwSrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791297629;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=3orEm8hcqC+mVIoM7h6bcGoww5v2MdeMfH4Aev4qIU4=;
 b=Xup+rckeHiVncdQIhl46eIMnDSSReOgaS5lkdh6ayWC5u18w2E7zKvYelgEvP5/LNuwP
 lgMyW1FnX5CSzkdm2JMLLtxP2XJBOrICITgaEXM7w7Fi4VyMDb32qvQ+Mq1GBS2vu3MKP
 4Uy6gw9EXQWDrMkj+psSEsn0xPa8pFGS3FH2zvFNSoYpFFZ0vpngFzhA6/CGyBS2d534S
 v2RtTymrLYC08JQJtKVnFqZVb2eSDWfOXUe/Nnjc/F+8ti1TxCeGNfGZph1EOoknerVd0
 tmboSICpI3TAdoPQMr/OL6Z/1djfttWHjRIKmlpn1d9pclBt6Lxc/BwDMAHJXvnjo4g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=hjgVgjKR; 
 arc=none smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hjgVgjKR
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C91D8605D0
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791297629; x=1822833629;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JPtpG/SLb17KoPiu0yd4nZOFbDXvdMgkMZD/W2E6oZQ=;
 b=hjgVgjKRjK5I7CN91njtulItuUdtdnS2SImufIxMB1UaeRO6nENP3hVd
 7+9Xp4znZMLFEDaAZhe3fgsEGBazqQFT9fUQeHv/oNb0ZNB4tFL04YNVE
 ig95cyp1jOc+ZV7JAtQbvLBBt0AoK+t8Qk4TDCL6SK5rn6vbDx+4I/G90
 8RhTAQXFV00sOYKqVlBnoV+te5hvX9ichiNp9ngPsTQeiEMDjhsJymNqi
 I/GzJOMF1gmrpCPOGcpiREIlzfNVuAVkDTNG+Si+rxwbmxChyK6EA4G2J
 95bIidpt94Puid2Lt8qSKx4KPKZBJCyCx0UU9JXeDwqMcj0fFrzvBYWCR Q==;
X-CSE-ConnectionGUID: PpPIbdaYRCiPiNk7Yzzi1A==
X-CSE-MsgGUID: gUDt0AgOT1Si0bQVfDVopA==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="108363429"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="108363429"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:40:27 -0700
X-CSE-ConnectionGUID: otfIMbVKSc6Ad/iHp3uTRQ==
X-CSE-MsgGUID: O4ncoCSlSf6kUYoIjdoRIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="315187511"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa001.jf.intel.com with ESMTP; 06 Oct 2026 07:40:26 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v2 4/4] ixgbe: add IXGBE_ITR_ADAPTIVE_MASK_USECS
 constant
Date: Tue,  6 Oct 2026 16:40:18 +0200
Message-ID: <20261006144018.2885932-5-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261006144018.2885932-1-aleksandr.loktionov@intel.com>
References: <20261006144018.2885932-1-aleksandr.loktionov@intel.com>
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

From: Alexander Duyck <alexander.h.duyck@intel.com>

ixgbe_set_itr() clears the mode flag (IXGBE_ITR_ADAPTIVE_LATENCY, bit 7)
with the open-coded complement expression ~IXGBE_ITR_ADAPTIVE_LATENCY.
This is equivalent to keeping only bits [6:0], i.e. the usecs sub-field.

Add IXGBE_ITR_ADAPTIVE_MASK_USECS = IXGBE_ITR_ADAPTIVE_LATENCY - 1 =
0x7F to name this mask explicitly and replace the open-coded AND-NOT
operation with the cleaner AND form.  The two expressions are
arithmetically identical; the change improves readability.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 05d0049..41f4329 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -478,6 +478,7 @@ static inline unsigned int ixgbe_rx_pg_order(struct ixgbe_ring *ring)
 #define IXGBE_ITR_ADAPTIVE_MAX_USECS	84
 #define IXGBE_ITR_ADAPTIVE_LATENCY	0x80
 #define IXGBE_ITR_ADAPTIVE_BULK		0x00
+#define IXGBE_ITR_ADAPTIVE_MASK_USECS	(IXGBE_ITR_ADAPTIVE_LATENCY - 1)
 
 struct ixgbe_ring_container {
 	struct ixgbe_ring *ring;	/* pointer to linked list of rings */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 3325eec..d2d8836 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2968,7 +2968,7 @@ static void ixgbe_set_itr(struct ixgbe_q_vector *q_vector)
 	new_itr = min(q_vector->rx.itr, q_vector->tx.itr);
 
 	/* Clear latency flag if set, shift into correct position */
-	new_itr &= ~IXGBE_ITR_ADAPTIVE_LATENCY;
+	new_itr &= IXGBE_ITR_ADAPTIVE_MASK_USECS;
 	new_itr <<= 2;
 
 	if (new_itr != q_vector->itr) {
-- 
2.52.0

