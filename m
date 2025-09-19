Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD853CAC59A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 19 Sep 2025 17:06:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E762821EB;
	Fri, 19 Sep 2025 17:06:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5MBY-6KzU23u; Fri, 19 Sep 2025 17:06:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A4AA58139F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1758301601;
	bh=QXWUnSCZAC20UwfauXmAUvCl4uRZ8RQWtz+peNc9m/g=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Krs53RVrrihYQcPDAwtKUO5OQ12e0woBya0bYrwlf22llGOZByM0f42IjGpJ00ScY
	 u5ZWzIW0ZdeVPGMwb6r0v/X4bfHwWGyaiE509EUU3QwAx0wrta4Q4pQ30/h/sqs8/9
	 +66l2191lyuX71dOGzWYdImHsk/A60vCJrJM1okG3LovCiD45mdygRk/M5tt2pjKor
	 qecIsGu6GVsQTL4Dvs6JAtGPe3Svwx29+bdb+wnpcOFkrpG7+ECzlNgMkmQUwdGfQG
	 MMDCOL/sSr+ndo89lpLQ8yQuyXdZZmk1cbNa/rDHInA909+aT7cqFTU/L9zKeu4MGf
	 /9CDhr6Oxbj7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4AA58139F;
	Fri, 19 Sep 2025 17:06:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D1402E7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 Sep 2025 17:06:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C34B040D2D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 Sep 2025 17:06:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YMZsi-JmKsOK for <intel-wired-lan@lists.osuosl.org>;
 Fri, 19 Sep 2025 17:06:39 +0000 (UTC)
X-Greylist: delayed 427 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 19 Sep 2025 17:06:38 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EB4E440079
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EB4E440079
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=sreedevi.joshi@intel.com;
 receiver=<UNKNOWN> 
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB4E440079
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 Sep 2025 17:06:38 +0000 (UTC)
X-CSE-ConnectionGUID: HkzcXIefQbqNq3IyOVdysg==
X-CSE-MsgGUID: dDhcYGwSRCaVp03ucYN2Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60763407"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; d="scan'208";a="60763407"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2025 09:59:31 -0700
X-CSE-ConnectionGUID: sn7J7KYiScSQDzB2d8odAQ==
X-CSE-MsgGUID: V3jOfLIhS8WrV+LC9xJnRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; d="scan'208";a="180119864"
Received: from aus-labsrv3.an.intel.com ([10.123.116.23])
 by orviesa004.jf.intel.com with ESMTP; 19 Sep 2025 09:59:31 -0700
From: Sreedevi Joshi <sreedevi.joshi@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Sreedevi Joshi <sreedevi.joshi@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Fri, 19 Sep 2025 11:59:05 -0500
Message-Id: <20250919165905.1599964-1-sreedevi.joshi@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758301599; x=1789837599;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KpJlYT1x4u5WWUj2aXT5S081UgMT4FN/iUfY8e/Zo5Q=;
 b=GxMwWy6sH25QnmvUj9L/bI56kIVpEFvOBJ2pFWrcrCsjsjUiQlTwXFPa
 4zjD62JbL+8SccLIohx0f1MeICK2kyGdBdYG27EmSF5pZ1lRVdA4ny3Cx
 n44aLwlC6xh//7blDQe2QCGTjIgIYl1Nmg88Lh8JeAoXmfL6V91gRXlxt
 n1CkkZDNrEF5ZqhbvkJXvz7gENCvsjupTEKSC8Irq/ASuUSY6zXYfv339
 hhgkJVcN4Zn+uRmsgb9XLQfDr+7dx0rLQ0iIiMaDHc14i9q6w2d8J1Mdb
 SFU5WaEy2KOtTAz+NfDV/ZatyPknkSsa/JbuNPYApZJEMUhao53MtQQpj
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GxMwWy6s
Subject: [Intel-wired-lan] [PATCH] idpf: remove duplicate defines in
 IDPF_CAP_RSS
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

Remove duplicate defines from the OR operation when defining IDPF_CAP_RSS.

Duplicate definitions were introduced when IDPF_CAP_RSS was originally
defined and were left behind and went unnoticed during a previous commit
that renamed them. Review of the original out-of-tree code confirms these
duplicates were the result of a typing error.

Remove the duplicates to clean up the code and avoid potential confusion.
Also verify no other duplicate occurrences of these defines exist
elsewhere in the codebase.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 0f320a2b92d2..21c50695348c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -732,13 +732,11 @@ static inline bool idpf_is_rdma_cap_ena(struct idpf_adapter *adapter)
 }
 
 #define IDPF_CAP_RSS (\
-	VIRTCHNL2_FLOW_IPV4_TCP		|\
 	VIRTCHNL2_FLOW_IPV4_TCP		|\
 	VIRTCHNL2_FLOW_IPV4_UDP		|\
 	VIRTCHNL2_FLOW_IPV4_SCTP	|\
 	VIRTCHNL2_FLOW_IPV4_OTHER	|\
 	VIRTCHNL2_FLOW_IPV6_TCP		|\
-	VIRTCHNL2_FLOW_IPV6_TCP		|\
 	VIRTCHNL2_FLOW_IPV6_UDP		|\
 	VIRTCHNL2_FLOW_IPV6_SCTP	|\
 	VIRTCHNL2_FLOW_IPV6_OTHER)
-- 
2.25.1

