Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35A0CC6B03
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 09:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABA9C80AD3;
	Tue, 13 Oct 2026 09:12:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dD5Oqhg00Lq1; Tue, 13 Oct 2026 09:12:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C6661809E9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791882770;
	b=Tu0FpM7K+OClSfSWXB02fZDUS87WzPCxX/NBljqbQoH/uBe5DIKttDe72GzpdlRXkKhk
	 hfNS6rGO5zbJYOe8LprwJENnhBJWHuyPQqvuFr12hWQevPngvF3re96ehqF9StJ5NcqJH
	 Ucv7KpqUzIWzUbb5+srX/PWRxo5dzmOM7k9awQaJ9Ve2Ep7fxIRklB7f6HsK+YaGZPdlN
	 EQ8ekKEa0JhbHUDFNmzoJ7jPw+/GAloGTpXUWoiITp8eh4Cba8y4MVHB6a739KxlbCI2n
	 nVcoIHUsMCuk1ihbXNIsP9yUfx0yirrMbO/7aAThHRicmh3YKqbf7KFX6acfZt8AIVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791882770;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0kNisD7DWmI/v6z+TT55NTMn6hC6JDyERHkvEMRtB8k=;
	b=ksmbfrim4qZvYUlqe/jruwd2So4uFcERVBmGdLJgGUVCwCwUu+9EWePfb4roBCUIHQ7W
	 V9JOP+rcq4gvQQybQrOgPmYcv5IPH7p1ny6fGZP7I1TFfLnYxNLwxtdl3YPKNqs6V/4ju
	 3VWBk9NnRtfIgOHGkDiaqc6oPDFu4up+GWZz52ADrJfR4WL4/2uFKqFPecBXJ0beiyHm9
	 KxO+ZLysZjuaEJJhwwIAnsOSvXDLUgtZ/nscCWBjoh+lTXnI0Z+zCWOfFq0GKzk3JYN8O
	 igivHMpeUQGV5ukHVCOOq9iY11+/v2ZKObNx6Tizj64BOrbjPPowNXmY8epfDsr2PuQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791882770;
	bh=0kNisD7DWmI/v6z+TT55NTMn6hC6JDyERHkvEMRtB8k=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o8OfmkvpjSN7d/MC8wNs4zPZlRh84djnnH+yUZEjcqlwCJMxt1r81WDttcl+pdIe1
	 7eoDEuEzyxjHlDwfPC0oAJxkdgBiWLFaJE52y/ZaCFiA1pGVPx25EDaHUskjAeL4at
	 8eBoFztXqiORMqaXBrL34+lk38dc5uMijyBIzbVgsk9I+JBPozG0X6MqYrwadHDMOG
	 2OeQxSrCLFoQs2eBt5Ib7dbNwzRoNpDYL2D7cRkLsEs0QjK2u/DUWDE7BRA9CWRPDD
	 yn9oRG1K/uTULXe4QcSaUXcUgjk1J8k2BPRSEwTsP9psCD4+AhP6CblKwtQS3mUHb0
	 nMS3gXbqh2urw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6661809E9;
	Tue, 13 Oct 2026 09:12:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 50859235
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 09:12:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 41F436075F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 09:12:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qsQ9eARl4u4g for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 09:12:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3CFAB606AF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791882762;
 b=JClzFowHcwc30LdVSC4FWr9PpGsJV05t057qhYre9M/fC0wOV1U3X9FTT8Rxye+yEest
 lOx/im0oDPZcQyIxOckTPkBs1iljsyGXKC2r9sYsh1jiPdkKRVCZSNwhxKtUYf2NrRQGO
 7hccxGyK9wd0IN94YJXey+svjgcq8tOPL+wJGCEbH++0Jzi2hk7vy5rR7LpY5DWkwMiJ1
 Xk7ZtINsnl/i+AtSiCOO4joHSS2w/1w90iweiVqPaOT03n0K9bhzqUbgTBf3lmsbGT7tz
 2vCPGVGIkYVxuoUTA4AZ59AFXu6wW539SkVxKxoMmiY4WcR7L7iKLlAOd4L0y7J8rkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791882762;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=0kNisD7DWmI/v6z+TT55NTMn6hC6JDyERHkvEMRtB8k=;
 b=eHIl3gWeHD/iepJR7zexkDvDv+mOj3eRmXlEjBIrkzLjYilB3OOWNOMoe7ZOeT7PK6XF
 kVrVsxQV9YxsRgMpBHnuNO/QXDsPTkpn/O9Hm96RkF2pFhm9O6Z62mEybiyITyJ47nePO
 PpMLRlZtFSdut2IgS23PeQuUvwHZJyVO+P3Y/CeJDkKTU5S3x3Lcs2OVJskImTTbK8xYK
 rVShsNh7fU+hI9mlWcbk+f0Ce8Ikr0tYPqd4oEUNE0wXQvSe9iV1p3awdqbTom7BEfIG5
 Jb8mxRUzTjgj2HyNCRlhHcpOBpMjeiBBRrbF9Nabnfs76ACuNbAKXAYP3QlY5fc8Q6w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=WPrzqpwg; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WPrzqpwg
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3CFAB606AF
 for <intel-wired-lan@osuosl.org>; Tue, 13 Oct 2026 09:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791882763; x=1823418763;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=+R80bgNgDKU5djLtcqnrQlPIzjKcAaXi5vV1p10blEY=;
 b=WPrzqpwg3x3vzj4QDV3LzsjIeq5GRpzFBFpst1FC5Rg+Ze2a1fgo1328
 3MxDsPTOkPlyDa1yDfUYAjM1YPgJqEHNPnOqDj+IGj8uu3pEk0PJhvpMC
 +aVv8VcvvX2HLmo+6BHFh7nryuk9RtLlAD/f3rYOSaiFPSsLQauxJBsor
 Z78skxyW/7MLt4evgBHDIk06CUGRQWKMQj3ufcQErGUWxkKOUhXFJWgbO
 vCW/vsEz5j+MBu07mtfAop4iTqKG36QVrvGSVQ9urWSJZ1rus8W/1ktaB
 VWGPCa/hSU7MlGN0su65VungFomtt0Gir4pKiJNtsQaRD5PoObzWuhhFR A==;
X-CSE-ConnectionGUID: ZvNf47hXTQeDmnXUsr3UoA==
X-CSE-MsgGUID: KhDkD0d2RAiXMs2kC/XPIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="481269"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="481269"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 02:12:42 -0700
X-CSE-ConnectionGUID: Ls3arw4SQmWu93IjQkZmpA==
X-CSE-MsgGUID: VKfEFubTSjWv/mstSpTjkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1125348"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa004.jf.intel.com with ESMTP; 13 Oct 2026 02:12:41 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@osuosl.org
Subject: [PATCH RESEND iwl-net v6 4/7] ice: Clear the control PF pointer when
 the control PF is removed
Date: Tue, 13 Oct 2026 09:12:32 +0000
Message-ID: <20261013091235.1423979-5-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013091235.1423979-1-sergey.temerkhanov@intel.com>
References: <20261013091235.1423979-1-sergey.temerkhanov@intel.com>
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
index b901f2e0b1c8..a8b5e9b2f2ca 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3300,6 +3300,20 @@ static void ice_ptp_setup_adapter(struct ice_pf *pf)
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
@@ -3638,6 +3652,7 @@ void ice_ptp_init(struct ice_pf *pf)
 err_release_tx_tracker:
 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
 err_exit:
+	ice_ptp_cleanup_adapter(pf);
 	/* If we registered a PTP clock, release it */
 	if (pf->ptp.clock) {
 		ptp_clock_unregister(ptp->clock);
@@ -3670,11 +3685,15 @@ void ice_ptp_release(struct ice_pf *pf)
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
@@ -3686,6 +3705,8 @@ void ice_ptp_release(struct ice_pf *pf)
 
 	ice_ptp_cleanup_pf(pf);
 
+	ice_ptp_cleanup_adapter(pf);
+
 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
 
 	ice_ptp_disable_all_extts(pf);
-- 
2.53.0

