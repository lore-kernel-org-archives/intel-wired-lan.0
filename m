Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C3BCA9ED0
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 21:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02B6E605D8;
	Mon, 12 Oct 2026 21:41:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8RCGtwKIFLfS; Mon, 12 Oct 2026 21:41:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 45D73605E4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791841317;
	b=bWqT2zyUObaxGiEo3klPqa++8xPNBo4hf1epjSepssm1j2tuYmkPZ9LqSdtxHELQmTAI
	 qQI3sUyZNwcSy4oxi/gKEP9frgXX1NQDqd5VlsxsNkel5i77U1Q/Qut5f+J+1t95GCBaP
	 vG99zXNY70Qmez8aLXZW/31hQWM9Gi1/DdIWs1iwQv3dxhf9eWrRPGMTNmhcP64IQ2hPC
	 FWVEhtgCrATPX+hyHAAsrJyUA3h8S6EeLiQxWe/Kz/2TcntpcYO02xt5RqlLrV7mhbF94
	 Zhn9v6tPTJPAHA4yk3SgEpZ4wJTNBcTNiFjMmxkZ0gkkRArIhiV9hmsRUHyTh1gm03Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791841317;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=t/+XhC/9oUjKQOTv0ZbqlUtVshoUJbcvrMepkIvvS3U=;
	b=pg2yYTgBn0D98oQjvHi21K0/X16JLcMy/FBUriO9X3yHhucqUl6ukmrPu7DdPwSsbUVB
	 XdF7l7lFWJZwHUkX8xY19eQkFKrvNHeu4WPgHI/uaWOlnth0ua8NwkhpIfuar9rl5pNws
	 KTlP7sz5GpnlyS6reppB5B66rR2mHEevt8Qi/PLeEBtRLzHAqdt3egzkmd3ebZBNOAm3k
	 vGTSHzWazuNa6YTuDPFZR47gs7gFe5U5wbEwik8Z3evwTlHqT7ThUqzTR0s8Ge1j1Vnhg
	 +mL6UxzdSJM6W4GYtwhq7TmHiN8YgqjjJQ2P5mI8q1SBqW67l2zpdX6w5nrfvhmh8Vg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791841317;
	bh=t/+XhC/9oUjKQOTv0ZbqlUtVshoUJbcvrMepkIvvS3U=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BZtcPPO/lR2MnxCcu55NxO6mohPr2LlPZSHca+okfA2w/vikOb2FMaLCIu/AMsGby
	 j5RCnogeigJSmxGrRJLm6Aw/kuAtvWCSkEJgUdNyrYPhm2iGTBYdtJE+8wmCvKXQOw
	 KSK8R6L4gKHOHIiNLHZDwJvw3GomXbNwo9PRCWPFEC+vbVvZt5eYfSh4GnM602zpm4
	 uPcuNhYEhxDvmw6hCaK2Q/7dRGAzNjgT30a0snt1C73v/ghQ3ZwsT3tWI5wryY6b/B
	 hsdYekFg4wLHdWKhF4aA3JHOirqC1PhAsZISDEZOFEPoCGnxflZGHBCaRNTqy5m1yJ
	 NhgGUY8T9bIjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45D73605E4;
	Mon, 12 Oct 2026 21:41:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EF3F2A8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 21:41:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C9A380A82
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 21:41:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bxk_AjZaFdPz for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 21:41:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CAA3080872
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791841315;
 b=NzvM0lNN9CFJzNy6XmZXqjHrHyTzHRzo1Ye6BvI9oyU86w8xztA0FVOOkiChn4J74oEh
 fPBajtG7AtFS96swHEI/ERwXd8r5ithmp7/CoOaW/7o+vFl+wm/mrzxAGUY3TREGzqyTC
 T/YlmNIFE6ExgHtAqg2AH/w5optXsFUIZg2JOdr+0yooRWvUaRm+UBwR/Uhi7PFBcDR2T
 jt8Om3Qscn4K/UkvOE5Cw8RQ7RpFuI8eSTn07YbamuYqAIa1RtvvCZoO/Ly3BJNB18tC+
 4dDXF/U44ztt+Wlz8syty3BeTFhHCSu7pqyTwKVfWEfyLI1ffFnx63zLTYkOWBNKuaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791841315;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=t/+XhC/9oUjKQOTv0ZbqlUtVshoUJbcvrMepkIvvS3U=;
 b=jBYN0BxPbpABMh1bcePHw1U9XIUNgpRNqfWao/t8MulT4p4murH7pdxqp2F0bzxI6KCW
 YUunynaMU4qZj/U3hWT7NGrktOCtFBUg7jOefd9QGTf2hVATPONvjukdhueaObKCuPzu7
 x8gNZ1pBWOD1pLtH5M7AQobjO8AawxS7qvy0gZ419/XLifvL8WWUsVg4dmTuylbJclNen
 TB7EAwMuYpplcSP2muDqih6/jsuK4yYtIHA2Tm4oEen648i7Gy12zr8cjqiUB0XP4X+z3
 H9blkN+OvcMZB6UliPn/bVhedHqYO8U/vLGOARemItetiuSMlQExiGxKMGK6P7mCfwg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=c4FxN8C2; 
 arc=none smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=c4FxN8C2
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CAA3080872
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 21:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791841315; x=1823377315;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=L41LowrlBNcl8ziFIB6UZHjR39jIoTE2Bs1vd6hUUqQ=;
 b=c4FxN8C2dEER402+NVpLQs0rqJGxRzErSv8vFejkpu6CtOFEAG03UZ+3
 FXkWOgDg1fdzHYahV0EHL028jVIp1tjBa2j2NpfVapQk/FWUOKG0SMJ4B
 NoGxJ0/ct2cpBQpTf1yl685qh7beza1zP15UqRG0yUZn6BOP9Ba7wND1m
 XA2IU+yw8Hka72L5DQL7CYk7kIb5AV1COrOfubl4CNsPsna/JKc6dhrhK
 MSfr411Zfi3Q94FYl4R3sx1JdZEE3gvB18fQw1M53qvYrcVZphVQcabRZ
 uf7vyLz9ZbvjoDDiH63sw7ej1MKNY0LI3+PslLQp4ZJDsHWsz3Y1kBBRe w==;
X-CSE-ConnectionGUID: NunURPLdT9Khiav+7GR6Jg==
X-CSE-MsgGUID: iH3eayGFRZChEwqRx9Cjmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="459161"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="459161"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 14:41:53 -0700
X-CSE-ConnectionGUID: yf9RUuT1Q5ulihdatn4IjQ==
X-CSE-MsgGUID: MZK0f2hjSbi5JbBZ4flSmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="897839"
Received: from ccdlinuxdev13.iil.intel.com ([143.185.161.17])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 14:41:52 -0700
From: Dima Ruinskiy <dima.ruinskiy@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: dima.ruinskiy@intel.com, anthony.l.nguyen@intel.com,
 Christoph Groth <christoph@grothesque.org>, ghrafn <ghrafn@proton.me>
Subject: [PATCH iwl-net] e1000e: Add additional systems to disable K1 list
Date: Tue, 13 Oct 2026 00:41:13 +0300
Message-Id: <20261012214113.69770-1-dima.ruinskiy@intel.com>
X-Mailer: git-send-email 2.34.1
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

On some Lenovo laptops performance issues were reported with K1 enabled.
Add them to the list of systems where K1 is disabled by default.

Cc: stable@vger.kernel.org
Fixes: 578294b8b60d ("e1000e: Reconfigure PLL clock gate timeout and re-enable K1 on Meteor Lake")
Reported-by: Christoph Groth <christoph@grothesque.org>
Link: https://lore.kernel.org/intel-wired-lan/87v77ial45.fsf@grothesque.org/
Reported-by: ghrafn <ghrafn@proton.me>
Link: https://lore.kernel.org/intel-wired-lan/_kB6DUeC6oOmJnK0FobVVJHADewewO3wzeFw_GrempgMu6s5CUwHpkT16Bwn8tXRq0k_CN4b2NY6API37M6mVciEpH6DKbTqK7f13KMpmgI=@proton.me/
Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 834a5b8883df..35c729368684 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -74,6 +74,20 @@ static const struct dmi_system_id disable_k1_list[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad P14s Gen 5"),
 		},
 	},
+	{
+		.ident = "Lenovo ThinkPad P14s Gen 6",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad P14s Gen 6"),
+		},
+	},
+	{
+		.ident = "Lenovo ThinkPad T14 Gen 6",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T14 Gen 6"),
+		},
+	},
 	{}
 };
 
-- 
2.34.1

