Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3877C54791
	for <intel-wired-lan@archiver.kernel.org>; Wed, 13 Mar 2024 13:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D7B6403B8;
	Wed, 13 Mar 2024 13:03:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ktb92a1YPu8a; Wed, 13 Mar 2024 13:03:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7EFCF4079B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1710334998;
	bh=5JMrvmDVNALmWdwq0fCgL0UHXuNvWW+anwgA6EwkPqc=;
	h=From:Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=vmZyH5rGP4fjC9tfpBbUfB7wxwxNDCSv/scDOIc6yimx5jd5/qZrxf15CbBcbNBaW
	 h2wAsNXLg6970Vytvi7rVmNcsbnQiumn3dLyjq632/b9xy+uRO+0VScXNzmGUIf0R9
	 tHpzlDbaVDgxuplzYr2+hFFOKFn//nvSD+O9b5dQMtkLofesA5sEkyRhkQPeit8t0/
	 LyL5Tqu0Zue2Wr9NHg7/Ml3y6xFsksMzchcXXReNmwERTBvvmi119sxl/zEHUKaSJT
	 MsTaItfbx826bzGfQoKEGPqdzmTphK3+lzX3JjTnfYfyAz681wWYcZL2zYEmv76eKU
	 h4RGE4vzWNrFg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7EFCF4079B;
	Wed, 13 Mar 2024 13:03:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 6355F1BF4E7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 13 Mar 2024 13:03:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B11840B00
 for <intel-wired-lan@lists.osuosl.org>; Wed, 13 Mar 2024 13:03:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rKO_vVmliKxV for <intel-wired-lan@lists.osuosl.org>;
 Wed, 13 Mar 2024 13:03:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=kurt@linutronix.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 692C3400C4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 692C3400C4
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 692C3400C4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 13 Mar 2024 13:03:16 +0000 (UTC)
From: Kurt Kanzenbach <kurt@linutronix.de>
Date: Wed, 13 Mar 2024 14:03:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240313-igc_txts_comment-v1-1-4e8438739323@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAA2k8WUC/x2N0QqDMAwAf0XyvICtY3T7lTGkjVEDax1NcYL47
 6t7PI7jdlDOwgqPZofMq6gsqYK5NECzTxOjDJXBtvbadqZDmagvW9Gelhg5FXTmZu/DSC44DzU
 LXhlD9onmM4xeC+dTfDKPsv1fT5DvGxMXeB3HD8lXVSWEAAAA
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1346; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=GrNnKDgkIMZeLbHmwfq5U1uNGlGFk+4T0DFZQ8Vk9go=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBl8aQQArPq6T4wA6zJH+1VgFG4zSS7YIU5yt0r7
 /BPCQNQtQ6JAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZfGkEAAKCRDBk9HyqkZz
 gnATD/4qjnv7e0lk7C4Hw4IY/ikKKbBjy3+2DJAeM3HV1l/WwqZP/0+ZcxKj1chuI5JKcoP2YMw
 w9vP637Aw3UGbN+2gUpSQGBhP+++NwG20YhASVfZsOMrSuNh0Rjb7exwtrUkUWSUYJaUq9lxH1d
 2P78YoL1qbhMLv3lZJl6sNKo571H0nMhb0rPS5239Aw+h9vmccFQPxviiBa6wCn+QpLQkSVRcd0
 3IygfA03DFdH83MnwmjAVlXRja+N/UVXLWuEN6vZgV26C2GHkjwtcY3gjQjcmV+tYLRX1rNE4BO
 8QsO0/zxn/eVVGRThaqFsE0KNXYTTvnKTqLf8lYg/UbjgLTdLoisoDml12yAYkGXFRpg/Cg/ms1
 948aMlgvtINJAPel7L8pRlIiJQWLT7qqt+ydwSa7HS1juP4exhnFb8hOaDOZ2gaZXxRodEQA4KI
 8JAH5sJpUYN8BjN4jXSKLzfMgSrlM2HJ7OsJKR7BrxX4DcgviwcseHgoNcGl35akQX/Uh2yy0rh
 6NL6z+U8vONlSpc4qHJQLerqxWKlq84+Gw3ju8hCbMatfSRcXqJsZRBWlfrMMXEu+JwhEONPcCH
 3w/SneL9lCk0eY7DSgB0hy8zORHUTpKSo/0umhrPkndzYULZyKxRGmca6beKvBZIM9pDntjeRiL
 JrLa2JATiNUmzvg==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1710334993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5JMrvmDVNALmWdwq0fCgL0UHXuNvWW+anwgA6EwkPqc=;
 b=RV2gzj+dCW8xw37tVDj2YSLi7Nv90UaTOWCY3JB+vr3nHyhdrpfasjXbp+aKcrO1OPjdXE
 Qpvuvzx1zpa7Fs1mNCpJOlOuQAbcPQ2oWUA3XxcTzWShKZN6iIv4mglzhWiCsvKvoWs02/
 Ni55KS6MczGaD4W4wz2qt5Kftx42ezWpFPbldcBUnVxzl0siz5vT662vWY1SyTxzmoak5P
 AY01XxtWnwiwY3/Xb1dDdvyB1jtYlyy65yF9zECSi3Bta5EqBBbyoGTAvqWGVp1madLR2A
 NNcHyc80IBEuonaVoZWzhOdcnRBWvknsJah8Jkc0FmHSlBmrLYnPISeLrBFUSg==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1710334993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5JMrvmDVNALmWdwq0fCgL0UHXuNvWW+anwgA6EwkPqc=;
 b=6NgVkPPJINeGy0Adfw9i7RnU9OCzxKqZOjWVza8+hMuIsEJrX8DhJxQZv+BC9iFN4eOZix
 TO/v2dl/1OhVvZBA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=RV2gzj+d; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=6NgVkPPJ
Subject: [Intel-wired-lan] [PATCH iwl-net] igc: Remove stale comment about
 Tx timestamping
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: netdev@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Kurt Kanzenbach <kurt@linutronix.de>, intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The initial igc Tx timestamping implementation used only one register for
retrieving Tx timestamps. Commit 3ed247e78911 ("igc: Add support for
multiple in-flight TX timestamps") added support for utilizing all four of
them e.g., for multiple domain support. Remove the stale comment/FIXME.

Fixes: 3ed247e78911 ("igc: Add support for multiple in-flight TX timestamps")
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2e1cfbd82f4f..35ad40a803cb 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1642,10 +1642,6 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 
 	if (unlikely(test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags) &&
 		     skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
-		/* FIXME: add support for retrieving timestamps from
-		 * the other timer registers before skipping the
-		 * timestamping request.
-		 */
 		unsigned long flags;
 		u32 tstamp_flags;
 

---
base-commit: 67072c314f5f0ec12a7a51a19f7156eebb073654
change-id: 20240313-igc_txts_comment-81629dfc8b8a

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>

