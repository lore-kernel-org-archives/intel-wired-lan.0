Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22570C88E53
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 12:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFADB4066F;
	Tue, 15 Sep 2026 12:55:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gHB7m2rwuOVJ; Tue, 15 Sep 2026 12:55:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 546E44064A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789476947;
	b=Lu7GWBsanRcTR4cd9DNqHJLrTQO1kzJyq7pMN1h3pIaqJTNIFjJfmy1l4hcbi9J/xMIO
	 HNMGJxLrNOXNlhf/oCpsUXoF1hhqFLMTdS+X6CfnaV9aRQ0Y1NOYXuXAxBZinPOUD61Qu
	 LFdTkrU8ez1ZNaDfqqvLe7fjrPopVIUFsmnKG3c8TgcRl2/Y9fHGvBzLYAQHTWMApwLyb
	 Af+lg0bqU2Zgfk7nUK1lnnHVCGIIbb7QTD/HV6KafeEeS1TUmDtspd5vw3AqwxCMSEmge
	 csy02Lfs51DkHaOQRnsdoZk57eg13w3cyYBPgaL33Xk7RsBEOGIIYH0RGASqj64nHjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476947;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Wd9MP4YXepWdtvoc29AfaDUlY5m/GLgg0cCoPIc/Tdw=;
	b=l5StUy0E1HaNCD2PE8LY2geCaVZfx+ktzYzpZqa3kqWz4zTxLL8G8oY5QXlMWuCild0z
	 ecD3AXQD7hvGtBG+aVOeWBxNfvVjsh/xFmCUKC58wgYULYdfKrw9mN3zD8TEvX51rgitU
	 oMKeH2uGrBbCmYHqMaFNub9GS50a8ckJhbr1MNklcbRrNVNMbHqmESk1nG29nsagsfXOs
	 VfnrIs20f/eIv9CSeMlIoMUm7a5VMj6CY1+fovBz7M4aSnnkFDHCOM2Ws5NDeOA7R/awY
	 3zD82UuCx1IBXl7RtrptpbxGcW76Ddy640tVY6FNVCGGsx7FgpAzQ9W+RYRtOcjxGSg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789476947;
	bh=Wd9MP4YXepWdtvoc29AfaDUlY5m/GLgg0cCoPIc/Tdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XVhSRD7p0AlSPxj1YdWGKT0H34XnttuFkuPdyvN7rj4HL+2hMvZIPdO9QC18vG7Cb
	 qyYP7AOTb/GGbKYhXFoOwdT4PoCmeMp9DYFC0WHC/7WHRcA9SdNWsvRjovXXsdbLac
	 ZhsXpMRj9K07y2sVscmXS6YKIB5AbF8YwB3VX6tc8l2oG1Su1lT0AwX0c4VkMf6zTL
	 5uByeR5OXih1xUhlhDnqeh5pZrmdonpbEOYSG9fhgM8Vvi84DwJdKI3Z0gJS4x7EWR
	 TlXOgEHAguUSgddXVZkxWQ1PA8fhczPBHp2gXn6o4wh9aHZlPeX9qtxpXdwWg1qWhY
	 17L78dCFNkhsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 546E44064A;
	Tue, 15 Sep 2026 12:55:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F014493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2113D4009D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KINDXIODy4GT for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 12:55:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 65C9D4002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476944;
 b=EH39XVOmu5yJlICNquzsVPsOqtBBdK7ReBvkxG9dS/QjsM8yzIuJ8RwsemlSBQ70P6IP
 d0ZCrVj+8ga3M0SiqZk9sHU29kOK18PRIfZ21TgQp+JQI8sIxT9R3P3s38D0xh8110zC6
 6KH2Q7eNVeCeIKZ+QXECgG5cv6P/IjQePQXuTfPTqO2rN2xKmzh5mW0nc+zZdoLnpvaAE
 +pdvD2knxWm0cDNdoysuv13dkr4mLRD4zecYJARJZWwPuFg3nibYNZSrg2GFn+2zZX+hR
 TM3KXQS/8zQQYpxphC7oRmXBURFji47VvMxyevNisu8zD8QjjZ1vRgZh24Dp92lLJPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476944;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Wd9MP4YXepWdtvoc29AfaDUlY5m/GLgg0cCoPIc/Tdw=;
 b=D/KV7ILMXeTw/G6duWRxQNWawmJ2gX2VZzN9hC/pHAw17+nj81HCqgkdzplMaWT33zLG
 5T9G4UICvz7Q75eR1wdmPBYFbx2F+RE6m2GYMDv291oZa2VcPank2mNReJ0To65Ug5uK+
 BCHEGa/eWhvp1++oCB58NwaRhoMexwbZu50TzdMCDbMyPifG0GK8mM1kgwnCJ8bp3FMxw
 OyeDJSijA8tt4eGpVRUbJWA5eWWiE8cghiZfrbW3XysL6AUXyjsRL95nhwPqqKnNv1TF8
 gNBB4u1EI4RL2PhBkUjVT4IWZMWJje7cYDKMzhPP/Vum+DYkAn9kt4BETdhHMtqDbzA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NZDfxFvK; 
 arc=none smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NZDfxFvK
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 65C9D4002B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789476944; x=1821012944;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nynaKHxpqFdUNf2h5qjJM7ve6b5QrdSZLCT6fYbUo7I=;
 b=NZDfxFvK3gLcKzxUIziPLZl7j5fUZ2440JuMSL49syc8qz9mPIVLzk5o
 WnSgNZoVsfa4mvwRp2uEtQCYlmp0vbdtOiK4tLIJiY8Wf6vRq5Ep6q1ed
 1LsrJyyvkupiTEtCJ9p2B9wjPL10YF0dZpFJBU/+LMtaLDAIjLQoA91/T
 Zo6bBs0m88BPjgGdNBSoHdMO/U9wISM++cbWEMgve7xAKwFPUSN2BskGt
 Wu/wabqOwC9WE605W9k6rE0oODrNyTpVrPw/rbEAy6F2OLCtDPoPtIEFa
 IAAHQezTT9OdJdl8tqUZM3BhG4jllvVqt2lCGw/3HLWqGYFYcYXd0yCvd A==;
X-CSE-ConnectionGUID: 5f16H2FLS2O/9fBgUtcp4Q==
X-CSE-MsgGUID: LQOyIxsSTLKTqUsfrN2CKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89853129"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89853129"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 05:55:44 -0700
X-CSE-ConnectionGUID: LDA9n+64TICdbbJ4NdstUQ==
X-CSE-MsgGUID: bSMa/eeBR9GbSunN1CX+eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1225238"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa011.fm.intel.com with ESMTP; 15 Sep 2026 05:55:43 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next 3/4] ixgbe: limit ITR decrease in latency mode to
 prevent ACK overdrive
Date: Tue, 15 Sep 2026 14:55:37 +0200
Message-ID: <20260915125538.3975870-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260915125538.3975870-1-aleksandr.loktionov@intel.com>
References: <20260915125538.3975870-1-aleksandr.loktionov@intel.com>
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

From: Alexander Duyck <alexander.h.duyck@intel.com>

When operating in latency mode and the computed ITR is lower than the
current setting, the algorithm can reduce the interrupt rate too
aggressively in a single step.  For a TCP workload this means the ACK
stream (a latency-sensitive, low-packet-rate workload) can drive the
moderation down to very high interrupt rates, starving CPU time from
the sender side.

After the speed-based ITR calculation is complete, check whether the
result is in latency mode and would decrease below the current setting.
If so, limit the decrease to at most IXGBE_ITR_ADAPTIVE_MIN_INC (2 us)
per update.  This ensures the number of interrupts grows by no more
than 2x per adjustment step for latency-class workloads, dialling in
smoothly rather than overshooting.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ddc18e1..7fb2ab4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2891,6 +2891,17 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 		break;
 	}
 
+	/* In the case of a latency specific workload only allow us to
+	 * reduce the ITR by at most 2us. By doing this we should dial
+	 * in so that our number of interrupts is no more than 2x the number
+	 * of packets for the least busy workload. So for example in the case
+	 * of a TCP workload the ACK packets being received would set the
+	 * interrupt rate as they are a latency specific workload.
+	 */
+	if ((itr & IXGBE_ITR_ADAPTIVE_LATENCY) && itr < ring_container->itr)
+		itr = max_t(unsigned int, itr,
+			    ring_container->itr - IXGBE_ITR_ADAPTIVE_MIN_INC);
+
 clear_counts:
 	/* write back value */
 	ring_container->itr = itr;
-- 
2.52.0

