Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A897E9A03B
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Feb 2026 23:03:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8AA2406EB;
	Tue, 17 Feb 2026 23:03:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E5uVE5Tlc204; Tue, 17 Feb 2026 23:03:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A34A8406E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771369389;
	bh=RybZ0KMeO4p7NLO6E13DWbAbZPecJd/yBQ0NZNQJYr4=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=ANR8ugiqaWTIDiprxYjW1oYfIap3cVEshf963FyfY0ZsjxH2WPrV98uGYADMoQ9O2
	 Yuzex2IEyIFFL1SYeEjPZypXhbQde9Lj/nqx14UZ0Cb0tV4zs7TBD2iema0wQIMckQ
	 zAz40Ok9qWmnnXgZ4MJ/UzVCQI6ujHxoImg75BTUHQGGMk6itEtcSCqV8EzXiPzjtA
	 OFhKX3jWIkF96WnrzbfuraBj7stM5xv+LtNe9/TYXi04xZGvOKjBGq+GGR0tqogh7q
	 lls8gNwOIjVJsBmH0IG1WC3B2F0wwC4u2rLisC7c1HIcEo/NOlXDB9Tzk4mWAbOgIe
	 6ymD0j7yOj/xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A34A8406E6;
	Tue, 17 Feb 2026 23:03:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 733A9270
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Feb 2026 23:03:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 57D8940262
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Feb 2026 23:03:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uGdxpmZUgHQI for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Feb 2026 23:03:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8E0E340248
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E0E340248
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E0E340248
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Feb 2026 23:03:07 +0000 (UTC)
X-CSE-ConnectionGUID: wBobFoGyRzWXJy26q7ie4w==
X-CSE-MsgGUID: oA8T/BSdT/uRRFZiBbtuSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="72541561"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; d="scan'208";a="72541561"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 15:03:07 -0800
X-CSE-ConnectionGUID: qR4X/p4tQaWBRVbfjFOlPw==
X-CSE-MsgGUID: /lrV/rykTearZIkt9IlOcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; d="scan'208";a="212732208"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by fmviesa007.fm.intel.com with ESMTP; 17 Feb 2026 15:03:05 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 17 Feb 2026 23:59:56 +0100
Message-Id: <20260217225956.1593920-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771369388; x=1802905388;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ACQhzgqYI4BP9sufN+hWv/pC9E5bB06fTv1NUnF6qdA=;
 b=BhJR1D1ShWwiuhFtHM/uFDLaGNx7i0q9ycSCe7hzG4BJo6EzyQ6Hq8G/
 z6zVD57Ad5zErC8jbZoTtdm/Vck+zhxK2lLWoHTv33IyxxBrmajwcmb++
 OI5bKF3oBIpWzIXiPd3C6ji+YJ+WTiwuOK/ERl+NUJay8FnvXk3Gzc8mK
 P5O+ITXL1x5TLGqnS5FWQjptA+NIwMc8hqAUu+o6qmmeN6YbJNeOVX1Qt
 /MJCleo6YeD2aCVS2O03zJMBEfTBe0Y/U9KsxuxJ0TP54/SrLOz9G398h
 bd6yYTjpOWoXsftimAmsBBkKH+E/UX14jTJqkHrll+dhs/LJx5HCJ11Aa
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BhJR1D1S
Subject: [Intel-wired-lan] [PATCH iwl-net] ice: update PCS latency settings
 for E825 10G/25Gb modes
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
Cc: netdev@vger.kernel.org, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 anthony.l.nguyen@intel.com, Zoltan Fodor <zoltan.fodor@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Update MAC Rx/Tx offset registers settings (PHY_MAC_[RX|TX]_OFFSET
registers) with the data obtained with the latest research. It applies
to PCS latency settings for the following speeds/modes:
* 10Gb NO-FEC
        - TX latency changed from 71.25 ns to 73 ns
        - RX latency changed from -25.6 ns to -28 ns
* 25Gb NO-FEC
	- TX latency changed from 28.17 ns to 33 ns
        - RX latency changed from -12.45 ns to -12 ns
* 25Gb RS-FEC
        - TX latency changed from 64.5 ns to 69 ns
        - RX latency changed from -3.6 ns to -3 ns

The original data came from simulation and pre-production hardware.
The new data measures the actual delays and as such is more accurate.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Co-developed-by: Zoltan Fodor <zoltan.fodor@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Zoltan Fodor <zoltan.fodor@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
index 19dddd9b53dd..4d298c27bfb2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
@@ -78,14 +78,14 @@ struct ice_eth56g_mac_reg_cfg eth56g_mac_cfg[NUM_ICE_ETH56G_LNK_SPD] = {
 		.blktime = 0x666, /* 3.2 */
 		.tx_offset = {
 			.serdes = 0x234c, /* 17.6484848 */
-			.no_fec = 0x8e80, /* 71.25 */
+			.no_fec = 0x93d9, /* 73 */
 			.fc = 0xb4a4, /* 90.32 */
 			.sfd = 0x4a4, /* 2.32 */
 			.onestep = 0x4ccd /* 38.4 */
 		},
 		.rx_offset = {
 			.serdes = 0xffffeb27, /* -10.42424 */
-			.no_fec = 0xffffcccd, /* -25.6 */
+			.no_fec = 0xffffc7b6, /* -28 */
 			.fc = 0xfffc557b, /* -469.26 */
 			.sfd = 0x4a4, /* 2.32 */
 			.bs_ds = 0x32 /* 0.0969697 */
@@ -118,17 +118,17 @@ struct ice_eth56g_mac_reg_cfg eth56g_mac_cfg[NUM_ICE_ETH56G_LNK_SPD] = {
 		.mktime = 0x147b, /* 10.24, only if RS-FEC enabled */
 		.tx_offset = {
 			.serdes = 0xe1e, /* 7.0593939 */
-			.no_fec = 0x3857, /* 28.17 */
+			.no_fec = 0x4266, /* 33 */
 			.fc = 0x48c3, /* 36.38 */
-			.rs = 0x8100, /* 64.5 */
+			.rs = 0x8a00, /* 69 */
 			.sfd = 0x1dc, /* 0.93 */
 			.onestep = 0x1eb8 /* 15.36 */
 		},
 		.rx_offset = {
 			.serdes = 0xfffff7a9, /* -4.1697 */
-			.no_fec = 0xffffe71a, /* -12.45 */
+			.no_fec = 0xffffe700, /* -12 */
 			.fc = 0xfffe894d, /* -187.35 */
-			.rs = 0xfffff8cd, /* -3.6 */
+			.rs = 0xfffff8cc, /* -3 */
 			.sfd = 0x1dc, /* 0.93 */
 			.bs_ds = 0x14 /* 0.0387879, RS-FEC 0 */
 		}

base-commit: acd2abc52dea91c3bc3d1b6dd8a92b9631d48bbf
-- 
2.39.3

