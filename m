Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE93CD6E4A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 28 May 2026 20:24:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFA6A811C1;
	Thu, 28 May 2026 20:24:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fNc1-ab73C5y; Thu, 28 May 2026 20:24:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 973C9811C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779999850;
	bh=f+buzPHP/yFGPxo5y7pttiRm4CAr4PHQWonzd0GLfQU=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=7aGYwXhEChciHCNolejLLUKh6dCRQ7Muf3r/1gLuH1/PJKf07almwLRLmsaz/3Cmv
	 vcsHpXdFqefHGZoaAtiFDWvvwowcgCd5T/DxGayKVfLKQUTFdzQBt3gFRPDYAy94e3
	 NWRdQig9Sz19TQqYkVYnSWe5Ac2taWgqOnI1MdAJrUIP85ByLU9exlUnmd1KJgVPNG
	 MY+2hdt2xfaxy+5dDS//hZd691+FA8bNZzUKEc12R2oItTe4niXBZa5OBltCMeMKfS
	 ICOkiihvbL6gNJbHHBGcjhUdUE4xCrezs826fVeklwb3FbV7GI0wIKo1NGnvtqD8IZ
	 UEP1C8U2Fn2sA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 973C9811C0;
	Thu, 28 May 2026 20:24:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BA59D3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 28 May 2026 20:24:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B41240180
 for <intel-wired-lan@lists.osuosl.org>; Thu, 28 May 2026 20:24:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3k0JPW5B078t for <intel-wired-lan@lists.osuosl.org>;
 Thu, 28 May 2026 20:24:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 44EA9400BA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 44EA9400BA
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 44EA9400BA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 28 May 2026 20:24:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D3AC443F0;
 Thu, 28 May 2026 20:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C025C1F00A3D;
 Thu, 28 May 2026 20:24:06 +0000 (UTC)
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev,
 intel-wired-lan@lists.osuosl.org, Bart Van Assche <bvanassche@acm.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Arpana Arland <arpanax.arland@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Sasha Levin <sashal@kernel.org>
Date: Thu, 28 May 2026 21:47:30 +0200
Message-ID: <20260528194644.539441066@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; 
 s=korg; t=1779999847;
 bh=f+buzPHP/yFGPxo5y7pttiRm4CAr4PHQWonzd0GLfQU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=1pad1rmO/t2vM1y6R/tLhp10GORt2E5xCAU7SGfqEbAkzEEHpzXDZBUb3RiVoyyeq
 O08X/7d2vdHnUWxoKiGEsX6fKBCQAYZPqzdgOk/McHSRkTuciehm9iv2hqlLMUA4Wn
 7rk0CPN9G6276RMJi9SYjnWfZudsO6SVkgIXm5Jc=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linuxfoundation.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=1pad1rmO
Subject: [Intel-wired-lan] [PATCH 6.18 212/377] ice: fix locking in
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 0ded1f36ba4021cba50513e80be6b6e173710168 ]

Move the mutex_lock() call up to prevent that DCB settings change after
the first ice_query_port_ets() call. The second ice_query_port_ets()
call in ice_dcb_rebuild() is already protected by pf->tc_mutex.

This also fixes a bug in an error path, as before taking the first
"goto dcb_error" in the function jumped over mutex_lock() to
mutex_unlock().

This bug has been detected by the clang thread-safety analyzer.

Cc: intel-wired-lan@lists.osuosl.org
Fixes: 242b5e068b25 ("ice: Fix DCB rebuild after reset")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Arpana Arland <arpanax.arland@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20260506-jk-iwl-net-2026-05-04-v2-6-a5ea4dc837a9@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 9fc8681cc58ea..270f5a00ece3a 100644
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
2.53.0



