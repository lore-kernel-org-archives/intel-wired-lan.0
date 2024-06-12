Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3ECBC27C53
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Jun 2024 11:04:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80D0C80E47;
	Wed, 12 Jun 2024 11:04:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uxY1k2NA7Rlw; Wed, 12 Jun 2024 11:04:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA4E880E22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1718190249;
	bh=jytCk9So4lxb/fZokIrIiofwwV9gHOPl5UG95GGRz8Q=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=jd5VMH1XM8qCmItUcu7qXBya0VxJli4AI7ab7hL7WDS/5qGoMxYA52zoL0jprBhgD
	 prOafdyxc/CtysgPjnHgc+4MoaF0nMXuMoOOW+1DUyB8oTXUVEvAgOojmWO28jnEIH
	 C4Dcnq/GsqGVMvl/LvSwmBc3Ez+YEaPsPRgs0p7GLE9vwPV/uwkAPoO3eboHYKujn4
	 uPEnMA0MDXfjHZ9VDo39dPzCpnh6zx3sMUaf08fQSIAZZZ/B9qhA9YRA0cpWDLW8Ul
	 fYgtGzShUt+bkB7oL2s8OdQIuQD2l7Nmw1C5qBPA5Lan/GtbKVXk/KSfuM2Ai3cOwD
	 7F2IfWUwGUntw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA4E880E22;
	Wed, 12 Jun 2024 11:04:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 1370F1BF37C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jun 2024 11:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F399980E15
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jun 2024 11:04:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fk_ro7244nDy for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Jun 2024 11:04:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E07A980E08
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E07A980E08
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E07A980E08
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jun 2024 11:04:06 +0000 (UTC)
X-CSE-ConnectionGUID: WNMWNVOMQ56TD3EjE+hugw==
X-CSE-MsgGUID: mFBV2Wv8SxqmDfbJ9PST+w==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="37467998"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; d="scan'208";a="37467998"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2024 04:04:05 -0700
X-CSE-ConnectionGUID: YhHQvWt6T5yOp7WqOVD85A==
X-CSE-MsgGUID: yOaMtA6vRryqRzSsyA938A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; d="scan'208";a="44151451"
Received: from unknown (HELO amlin-019-225.igk.intel.com) ([10.102.19.225])
 by fmviesa003.fm.intel.com with ESMTP; 12 Jun 2024 04:04:04 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Date: Wed, 12 Jun 2024 13:04:02 +0200
Message-Id: <20240612110402.3356700-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718190247; x=1749726247;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pw+RJOP5tBxwzihRkSI6e94yGizrIsoHviIc8xOIVv8=;
 b=EFM4TDdhDafikhHU8Igq7qUJsXoQL4a1mlFKKAgsGpm4cRTMHOgz/JKW
 a8Np2byIi9rPplDQzK5zVtAwRB6/cjIjBcDfyq7nDTtlapp6KMoDWnolW
 X7S1FwvMiewI3gNWULrAUZHN/y4weS9qpEM0ruAz91AoaRmtj4WQuC4nJ
 mlelw1yy3u+sGOPLHDHiwQx9mVHpXLe826cbyjYZaabF40yGapUArYAC0
 UeViX/P55m8wrsDDg5os2Iuv4RWpYpvV/jR5zmyAxmz0BEAoAsHGeCEbB
 yofXz/fTizxAGbujIE9+5S/WdpJ9/vVb5I9fpV8fjduqwqLks8UmXfPgd
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EFM4TDdh
Subject: [Intel-wired-lan] [PATCH iwl-net v3] i40e: fix hot issue NVM
 content is corrupted after nvmupdate
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: netdev@vger.kernel.org, Kelvin Kang <kelvin.kang@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The bug affects users only at the time when they try to update NVM, and
only F/W versions that generate errors while nvmupdate. For example X710DA2
with 0x8000ECB7 F/W is affected, but there are probably more...

After 230f3d53a547 patch, which should only replace F/W specific error codes
with Linux kernel generic, all EIO errors started to be converted into EAGAIN
which leads nvmupdate to retry until it timeouts and sometimes fails after
more than 20 minutes in the middle of NVM update, so NVM becomes corrupted.

Remove wrong EIO to EGAIN conversion and pass all errors as is.

Fixes: 230f3d53a547 ("i40e: remove i40e_status")
Co-developed-by: Kelvin Kang <kelvin.kang@intel.com>
Signed-off-by: Kelvin Kang <kelvin.kang@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
reproduction:
./nvmupdate64

v2->v3 commit messege typos
v1->v2 commit message update
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
index ee86d2c..55b5bb8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
@@ -109,10 +109,6 @@ static inline int i40e_aq_rc_to_posix(int aq_ret, int aq_rc)
 		-EFBIG,      /* I40E_AQ_RC_EFBIG */
 	};
 
-	/* aq_rc is invalid if AQ timed out */
-	if (aq_ret == -EIO)
-		return -EAGAIN;
-
 	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
 		return -ERANGE;
 
-- 
2.25.1

