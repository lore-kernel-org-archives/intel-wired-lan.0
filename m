Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB21F33817
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Mar 2026 08:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA41061498;
	Tue, 17 Mar 2026 08:45:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xplnio8K8Vqf; Tue, 17 Mar 2026 08:45:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 619BF61465
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773737106;
	bh=qlrgBzBmmql/l09nQXSVU+R5EyGtYoctbLed2EqtFv0=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=76c3i/gq0pr+xR7DV8JsJQlUJsW6uyoN2v73GJghYUW1Csg77fA0h+jWMlbmE5+ca
	 GYuE1XSlOYVTWWCxGfFc2xpiL6sx9u8MpF8Uj8xvHl0kOFNAOCuGD3eh5LuET/08Ut
	 VgKsVKkgNtfmjkaC4nq/DqiOxaZq/qdgXXFb4f21vZpP/yP4IhA53WsxGKyRnOc+mR
	 BaHyDsTvO7xG92/Jyh29ciFuIWyYzH+PtctxtAV3K7EFH3Cx0TL9QIYg85v9+GZCDO
	 bG4tMYFVFQJaRsPOQSvslpDKUq7H4+/8G0nleuCm15C/PGU0UiIdwU0RVsLV7GWEUQ
	 XEhokYH3E96vQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 619BF61465;
	Tue, 17 Mar 2026 08:45:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6ED27D3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Mar 2026 08:45:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5474483E35
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Mar 2026 08:45:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tC7M1oagyp_7 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Mar 2026 08:45:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5835083E34
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5835083E34
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5835083E34
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Mar 2026 08:45:02 +0000 (UTC)
X-CSE-ConnectionGUID: +aEoQKxjSbeNiSJiCRYUdg==
X-CSE-MsgGUID: 0wjYLGM8RgKg8OzwFHyx8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74651557"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="74651557"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 01:45:01 -0700
X-CSE-ConnectionGUID: X0jYK42PQgeUEzYVlt/b6Q==
X-CSE-MsgGUID: Zc28UOdfQgeO2Nuz+NTU+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="219710027"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa008.fm.intel.com with ESMTP; 17 Mar 2026 01:45:00 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Date: Tue, 17 Mar 2026 09:44:59 +0100
Message-ID: <20260317084459.2196606-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773737103; x=1805273103;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=IRQR4EX62gHxndHVD5ol1tVDrK0iQUrN/1zkt/4CXKQ=;
 b=emCw/ZL3AI8xVRmnY+Y89gjgpIa2u4vg9nt3S3qGSOmcQcFZhEOeWdDB
 2//qY485z8Eu4+046pX2ySG/spA0FzcMppt9/SPME/gcIwkWRsrjE/0ai
 JHVuBUx3anAXLXtcHZy+ICJB5AUG+3+HfD3cKNGhxZTrhLANZUOrXQ2JM
 L63+FDV1PHUZti75ugVTPlhPpyilRFpd8ZFwp858AJfatxVrtWqueUyX5
 +/qmm2BSrA5IYwV6sOcDxXBM2+NIZyAG6zf5SX5NHbAnXlLdkINjd06XQ
 BCyOoUhugN0qhE9FJ/gkttyO8JK5e3icBJe+4Ct/iCU3W1pvmqiPfNY5D
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=emCw/ZL3
Subject: [Intel-wired-lan] [PATCH iwl-next v1] ice: add ethtool reset
 support to safe mode ops
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

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Wire up ice_ethtool_reset() into ice_ethtool_safe_mode_ops so that the
.reset ethtool operation is available when the driver is operating in safe
mode, consistent with the behaviour exposed by the full ice_ethtool_ops.

Without this, a user-space call to ethtool --reset while the driver is in
safe mode would return EOPNOTSUPP even though the underlying reset logic
is fully implemented and works correctly.

Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 301947d..bf90bd5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4917,6 +4917,7 @@ static const struct ethtool_ops ice_ethtool_safe_mode_ops = {
 	.set_ringparam		= ice_set_ringparam,
 	.nway_reset		= ice_nway_reset,
 	.get_channels		= ice_get_channels,
+	.reset			= ice_ethtool_reset,
 };
 
 /**
-- 
2.52.0

