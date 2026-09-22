Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649D9C98309
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 18:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33FD2406FB;
	Tue, 22 Sep 2026 18:08:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yKcn3RBfu-NY; Tue, 22 Sep 2026 18:08:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 907684078C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790100521;
	b=Z05v7fl5QANtYeThdf7QyEl7EpIS2izbx1G9OXFv7nIuSJEdbj6G4rW6H6C4JeX9fagw
	 WbRWyTdP2L7YRTW/TwJOUUGGT0+dzbGeVlYyAdwGJj1aKD24X9I8v6RHBNhP8oIQUHtmF
	 4Y+D4qBGAjt1lC4pLPZO8RWmewjzFiJP5DFwUKqM5FkA4pkrFnQagXoSLWGUB24jmOd2v
	 UfYgSjqY3t8S3tMdcSQ2nUS7yc74+KeD1GEktNJxBAjB0YzX2MbDCnwLJ+2Jq3RmAGXBa
	 xx9VJjULKEbuZdDwXU/XsqoDzpkplBMUCWvF95vklEBJeXfanuf+4xyqp+j4RhOxdZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790100521;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8OWAHyqYZZK8upQgOY6J4qSKQl5MZP7YICiltyNEdNE=;
	b=D504LC61HhorLQAfW8ldDcGcj5rgsxbDFDltO80IjY8/bncLFajlEmGTLnaxiOAlUzVJ
	 vziEz//9aKbjk+X74gE3umeAOirBBKdJFpnHJd0oBndk7dXEeQKTUCstdm90gMyFqATtO
	 3AfbwH3RwAhA+bKtYBuSr9vdHzkSFfTmSZWA0i1t/di/xljIZdB0cmuG6xfXj6GpC5i/z
	 yZChhKfADMHk1+9X4qzLd1Nd5SKiJjszH5rabgi/cT3Cc+SW+NcFAAwW6ZHqo6KGpBD6j
	 gipkiHdJ/uIUXuP1xCvb1vpg1/Hs6w0UhKf+NgGCtD3eFeSDkfneWOg0fC8RazKtW6g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790100521;
	bh=8OWAHyqYZZK8upQgOY6J4qSKQl5MZP7YICiltyNEdNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Taj7VlyomZ/q0AI72PYPcvOm4qm+Twf0oyk2jOsrRypFEUQaRKxvmxy+MeoT9xbVv
	 G1JtirbV03uvct4Y/vqoyzE+7xU0ThlatLx5L+g3MuqI0J4Xn60QvaGxqYTiaRxeCF
	 tGXEK6vjf6u+hzCICPw0xC7NiCc0l5RsqG4eF4uOBJi3tw4EFN5pZTW6lj2KApqMh4
	 kPOp+SBfOnQMy5iTeDRy5ivHau4Yx6XeOo1N563HHyHV8A5I4saMrtxK3dU8aEfLq2
	 fJqJ6WK6Bp4h+kZfWESnlUac5LfehAz8x3DB8df/TN2JrAtt8YGfn7iMlGKoXAUrq9
	 kfdR/C8P14DXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 907684078C;
	Tue, 22 Sep 2026 18:08:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0482012C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0266440076
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SfEuPL3FvARp for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3C7D840068
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790100508;
 b=FTGRnY30QYb0+LLbEftvalp8agbikuWW61bDC4WVozNWVXjKBopgbYtc7346q27JB0I+
 B6zbX4V5PRgLiBzfk3ohVDHjQQRs1HX2uIT92Leg0q8QV/UnjgFWVoFbiAMtmth6jpInx
 EJTqQzX8rlVuY7Pe2fypJFe1ElUbGJPcA19KUJuzIiJG3zhKBtxP6G6Amukf9KRt2N52v
 Deojz7jaq54Ry/6dJ10Q3vvsrSTlKhcRzpjKlJs2QVFQevK2DTznZINW7YYN3BB0YoCoZ
 3cUP8ole1G9RPOlGK8lDm91mrfzD/JSZGB+yqEuNGxKdoglc+lVzXlIxGukMWwElOug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790100508;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=8OWAHyqYZZK8upQgOY6J4qSKQl5MZP7YICiltyNEdNE=;
 b=CNVutOcGpL0X+aMxXnInv99WTZxXSXjMIV0x61TIm7Wk6CLvVW+DjIEWGVAfRjtvY0nW
 mRVdRW7ex/QY6Z2hXHx9zTzLZbPl51pvSeXrJyvxUMz4hLAq0Uro9xmWLMl4alve86sfK
 YVxbSrLnSeFH+jmCLTb5fMWjxRLmJffIQL30xcRz1N9V1QVy3T2wKizeNhpadGXXt45Aw
 O0yfvOfYUV0W3k5E+322SaHq26lYIIjxXjkBWn5UxpF/PgcD166guR1DOe7iVeI1VXg78
 mN0Nslvy11uSF/fnlh1qCU9/GS/YQ8rb2bcy2BvEO39XfC1wHhtKt9Vcb8hJ4g83r8w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="jSp6XH/I"; 
 arc=none smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jSp6XH/I
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3C7D840068
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790100508; x=1821636508;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=NoObGFVJCFbWGwgcX+lDandtZXkhcJq+tpybIb8MefM=;
 b=jSp6XH/IABy87Ap7smGoDAx0f01QhgOS0yxx8zxoOTU5MPnthksqkyVX
 B/sGlSlDpNh/Y8NHFsr+XCGPsucH0wvfltzDfkieMcQmOvBZdK0BZGHSU
 NIfQQWbuvohFo6aZR8XSXb5Asq8Rt4kNxX6h28lnehft0zGbcmu01a+BL
 iNLPIgy0OZUQLErODFm39ZUkIUYAwQ21C47R/4LRU09nbui7NKJo3bh9u
 Uu93FM327ZS2/gsC748Se9+P0z6UmfZtvMT5R0z+nWZc8+xMeHkTPngcE
 l+LTnqb/CqfnnJDANtdPbbQFlb0KEPC+ntAAJh8ucyH0nzUnNOFJyBq9B g==;
X-CSE-ConnectionGUID: RcZdBPzuT/a43yHBdOSXAw==
X-CSE-MsgGUID: XfIj5vYORqKeeg57DdtTrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232059"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="108232059"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:24 -0700
X-CSE-ConnectionGUID: Hb3pwMZDQJi8+PWKmsve/A==
X-CSE-MsgGUID: n9BgxPM5RfKJT0uaWY0v4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="281315344"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:25 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Sep 2026 11:02:46 -0700
Subject: [PATCH iwl-net v2 13/15] ice: skip reading Tx ready bitmap on
 ports with no timestamps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-13-e55b692d0e6b@intel.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=2422;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=NoObGFVJCFbWGwgcX+lDandtZXkhcJq+tpybIb8MefM=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNh2U5MyZonpr1LlJ7ecwqjr0Oqxh5lxlcaVXc7TiDf
 9NO/uTKjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACZy8xfDP/VP/by8jgVN+ypa
 /X67POiaXuLc0ujdeE8kdJd75i73SEaGzctq9H6ffBPZGae3eIb032lyr0JUAx73JnG4XSlU4u3
 iAAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
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

On E82x devices, the interrupt for Tx timestamps are handled by the clock
owner. When an interrupt with the Tx timestamp cause is fired, the clock
owner PF iterates the list of ports and checks for timestamps across all
ports.

The existing logic reads the PHY timestamp ready bitmap before iterating
the list of in-use timestamp indexes, even for ports which have no
timestamps waiting in the software timestamp tracker. This has a
significant and measurable latency impact on reporting Tx timestamps.

Check the bitmap and exit early in the event that there are no timestamps
waiting on a port. Observant reviewers may notice that the check is done
without acquiring the lock. This is fine, as the only thread that can clear
in_use bits is the miscellaneous interrupt handler. Whether the thread sees
or fails to see a new outstanding timestamp does not affect correctness,
only determining whether or not it should do extra work.

The average latency of a Tx timestamp is impacted by several factors
including system load, the number of timestamp requests, and some random
factors that are difficult to control. However for comparison on my system
with these changes, while operating ptp4l on a single port with a sync rate
of 16/second:

  Before: mean 317.43 microseconds, standard deviation 34.51
  After: mean 189.71 microseconds, standard deviation 43.24

Of course this level of improvement may not be indicative of a production
setup as one might expect timestamps to be operating out of multiple ports
on the device. However, even in that case an improvement is still likely
depending on the actual timestamp rates.

Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 06f383415d07..890c2e8d4ece 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -574,7 +574,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	pf = ptp_port_to_pf(ptp_port);
 	hw = &pf->hw;
 
-	if (!tx->init)
+	if (!tx->init || bitmap_empty(tx->in_use, tx->len))
 		return;
 
 	/* Read the Tx ready status first */

-- 
2.56.0.rc0.395.gd1f3524e15dc

