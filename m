Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634D960A2604
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=t+iRUOZO;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iCbSFuUS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4415E40719;
	Mon,  2 Nov 2026 10:46:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u-b0LSlOCrg5; Mon,  2 Nov 2026 10:46:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 797C440730
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793616413;
	b=M9zz01Dd5nKdaKDd7L0xMV3mua56xIAvcv+P44HP5akRTsT3xIK12rfJm7B16J0CiYHk
	 Nh1dUd4Ycd3AwHmjAxsHcfwPnE7niR9ULf/rx3FK3jBIfBOqmP8j28YUYn82Yu8eTgWcZ
	 9ddAGssQdtzcl9AJ72fhVrGUoqkw42QXXtoMgp9e+8U+PRIW7BsGh7uMV+lk1qY9Q+RAy
	 eHRABPZcL5sqa3fP5Glq+JYlnevhjcVqMW0MB4a1YBFjcX3KapayjDyFLHPLHMC3s8iCk
	 HXrz2nRD4kSYGih9xqy6kF4I4WCmJmC01RnS+e07xsB62kKWiHccMwnuw5dWZ/IbOqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793616413;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1e/18QTzPWjcuzj9EXaVFILikpuomb1TPJ/A+uDZ7q0=;
	b=A+PcMpf/T99xUu0Okki6GTLWfZUUYrNZozgrtpOxvmSGqw2kn5A9xnNEigaNCwOwXIuF
	 wFKwdLXcvrr7ASztBLh3Y4J6gT6MY+gYw4JVFsm673VLvk6sGEmMkbH9j3aPAuUJU/7Po
	 wU0yhlCzpOkTYCR3YPf6crT9Af2SLcfCqJIzhUI744TFWf5bOfECaeLx2I8qItRipx0Rz
	 JfSIl0xkXoEFExA2Fcn7nfULwKgRZAMl3Hg3cCxNc5zq/dLFRcYoRAOtSN22GIZWqedg4
	 SibZrGAvcHx/DTEzXKyNTzvk4OMepaAeAolvgWL4GgcRAx9a/IJTv5g66xnx0bK8MxQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793616413;
	bh=1e/18QTzPWjcuzj9EXaVFILikpuomb1TPJ/A+uDZ7q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t+iRUOZO+LhiJSYuotBWTm46f1Av0ur8pXy1qJOFq+C/uCJ/xahZreB8YF7Ap1YY2
	 ZRS0rS1he+/VLtnzjyJnL0RWJRqUnq2oT4zYekYMLliqDXMeIQ5UE/0/sB8NAmAp67
	 hPpibxfwMqenCU37YWKq/qU9LpZ5tv/MbxTetaboAPuVPWpevXSq+3WLam2fNbPRkw
	 mX0Y5W6iBjkF8Q1brfgPlZxodYFuscKAZOTKSPFtLGAIbs15CfXMCp5UJlYeHglO0/
	 EFSNyV7gnsrptYheSrm4l9FuwyH0WvWF0SFMKNsc0jB4ByYtuD5kv5RwBQjM6QXHUq
	 sDbwj1s4ocJQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 797C440730;
	Mon,  2 Nov 2026 10:46:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D89C362
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:46:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1FB9B607AE
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:46:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J2Qk_LAClvh3 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 10:46:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3FC4B6076F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793616410;
 b=NmmQ3LxfiZYXmOD4SJs5Gi5TbjT2iFIlhJ4Itlk0qJD4TojVr1adjuPds8yNkssYjxhP
 fkj/B3TcngcRiu2RxK2nccoTBst2vUgQ7nB7qrMgWe2bHJ/Q6YQDKpOSgjAzjK4Y6jDPa
 8HJVHeeEEV/DmTL1zrMh44PxifDdtF1AqPE0Ci0heqCKM0z+W1DdPkdbILj3DyULXQZ3J
 3tu98ACxBjEHWxxXUTSDrpDKVwlwOWtqW2hG3dPpCn8Zg1qw4LasG+e46IG0lnF8VAwPJ
 DWeL2uEPvD42o470ROREhTmglfcjG9lAsxRu0M4EqXRZsu+RlmDMaJeVaZd4zDBqrkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793616410;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=1e/18QTzPWjcuzj9EXaVFILikpuomb1TPJ/A+uDZ7q0=;
 b=fUZllCePIvHuemDl53hn1WZWkZW3I4KUGX2tKO6d0jePZLbFIbyUqImCGWZrnVIV3cef
 KH1dPtUCE3DS8huyB2IgxFz0tcz6UOcPByMnvigbWHMdE2XHbL8E34xa79izkWt/PW3MU
 +eFxVSJP6QHH+AWchPAPwJnueW8AINH5Wc1MtkIRbeJuOtiX2wQ1fA+vULcISqExZkUkI
 JFSpDeRADe3Mbexu7TWgKX42kvm9TIsGxTSgmv2AGI6aIV68Qp/hgmAtOyurkJys6DThN
 /8Fg8V6eA51TeJONhzBrN001QBhEKy01x7NjrABDABMyVzmsxQvLAqpqXrn/KbXCo/Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=iCbSFuUS; 
 arc=none smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=iCbSFuUS
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3FC4B6076F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793616410; x=1825152410;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wJmfcS2b/F3JUroioHdfd/TNb7xOb9fGQy7xtYYDNuU=;
 b=iCbSFuUSDJJLy+Re2Q9wAe1g60eLAXBXhnAfzPIKzVL3ut+gcl2ejNcC
 FbBm8iBIR+w3CIzXgI3Hr4HeBvqomKtHId2vravLHmE9R8tIrUsnpzhmA
 DQw4Uzmma2s+IS8xV7z8CmAT/IjByRsTLOEvkI1q2K9jIQOMsZRqmxieS
 ddZhzqcPstn8OKCb7uEAsUeZFla4snMVjzGcu0NEIuJurJFI1PBBN0leq
 wJ426LlD1rWIZCFwzIalIg4bGqbiGOK7QzrUMFLo4BjcpkWL5IwA0/Nzw
 scZ13hqXskC14Mrp5j5GkG0v+d8QDc3Hvscyl87geAMaRL+y9sVYj9E+P Q==;
X-CSE-ConnectionGUID: 6WdDumPTTdijDs7j1R4LuQ==
X-CSE-MsgGUID: UPCYDnmERpKBqA2RB8BZ0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2305040"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2305040"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:46:33 -0800
X-CSE-ConnectionGUID: 1nby3DNKRfmRVgkusntSkg==
X-CSE-MsgGUID: nsbrz+3cSAGPF2T6q+f36w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6012015"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa004.jf.intel.com with ESMTP; 02 Nov 2026 02:46:32 -0800
Received: from pkitszel-desk1.igk.intel.com (pkitszel-desk1.igk.intel.com
 [10.217.184.18])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id A1BA32876F;
 Mon,  2 Nov 2026 10:46:30 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH iwl-net 6/6] ice: register LAG event handler last in
 ice_init_lag()
Date: Mon,  2 Nov 2026 11:50:21 +0100
Message-ID: <20261102105346.30739-7-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
References: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ice_init_lag() registers the netdevice notifier before it creates the LAG
recipes, but when creating any of them fails, the error path frees the lag
struct without unregistering the notifier. A failure of ice_init_lag() is
not fatal to probe, and pf->lag is set to NULL, so ice_deinit_lag() won't
unregister it later either. The next netdev event then makes
ice_lag_event_handler() use the freed lag struct.

Register the notifier last, after the recipes are created and associated
with the profiles, so the error paths have no handler, nor queued work for
it, that could use the lag struct or its recipes. Free the recipes if the
registration itself fails.

Fixes: ec5a6c5f79ed ("ice: process events created by lag netdev event handler")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-e0559bca-fcfd-4435-96f2-15f7e3d74184
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 08a17ded0ad5..c4b8af01e2af 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -2601,12 +2601,6 @@ int ice_init_lag(struct ice_pf *pf)
 	lag->notif_block.notifier_call = NULL;
 	memset(lag->sec_vf, 0, sizeof(lag->sec_vf));
 
-	err = ice_register_lag_handler(lag);
-	if (err) {
-		dev_warn(dev, "INIT LAG: Failed to register event handler\n");
-		goto lag_error;
-	}
-
 	err = ice_create_lag_recipe(&pf->hw, &lag->pf_recipe,
 				    ice_dflt_vsi_rcp, 1);
 	if (err)
@@ -2638,11 +2632,20 @@ int ice_init_lag(struct ice_pf *pf)
 		}
 	}
 
+	err = ice_register_lag_handler(lag);
+	if (err) {
+		dev_warn(dev, "INIT LAG: Failed to register event handler\n");
+		goto free_act_act_res;
+	}
+
 	ice_display_lag_info(lag);
 
 	dev_dbg(dev, "INIT LAG complete\n");
 	return 0;
 
+free_act_act_res:
+	ice_free_hw_res(&pf->hw, ICE_AQC_RES_TYPE_RECIPE, 1,
+			&lag->act_act_recipe);
 free_lport_res:
 	ice_free_hw_res(&pf->hw, ICE_AQC_RES_TYPE_RECIPE, 1,
 			&lag->lport_recipe);
-- 
2.54.0

