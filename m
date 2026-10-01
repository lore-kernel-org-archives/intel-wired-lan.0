Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7404BCA5FCB
	for <intel-wired-lan@archiver.kernel.org>; Thu,  1 Oct 2026 11:52:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2402980ADA;
	Thu,  1 Oct 2026 11:52:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F_ra5woArENF; Thu,  1 Oct 2026 11:52:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 16A2480AFE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790855558;
	b=gfDCpDB+vMM/SY5nZFONoA9yLfzkItGhPVsWKqsol9c7pyHRuxY6ZsfM8Q9cwUcRxsb/
	 DJH0/5kOOLdVfeGf6HS9851PQoTLGGSq7E39ybEuhijr93W+lvYGniJTg2oSZwCBxvrbZ
	 yorsrb7K3rrM4179VLLJ5WqUIJT3PvUZyyx3S7JQ3LkfDoXMf+6c9ORj6z4uEMuPTLbQn
	 iBScD+BA78h0c4mjksdtYnVbKKFL/yhuuGs65RMRxGBllGgnpXYEOGbHH7HKlxRGh/Vrb
	 C4Cvdsz6k5dqJtTRmUxQ5jC+d8EF+E+VY2/Q3BREzlvSQw8QUhLQ8jKgBZeGi6ZvnBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790855558;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ACOC7xbGEeiNd2Ug9ecx2jVpGBe07X7HszYoRvzhWgg=;
	b=LGEUJr4B97r95mcPoxGEtr285rXW4AHBfl5z7U8aAoN7c7fFHNg4BdI1DMn9MWc+NF1O
	 2sAUICDb3EoP7cWYDjRvPYdlqQayo/3Cub06fBXXpu32DBd6PYB26XoLw+oHjkP4npLhZ
	 15A/Gu7xx0vfyHDvtuC28BAAe119pEet+A4VjCVzbnwXwTRTQcyYtlNIOozEyd4GzNPOa
	 +lxodqgqn1wC6lOTJe83KhVvxjvE6obm+CFz21fS/gMw6mZnVsEX30W/SH/SLQadXDzNs
	 tH91kvozpfHzb1EtPI5bAF0yRKvLqQKIaTzXNUjLUzPmG6mOuQaHDYlrIAOP8FBqsyA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790855558;
	bh=ACOC7xbGEeiNd2Ug9ecx2jVpGBe07X7HszYoRvzhWgg=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GBs0H5ZOgnVe12+FIp+XMDa0VmS3KLmcfYotjnQs6MheAXvkllaAEknSjEU5FTpLW
	 cOBLIN8L7lG9vLeHlQZyuEmiUtDPejUw+J65zo1HpiRAGNrBwjEiNiwuUVFKSgvTm4
	 6LQbU5CtI2NVop8m4juLbbwdSnUD4OBY00vw78XD0ePDa2yxkVecaE0tSttqBmpz3v
	 nkzfg5NEA8JE3QsqIEWaYQLUa3sRbNzBWD72Ctgt7jOIjbY5RFoWEUg8T9AfnrpyoP
	 ze1fCT+wHON8AYnCOnK58VjFs1p8KwH6gskvPV6aHG3oFLjLSw9yTBhiDXL88wf2py
	 d1qz+hBQgdveQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16A2480AFE;
	Thu,  1 Oct 2026 11:52:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 940B032A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Oct 2026 11:52:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7AAB44080D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Oct 2026 11:52:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fF06iaavVXe4 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  1 Oct 2026 11:52:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C85E2406A3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790855555;
 b=FpfQfqxsRW8+c59/vNi5fjxE6G+23TqyTO71wfwpLeKxISviaOVOBRZ27/ItZjmFpEzU
 HR3EKzcH3qnfM/tDYRfyBaxRKfLocbn59lrzt568K4MlUPkG8hhE8TgVT2zeY4GWJ7n3c
 MGBs0Z1EOjZkXgJR1ttCkXHne7A1QDyoHD1x1kK8NSQvH8DIpTqt+mcPmOFg18gS7Kyir
 Yoa2mOyLekJM7FricRZrBzqEXe6f8HIsAjKvtNPf80C7alzBwF/0l20Uaz25G+7Xda6ts
 G7PECOdkGYsmt+pMBTz1w3yUY8ZFJx5+Fg4TNAUDqD4T6GxPD9ttzrBeZSV/RvybwTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790855555;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=ACOC7xbGEeiNd2Ug9ecx2jVpGBe07X7HszYoRvzhWgg=;
 b=KYnE48CFZcZwVyoysITjQ2GM1lTTvIFnUqXXsofz5rYVLUGIC+Md/EF44EY2OMUq9t0P
 LceFCJxC4ygj/0NwsKMFixFF79nwk5PaCkyOX3lRVXWtqc9pQdwJxuRLsgIT/E7BEsDwx
 uVhszLcQgsI4ZAVeqOz383PImOnc2TZ7rezYqPTFY6gffVGX19v870/DfDYSbogwbglVe
 jA7+FDrsXBrW7o5QM59hJzAXfoI7UH7XZZAVJb8hj/9osASHa4VrbvALD72K2rSna68Pc
 yN6HNkIq28I+cqSXMsCh+X4cO4oSoI+V4/V1DIzSKiS7ExhpYqthB8ErrCFVai6npvg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="eY/RC34h"; 
 arc=none smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eY/RC34h
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C85E2406A3
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Oct 2026 11:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790855555; x=1822391555;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=z0GRBz/HAs0raDdaftgcEjiHELfWhLFBmcfPjtoVjgE=;
 b=eY/RC34hooIlWck41zcRf/4q0+BSfOCdGmRPZAf5YwFG6I7OTMPbCUBf
 5IAWHJAjkclpdOqxPCViNoCdZYYUQRqKTuqmNOrRR81M/M6YmTjgAzXJZ
 srOHIIOhwVWH8vIPvu+kZi8ncHX1rPfQi5KfJODHIKVjEtver7HtU4WcQ
 hsIYivuk3fAdJ5OTGb3/M2FFYP1tb/scfMJGjAHr21Xnh54myhpGTQvrU
 8k+DbXIuoKWzW4pK5S4b2kQGP/uoC1U8uxEp1gYQjs8Yh1SObIJKK3GZV
 GFTwnEnzKerJ7IFQRhZMMjdCCFycDaV98DmKxIQ4x0LefTnc6vCVKIsDu w==;
X-CSE-ConnectionGUID: RZzb/Bo+RUCgP1T9yr+CAw==
X-CSE-MsgGUID: S9sb5PzSRz2VmbQ6WzyiZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="91706754"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="91706754"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 04:52:33 -0700
X-CSE-ConnectionGUID: EDswv1pEQDu4OFxfEGdPAQ==
X-CSE-MsgGUID: kDLdS5TaThuc/jedUHjL+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="272400986"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa009.fm.intel.com with ESMTP; 01 Oct 2026 04:52:33 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Subject: [PATCH iwl-net] ice: Skip PTP timestamp processing during release
Date: Thu,  1 Oct 2026 11:52:32 +0000
Message-ID: <20261001115232.13681-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
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

Do not run a timestamp processing callback on unready hardware
thus avoiding hitting uninitialized structures etc.

Fixes: 88b68f35eb43 ("ice: PTP: fix missing timestamps on E825 hardware")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 24d4ab2197c3..d04a4099db92 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2806,6 +2806,9 @@ s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb)
 
 void ice_ptp_process_ts(struct ice_pf *pf)
 {
+	if (pf->ptp.state != ICE_PTP_READY)
+		return;
+
 	switch (pf->ptp.tx_interrupt_mode) {
 	case ICE_PTP_TX_INTERRUPT_NONE:
 		/* This device has the clock owner handle timestamps for it */
-- 
2.53.0

