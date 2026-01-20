Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C9AD262AD
	for <intel-wired-lan@archiver.kernel.org>; Tue, 20 Jan 2026 22:44:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D512940CF7;
	Tue, 20 Jan 2026 22:44:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1WvsU-VfuTXJ; Tue, 20 Jan 2026 22:44:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9163540CF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1768949081;
	bh=Lc5y+oZmTsX/1mrxdBWKFkiekrPC6HZeLaC2h0xMm5M=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eGk3h3qAriZGJVE2nztEFzRzeGImwrB3IOdSJJ8RW9Dz3Jpc1tddxPElXT+4si9z2
	 NqI3kEROl1FWta46HcfY4TeNOp43piR5oEw1i4JkwHdWDY0TBXYPKj4oGF0k6vG6FN
	 Z9We47BBms5uCH2+tpUVKll9hPZDN80n1spgkGXsFLYF+wplpZof/nGbDaXU21Pkia
	 INQ7bQicsNlc611SBP4cyDj+TqCTJfeNLREl8+EjXvx8OPIOZcE40CMkG0gSHs1rnL
	 P9mUJpmN7SVIYbeOeTwKMYYtKqTIyVmP71edOQPmR/aAsaO2hrCiW+inYXLWLBtdat
	 55R7culCFwX7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9163540CF2;
	Tue, 20 Jan 2026 22:44:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C427A160
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Jan 2026 22:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A3B5F80883
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Jan 2026 22:44:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x7f3FKbwrAUq for <intel-wired-lan@lists.osuosl.org>;
 Tue, 20 Jan 2026 22:44:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C8F8580879
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C8F8580879
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C8F8580879
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Jan 2026 22:44:39 +0000 (UTC)
X-CSE-ConnectionGUID: pWtO8bTWQPq6isq1pdkcCw==
X-CSE-MsgGUID: AdHsoKNERZWBsTcKpSivJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="81548795"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; d="scan'208";a="81548795"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 14:44:38 -0800
X-CSE-ConnectionGUID: PjyR6n8sQC6ACo5AEPesVg==
X-CSE-MsgGUID: 2pbY1saLRR+Yj0qNZ0D42Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; d="scan'208";a="236920163"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
 by orviesa002.jf.intel.com with ESMTP; 20 Jan 2026 14:44:37 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, anthony.l.nguyen@intel.com,
 richardcochran@gmail.com, lrizzo@google.com, namangulati@google.com,
 willemb@google.com, intel-wired-lan@lists.osuosl.org,
 milena.olech@intel.com, jacob.e.keller@intel.com,
 Shachar Raindel <shacharr@google.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Samuel Salin <Samuel.salin@intel.com>
Date: Tue, 20 Jan 2026 14:44:28 -0800
Message-ID: <20260120224430.410377-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260120224430.410377-1-anthony.l.nguyen@intel.com>
References: <20260120224430.410377-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768949080; x=1800485080;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RF0DMaTL2HFT3ksEd5Q3xpKkrh26dMUQMd95p6l5Yvk=;
 b=OR4GDsaweSjyo5LxVWKIYWLhw5NpsnkqdC15fEnqcyFWepcOhx9PT0z8
 2nlVe1bCTy4sIz+0FJ0e0DOLm5lvdcdFPCxz6e5w/vB9nui8nfdtLt4c/
 PdJJfrvwCgkCGKqrp3kg13gXiJJTAC8uzJGjuKQCpJ3WBV28ABMKy0PFq
 3X4oXjZvGQf8vgQZ+HsKnYAOKAMO0CJnJd2NsEJ8qjysXdsGSV0tEmf84
 y+6L+/SJYzP6m75uxh7jc0gxBlEJv92sxyE9aX8HL6kOH5iA02fiIUjZm
 rRHKCMlCdk2pWXXk7DoPjygaS5m8smvs9Z8f/UzKz2+0PC5G69YCRrKVd
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OR4GDsaw
Subject: [Intel-wired-lan] [PATCH net 4/4] idpf: read lower clock bits
 inside the time sandwich
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

From: Mina Almasry <almasrymina@google.com>

PCIe reads need to be done inside the time sandwich because PCIe
writes may get buffered in the PCIe fabric and posted to the device
after the _postts completes. Doing the PCIe read inside the time
sandwich guarantees that the write gets flushed before the _postts
timestamp is taken.

Cc: lrizzo@google.com
Cc: namangulati@google.com
Cc: willemb@google.com
Cc: intel-wired-lan@lists.osuosl.org
Cc: milena.olech@intel.com
Cc: jacob.e.keller@intel.com

Fixes: 5cb8805d2366 ("idpf: negotiate PTP capabilities and get PTP clock")
Suggested-by: Shachar Raindel <shacharr@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index 3e1052d070cf..0a8b50350b86 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -108,11 +108,11 @@ static u64 idpf_ptp_read_src_clk_reg_direct(struct idpf_adapter *adapter,
 	ptp_read_system_prets(sts);
 
 	idpf_ptp_enable_shtime(adapter);
+	lo = readl(ptp->dev_clk_regs.dev_clk_ns_l);
 
 	/* Read the system timestamp post PHC read */
 	ptp_read_system_postts(sts);
 
-	lo = readl(ptp->dev_clk_regs.dev_clk_ns_l);
 	hi = readl(ptp->dev_clk_regs.dev_clk_ns_h);
 
 	spin_unlock(&ptp->read_dev_clk_lock);
-- 
2.47.1

