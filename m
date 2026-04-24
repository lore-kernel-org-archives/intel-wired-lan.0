Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E4FFDEE5E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 24 Apr 2026 03:16:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD4DB40B8A;
	Fri, 24 Apr 2026 03:16:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XKO5kG68lIhv; Fri, 24 Apr 2026 03:16:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DDB7040B70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777000564;
	bh=SbAAeoe+lCfBByxTKPuDEe/gKzpl0DVHWMIRbJcx2qg=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=GHOuximwYIkOTb6QQhqY+yJBFWDg9UpoaFEUKokVyPIKFMpLUpFOeKOioaQLY4Z4O
	 thyHrsbgOJkIPUnjvsUqaE0fh1q7qTbH/JeUHZRUhT7XXtLeEhjSqRZeEyULUWiH1T
	 Lh4kUl7O3tttsRPTpXD+MaN+020r3ucXZ1hebKRvZDHLAVRH6KUQ1FrJ6HK3US8lut
	 X4IEVVw/CKE5YWHsH7+j3DNEo/iLByVIJN1NhyaHcJNOiAMNgeDCLv/xktn5d9NyKB
	 2w6hJtxqyQkm5p2nkgASLc6HUaVpnFplXq3nAae1esg1pwLoWQzfobez+i8Tk5I8pN
	 LLby39wFZrHzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDB7040B70;
	Fri, 24 Apr 2026 03:16:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CD72D24D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Apr 2026 03:16:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B32AE4076B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Apr 2026 03:16:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 461YgAp5rAY7 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 24 Apr 2026 03:16:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::134a; helo=mail-dy1-x134a.google.com;
 envelope-from=3cedqaqykdzqreebbyweewbu.secydjub-myhut-bqdbyiji.eikeib.ehw@flex--boolli.bounces.google.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0B45340594
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0B45340594
Received: from mail-dy1-x134a.google.com (mail-dy1-x134a.google.com
 [IPv6:2607:f8b0:4864:20::134a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B45340594
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Apr 2026 03:16:02 +0000 (UTC)
Received: by mail-dy1-x134a.google.com with SMTP id
 5a478bee46e88-2bdf75bc88fso9463654eec.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Apr 2026 20:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777000562; x=1777605362;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SbAAeoe+lCfBByxTKPuDEe/gKzpl0DVHWMIRbJcx2qg=;
 b=OMcb5sZKNU1N3tMwZcBh4eqEpu7le5HfinfKI3WpGMfZ+w6QY/p5X5gOtNkCp21jT0
 hy0pA7ppCGyIlG6W1882Z56cpQFzNMKGlmwqFHSM6KRgybtrB8VB1f2jXCgbLUR5x3Kw
 FitxTxhIHh1F9Hs4j92c0CFngoRvW0MUTTxm6EPPtFzuOi8WgcEluBcCKkXaaZR/oK/V
 xuaemgJo8vNLc+g1Fe/t0IYLazQB/c1mptVlWX9dwx1q399zN6AUbuGj1NNldbWO1VVH
 mpdVbcGjK8+blCWdz4Oi6+XioNOkiXX9YetrTqPB8f2nNix1TAO2Vfpy+cHotp2HtHmw
 479Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rYwDrzb6evxvkNGw1Z54Q5DFZgYl1zv9eG8Tx1ENulx5zLYT95Y9KybR0RgGytJqEVoKLHRKWvzKCGHXtkmE=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzxyRvUaodmPqDu5xsvLzSosh/W2v84DMJHcwc4AAcC9UGYkywu
 MGInsTx/TUsZF1g7sZwAbYyZFEZnWf3W0aSSuF7DnK9Si458mAfkbmMpjswsxSCXo14HiaQjQY2
 woooYKQ==
X-Received: from dycog19.prod.google.com
 ([2002:a05:7301:9a93:b0:2dd:53c4:1b43])
 (user=boolli job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:fb94:b0:2c4:61be:1d33
 with SMTP id 5a478bee46e88-2e464eaa230mr15160221eec.6.1777000561536; Thu, 23
 Apr 2026 20:16:01 -0700 (PDT)
Date: Fri, 24 Apr 2026 03:15:45 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260424031545.3777023-1-boolli@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Brian Vazquez <brianvv@google.com>, 
 Li Li <boolli@google.com>, emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777000562; x=1777605362; darn=lists.osuosl.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SbAAeoe+lCfBByxTKPuDEe/gKzpl0DVHWMIRbJcx2qg=;
 b=HQWMn/4+CKFtL9eOGo/STby/r75C2iKt+loCn0R4B/jp7MnB/2EmLLuqHXxmy4fXLN
 Oin3rX/NSbF5vc0CqMbuREoypU+il8lrLg7BlKNyo0mPuvcqAfKMFUH7RdOjvsL0qzWN
 EUdTz4fvZj3eJML8LFHJaTKw89uHlFpSpDMD2qQM0nIRuFjfOmHWCXRISvgL27VArEkh
 wF7OINBz4/nCbiBqqqjzjHAG08YOErEvfa6xcaQjtwwEq8mKp/F0djCNZyCi1v01BvvN
 V/UFYS0+n5K7u+wkSYEK+P2Ky2XXalDwMR9tnp6PImlXb8lm1WypWgcDHBpQhOb+yf2e
 +gwQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=google.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=HQWMn/4+
Subject: [Intel-wired-lan] [PATCH iwl-next] libie: log more info when
 virtchnl fails
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
From: Li Li via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Li Li <boolli@google.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Virtchnl failures can be hard to debug without logs. Logging the details
of virtchnl transactions can be useful for debugging virtchnl-related
issues.

Tested: Built and booted on a test machine.

Signed-off-by: Li Li <boolli@google.com>
---
 drivers/net/ethernet/intel/libie/controlq.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
index ebc05355e39d..7eaa77413621 100644
--- a/drivers/net/ethernet/intel/libie/controlq.c
+++ b/drivers/net/ethernet/intel/libie/controlq.c
@@ -762,6 +762,16 @@ libie_ctlq_xn_process_recv(struct libie_ctlq_xn_recv_params *params,
 	status = ctlq_msg->chnl_retval ? -EFAULT : 0;
 
 	xn = &xnm->ring[xn_index];
+
+	if (ctlq_msg->chnl_retval) {
+		dev_err_ratelimited(
+			params->ctlq->dev,
+			"Non-zero virtchnl ret val (msg op: %u, ret val: %u, msg_cookie: %u, data_len: %u); xn op: %u, id: %u, cookie: %u\n",
+			ctlq_msg->chnl_opcode, ctlq_msg->chnl_retval,
+			msg_cookie, ctlq_msg->data_len, xn->virtchnl_opcode,
+			xn->index, xn->cookie);
+	}
+
 	if (ctlq_msg->chnl_opcode != xn->virtchnl_opcode ||
 	    msg_cookie != xn->cookie)
 		return false;
@@ -1011,6 +1021,11 @@ int libie_ctlq_xn_send(struct libie_ctlq_xn_send_params *params)
 		params->recv_mem = xn->recv_mem;
 		break;
 	default:
+		dev_notice_ratelimited(
+			params->ctlq->dev,
+			"Transaction failed (op %u, xn state: %d, id: %u, cookie: %u, size: %zu)\n",
+			params->chnl_opcode, xn->state, xn->index, xn->cookie,
+			xn->recv_mem.iov_len);
 		ret = -EBADMSG;
 		break;
 	}
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

