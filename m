Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D3AC9830E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 19:20:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04A6F60B66;
	Fri, 25 Sep 2026 19:20:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QQ6huu6eq5ii; Fri, 25 Sep 2026 19:20:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3A17360BED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790364051;
	b=YJWCm+RSs4mEJ7QFG3ez5SGw5z+Fz6vERayEVOFH2p3ufljdHcf/uCJ1C+ZLWQiL3J7Z
	 bVWfjGke8GBj2yy1GfawEsAOSi51Ct/W6bzws27MK/804jwHeCt5HNmfMYQvu3FaXrYc+
	 jeev/xjvZ60b18/MJXlnQ+a5nVs1AuXFSQVE81IAyBs1iUsURA2Jq4y3HnP3bkTFqW+fX
	 8v3TlGJt319IHeejnMRgLCvi9yXLflmEj4hUs7z6pZcaFH4emVibZvD45f7quHwtBgdiP
	 HLA7hHZA88AJUgLSTv/iM19qB2Q//acVPNru1SJJD9qwlLDWkCFCBzDxX7iATs/pLzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790364051;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Y9hYmlw6zk2qo/a8l96RwAV6EeASOQdPULMd03l/L8Y=;
	b=S9zyGtHAcaxMPuKPfu5C5iG0f2/48Hmb1cQtqo0gts/1KPA7ssbP760tf1HTw8NvoRQz
	 Ffseac5PAMLd/xOpBuNO7tDzIgvmMcI6aTSZj835EDnAmslkW/ASw8Dl0/07BVhu5yzxZ
	 AVdyYD9yTlJgAMTiBqqiV9cKkEk8Ic+G2h14FihrmIMS4uVwof8xiimfJy3xHy+JVSCe2
	 uSUNW1TU/UwXB1Hg4UzNW7m4w/1PuhiPRAgJkp4GeLXGPYltGMjaMkCdpU11gNKJkK6Qj
	 9kZrpG+paQushhW23tMGi+i+n/Rr1M8HInO56fxzw0uYBbnlC4vS6cd+xiGHsCllT5w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I4JdwAwa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790364051;
	bh=Y9hYmlw6zk2qo/a8l96RwAV6EeASOQdPULMd03l/L8Y=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=glELrQ7yUobDQUD08ezKTyBNg9OdP+4Ub6wLEKTT3B04yvkiMV61He3ReChVIjit4
	 suKxsNd8rwI8EzNll6pziZgRefPdQI8jEb1k3VGnrtJjtIrMv8HXfv3PZv35p6wILx
	 XEvsaGXcUEziTN9tc4TU917ltnM6nWjuM60YmesOg9r6UH3uYdiQA3e3apgRpV8cOw
	 gkJgGV05PGsh3vC+ZSkmwBhjs45okvN+22Iya6lifln9jf5ZRn9LOtw4B+JtZW433M
	 tPEfRDDGLwOk3CEKrLIDjF4pRSZHpn9NoL7RoqkQFBSScYfIMNpZ+aWWfJ+rH/oGnm
	 CB8bMH9TpR8Cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A17360BED;
	Fri, 25 Sep 2026 19:20:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D5916F46
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 19:20:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C770E60BED
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 19:20:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UboZVtzw03Q8 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 19:20:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E9EDA60B66
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790364049;
 b=LsfYBuWnqeaj52l1oOS1/vvx7GPeNMQDwQVynZEqDUR9ZZGtU8uy9aTYcxWYuEvOETRx
 kfScaSXEGyGs3cOAlSY/zGF9dnIk93FWcjCjbFzwuaxdSuq5u/E5JLLBDS1qUpPKEy78H
 xhcHpz/uJ2+8QkYrww0bQ27Dcmdv9mYHiuBnGmIY+ccyHNk2zI20qWUbGN4nHfzUL+VlK
 1MEzB+eH89ePXjqvG/eNheJCB1iu/c+q8zyrC2RYQi24JhQpymo9qjDqbiy4R0VOeFmKO
 97aza538Xn0WL7x6vQgV7b/FrOVUCo57sBRFfQVJfzXHsHtnN1VLw+SfH4yi1mGmbmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790364049;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=Y9hYmlw6zk2qo/a8l96RwAV6EeASOQdPULMd03l/L8Y=;
 b=i7zF1xZNKMbGXH0cq8gm+D8fgR0A1YctdGlOT9s5h50hq3B8kJI9WXebcJxWZXr+EY32
 kjCPm4wdtbRpTPtjsTyAk+I51UzCnS81SRl6zEi5Kbtn/rhdLVJmQfww2cYKoofGkD6B2
 mrI/jlOIOLaWqti20TTYY6cbaTUfAS2zI3AUJU8XT1TKYuoXsusmYCAmkUyQ23uDNPihd
 FVPK8VOCoTBjMMXsJjbVoJgrC56Ppp5FnwsRHuBf/e+QgqjZHbZU1Mikx2uy4jy3Zbvv8
 0245az/Skvblt5WqAvejzqL8bI2bF6Fq0tiCU7uH0JUg24VyBy7Gx1iEDoMmfWWcIpw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=I4JdwAwa; 
 arc=none smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=I4JdwAwa
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E9EDA60B66
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 19:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790364049; x=1821900049;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8KgwHLXU4PJq61cEsmIeRpFwMxqoM6+u36m1kI3Bki8=;
 b=I4JdwAwaEa1UUzxnSGq4AX29P7kDB+z5Bsoq9ymbH19hW9XSlWvcuQSM
 ee0Q6Hfd1P3nzCj3y/KxuQHpzlTpXy1cO4LLQRrTj2uabqlCD4atG0sRB
 gOIWkHWRaaGY7pSTmsCgPm/Hs8nt/kLPmbcATq+M5HGTY/XdaDhoWKEoS
 sqt0R+pQqTYKT2Er5UG425CugXi4Jn4f6+c6ka2XVJvG+133/V7MNX0Mj
 xc3kOH8OSVW/EZewXOeXnmDI9jw9Eu1pLIiSllWcDgc9jGvp3KS0733nn
 /l2y8eiWN8FabQD8BEgeDjGLU5wwSXR42C7SqJ6WVITfcH/dC3BUpr2UL A==;
X-CSE-ConnectionGUID: 371s6cDKTryWLTKn89qdoA==
X-CSE-MsgGUID: A2mhrzvuTrGPNuP0W7L5gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="108648930"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="108648930"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 12:20:47 -0700
X-CSE-ConnectionGUID: QsHCOclQSaSy64zk87YTZg==
X-CSE-MsgGUID: ujn/HNl+R1Gftv/KL9UvAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="312323431"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
 by orviesa001.jf.intel.com with ESMTP; 25 Sep 2026 12:20:48 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, dima.ruinskiy@intel.com,
 raanan.avargil@intel.com, gil.fine@intel.com, javier.herrera@afronta.com
Subject: [PATCH iwl-net] e1000e: add system to disable K1 list
Date: Fri, 25 Sep 2026 12:20:44 -0700
Message-ID: <20260925192047.3308768-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
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

Javier reports seeing issues related to re-enablement of K1; disabling
it makes the issues go away. Add the reported system to have K1 disabled
by default.

Cc: stable@vger.kernel.org
Fixes: 578294b8b60d ("e1000e: Reconfigure PLL clock gate timeout and re-enable K1 on Meteor Lake")
Reported-by: Javier Herrera <javier.herrera@afronta.com>
Link: https://lore.kernel.org/intel-wired-lan/CAKRuCQLWEcci9hPgNUmvq44Bd2H30T5_vP=exMjsknXMN5Yh9A@mail.gmail.com/
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index a55e459a78c1..9e22fda7ed93 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -67,6 +67,13 @@ static const struct dmi_system_id disable_k1_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 16 Plus PB16250"),
 		},
 	},
+	{
+		.ident = "Lenovo ThinkPad P14s Gen 5",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad P14s Gen 5"),
+		},
+	},
 	{}
 };
 
-- 
2.47.1

