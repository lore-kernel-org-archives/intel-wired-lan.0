Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A043C9831D
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Sep 2026 12:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5523440D9D;
	Thu, 24 Sep 2026 12:59:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cxpH-MyCK4kO; Thu, 24 Sep 2026 12:59:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6A1CE40CAA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790254782;
	b=dZdrbzq7nTimxF95IF+hd0Z9PpZbTqn+rONYG4O06CRmzgn6LrGRLqV2Uly/7ctIUa44
	 3WSc9nGbZcapvjzGW1r4YhNQ6gYK/GWAQ2NSQGp9iUYw2bJnyWXQdgMzXlI7hs5fXNzdX
	 esDj+6moBvbsGDQHhL2uENvdXCnl11IL5waQMM59wiWdr9xSU4kI5PD7JwNDoiU0m1wGh
	 Y5M9ZO15gTYB6q/x6s5h6lqchdS00smNAkA8bKpZfoVwk0FfaVEo2jUa9DeciT0OOVCWz
	 HhX0enRERFYb0S8Gd+2eyEIh63/8fpAbufP9KwpvjrTF1a0ysxsnDIcDc5/t07o0tOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790254782;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FIQlEUFlSPuubbK2RoxRbBGR9SjJqreDr2oCk6es1ck=;
	b=BH/tbs2f2YCCzidqRh5WJQwbXmsCMFXYEBrCsajZtfJme9Vo3hqRs9YEYQd3sio82GAo
	 +MAPn0iXCBOKRSDX/lRvb1bmLEpykjNwnkxl8AcXQSSoCy4e4+E+0OigMqheZVye1xNoQ
	 1D1U+mRBm88MigvcfiELt7910PhgFNBSClskRLHbfVhR00d5rqnIuUP/2xmhrLOQ4Rtmm
	 4C/eI7m1LMriA7O4QXhQv2AduLE6gnffcxXYVHgEg4aQkxmStQlMaZ3LGRhtYE1Le8LpC
	 BCwJKtoqeMOthR89k26U4+AL0CtKFmHrA0H080qsJlnfqAJU381qTKBES6rsnpIV2Vg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790254782;
	bh=FIQlEUFlSPuubbK2RoxRbBGR9SjJqreDr2oCk6es1ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D77jco5A2G3mVStJrs9f9ATAruLubMm0IfZsTulWJ1PbUaQ7gwarWbOgLdkw0qalI
	 JmT4HBDrWj2d5LEm45zvtXIChAAVBu3orGDNVYwDyI1RwfyH2po+dxXgWU3m9IeooG
	 KbRbUL+drNPVb+Pgby+JYlFVK/cb/bkSoS23c3DFDZJ3xzn7R4GD9WO6BvLcAAbHDo
	 /buX3w/wS5S9qWgK5jK0BsifLi8ScB8PIV9+8oOhsPdqxz6zg5HxXZOwe6x4gWeCet
	 z0iw4sbN1u9MhbaMq9ClkDnQQyFbjHF1PD2CJuPTZxIZh3BLXImpz866q5gIHOTOM1
	 WKr3e3wfhjbwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A1CE40CAA;
	Thu, 24 Sep 2026 12:59:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BB7FE194
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC8FA6082A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 00IbmHpuQNl1 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Sep 2026 12:59:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C19BF60807
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790254771;
 b=Rio5uMV4fTRG7RqUxaan5Iww8EmxHarkYQBLfRHLdYL3yxfzxCHEyhecwgF1CFy53aEB
 /nnRe0kzjbfRGSJeoBdt3WIwXfCJnMZnXowpIvN3zLRbJmJKiCcoQUzPK1GSaDG5CmNOI
 AInFz7dctjQynkNzyxn0SO/Z9jXQKwXKsKCoRu77Bx8ZEgkk1R4hF16jbuPmBRbJMoDok
 hGkfJ4RIbG4tqN9KfxbHOrQO0mfV+EV4IOk/xue6ZU3+bZUT8pN0KZYlqK5kpjiCfY4PQ
 6ntQJNVTb+P8CSioPgrIW3la8jv+Qst0qIn1U2TTc7sm8jz736N4FTxXwvr/bD86M5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790254771;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=FIQlEUFlSPuubbK2RoxRbBGR9SjJqreDr2oCk6es1ck=;
 b=KuZxSLDtLNJn+YdoPXsl5+w64aMRdyHsl9D0Th7x6WYrhUSvuIq3ySrqUFELyPYzhi9Y
 1THDXvcwe6yJFAdttxmy97ss7olKUFQ2Yl0ihky9XngL+UWcTGE5ryFVz3aeJBMLEdylY
 s1evbMVBPApl5v5Zma1v7zPjq2a1Q68gZLTpb+34fr1TPyo7Bf9A3G4QtQQC5gcuDPiee
 mH7+0e2hfb0aDSVJWHlNOrBDAsUApUdsActeOUTtEtaB7zRE7iizILAYT9zkBaiKMOCyg
 ZyNpTimCxMCWu/NSZT9wP/D0nXk54MhWe9NfpoofEClJeRbTPZABJhz62KuoA4rImnw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Whf3p9tM; 
 arc=none smtp.remote-ip=198.175.65.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Whf3p9tM
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C19BF60807
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790254771; x=1821790771;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0tf+p1G4D3ewn7KDhH/n7CLlgziNzxiJx9suljYesq0=;
 b=Whf3p9tMvXJU3JwBFrEok8tSaZA6UWyd/H0qhGimbxn35vBxBmH2RMZv
 DXNxQbOKUXB1ZZ9m+CxaJZBZsdIg2coQ4aYSBCPl0KfqdfhM5115NuCr6
 zksObUFI1Qs7999ViKcR/IKXCmMxVuu5+CyEipmVMgfopsFwk6Wd22b7C
 /oHljXbHX0txpFMhLfK38SGkNLnT1+Iwqfns0v2N+wSo+lbZ1yICGmo5/
 QEv/0SE+GSwOyZfHjU3DCNxsNKIVqqYFDvrUh/4sUJt9jK7cRlD4XcCLe
 +LTihmDAZsbvQSfQkhgEuK2wE4ZwTGnl3WHCHdoqDTKe35vhKQVI+I1Be Q==;
X-CSE-ConnectionGUID: td3bs50uQXGL8z/16wUlpA==
X-CSE-MsgGUID: bfFyC2dySySsgjRqSCOyag==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90249215"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90249215"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 05:59:19 -0700
X-CSE-ConnectionGUID: Xley8Jw9QrOW76oTx4Cunw==
X-CSE-MsgGUID: lY7UqxcBRxivS2vcLB1msQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="311934423"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 05:59:18 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v5 1/8] ice: Unlink the PTP port before destroying its
 ps_lock
Date: Thu, 24 Sep 2026 12:59:09 +0000
Message-ID: <20260924125916.2796499-2-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
References: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
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

err_clean_pf destroys ptp->port.ps_lock before ice_ptp_cleanup_pf()
removes the port from adapter->ports.list and drains the outstanding
references, so while the mutex is being destroyed the port is still
reachable by every other PF on the adapter:

ice_ptp_settime64()
  ice_ptp_restart_all_phy()
    list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node)
      ice_ptp_port_phy_restart(port)
        mutex_lock(&ptp_port->ps_lock);

ice_ptp_setup_pf() publishes the port before ice_ptp_init_port() runs,
and a link event can set port.link_up at any point after that, so the
walk does not necessarily skip it.

Call ice_ptp_cleanup_pf() first and destroy the mutex once no other PF
can reach the port, matching the order already used by the
ICE_PTP_READY path in ice_ptp_release().

Release the Tx timestamp tracker here as well, so the label frees
everything the port owns. ice_ptp_init_port() allocates it through
ice_ptp_alloc_tx_tracker(), and any failure unwinding through
err_clean_pf after that point would otherwise leak tx->tstamps,
tx->in_use and tx->stale. The tx.init guard is needed because
err_clean_pf is also reached when ice_ptp_init_port() itself fails, and
ice_ptp_alloc_tx_tracker() leaves tx->lock uninitialized in that case.

Fixes: 23a5b9b12de9 ("ice: fix PTP cleanup on driver removal in error path")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index a735dfa2b03e..5104ccc70d4c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3587,8 +3587,14 @@ void ice_ptp_init(struct ice_pf *pf)
 	return;
 
 err_clean_pf:
-	mutex_destroy(&ptp->port.ps_lock);
+	/* Unlink the port before tearing down anything it still shares with
+	 * the other PFs on the adapter: ice_ptp_restart_all_phy() can be
+	 * walking adapter->ports.list and taking ps_lock until this returns.
+	 */
 	ice_ptp_cleanup_pf(pf);
+	if (ptp->port.tx.init)
+		ice_ptp_release_tx_tracker(pf, &ptp->port.tx);
+	mutex_destroy(&ptp->port.ps_lock);
 err_exit:
 	/* If we registered a PTP clock, release it */
 	if (pf->ptp.clock) {
-- 
2.53.0

