Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F15C30653
	for <intel-wired-lan@archiver.kernel.org>; Tue, 25 Jun 2024 18:50:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C931F41963;
	Tue, 25 Jun 2024 18:50:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MUJdoVBjtqvd; Tue, 25 Jun 2024 18:50:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A9CD9403DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1719341401;
	bh=fcqKC55u7h0+C1R+TZmcf7AGG796DU3uoR9nbL9VG1U=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=JSxrpCZHA5wtqezjAaFM/vIazd00OKnTVSKERnpo3oqadEub8hdIANVjCh5xn7v6F
	 OFwRKW2hwJYsvjGa/DDxL/h3YjYbbT8W8jKlTqjfQ8nXY02DKp4whwknABzTi3FmsW
	 bN1JxvQkVxeU9OGIH1ZVoPWUmWTTMjITdXY4elu/1BBbq7eddg8NH0qA3QF23DWCTr
	 Ibs8vU3w3i+AqOfJpXNZQyzWrxNaAU1dPOXcAZRaguRFMXj8wPdT1LRbpqbQ4YDB9X
	 e+LUrIw8PknhZMuPw1eX7MfVvz7D+0hVIB6XMesoX2QkpK51Co5PBaJJqg7jh0uccn
	 sbgPaqRhnFEHw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9CD9403DB;
	Tue, 25 Jun 2024 18:50:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 593D21BF47E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Jun 2024 18:50:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 51D8F405CC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Jun 2024 18:50:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id okXZIZ3tT-F5 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 25 Jun 2024 18:49:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 18941405A8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 18941405A8
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 18941405A8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Jun 2024 18:49:57 +0000 (UTC)
X-CSE-ConnectionGUID: qChbzaYHTfCII87TTkNOEQ==
X-CSE-MsgGUID: rDYSGJ9DRn+GupIqY39gjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="26969770"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; d="scan'208";a="26969770"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2024 11:49:56 -0700
X-CSE-ConnectionGUID: CpKab/YiTq64pFtkTZ4gEQ==
X-CSE-MsgGUID: sjZqw6orQU2SYiFkfvWxEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; d="scan'208";a="48192336"
Received: from unknown (HELO amlin-019-225.igk.intel.com) ([10.102.19.225])
 by fmviesa005.fm.intel.com with ESMTP; 25 Jun 2024 11:49:56 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Date: Tue, 25 Jun 2024 20:49:53 +0200
Message-Id: <20240625184953.621684-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719341399; x=1750877399;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=I9+x5dwtD4RCBDpgMKxC/11FGcUFxcGqqLv62GSTPTY=;
 b=DghEnPjc7F520T7q40nT4W7LQsAZfGiaKuCCbol4aehSzx7WpoN8uKee
 NKrm+xNDHMhtARUK9uFn0AHFjRgVVmss8Xt6Viczo8YCA1jRPwazAQR2e
 5w9KJm9vErPsuP+1Ntm4NDflbIaKL2mNqa89ktvKd/1dIAbk/KpbLH4Kl
 3YQiB6q9TYVWz/2/k5Xby60EbSqeBp9DiXXs+HoktsO7huBJ0cA1RxWID
 WW7/0IrtD7bDi35rQEJh3YA7gtMAZfLojZJ+I8JizdBaLXoOpFbfdtL+I
 F5hWpliXCakSmeIrQkL33HQ9qEkNGP3Nk7teft9H/PAnkW7caTeAKYPGF
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=DghEnPjc
Subject: [Intel-wired-lan] [PATCH iwl-net v5] i40e: fix: remove needless
 retries of NVM update
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

Remove wrong EIO to EGAIN conversion and pass all errors as is.

After commit 230f3d53a547 ("i40e: remove i40e_status"), which should only
replace F/W specific error codes with Linux kernel generic, all EIO errors
suddenly started to be converted into EAGAIN which leads nvmupdate to retry
until it timeouts and sometimes fails after more than 20 minutes in the
middle of NVM update, so NVM becomes corrupted.

The bug affects users only at the time when they try to update NVM, and
only F/W versions that generate errors while nvmupdate. For example, X710DA2
with 0x8000ECB7 F/W is affected, but there are probably more...

Command for reproduction is just NVM update:
 ./nvmupdate64

In the log instead of:
 i40e_nvmupd_exec_aq err I40E_ERR_ADMIN_QUEUE_ERROR aq_err I40E_AQ_RC_ENOMEM)
appears:
 i40e_nvmupd_exec_aq err -EIO aq_err I40E_AQ_RC_ENOMEM
 i40e: eeprom check failed (-5), Tx/Rx traffic disabled

The problematic code did silently convert EIO into EAGAIN which forced
nvmupdate to ignore EAGAIN error and retry the same operation until timeout.
That's why NVM update takes 20+ minutes to finish with the fail in the end.

Fixes: 230f3d53a547 ("i40e: remove i40e_status")
Co-developed-by: Kelvin Kang <kelvin.kang@intel.com>
Signed-off-by: Kelvin Kang <kelvin.kang@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v4->v5 commit message update
https://lore.kernel.org/netdev/20240618132111.3193963-1-aleksandr.loktionov@intel.com/T/#u
v3->v4 commit message update
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

