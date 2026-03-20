Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47BCFB5EA9
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 05:05:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A753617A8;
	Fri, 20 Mar 2026 05:05:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rdJ_knioEiAi; Fri, 20 Mar 2026 05:05:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D6A47617A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773983141;
	bh=RpJmUzBpOrjnex4C3iLXAMcaqR+WnZyJN8SdA9BtlGI=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kTSIGC3BsLygCapxRfM59v8TQorI9tnRgFz6VMkGH2JJWwMV1MVI+r7nLa+ibdOmV
	 +yV5MTG7Td0TE5yju2clJs3yPS777yGMl6xrBq8F2REQGRPRvD2erMwVVLaHv+9ubA
	 FH5TWunIDPGUD+Iwe9jibZoGU6Vls8AdZXVYkPHSdPlWsU4+JUB2nI4yjX/mAVnZ74
	 VsoF+NEYm/fmtT+4MISj1vnI3YxPmBe82axQ8OofYBCBkHyk+G6cWp9KJL+5pbVuil
	 IMzaOWAjr/BpqiZpeGKqU0OG144fF0R9DBiJPPt44W3Ya9LmPuq9EoRD4qbtRfWw4D
	 W3H0xb1Up4oiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6A47617A0;
	Fri, 20 Mar 2026 05:05:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AC86225C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 05:05:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9E34D41398
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 05:05:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O9d8_06F-h3H for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 05:05:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A7DF440176
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A7DF440176
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A7DF440176
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 05:05:39 +0000 (UTC)
X-CSE-ConnectionGUID: VQMYn65PQL6yuhURSPPTRg==
X-CSE-MsgGUID: 0SMoEPAYT4ScVDH5X012jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="100522731"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="100522731"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 22:05:39 -0700
X-CSE-ConnectionGUID: msJ+aUbWT4ym07l5lbYtkw==
X-CSE-MsgGUID: 9/a2oKZYTsqzceeNM1PWhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="227307309"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa003.jf.intel.com with ESMTP; 19 Mar 2026 22:05:38 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>
Date: Fri, 20 Mar 2026 06:05:37 +0100
Message-ID: <20260320050537.422528-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773983140; x=1805519140;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Y2X9UvI0EgjYn3IIhrToWZkRwx3++jcwtMMvMJSYZ6U=;
 b=O0NuRAUJO6lhVBh6rErXf94TMPuGFA+Ld4ZPZShdkYpPMrEffbk7we+A
 hkO4hoIiPETo4lvOxM4pYaudF500MZ5ZbXKrPxj6y5yVLZtTYqceiNtSh
 sBkLtrRAX36WaysIekFkLMhC7ECnQqIBw8eCdoAsvohxv2LW1FZaDV2SY
 taYRoQYwUpcjYLwsukcaKDYzmBF/55hUdV/IG4LoKYn5mRrnsGn2Zxda7
 MOP/OrDmdoB8mQLGy+2PyMTPErUOzpVyjStt3UXF6ID1YpprAvJGKwI6y
 1moyAqxMm8MsZ3Ki503Hgl+fVz8ZL0CKihvxMFejIiKp/O5iZlOiX1Mv/
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=O0NuRAUJ
Subject: [Intel-wired-lan] [PATCH] ice: fix ICE_AQ_LINK_SPEED_M for 200G
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

From: Paul Greenwalt <paul.greenwalt@intel.com>

When setting PHY configuration during driver initialization, 200G link
speed is not being advertised even when the PHY is capable. This is
because the get PHY capabilities link speed response is being masked by
ICE_AQ_LINK_SPEED_M, which does not include the 200G link speed bit.

ICE_AQ_LINK_SPEED_200GB is defined as BIT(11), but the mask 0x7FF only
covers bits 0-10. Fix ICE_AQ_LINK_SPEED_M to use GENMASK(11, 0) so
that it covers all defined link speed bits including 200G.

Fixes: 24407a01e57c ("ice: Add 200G speed/phy type use")
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 859e9c6..3cbb1b0 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1252,7 +1252,7 @@ struct ice_aqc_get_link_status_data {
 #define ICE_AQ_LINK_PWR_QSFP_CLASS_3	2
 #define ICE_AQ_LINK_PWR_QSFP_CLASS_4	3
 	__le16 link_speed;
-#define ICE_AQ_LINK_SPEED_M		0x7FF
+#define ICE_AQ_LINK_SPEED_M		GENMASK(11, 0)
 #define ICE_AQ_LINK_SPEED_10MB		BIT(0)
 #define ICE_AQ_LINK_SPEED_100MB		BIT(1)
 #define ICE_AQ_LINK_SPEED_1000MB	BIT(2)
-- 
2.52.0

