Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F6B10F9969
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Apr 2026 18:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0B3641020;
	Wed,  8 Apr 2026 18:47:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lB0kG_whue7E; Wed,  8 Apr 2026 18:47:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C7A6141000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775674051;
	bh=6BZRACkg6HCd8QTfUZiajdSXrt4t/7hWMQhstCE5isQ=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=gNFkh/9kjr7vgu+krO855aRrl44BPtq16mb3E0F3EvdePWFrAAbiqOS0MWW+LcCtt
	 JZSpDsNcftPGmCDi3tMlv07bBu/+g9x5i597z3ANMgtays356FxWGGeGG8YyVK797r
	 c8TJOrPP+tLVAB9G9RXn1n9hoDhr6bBrTYtPc0CZeTMgDIxGo8NJTUopkAW4JSSg+y
	 pehtLlmovcaiW8uZNaeGivkg2mg2G78ddJfc5WBHspUhsYID0E/cYMJqyWsgJus8Gs
	 +yw9ogsPJUO7kpxfSA58hQ2Lk9HVb+l23CbmqN5czmkhvELqaCFAU8+2jeyemez5e1
	 gcXkRU7/qmc5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7A6141000;
	Wed,  8 Apr 2026 18:47:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 37BF91F6
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 18:47:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1D53440383
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 18:47:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uFf3FqzH2ssW for <intel-wired-lan@lists.osuosl.org>;
 Wed,  8 Apr 2026 18:47:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5114140130
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5114140130
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5114140130
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 18:47:29 +0000 (UTC)
X-CSE-ConnectionGUID: sIgIqY7+SIOK0And13Xgkw==
X-CSE-MsgGUID: keuVBjXxQqCacXUzpXLv6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="75841382"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="75841382"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 11:47:28 -0700
X-CSE-ConnectionGUID: 8hAv3SWVTB6eEHvfPYVAnA==
X-CSE-MsgGUID: clAReoAlSWaVf9ZvYM4epA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="230217570"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 11:47:27 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 08 Apr 2026 11:46:34 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-jk-even-more-e825c-fixes-v1-4-b959da91a81f@intel.com>
References: <20260408-jk-even-more-e825c-fixes-v1-0-b959da91a81f@intel.com>
In-Reply-To: <20260408-jk-even-more-e825c-fixes-v1-0-b959da91a81f@intel.com>
To: Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, netdev@vger.kernel.org
X-Mailer: b4 0.16-dev-306a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1919;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=R6AxwX9GU8IMz9cc9hHesk4hswO49vClh2NXD0wCyaU=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsxri/Y+bSrduCnDdYNNGJPPVBP12JaMpDUuKV9mhBSf5
 lS/e6Gmo5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgIncn87wiyl3veh+2e1PH3JP
 NFr6wmrN072BHdc+fVv19YBH3oOvmr8YGd6s//mjPfNjgKXMGqG9XYfnMcSslPmd8VlFflkDC3N
 EECcA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775674049; x=1807210049;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=R6AxwX9GU8IMz9cc9hHesk4hswO49vClh2NXD0wCyaU=;
 b=WmVl2axIpajhgQfl9wz3i1FqVVUGYT9/BFTpFFxnc0+MqZjXQyf9a0pe
 BIT6yDXNXn8HqkHn2TKKqSzbe/TITvRJXyg3vliGF1q4Sckz7UpSiihkt
 UZyZLIYeJldUA6kBjtgBjfgpsAFi9J0/8j2xtT/kwia6ZswpO/nngioGO
 MvnmdPqe2KrCDZrbR0JTFNyjQPuxRnQFysvjq/hdjA4kMm+Q+dXlQHimk
 xqaSA48QLaSjJL2Ny8sPveeG0jp2VNlYmn6Fegc9Xp5uMRI8yrwC04gsJ
 WawptFwkhbq53ryDWm+mj91vjhv/w3DX7tfoZAVrbv83co6eRzvoiFPV9
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=WmVl2axI
Subject: [Intel-wired-lan] [PATCH iwl-net 4/4] ice: fix
 ice_ptp_read_tx_hwtstamp_status_eth56g
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
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Timothy Miskell <timothy.miskell@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The ice_ptp_read_tx_hwtstamp_status_eth56g function calls
ice_read_phy_eth56g with a PHY index. However the function actually expects
a port index. This causes the function to read the wrong PHY_PTP_INT_STATUS
registers, and effectively makes the status wrong for the second set of
ports from 4 to 7.

The ice_read_phy_eth56g function uses the provided port index to determine
which PHY device to read. We could refactor the entire chain to take a PHY
index, but this would impact many code sites. Instead, multiply the PHY
index by the number of ports, so that we read from the first port of each
PHY.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 64ad5ed5c688..672218e5d1f9 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2219,13 +2219,19 @@ int ice_ptp_read_tx_hwtstamp_status_eth56g(struct ice_hw *hw, u32 *ts_status)
 	*ts_status = 0;
 
 	for (phy = 0; phy < params->num_phys; phy++) {
+		u8 port;
 		int err;
 
-		err = ice_read_phy_eth56g(hw, phy, PHY_PTP_INT_STATUS, &status);
+		/* ice_read_phy_eth56g expects a port index, so use the first
+		 * port of the PHY
+		 */
+		port = phy * hw->ptp.ports_per_phy;
+
+		err = ice_read_phy_eth56g(hw, port, PHY_PTP_INT_STATUS, &status);
 		if (err)
 			return err;
 
-		*ts_status |= (status & mask) << (phy * hw->ptp.ports_per_phy);
+		*ts_status |= (status & mask) << port;
 	}
 
 	ice_debug(hw, ICE_DBG_PTP, "PHY interrupt err: %x\n", *ts_status);

-- 
2.53.0.1066.g1eceb487f285

