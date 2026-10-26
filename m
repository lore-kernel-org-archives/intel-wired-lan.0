Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A442D606A31A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=eReEbq77;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iNWniAMy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 835D880F47;
	Mon, 26 Oct 2026 16:34:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 49BUyJBvrHyT; Mon, 26 Oct 2026 16:34:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D721E80F46
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793032487;
	b=WB6jTewDaLPhNNkkQyG4G91T4KLUL59LP3yAEc3B0pyN5F5G7LgD2Ba0KYOT755yvVpv
	 KPtT7QjTLBcbvY37kWJ+6v5A0Oy/e0CTFEbkfLU+MGmOPAayDEzxjYI2UKOZqm+yyzpAm
	 ygWhsUZ1bdOn7LFerNNJKjGfz8zndIn/aVp7KNZZpneFA6heyRiLgbEI2jgmaUhqXxAjB
	 k/8eGFuPQDJZKRMgfLoJYMfeQrCPBsUSlIs7y1ig7hp2pHjA7UKzjuGsqwC3wCZn8Gm4e
	 ocUecaHey+6P+ZIyGX6tKAm68t4jtK6+5t4YvMI7NCfnreHLRZOTgmdUkA/QXTVfzZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793032487;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=h2MSe46gbMo+mwzqaaiBKoZIORRsWv/ChOEDfBtLqGM=;
	b=VFKCRjc+dQgzfEIXhqjKUPhDNFd5e5mUhSatMTrntajVk1UN5YS4wtsi8gjq8Cgi5svt
	 SEEcuYKrSHwzzUCev6HikKNkF6mwyG3or0YaYzF8iiGiv1i8A7FZPIt971VENRuqAm1Gs
	 TqVkb+Vjn2FcBdj0VN6fiCruhrE4DF/Fklk8iQNG4aIJ7Y2tJBIlK0UqLqLCVyDjy+R2z
	 GKmQbG6rwdTn2auwTW1dw7Bb1aK5RnQ+++lyEZfnTEv+fox1LEk+suMe86XnyUwGFz3ZF
	 IW9aADCxmlEqvvGq1KQvUbGJQTvQ31fvssxR2Z5cpG1tmM8UQkHRdhxl3dWOggVyYFA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iNWniAMy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793032487;
	bh=h2MSe46gbMo+mwzqaaiBKoZIORRsWv/ChOEDfBtLqGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eReEbq773+VhzJ11jK0Tg6AWpTe8wXDqNrGnJOxWJwkn+R/6aKifO2FUu2aO9+frm
	 0aj+YQnkKWmtpgRzWwnJ3LKl8ylbD9x2VprusZOuQ/Sc7kL66JCet1LXq/PfWVglqY
	 pIAWnVJCHK08T0NvtBwJRG04cWyqgYSnzEga63JusUgPd4ANUeUhKbfqP+rDREpDgX
	 sJ7Rc2l0rVGd29ultbWqX5qaDNsdHM7wGeRgw3IX5A1wUH4MPCT0Suqh24ANWGurSd
	 wvtJyW7OrVkiiDuNcAeGSMZ8mbC28G6w5n+9wNFGwSFacMnTpIcg443tHsvyeMsqoh
	 DixD1GZ1pJOzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D721E80F46;
	Mon, 26 Oct 2026 16:34:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BDC4356
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 16:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8D4DA80F23
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 16:34:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 27-gXT2ZevRx for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 16:34:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BAA0380E86
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793032484;
 b=XYrErc2grAgj6ni8nG4gdCIlLYr6/0PmZ7guqHN1n8JTe2viTxhXK4DHCG0kT46mCj5L
 O7QyN0pSKMR3S9F2ZmIY1ss7Y0xfrJewm50whlAbh58qKhApwZv683Frcg6U2EZfB7Q1O
 smWC4rNTHvYiLOUMsqRbFJiXRjJTuwiHKckdnqJ9pUMRAiaCjCuKpohELnUsn8OSTS73e
 Wz4GDVDnqDjZEnKWv9HzAvt87vZimXFllWw4YSecXopXfhzvxrgoGNnsuFJiQaW/OKl2f
 LmruIvu30nPeeFHnrQ+QkCvrRHRHUiQ9imSisNQpSNYe5q+xcCne940gyT8FQ/Zf3BA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793032484;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=h2MSe46gbMo+mwzqaaiBKoZIORRsWv/ChOEDfBtLqGM=;
 b=iI/Lj5WnZpWUntd6r6AcQUmi5oqvoFnDyWMVWC6LKROYjplBw9G86Z0ZKoBnwx6nhPxG
 5OiAE5zFbCiVPo4wk0L/GtTt7Zp675hKQ5mXVg7Ur11t4HJV1WStkQydOTylgPHwpEXTj
 HxGoLPLWHZtt+57lEGC/mCo7Ter4hwr7OVHR5nfvwjRPVuKWyTdC/IgFERq0gAkWmYYfl
 Tqy6EQmy9kL9BDgSdp3+RBXx14odRATqk84QC2dZUT3u4NfFf22U1/tET1sLxqyY6V2va
 tl+cQAy4Bg7bDCIPowjrGfnRvmpjKS7ni66f50U9DxBuqvpj8KJcfwYRCcnw8JN87jQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=iNWniAMy; 
 arc=none smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=przemyslaw.korba@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=iNWniAMy
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BAA0380E86
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 16:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793032485; x=1824568485;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WuMsWnXlIdVttZJ6ZspVw5iLIyh2fcn3Z8uhla6/pnE=;
 b=iNWniAMyA259mTJ/Nyc/j3Alqg051whdNPTbeQOOVHIyusfY0Lan0CAz
 gVVGz+ZTVHq7WfGeNRGLP7E4bLPvLSNEam9ft74PVF2ayqMY2DL7tjlY8
 uLtZI9Ph98iQ9sXKbnxYw7tGbiTfd20KdV228xsTK+/reYx0bIb2gGUXC
 x/ItOicoRRg/SCIBs7n2Fh2SMBIKYfVlEyNKOMnPmyhQ9CwxdBU8n0KNW
 ZE3irqmjuzqHar6d/Go49BaqXfGZ7Qqd31rce62xbTK7HfzIKhw/YAAHn
 iyEFjGQm9otRmGM4pjBV2+iI1KlcM5RHAEvDnpVTl8ihWosATogmCBJwF w==;
X-CSE-ConnectionGUID: v4Hb3FWpTpmHJo+7f6x2zg==
X-CSE-MsgGUID: yGnTDln0RBuoiELDQAec6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1588038"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1588038"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 09:34:44 -0700
X-CSE-ConnectionGUID: ardUOQH3Rv6jYf1+cBpNOg==
X-CSE-MsgGUID: P0oRloDwT62dSBDIGC0B6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4708033"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
 by fmviesa007.fm.intel.com with ESMTP; 26 Oct 2026 09:34:42 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksandr.loktionov@intel.com, arkadiusz.kubalewski@intel.com,
 konstantin.ilichev@intel.com,
 Przemyslaw Korba <przemyslaw.korba@intel.com>,
 Milena Olech <milena.olech@intel.com>
Subject: [PATCH iwl-net 2/2] ixgbe: fix Rx hardware timestamping for VLAN
 tagged packets
Date: Mon, 26 Oct 2026 17:36:42 +0100
Message-ID: <20261026163658.2733471-6-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026163658.2733471-2-przemyslaw.korba@intel.com>
References: <20261026163658.2733471-2-przemyslaw.korba@intel.com>
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Timestamp in packet (TSIP) is enabled by TSYNCRXCTL.TSIP_UT_EN, which
covers untagged frames only. VLAN tagged frames need the per user priority
mask in TSYNCRXCTL[31:24], which was never set, so they carry no timestamp
and IXGBE_RXD_STAT_TSIP stays clear. ixgbe_ptp_rx_hwtstamp() then falls
back to RXSTMPL/RXSTMPH, which hold a single timestamp latched until read,
so a tagged frame is given a stale timestamp left by an earlier packet.
Filter type TYPE_ALL also clears IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER, which
gates ixgbe_ptp_rx_hang(), so a stuck latch is never cleared either.

Set TSIP_UP_MASK along with TSIP_UT_EN, add the missing register
definition, and extend the clear mask so the new bits are cleared when Rx
timestamping is disabled.

This covers 802.1Q priorities 0-7. The fallback itself is left in place:
any frame class the hardware reports with STAT_TS but without TSIP, such
as a QinQ outer tag, would still be given a latched timestamp. Suppressing
the fallback outside IN_REGISTER mode is a separate change.

Observed on a machine in real use: ptp4l over an 802.1Q interface never
converged, reporting path delay between 444 ns and 31 us and even negative
values, while the untagged interface held a stable 3 us. Reproduced by
adding a VLAN interface and running ptp4l on it, with no kernel
modification and no error injection. Tested against that reproducer on two
Intel E610 10GBASE-T ports connected back to back at 10 Gbps, where ptp4l
now converges over VLAN as it does untagged. No kernel selftests cover Rx
hardware timestamping.

Fixes: a9763f3cb54c ("ixgbe: Update PTP to support X550EM_x devices")
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c  | 6 ++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index 8dc6a009b62c..4be7450beea8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -1084,7 +1084,8 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 
 		tsync_rx_ctl = IXGBE_TSYNCRXCTL_ENABLED |
 			       IXGBE_TSYNCRXCTL_TYPE_ALL |
-			       IXGBE_TSYNCRXCTL_TSIP_UT_EN;
+			       IXGBE_TSYNCRXCTL_TSIP_UT_EN |
+			       IXGBE_TSYNCRXCTL_TSIP_UP_MASK;
 		config->rx_filter = HWTSTAMP_FILTER_ALL;
 		aflags |= IXGBE_FLAG_RX_HWTSTAMP_ENABLED;
 		aflags &= ~IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER;
@@ -1112,7 +1113,8 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 	/* enable/disable RX */
 	regval = IXGBE_READ_REG(hw, IXGBE_TSYNCRXCTL);
 	regval &= ~(IXGBE_TSYNCRXCTL_ENABLED | IXGBE_TSYNCRXCTL_TYPE_MASK |
-		    IXGBE_TSYNCRXCTL_TSIP_UT_EN);
+		    IXGBE_TSYNCRXCTL_TSIP_UT_EN |
+		    IXGBE_TSYNCRXCTL_TSIP_UP_MASK);
 	regval |= tsync_rx_ctl;
 	IXGBE_WRITE_REG(hw, IXGBE_TSYNCRXCTL, regval);
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index c2bd104e64bf..78067b49216d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -2283,6 +2283,7 @@ enum {
 #define IXGBE_TSYNCRXCTL_TYPE_EVENT_V2	0x0A
 #define IXGBE_TSYNCRXCTL_ENABLED	0x00000010 /* Rx Timestamping enabled */
 #define IXGBE_TSYNCRXCTL_TSIP_UT_EN	0x00800000 /* Rx Timestamp in Packet */
+#define IXGBE_TSYNCRXCTL_TSIP_UP_MASK	0xFF000000 /* Rx Timestamp UP Mask */
 
 #define IXGBE_TSIM_TXTS			0x00000002
 
-- 
2.43.0

