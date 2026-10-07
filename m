Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2191CA600A
	for <intel-wired-lan@archiver.kernel.org>; Wed,  7 Oct 2026 13:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9DF040655;
	Wed,  7 Oct 2026 13:17:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ahBQGJ1mY1np; Wed,  7 Oct 2026 13:17:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B92DD406CC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791379027;
	b=kT+QU88IwaQQIn9UFXTada/NpJvESVXMqbVk1j8bfPlH72qRy4BMxIbFM01TdUjgBikX
	 1yyZzydjxEi0mbebAyxD2nwLQYAChGGBK5TacmzQvc6qsUaCEkXwqyyyDSW6ZD7mx1MWe
	 c+y5txNPHO1TyftReiZcBZu+/4Y3SXJfoV9kUl50Iv9PoVSwFQ28iA3iQsVlUoF7/GhoQ
	 4wKbb4qNtuLpSb3GFGd3ge9yvVCm9hC8uYhATVMGPrn+8AhPQ9Q5MZfHJAbgPmj9RwEz4
	 4wBolF0fT9WLXL0Ze7pQfucH0UqqsywtNT810WFZVZJoDD9ZG5qZVDKWlrpVlbqMNZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791379027;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AcQszztDY/H7pn+R8FWF/OQ/QLLpXC03hRGQ+RDQuV4=;
	b=SgusWkWSzNkiV6LoSKahJS3jaeNpOKLojqK6v7NLgmLH4vsP36Rw4u6AI5rIDKqZb8dB
	 KRKnSSbViNqGtCEAllSPO3V7Od/ckW/smlObyhP/6c7OljPgx55gHYwWp6+qZxc4+KcOg
	 hNGceitGkQIIraTLGryax1AXOjgEuwtZxox2I0d/UNRlBxAx7tpUijnaE3W47jPJmj1Nx
	 ua79qkgxRVcEPto3b2LaZw5Vrj6Y+bYZZCnq8kGVJLogjHPp01fCrtY5ef/cuKvo2N+pz
	 QGpo3y7d42wAdl+9n/CBjpIR9VThVwVWXnLcub/eSait+YYRTf+7IgBR3XWMtsiwUUw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791379027;
	bh=AcQszztDY/H7pn+R8FWF/OQ/QLLpXC03hRGQ+RDQuV4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hiRoA48roaVsEsJ2FZ89HA/FvD2sHsFgef8YraB9aaPvAUTjYnNrixjXSMeNnwZc1
	 kSTqJ8duv2H/NDLyWG0bN42B05dIS9eCwMdDHb6ZAmwp5vMOZIzdHwBtGz8oOYxAE1
	 skKeJNCZiN68nmNFAxnD2ttJAQcRaMWKuQXRuWnrHlnYKs4yROvR7C3wHyr7UWc0kO
	 jcuLH7S7ppIoR0FxidkWB7i6lTZHaKE7w2TYlyRgCymO3c/hNjAQZocFJq+R76P2Um
	 JBnrw1XdhcJ0+oV/dF4m5NyMsSFyf8jIiNHwiEgVBTRyofuMC8m9RazfXAh6NNoWnG
	 KvODvTNPnNnfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B92DD406CC;
	Wed,  7 Oct 2026 13:17:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B4F0E338
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9AE4480EDA
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LmtN9cUaxh7F for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 12:48:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C0CD980969
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791377304;
 b=kVdqIo2x0PCNbkvAfFxSNtRx5EG2Eq49eY98TFcyaEaQjdWqUfjZ+OTKmOHmBKKjLNbO
 +AP/woWH/0TE54VNvQfJE8hniWkc4nGdzeb09894x2+8W2vbW1jeaaInPsr65V9T597dN
 L2YS15gyixLs/mjBtEFO14JOBwmspPwNbBdSbLsQeI0h13ArYMOvOmg1sgX5C3+BtpmKb
 G9rCZETgJUAim/8dWAO8Qtzk/tEiz8VnRzVJNmtlp392i0koqqubd0c4+XinVym9sqEUf
 Y1otVkU2vjZ0PiDsFkdq3+/rndq1neMjy3kR+lJIYwFA7RdkSu6p43L+vTgRKNVciJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791377304;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=AcQszztDY/H7pn+R8FWF/OQ/QLLpXC03hRGQ+RDQuV4=;
 b=WSiAitMP28fCbcum8ppRyLIm1XaicnELNfigg3eQN4n7fkKckD73yoXghaEgmU1wesKo
 i3NsmwKKL44K/qh+9dsQkcHF9Jse54g5cIUExJ0cHlnmwXzsfG5oGYsyiATktJW6VT/24
 rpKLNaPvDUBq7ZRdQkrsagSQ82NWAOO0RgoaFdpaAanm6mzFbViedOEzCD7VLdtpePkh/
 xc27JmWBZbvdoFYHa65EfQk/qjSZaF0IanmbeKVQAwneRi0rmYkYvMKs8FPcXwXLVV4c6
 w+YQqk3opGUoCyQKamjEhu+9/suNO/y1X+mzEJaVvSGUmYBjEJhlSgqNzo5939qYLaA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VfRvKofj; 
 arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=VfRvKofj
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C0CD980969
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791377305; x=1822913305;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=6OSah0iKX8hYtBLSSUxiUKWOg5YiakMGmAj377rtgsU=;
 b=VfRvKofjphvspFQDl/rI7NmkyKa0fqMEbvrlgQr9QHCkrMyprppRxtjk
 NKDqzVrist7i2Oa86awWKFKljGf8Ta4BbHuR404UHL8kZQtJBgPUwl2SP
 8g7p5r/RXBG+Tu0JYgJwR+4LoHRDiI+sEtfWEjWFFrAL0XwOU2xtITZCG
 tALCJipg08X54nnBEPGdgnsVIM/6mytqEuj5yWbgyvTa4I0hjGs8u4c5E
 cezhLdG7o/wMPtNbuUcgKYQz7rtNeGkUwqEKZUW4UsnsNEyOwuE/GSe9m
 pi1Y92xsJ1TWhPAiTz+JFiN7FYpdxkC8XS/krhCt2bOlEymlM64FwUUum A==;
X-CSE-ConnectionGUID: /b4e9PA9Rve45bTcemPeng==
X-CSE-MsgGUID: BZB1nWQHRjCC9Edjgwow6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="31582"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="31582"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 05:48:25 -0700
X-CSE-ConnectionGUID: o1pa3ZB9RS6oW3BpeD4bfw==
X-CSE-MsgGUID: 0VfT4HzqRuW9NXhzTaYGHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="281191705"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa005.jf.intel.com with ESMTP; 07 Oct 2026 05:48:24 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Subject: [PATCH iwl-net v6 4/7] ice: Clear the control PF pointer when the
 control PF is removed
Date: Wed,  7 Oct 2026 12:48:16 +0000
Message-ID: <20261007124819.1074675-5-sergey.temerkhanov@intel.com>
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

Zero adapter->ctrl_pf when the PF owning it is removed and wait for
pre-existing RCU readers before its storage can be released. Without
this the pointer outlives the control PF, so sibling PFs keep
dereferencing it after it has been torn down.

The preceding patches make this safe to do: readers already resolve the
pointer once per critical section, and the PTP paths already reject a
missing control PF instead of falling back to the caller's own register
space.

Clear the pointer before unregistering the PTP clock on every teardown
path. ice_ptp_clock_index() samples ctrl_ptp->clock under RCU only, and
ptp_clock_release() frees struct ptp_clock outright rather than
deferring to a grace period, so a sibling PF could otherwise read the
clock index out of freed memory.

Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825 devices")
Fixes: e800654e85b5 ("ice: Use ice_adapter for PTP shared data instead of auxdev")
Reported-by: Frederick Lawler <fred@cloudflare.com>
Closes: https://lore.kernel.org/all/aIKWoZzEPoa1omlw@CMGLRV3/
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Frederick Lawler <fred@cloudflare.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 471fc39f379b..043a386c2657 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3377,6 +3377,20 @@ static void ice_ptp_setup_adapter(struct ice_pf *pf)
 	rcu_assign_pointer(pf->adapter->ctrl_pf, pf);
 }
 
+static void ice_ptp_cleanup_adapter(struct ice_pf *pf)
+{
+	guard(rwsem_write)(&pf->adapter->ctrl_pf_lock);
+
+	/* Zero out adapter->ctrl_pf pointer when the ctrl_pf itself
+	 * is being removed to prevent any secondary PFs from accessing
+	 * it after it is deleted.
+	 */
+	if (ice_get_ctrl_pf(pf) == pf) {
+		rcu_assign_pointer(pf->adapter->ctrl_pf, NULL);
+		synchronize_rcu();
+	}
+}
+
 static int ice_ptp_setup_pf(struct ice_pf *pf)
 {
 	struct ice_ptp *ptp = &pf->ptp;
@@ -3716,6 +3730,7 @@ void ice_ptp_init(struct ice_pf *pf)
 err_release_tx_tracker:
 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
 err_exit:
+	ice_ptp_cleanup_adapter(pf);
 	/* If we registered a PTP clock, release it */
 	if (pf->ptp.clock) {
 		ptp_clock_unregister(ptp->clock);
@@ -3748,11 +3763,15 @@ void ice_ptp_release(struct ice_pf *pf)
 			kthread_destroy_worker(pf->ptp.kworker);
 			pf->ptp.kworker = NULL;
 		}
+		ice_ptp_cleanup_pf(pf);
+		ice_ptp_cleanup_adapter(pf);
+		/* Unregister only once no sibling PF can reach pf->ptp.clock
+		 * through adapter->ctrl_pf any more.
+		 */
 		if (pf->ptp.clock) {
 			ptp_clock_unregister(pf->ptp.clock);
 			pf->ptp.clock = NULL;
 		}
-		ice_ptp_cleanup_pf(pf);
 		ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
 		return;
 	}
@@ -3764,6 +3783,8 @@ void ice_ptp_release(struct ice_pf *pf)
 
 	ice_ptp_cleanup_pf(pf);
 
+	ice_ptp_cleanup_adapter(pf);
+
 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
 
 	ice_ptp_disable_all_extts(pf);
-- 
2.53.0

