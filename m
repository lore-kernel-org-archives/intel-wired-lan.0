Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDEBCA6004
	for <intel-wired-lan@archiver.kernel.org>; Wed,  7 Oct 2026 13:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23CC84063E;
	Wed,  7 Oct 2026 13:17:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KmjG-NaS5s13; Wed,  7 Oct 2026 13:17:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8DCA040694
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791379030;
	b=mwQ+YA8UTwoBMRAEQYQdRfFyeRkv/7UyIgN6GuVwz24JaUWplHLzM0uRsL0wa9QsuXHq
	 Fq60yG8Xmoq80xGc3sducJosaEEg6iKzGr/vEY+uT+fK+e4oamm4eUgtp9WCbpeLRJ0Yg
	 15g/Dal2lavohJrwieqji4YJ2/V9n/gnCmXh0t4YtMGJ85FIOfXA/ToO82aJK0xzGfoIo
	 KsRFVL/QSTvpyxPe8L6lMpiA+5dFTfvF3pK26FDzuBUmyXyhmAp+E8BnbdxVq2/R/O0so
	 gmLjsUQAqrKBcRvjrotvBFxfTZgMqzg2zc/z0pyp4Tw0Lrs/pFRiii3b31brSMGDVQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791379030;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7wwYwwzD0/r6MjBkx4w+I32y7+Gbi/4nTNQdVvC74NU=;
	b=J0m/swLPWUFloUKZFczzV+6P8qEUmxjTwAR6FA1P3LIZEZr9ZJurM6WJiqp+BNnp+UPf
	 UFVE/Ju33T6RKayRMkhA6LAEXG/wG4amQ3xuK3CmEia2bCiZ7G1z//QQ+VWExGbHjJ0GR
	 bVVCGkCcNEH2gWhssM29lWIne62LxlwQsyraEwze5dmd6+G7Mxg2cr+EQDDi6dXn4ZzFU
	 TqGBeHqNmiHFu6mCKbvds0y5jj/syDMYl/M4C6S5m+bu6c8wWqZ+YJkjMRwRJK/IPANjb
	 VAnp0Il1c7N2Vi1HyqOFxuV1DEYd/alI8XH5zCdDn8EuBdGmFW0vJwH9g7yprbIaZGw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791379030;
	bh=7wwYwwzD0/r6MjBkx4w+I32y7+Gbi/4nTNQdVvC74NU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dA9TxwOoQVzi6sOFxsD3nxiEivGLJj5uS1FyFqqGdHzmnC5gOF3i/DbTTFWa9F0aR
	 Eiq3tHjZGaM4atzSriOIb8GRpQprCRIQTLsh4kK/lrwv+9dp/+KvAPnytdsjBjjn9w
	 9QU8J6XMAeAWLqt4t23QRzLloB8YS/SfNcfBpG0wguUERyb3lqQWARLNVA+CnMbaOx
	 NJg0URee2nLksm2hcsPLeQ0bpqct4DSQBNjsjwC/I/KSKQbe+Zx9L9z2WS78neJdUF
	 RjDt3F/dP51hlvcJPpNDHXXt/L2MM9K4c9kY4NDTFVbhoX56FrnTRiyOkyjBYNXNGY
	 ZY8Sxl23ho6+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8DCA040694;
	Wed,  7 Oct 2026 13:17:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 69BB022B
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5B75180D91
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xs-M_R_Uqqfi for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 12:48:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2542180969
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791377307;
 b=m9qkvPG7QZ0h90t8uMGiOOPaPLdxtt8R/2cYyRXLf8PmFO2KRDO4mGJMAMScoQJRe6QV
 2Ds4Q/LyZ1tnDrynPPlV+cIXgCHM2s54gJgwVcUdnvMUWh0Ee2G9okhVQtpk7qrsHGThR
 ikGI9RioZqBfeDCUaxON2uJYMAGtsXa4t3TxkNkpBpETfzIrjxu+1Px9D11FuCYDnjA/p
 897bH6hdHcCJ0sqsZUNP2uXJAd1vKfvCv+hH+MWrYhcI3AN+a35OmRKm7o3mbOz1ixm64
 2Nm1AHwoKNPBEJap1Ry1XRLp5sHwIbpIzXIdRPuN801WBjuK4tMJwHQbyNE2Xn5jP2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791377307;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=7wwYwwzD0/r6MjBkx4w+I32y7+Gbi/4nTNQdVvC74NU=;
 b=crvSdSlXG+cRJ0b931L5WU9sio8UR3pY3OtnRzVFuSL2CrYXTXUsSTcSKoQdS0vzA16i
 K5UALMRxav/wDO/1O0ZGeEj3CxkV9vdRsrxmmIvos54h+CTBWPNwlCJ8rLTJRD+fMbSRx
 JFnTwyu3IDuCxENTae6rEkA92eOd1eATrFvIbUncGQQmw5weyq883xckeT4q9tR/Ac3i7
 3deu1LjcgPB2iecWg2VBEZrZmbRiYCrkw2zoQiZ1g5L9VIJGkdaiB+j5ZJyBulLSG/khn
 wJxfmEzjcoYG/JvJi+yuYUmPaawnoWSLZmVf9hJVd8t5n9TeLM+g7fgMe98I20TAdVg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QQxKpmNu; 
 arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=QQxKpmNu
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2542180969
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791377307; x=1822913307;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=lQRU6GYlHeLDXlqO/JOHP5mhRupTpQEOKntkhR8zZaY=;
 b=QQxKpmNu8uEaWReNInVasOiYBs8DSwpq8/8W5NPLS8bLT382vajv6Q+v
 9JL2sEKN+6IrQBg2c+1Cm9zQ7H1VT5foeAKp93X2g55B6qjtyhLSmz/mb
 9Qr4jQJWLT1Wo9CAJzt8QluLp1NDugFokXs1CveabXM2yRxg85/fKJmem
 e2u1JwnX1V1ht4ljaYGHC1LWduBNXRSTIkoHczMx6fQCNpauwDM5AW8zz
 CuI6osGgtGf4AzPOMbr1oAgdXaRo1Ov8IUZSG7xvbsFABCIFCPb/B8YpP
 BmgaRXCHbp3mOdRfA07uQTY9qXze1FFYt71I1mW5fyYKa+6IOc455Ps3k A==;
X-CSE-ConnectionGUID: TFVX4pX5QNW6gkRgc5U9FQ==
X-CSE-MsgGUID: I0g6CDYeTMKtqd1itZqxDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="31589"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="31589"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 05:48:27 -0700
X-CSE-ConnectionGUID: Z7t9LCWUSgmUUgLjy2Fojw==
X-CSE-MsgGUID: 9mi1rX2QRVGe22jlsfCKdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="281191717"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa005.jf.intel.com with ESMTP; 07 Oct 2026 05:48:26 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Subject: [PATCH iwl-net v6 7/7] ice: Release control PF lock before RCU wait
Date: Wed,  7 Oct 2026 12:48:19 +0000
Message-ID: <20261007124819.1074675-8-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007124819.1074675-1-sergey.temerkhanov@intel.com>
References: <20261007124819.1074675-1-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Clear ctrl_pf while holding ctrl_pf_lock for write, but release the
rwsem before waiting for pre-existing RCU readers. The published NULL
already prevents new readers from acquiring the retiring PF, so holding
the writer lock through synchronize_rcu() only stalls sleepable users.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 043a386c2657..e4c7b110016e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3379,16 +3379,21 @@ static void ice_ptp_setup_adapter(struct ice_pf *pf)
 
 static void ice_ptp_cleanup_adapter(struct ice_pf *pf)
 {
-	guard(rwsem_write)(&pf->adapter->ctrl_pf_lock);
+	bool synchronize = false;
 
-	/* Zero out adapter->ctrl_pf pointer when the ctrl_pf itself
-	 * is being removed to prevent any secondary PFs from accessing
-	 * it after it is deleted.
-	 */
-	if (ice_get_ctrl_pf(pf) == pf) {
-		rcu_assign_pointer(pf->adapter->ctrl_pf, NULL);
-		synchronize_rcu();
+	scoped_guard(rwsem_write, &pf->adapter->ctrl_pf_lock) {
+		/* Zero out adapter->ctrl_pf pointer when the ctrl_pf itself
+		 * is being removed to prevent any secondary PFs from accessing
+		 * it after it is deleted.
+		 */
+		if (ice_get_ctrl_pf(pf) == pf) {
+			rcu_assign_pointer(pf->adapter->ctrl_pf, NULL);
+			synchronize = true;
+		}
 	}
+
+	if (synchronize)
+		synchronize_rcu();
 }
 
 static int ice_ptp_setup_pf(struct ice_pf *pf)
-- 
2.53.0

