Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECDE109316E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 05:05:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9372141C5D;
	Fri, 20 Mar 2026 05:05:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3z3tsHSbkRlO; Fri, 20 Mar 2026 05:05:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7166C41C5B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773983146;
	bh=z40fQY/dv62Wbd2UIAsd2MEpdDaX3epNsu23AcUJffE=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=4yjrXwt4vTUjdUBQ2wSyja31tTXMXjcX/5ROqBC1EBem6E07PzIf6QgMPDWy4k1K1
	 k1IZ4llJs02vLVq0UEEF3oC4WwvT2LlNYVe+Iw3Mcx2ItyT1F8qkrb/4wklZMhXOmg
	 WuCbdtUnndPWVgEL9NrRMhTPCj+hku2UIrhK51ayMvcq3bXsh8aQi/0WOUwA7fQ/81
	 c8MCMfDsIeRn1zhNJuIoxxueG2SDwilLbsa70a2gGnte3RZ+OiCgsCTTowVZYSAdBS
	 mI7MH3aSNs+mXo0Z+0IHJWsJ8hcFVqiGNGcn+KiKOyLRAK7DPcSIJVLRNBBZp3zOyR
	 AduevycGRPBXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7166C41C5B;
	Fri, 20 Mar 2026 05:05:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 902B31B6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 05:05:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 81F2D41398
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 05:05:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AmU2HMnM3ZmO for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 05:05:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 890B640176
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 890B640176
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 890B640176
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 05:05:43 +0000 (UTC)
X-CSE-ConnectionGUID: XiMBIIFFR7WvMI7pSPIASA==
X-CSE-MsgGUID: hsQXGVZGRGKEZ69nCCXntQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="100522746"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="100522746"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 22:05:43 -0700
X-CSE-ConnectionGUID: a7IlZjjPTcOIrFw199eP1Q==
X-CSE-MsgGUID: s4TtrwfrRQGHeu9tjLl9qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="227307328"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa003.jf.intel.com with ESMTP; 19 Mar 2026 22:05:42 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Lukasz Czapnik <lukasz.czapnik@intel.com>
Date: Fri, 20 Mar 2026 06:05:41 +0100
Message-ID: <20260320050541.422592-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773983143; x=1805519143;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=iFNr/Ozkk9eyLzFtKdItjdVVoPA6I8UzXs9nhcOrgwU=;
 b=SQkWVOXik/4VVO4ML3t9B0voOc+GR/Bpo9YJKaMw0qcPW94rilhwTryy
 qZit2vI/a2PNImFwnWQ6Mx1ms+ocJPZz1lMgZ4HW34+3kt4UL3C8tgcG2
 jJUR9UO5YZIqXwN/Aleq6jA8YHwYIopW/o03nVcycV/b47WKDCxZ+PdoI
 oDgYMRKeyk9s2kdgKvksaZDeCPMJLbgRd+U/JbkmFJYxRddgyqQK7NYDU
 UGcbaaLgdz/2Lq2i1qDjdCW4K3BdsR+rOun3xfynCSJRz+hq8LIIfWyUc
 7Jx6A3giTU39gtPZi2QMTX2Cz7iToaqMO1g91PyNMChrJcQTAjnR4vJYX
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=SQkWVOXi
Subject: [Intel-wired-lan] [PATCH iwl-next] ice: init desired_dcbx_cfg in
 default DCB config
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

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

When DCBX is disabled in firmware the driver falls back to software LLDP
mode and applies a default DCB configuration via ice_dcb_sw_dflt_cfg().
This function properly initializes local_dcbx_cfg with valid parameters
including etscfg.maxtcs from hardware capabilities. However,
desired_dcbx_cfg was never initialized in this path.

All DCB netlink functions (ice_dcbnl_setpfc, ice_dcbnl_setets, etc.)
use desired_dcbx_cfg as the base configuration for user-requested changes.
When desired_dcbx_cfg remains uninitialized with etscfg.maxtcs=0, the
firmware rejects the configuration for 4+ port NICs, causing DCB
configuration commands to fail.

It is not a problem for 1 or 2 port NICs where we support 8 TCs - in
that case FW accepts maxtc=0, treating it as 8.

Fix it by copying local_dcbx_cfg (which was freshly initialized) into
desired_dcbx_cfg after the default config is applied.

Fixes: b94b013eb626 ("ice: Implement DCBNL support")
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index bd77f1c..060744c 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -669,6 +669,9 @@ int ice_dcb_sw_dflt_cfg(struct ice_pf *pf, bool ets_willing, bool locked)
 	if (ret)
 		return ret;
 
+	/* init desired_dcbx_cfg from local_dcbx_cfg */
+	pi->qos_cfg.desired_dcbx_cfg = pi->qos_cfg.local_dcbx_cfg;
+
 	return ice_query_port_ets(pi, &buf, sizeof(buf), NULL);
 }
 
-- 
2.52.0
