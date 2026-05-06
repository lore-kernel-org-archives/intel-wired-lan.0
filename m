Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A6ACD3439
	for <intel-wired-lan@archiver.kernel.org>; Wed,  6 May 2026 21:49:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4564360F4D;
	Wed,  6 May 2026 21:49:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dfYmpbKL65wM; Wed,  6 May 2026 21:49:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A12D660F49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778104163;
	bh=+na9m7+ac+760l7u1L/pwZtPpJfOwh2z27ZW4BFo5Z0=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AV55yf/S79ZWXMiICSjcvZb+9Xp+xgE46MEFFAuNNoQ6QGH4hw0vhdjQzqn5mzqpg
	 WGgQFJDa8mXE1jUB91zszuV9MUL8EIOTD1dXz13CldkBSxX0ewn5lGLuI9dst3z4g6
	 BZ8EIHCq+AIndlnu1TiSJr9z5W1JEoCEhTVDxmyeIoLzp+oBeIkqyVm4frSJXs2uFJ
	 XB/Qad5OF9RgqYb/CjUnn3GRh5dY3kU2KIYYF4SDDWacODqQ4oDOyzuKmPyEaoZJso
	 +Js/0S3loMAtSo0FQDsUm6VRWlxSWVcML443yALICXIGn+ElmHcXHGBCv/ENAxtX1W
	 v/Kla1C0M/itg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A12D660F49;
	Wed,  6 May 2026 21:49:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A60D280
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 May 2026 21:49:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C73360F49
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 May 2026 21:49:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V5BW5BcxDvnp for <intel-wired-lan@lists.osuosl.org>;
 Wed,  6 May 2026 21:49:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 19C9360E95
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 19C9360E95
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 19C9360E95
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 May 2026 21:49:20 +0000 (UTC)
X-CSE-ConnectionGUID: B+qrxbp4RJqz65TPi3Gkcw==
X-CSE-MsgGUID: iKOEFFxoSiy0yxiSg0C7uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78982526"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; d="scan'208";a="78982526"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 14:49:20 -0700
X-CSE-ConnectionGUID: nPhameQnS2Ou1tX9cJfYyA==
X-CSE-MsgGUID: 2/ScJ5N8Sx+F7NHN+N/1Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; d="scan'208";a="259698631"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 14:49:20 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 06 May 2026 14:48:15 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-jk-iwl-net-2026-05-04-v2-6-a5ea4dc837a9@intel.com>
References: <20260506-jk-iwl-net-2026-05-04-v2-0-a5ea4dc837a9@intel.com>
In-Reply-To: <20260506-jk-iwl-net-2026-05-04-v2-0-a5ea4dc837a9@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Joshua Hay <joshua.a.hay@intel.com>, 
 Madhu Chittim <madhu.chittim@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Dave Ertman <david.m.ertman@intel.com>, Ivan Vecera <ivecera@redhat.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Bart Van Assche <bvanassche@acm.org>, intel-wired-lan@lists.osuosl.org, 
 Arpana Arland <arpanax.arland@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=8xxRBB2hCfnptncdvaHpAb1aQ37pmgCfaRqlFzs73jI=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhszf22OO/D7l3rj4qSeH5b37OZaCsr5F+eXrrxpFGyss9
 GnSkFnQUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwET6pBgZNueofLSVcovk38lW
 +pfba5m08OzMlpk3Xu3cbHPM49N1BUaGRUekxa4Y302+cDnj/P4NYl93qmS4p0zcb8MRN9WNWeE
 vOwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778104161; x=1809640161;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=wHo5j9nJDIamG49pqy+qz+6YnpC7rg7uJNijoxFDE5s=;
 b=NgeRDUYJPhsf2/8Z9c6sjN2tWAH2aUvbZr4kl0Wa806dvRDymuwWDX2a
 R8SAqKnh720L5BWeCP9k9vNEyrMGjAksDaPmzXSUpYCJGqR2+zgJ+LdkN
 67A2vEFat5IHBV/f5MtwFyTCZ9mFR+4rJ4KS/VdHj7siCoXSIFLeFWbos
 lQA/mLv9jEpo6aO7x+9A5nr3x+gPLlW1hCRqCK/1dLgwlf0DdDVJiijLm
 pr4QZ4fxh9z1/6PpbqrHI6T1qc4AOtGjzM9qBkLP8+h6IgSOPjYP7wn5J
 7FGLkB44BWmTtEUlnDzQlgWiCXTPIgONjrxyXrI8dsXiBNzJz6Oom1UqE
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NgeRDUYJ
Subject: [Intel-wired-lan] [PATCH net v2 6/8] ice: fix locking in
 ice_dcb_rebuild()
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

From: Bart Van Assche <bvanassche@acm.org>

Move the mutex_lock() call up to prevent that DCB settings change after
the first ice_query_port_ets() call. The second ice_query_port_ets()
call in ice_dcb_rebuild() is already protected by pf->tc_mutex.

This also fixes a bug in an error path, as before taking the first
"goto dcb_error" in the function jumped over mutex_lock() to
mutex_unlock().

This bug has been detected by the clang thread-safety analyzer.

Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
Fixes: 242b5e068b25 ("ice: Fix DCB rebuild after reset")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Arpana Arland <arpanax.arland@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 16aa25535152..0bc6dd375687 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -537,14 +537,14 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 	struct ice_dcbx_cfg *err_cfg;
 	int ret;
 
+	mutex_lock(&pf->tc_mutex);
+
 	ret = ice_query_port_ets(pf->hw.port_info, &buf, sizeof(buf), NULL);
 	if (ret) {
 		dev_err(dev, "Query Port ETS failed\n");
 		goto dcb_error;
 	}
 
-	mutex_lock(&pf->tc_mutex);
-
 	if (!pf->hw.port_info->qos_cfg.is_sw_lldp)
 		ice_cfg_etsrec_defaults(pf->hw.port_info);
 

-- 
2.54.0.rc2.531.gaf818d63126a

