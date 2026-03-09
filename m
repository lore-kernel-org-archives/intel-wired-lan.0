Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF66CF3C269
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Mar 2026 14:11:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FA0760790;
	Mon,  9 Mar 2026 14:11:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wPzWs9_wL0YG; Mon,  9 Mar 2026 14:11:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F4A060786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773065462;
	bh=+sZLd/YXnYFjYh0sULI6KXmGZLECUA/k//mYwT8CFFA=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EEh2jmhY6jQNt6fhnWHryt6PS1OzdIc3RJZvONauKvG+f1ezt4QDr6X8emK/w5nL+
	 T+MlRcawRt6A7qOwpFgy78kQtTWuBjNpCxBLobVj+hBokbjrjXTeDrD6gGzxRN1QMV
	 p6F+A446TPnRrCRmRIUdj9K0RsmgKklVkDVcZtqdlwWiDCAdO20g7KNjNgCWus8xjc
	 IWyrmddThGZsPRz+ykHcAVUqnzsGrJf7znaPPkKbTas56/1untrgLjey5yWY/n0f8Z
	 7CMp4OchIshzxoPnAj+8x8bXgfDRuRu6z+yX9gmwnZctH1tSddJE2AoXVHlowBBNdF
	 Im+Azs0i8gKDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F4A060786;
	Mon,  9 Mar 2026 14:11:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 76A92358
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Mar 2026 14:11:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5C28A8238F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Mar 2026 14:11:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ymEMONTyW1Jk for <intel-wired-lan@lists.osuosl.org>;
 Mon,  9 Mar 2026 14:10:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=przemyslaw.korba@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D8E458237B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D8E458237B
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D8E458237B
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Mar 2026 14:10:57 +0000 (UTC)
X-CSE-ConnectionGUID: 3/RpAdmRQ/+eC08jTolR1w==
X-CSE-MsgGUID: ihXEp1CZTwKQ2OvYmrOczQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="99558354"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="99558354"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 07:10:57 -0700
X-CSE-ConnectionGUID: EvA5GxjlRc+V+c7JNax0gg==
X-CSE-MsgGUID: blDyQXPBTiiuXBnTw85/ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="224463312"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
 by fmviesa005.fm.intel.com with ESMTP; 09 Mar 2026 07:10:56 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, Przemyslaw Korba <przemyslaw.korba@intel.com>
Date: Mon,  9 Mar 2026 15:11:51 +0100
Message-ID: <20260309141220.343224-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773065459; x=1804601459;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=06y9i1blvXKT+0qakd+4jlyn/5w+VGLU+tv5laJuacE=;
 b=f+z45SbUWwpv5F+w171HF8ydULPnPFpz8b09FuFIQptDz8kqxihd9+W0
 hH77+VGdPGDiLQeAEXbJLnqKHDYrBPVP7HAVqAdhMv4ecaHFAC/wPYwgv
 vxqI+MsD1d4h+j0Y3RBBzIKyivyBKTPIeCGhumU7IC4YQZ4/MAjU+8rL9
 FiqdB03N8OsVshR3hLjjTW4cKqnddXFTnt8i8pzKJMak8/cJe1ZX7zufQ
 EbkjQT0s6VevGmH1wm4hMJZ8G+RjG64wcxpfOugDJGL3CeTzPbuoTpRqI
 YaCleHT6NBo+rloRUkbw7gw/pWcWmMz/P6m0VS+uoDmivCA6a6EgRYAcw
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=f+z45SbU
Subject: [Intel-wired-lan] [PATCH iwl-next] i40e: PTP: set supported flags
 in ptp_clock_info
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

Since upstream commit d9f3e9ecc456 ("net: ptp: introduce
.supported_perout_flags to ptp_clock_info") and commit 7c571ac57d9d ("net:
ptp: introduce .supported_extts_flags to ptp_clock_info"), kernel core now
requires that the driver set the .supported_perout_flags and
.supported_extts_flags fields in PTP clock info. Otherwise, the additional
flags will be rejected by the kernel automatically.

i40e does not support perout flags, so reject any request with perout
flags.

Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 7bcea7d9720f..8d7958692235 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -601,10 +601,18 @@ static int i40e_ptp_feature_enable(struct ptp_clock_info *ptp,
 	/* TODO: Implement flags handling for EXTTS and PEROUT */
 	switch (rq->type) {
 	case PTP_CLK_REQ_EXTTS:
+		if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
+					PTP_RISING_EDGE |
+					PTP_FALLING_EDGE |
+					PTP_STRICT_FLAGS))
+			return -EOPNOTSUPP;
+
 		func = PTP_PF_EXTTS;
 		chan = rq->extts.index;
 		break;
 	case PTP_CLK_REQ_PEROUT:
+		if (rq->perout.flags)
+			return -EOPNOTSUPP;
 		func = PTP_PF_PEROUT;
 		chan = rq->perout.index;
 		break;
@@ -1340,7 +1348,9 @@ static int i40e_init_pin_config(struct i40e_pf *pf)
 	pf->ptp_caps.n_ext_ts = 2;
 	pf->ptp_caps.pps = 1;
 	pf->ptp_caps.n_per_out = 2;
-
+	pf->ptp_caps.supported_extts_flags = PTP_RISING_EDGE |
+					     PTP_FALLING_EDGE |
+					     PTP_STRICT_FLAGS;
 	pf->ptp_caps.pin_config = kzalloc_objs(*pf->ptp_caps.pin_config,
 					       pf->ptp_caps.n_pins);
 	if (!pf->ptp_caps.pin_config)

base-commit: d5fbc991435eac7a1ead7cd2ddb5a743528718bb
-- 
2.43.0

