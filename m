Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0474D2FEF8
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Jan 2026 22:31:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C02D8174D;
	Tue, 27 Jan 2026 22:31:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HRr08Pg9ygZu; Tue, 27 Jan 2026 22:30:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD4A6814AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769553058;
	bh=FzQecqOgEVlC0HrE6tHGzBGEOGeTxGqu0rBIkcHnhtA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LCO5ADX3VnwAmg0rVnxZTtSnfp4A1UorNWKk4ift0pQmp4Ex7KhHmv9Ipm4vZ9IjL
	 35Xq812WhK/AcAe05Xr5QLoOglhXpcEWgg/wNyNBTa2rayMbq8er9P2Uuc2w4DwnFM
	 WLKDAbdEeQAtKUHz3JG3uVtajc0dHZmxVUgh6NsgfezRkJCaX+Gh9Bn5B5sTG74Xy6
	 nnElykeM04pcHacoq0e1FpujH0upQxftzyMBvffn75abBbYB8+dxewCdc/IxLrDyac
	 6uUKcVMQ4McnPWKIKpTvuuZGP2lF3WCp0GlNN+Y6OC6Rl90NmGQAoP4pk45pSy1ix6
	 BFC1D0h4s5Rtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD4A6814AB;
	Tue, 27 Jan 2026 22:30:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 30D58118
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Jan 2026 22:30:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1403E408F2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Jan 2026 22:30:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rOIU4QOLP4wX for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Jan 2026 22:30:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E731B406F9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E731B406F9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E731B406F9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Jan 2026 22:30:55 +0000 (UTC)
X-CSE-ConnectionGUID: E+mQrDnjTFuBhK0/iT+xww==
X-CSE-MsgGUID: l6E7viHTSumAUOAU1YPG1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="93418619"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; d="scan'208";a="93418619"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2026 14:30:54 -0800
X-CSE-ConnectionGUID: iXc07w0xSmWb2XTHdNCqtw==
X-CSE-MsgGUID: HeeSEK8US9GfyhSRPNODhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; d="scan'208";a="245714648"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
 by orviesa001.jf.intel.com with ESMTP; 27 Jan 2026 14:30:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>, anthony.l.nguyen@intel.com,
 jbrandeb@kernel.org, przemyslaw.kitszel@intel.com,
 jacob.e.keller@intel.com, IWL <intel-wired-lan@lists.osuosl.org>
Date: Tue, 27 Jan 2026 14:30:45 -0800
Message-ID: <20260127223047.3979404-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260127223047.3979404-1-anthony.l.nguyen@intel.com>
References: <20260127223047.3979404-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769553056; x=1801089056;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e0I4SBy3yMZHfTqRdAw1mnt5JfamU2pL9w0ooXrEd2g=;
 b=J/n6jGjp5sZKD2sSYZUlEvd3iMJTbejaly+zKN4f4vXU7SXS2bgWx4Ng
 fA95h3HDTg74Sr+Jiz1o9lld0mIVOWWZh0GWpRRQPkRhAcRwHseiSuNnQ
 Uzh2V1TIeFtwRI3fFZf7uIkemTIVLY/alt0hxMQ02hlPmt1mKDLEISucX
 7unp/isR9m9amFnibx0sL9c92oojP6Bc0vZ/EnHLfXcQ6eqnIWYd+YEyu
 CF0qgUYyemuu+wVuS50S60PPl14slgDbVUG5t5VP3C8gZ0bqGDZ4fgmsd
 jmT+Br7O43mcuvTRcCrs/Y8IAmKm2diEoKPhSQRpqxhDl6sdiW8rd5qyS
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=J/n6jGjp
Subject: [Intel-wired-lan] [PATCH net 4/4] ice: stop counting UDP csum
 mismatch as rx_errors
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

From: Jesse Brandeburg <jbrandeburg@cloudflare.com>

Since the beginning, the Intel ice driver has counted receive checksum
offload mismatches into the rx_errors member of the rtnl_link_stats64
struct. In ethtool -S these show up as rx_csum_bad.nic.

I believe counting these in rx_errors is fundamentally wrong, as it's
pretty clear from the comments in if_link.h and from every other statistic
the driver is summing into rx_errors, that all of them would cause a
"hardware drop" except for the UDP checksum mismatch, as well as the fact
that all the other causes for rx_errors are L2 reasons, and this L4 UDP
"mismatch" is an outlier.

A last nail in the coffin is that rx_errors is monitored in production and
can indicate a bad NIC/cable/Switch port, but instead some random series of
UDP packets with bad checksums will now trigger this alert. This false
positive makes the alert useless and affects us as well as other companies.

This packet with presumably a bad UDP checksum is *already* passed to the
stack, just not marked as offloaded by the hardware/driver. If it is
dropped by the stack it will show up as UDP_MIB_CSUMERRORS.

And one more thing, none of the other Intel drivers, and at least bnxt_en
and mlx5 both don't appear to count UDP offload mismatches as rx_errors.

Here is a related customer complaint:
https://community.intel.com/t5/Ethernet-Products/ice-rx-errros-is-too-sensitive-to-IP-TCP-attack-packets-Intel/td-p/1662125

Fixes: 4f1fe43c920b ("ice: Add more Rx errors to netdev's rx_error counter")
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jake Keller <jacob.e.keller@intel.com>
Cc: IWL <intel-wired-lan@lists.osuosl.org>
Signed-off-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Acked-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index de488185cd4a..71c6d53b461e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6982,7 +6982,6 @@ void ice_update_vsi_stats(struct ice_vsi *vsi)
 		cur_ns->rx_errors = pf->stats.crc_errors +
 				    pf->stats.illegal_bytes +
 				    pf->stats.rx_undersize +
-				    pf->hw_csum_rx_error +
 				    pf->stats.rx_jabber +
 				    pf->stats.rx_fragments +
 				    pf->stats.rx_oversize;
-- 
2.47.1

