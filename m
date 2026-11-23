Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE26606A31E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Qk9qEfz5;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kws6VOAR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F65940687;
	Mon, 23 Nov 2026 18:40:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yeEDyOKZCQ1E; Mon, 23 Nov 2026 18:40:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 82276406C5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795459219;
	b=DojTurRWD99Y3QLyHcihRwL4kX/loIp+h9ov9RDWO6YmogGeerX4Fj7qjO0770dpIOx3
	 d7VUeB8kj0o57va5YaeNd8PzNPUGjXRgs/QzBFQOnxwq5DamM6/IMI80/5TeSxMr3yZqc
	 KInUHyjwUj92ygOBeF0HP98s4XZVbcaBN4HEUEPZzxOQKHJhyCpvo1PPUAif+Pl2v9scr
	 rcSrq0WvzIYpyiWhCPo2+XTb/eJOIQP+RWcFxeMaMNKK/gDDT8mGDPz7IEshfmgpm2Mpv
	 FrEd2nasWeylg2a+20ZNHnn3YyfsLzS80/6Rr5wDO4odJZJfZHPSUxVJUiqBz/XSN9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795459219;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=t8I02Sa2ZDhlIDWGb+fFmkL3FqMcYFBBiPLlDm4JG5Q=;
	b=m2y0DBRfe6OTofLQSbs0niUXCHsAQd3xswvnU6zXN3ifrcmNrJ5GXVCfyi3rHAEBi44a
	 0W8mXO7inRxfsS3gxBg9qmBQ6l1j13m8uenS2yMCWUpBIC65qkIzEXhKSRnP4oNXhzPn3
	 Zt9f0raK4wT9847KffpEPuSvtZlCnuJtK8u7/rTgmBhaAxg0yhk2t6tZuwSKoTy2k9Jag
	 a6bJwfNFYFIjoj8RNaAiMs0t6x543CLGqAv3ofGoaS49/aBudibGNaRfmQuvj60Ud8AII
	 Norjtfs4r3PT6qeSyBEPSF3y+3gqOO9N+rZ0EOlaVDC8d61YBW0tXqGa090U0Gfd/LQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795459219;
	bh=t8I02Sa2ZDhlIDWGb+fFmkL3FqMcYFBBiPLlDm4JG5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qk9qEfz5guUlg7w6fUPabFRyW/pfdA17TjyO4rd+UlvQ5f+g1P83mlXnCIn64Wnuh
	 xcwiwomZpRCWE8g+/54r8SZt9GYhpiDkR/kB1anJ5FtRemJZhIQHyVBMpvK9UEJ8F6
	 kY1FimAp2W8XfYhKYIv96EnxKnMh3WOvq2EnhLRDB21pavWbVmnieIir6kCrhpcNih
	 RB9cEPUjHyIJ4JUjYkD384fk66b2ciIK2c0jNgvyqdFnqQpzG+vq1g/GWa7FuF4YH/
	 OGAb5qHgVXun5obFswCwK/rRx6z9VgHggbPMUvNK/DxAZCx7SV1+YeEDR0hZpfv7Rv
	 v06u8KwyXFm0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82276406C5;
	Mon, 23 Nov 2026 18:40:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E2FD499
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:40:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 203DA4021C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:40:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WemUg7Q0cyqp for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 18:40:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6291840093
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Kws6VOAR
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6291840093
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795459218; x=1826995218;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eFM3ofTPTF/DuHYV5NjvC4twD7UQRlKor4Fa1cEbWuk=;
 b=Kws6VOARq6lFsIYjWv/LAET7p7li+bqfHxqsILA66wp4vnvQ5Ast2n1Q
 IEn0MQ3vPyGHqi7xxHpPnLNTwvLCVYZmU87EyoInupiSV15QD9XrArjJO
 KvIh6/RZiyNvpwjh+I/KjylrEtkn0D8Kiznt5w0FG5Wedb5iknp3B0oSR
 JDUYBwiui7/SsnlAZTUp+qfbsUozmi4v2ro0ZP+KqY+mB2YJdCMrxo/u8
 /7fJlDmyE4PTKtJfnAVuX27JEfqFgvk/21MdaCWFOFREKIKxKV6tTsvg3
 iEsGIWLJZUGuJZtmdG7ITHZLLhLmEte3Zi1rMAgm9rR4htHJuZ7H6wr34 w==;
X-CSE-ConnectionGUID: hfMK2rcOT6uUSi6JkThnBw==
X-CSE-MsgGUID: K4A3G5Q+QuG1I4nD+r8Pag==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4157687"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4157687"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 10:40:18 -0800
X-CSE-ConnectionGUID: 5QOGNWFPRRKW4zxzNu0Rrg==
X-CSE-MsgGUID: FhDWGuVQQVWEUn0DG2M/Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11245384"
Received: from ccdlinuxdev13.iil.intel.com ([143.185.161.17])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 10:40:16 -0800
From: Dima Ruinskiy <dima.ruinskiy@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: dima.ruinskiy@intel.com, anthony.l.nguyen@intel.com,
 Michael Edri <michael.edri@intel.com>
Subject: [PATCH iwl-net v2 2/2] e1000e: remove K1 workaround from Nova Lake
Date: Mon, 23 Nov 2026 20:39:56 +0200
Message-Id: <20261123183956.1177222-3-dima.ruinskiy@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123183956.1177222-1-dima.ruinskiy@intel.com>
References: <20261123183956.1177222-1-dima.ruinskiy@intel.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit efaaf344bc29 ("e1000e: change k1 configuration on MTP and later
platforms") implemented a workaround for packet loss issues when the K1
low-power link state is enabled on the integrated LAN on several platform
generations, between Meteor Lake and Panther Lake. On Nova Lake platforms,
it is not needed, and may cause noticeable performance degradations.

Now that board_pch_nvp and e1000_pch_nvp are distinct types, add another
MAC type check in e1000_reconfigure_k1_params() so that it never applies
to MAC types before Meteor Lake or after Panther Lake.

Tested on an I219-V29 (8086:57ba), K1 enabled, 1 Gb/s link. For each test,
first line is the result without the patch, second line is with the patch.

  iperf3 TCP receive, 20 s runs:
      16-50 Mbps, 72-208 rx_crc_errors per run
      949 Mbps, 0 rx_crc_errors (5 of 5 runs)
  UDP 120 Mbps for 120 s, 2 runs:
      0.55-0.67 % lost, 1855-2651 rx_crc_errors
      0 % lost, 0 rx_crc_errors
  HTTPS download of a 4.3 GB and a 3.5 GB file:
      5.6 and 10.3 MB/s
      74 and 59 MB/s

Fixes: efaaf344bc29 ("e1000e: change k1 configuration on MTP and later platforms")
Co-developed-by: Michael Edri <michael.edri@intel.com>
Signed-off-by: Michael Edri <michael.edri@intel.com>
Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index a412475f5..f5f3867ad 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -301,7 +301,7 @@ static s32 e1000_reconfigure_k1_params(struct e1000_hw *hw)
 	u32 fextnvm12;
 	s32 ret_val;
 
-	if (hw->mac.type < e1000_pch_mtp) {
+	if (hw->mac.type < e1000_pch_mtp || hw->mac.type > e1000_pch_ptp) {
 		if (hw->adapter->flags2 & FLAG2_DISABLE_K1)
 			return e1000_configure_k1_ich8lan(hw, false);
 		return 0;
-- 
2.44.0

