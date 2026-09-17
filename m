Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE01C982D7
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 16:07:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F547608A8;
	Thu, 17 Sep 2026 16:07:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mpNwiUPKct7v; Thu, 17 Sep 2026 16:07:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 91829608B3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789661231;
	b=Lnjs5kjrLjLGGIEiYTE5yUOPULcK+16k9FXbwMmyOd50PEyJvgttOWXUSfQp+WuuwwZu
	 hXsY6gzQUMn0ZSnG5QCgCoiZu2Nkbou9+9aOJOt1Wj38Y14tyzP2qfePIOy4N2fVT1pbs
	 Hy6WiMxSm/04BD/mfjk7vo5ISaq5PjQRSXTGhAGnEfouPe1Sbj9j1/sMcmwq5tpIn4A3P
	 YhUeERGaa43vqXYTH4uiFZTjjifhWP7oU1fCpbkx0Ffn0Wg3rSnW+H8UiKqdwINQq3cyi
	 H+iC8HEGjts4uBqvnvdHYD0oJl9LnBIdH4Fv5K4m0g4DomLplnBi5+bHRfI/lkB6hog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789661231;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JeUTZ5Xfmu3CX5ZC/fWVdot1MmSWPUPNS4TQoJ0nO2A=;
	b=RCuKiQv9e19Vq8eM4Ak6GptQG23N7q0PdbBXnzWtcTesvvJ0yYEoLCn8RCY5XlWu8MkE
	 VxtlHXVjpZ+oDvzkiF6PHS+TZceqBqknmNyAepa1eUfamdTbtdrMyxOjAazZ4whIVrc+i
	 Kq9HuupfFgQbkRaqK9sQY/oMD364Ct2/8OvgSDhNceaKvNbL3KBnXJCPF+ked6sKqbP7/
	 QRSVZ8MFVvwS2qGdiJPJ6iWzdUFtFVl4Hfs2lCkdDWj1GFcrPr1hkLMLdnqPba21E6gD+
	 WBEUhi37iVvnDJ+vCvn/6VFKTmnYZGLFkqI+0OqZQmZCL4+rGhS/octJZX9wdXvv2zw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789661231;
	bh=JeUTZ5Xfmu3CX5ZC/fWVdot1MmSWPUPNS4TQoJ0nO2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1LEPMOlqNTGShFXKPjWp/jmvWYumXNZBZ9kJMsJikzcm4j4wOiwAHqwFW+vXIvhAj
	 jD32ovWd3qoJmAIitVKkcwyyaU1w0U+JpAX1+BpMU4nc1diPwxPFWqG94kJNcWW8Wk
	 chY9DUwlu56JOqnME/LhKDKdHd19PqXPUYzS4Zf9rBiL99ghOI5aiubqWJxcGkrNPj
	 HA0pFDo83094VSsebtZu5Kv1hcBzuXQhiIjjhPPz6Bahnby+tFff0ditr/RVuIPusY
	 VbZUcUa4cYvEr5RmoV+f8oks5lWNskpH0JDk4ugF7Y9z+7xtO032pwQ6A/OslN41C/
	 dDwn7sP1AHUIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91829608B3;
	Thu, 17 Sep 2026 16:07:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 87A0E42D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 10:52:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7977A402BB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 10:52:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T0BEkfkKbHAm for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 10:52:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C33DE40750
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789642338;
 b=phkz9k1fPPq1JbOJJt21eg3iDCb2s/4nVlBw2XUpn6My2fxBAa5m1kL1PSEhgHNNGxtH
 9n6EdQPQTtbZ6bsnwMDNwWOTpEI8O2joY84LSnQunWr6tFUrMOo1Hp77SmBK/fg2qkxEK
 eynxPkFMRNALT8a61q9H3t+hdkyZmaBAqQU9YiMvpoUusNxr6bHf/+ECGX98ivXDIWQCm
 h0xb/AQ5A4Ib+0+/P/p+JWj3Ss6QnH0H9A6KwGJ7SoKWvH2NvMa8uy1UyzP/aSEKhZAX/
 NxyoKH3JeqsZf82TZmGOEQqOXTPEwjeIVX7bPjnnfUumtS5jURuA4JrOsfyRplMICJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789642338;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=JeUTZ5Xfmu3CX5ZC/fWVdot1MmSWPUPNS4TQoJ0nO2A=;
 b=XR7n8D9oDFzEmgnNaRlod/gqiofWlxD3qJ/JtvsB56HkWrIPgDhp2o+lXAmZrV7wD0cK
 Geez6jC4vHolXqv+uMPXuKSmLC10sHjNqOkoUDjGoUR+RvtiTefZtIQFSsig1lioFTEis
 zlSqhwYLX/jgPLzRqsFo9POyjDUKWoxYQGtx1pKb1U3pBJ9Sf1q6WTWZ19BwlSANPo7nj
 cWM8pP9JMI7jszHrIr4vWfzG9kQsz0IoOVNIvE6kL2bZ5yGg7ig64hNKZKkk4BslXpwnv
 FYBScNC5ufBsHFIyJjCu/2eqNILydfIyeuiJH9oqTtgUCZ65zAYt5GfmYIVcQnVGExQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DnsxnCO0; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com;
 envelope-from=luckilystar08@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=DnsxnCO0
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com
 [IPv6:2607:f8b0:4864:39::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C33DE40750
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 10:52:17 +0000 (UTC)
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d747ee1f9bso6074755ad.3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 03:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789642337; x=1790247137; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JeUTZ5Xfmu3CX5ZC/fWVdot1MmSWPUPNS4TQoJ0nO2A=;
 b=DnsxnCO0YQAf6ZKCegfgFnu/DGIlV43jau6md6fLJGv20pYwebCUc16n4OemczWqTI
 JFozNiVItcxYuI9gc0NHW9x8dv+tAYqG0OFGQfr1H8l2vCk9StzOwZtfv94W7TOCgytd
 WFy87lsspYaPmbh4NrMYKbG+i+Tv3IUnAP9CC2kMKUCs9KIacuHMbgvNkYIt5p9EiNyi
 WcJ14xUjX54+QnRCC10kVJAGgpVOKvXYH3KikzJjYE2iunGIJpIufVYwAld9qJS41kTD
 YsFLXZ/pMxQPIOZYfJHPMkDe04M56/PUp0JLeeHj3pg3puBoD/tezfYeNNft+nQ4v8+0
 sDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789642337; x=1790247137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JeUTZ5Xfmu3CX5ZC/fWVdot1MmSWPUPNS4TQoJ0nO2A=;
 b=P5rqYaX5t69ziYlxnLIwWzru9WYDRU1J+V/D5TAzj5OGceuaBFULt+MFm82mJ7UW+y
 S3lahNNGmf8Y2Jwc46GOeglNxmi+M9KBidzCB4U1JKJHFZJgTlcGwjRvBgTyHkpAQo8O
 +qLstByIwyfAhT6zvYjblyCmr36yrGsvx/R+/+C0TqCo3ztoXao13bRS0TlnEv3gAAlU
 P+Rp1PMiYPi3X4NzoDrlY8YGD1P0B7cosN16riPcOIqOwiBdnJizLH4UpPXfgxFUBcQB
 fPT9m7b1HNHOoh3U4Kpf2EPrWM3jUTunfWi6DnN803gH3Orw4kEdJPDoQJ8g5nQvqYIk
 LrdA==
X-Gm-Message-State: AFuF++lr3knOr8x3SzbNFgGUjuo/BiY3sft2CExasle9H6bXLiD4PKTO
 aR0h30qx1XHldFJBxWugmND0yTjWJsU9xg+O75dC0BNmvQJqAf7rKh8doXgEOsjk
X-Gm-Gg: AYBFou3T+NAxc0x6yjtkSi5CzqSes3JqOVEClRPbBlviv9ptMMk+ubppfdUfUfjBun+
 jKW1ktfO3pQlmEZBkDwQ0BLp5qNLtyo/1fhHKgHWD0eWg/i4ehCTb4p+koe4frgv/Rg9pXtIv5U
 XNF0qOKYXdLGmrwjLv0OZjssrPzNYFZ9VfgHn1xNWmbJO5Q30yiVyJTtAYADccb953Pnowjbog2
 uTv2NizlIYHPTzp8GZwz9i3IWHd83Jpk35tr1fKm6t518LWp7xT4C8k4YjbKLdcb3o5rXFUokBN
 l1Trp4LKKdyU6ON0nKwWX4kRaRBVgl7nQD8aFs0xO+dKEvyNXCRPTVLDPP3I3pJoYkmd/ICmO94
 XqbTHifq5BXbOJkRSIBvw01Qe46zJGmcPku4rB8jes36woKnrXduBbzF3UFRSVnL9XVl5urwTFL
 gUWc+p4nG/4Yvz2QX0dAmzGp+CBc1COc+d9k54qkqqW08yJ/2PcMDrKKMO2tximApC/HdToTvRA
 aYhFnq5RJWlEWOUdix16RJJJl3wNB6XX+HQU5XcjkvJFaLNWll7C4iw26HuThMXhFAgyjkISA73
 460=
X-Received: by 2002:a17:90b:3c41:b0:39d:fe64:5733 with SMTP id
 98e67ed59e1d1-39e1e5612demr22035813a91.24.1789642337227; 
 Thu, 17 Sep 2026 03:52:17 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net
 (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e361b8e1asm4486019a91.12.2026.09.17.03.52.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Sep 2026 03:52:15 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
 emil.s.tantilov@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net 1/2] idpf: keep the mailbox up while tearing down
 vports on shutdown
Date: Thu, 17 Sep 2026 18:52:04 +0800
Message-ID: <20260917105205.37561-2-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260917105205.37561-1-luckilystar08@gmail.com>
References: <20260917105205.37561-1-luckilystar08@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 16:07:09 +0000
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

From: Tian Xun Ng <tianxun.ng@bytedance.com>

Since commit 4c9106f4906a ("idpf: fix adapter NULL pointer dereference
on reboot"), idpf_shutdown() calls idpf_vc_core_deinit() directly instead
of idpf_remove(), so IDPF_REMOVE_IN_PROG is not set on shutdown.
idpf_vc_core_deinit() uses that flag to decide when to shut the virtchnl
transaction manager down. Without it, libie_ctlq_xn_shutdown() runs
before idpf_deinit_task() tears the vports down, so every message sent
during that teardown (disable vport, disable queues, destroy vport)
fails at once. The device is never told to stop its queues and keeps
them enabled, with the ring addresses of the kernel that is going away.

After a warm reboot, the first queue reconfiguration of a port that has
not been opened yet (udev setting the MTU) sends VIRTCHNL2_OP_DEL_QUEUES.
The device then drains the queues it still considers live and writes
SW_MARKER TX completions (qid_comptype_gen 0x2800 / 0xa800) to the
previous kernel's completion rings. With the IOMMU translating, those
writes fault on every such boot:

  arm-smmu-v3 arm-smmu-v3.17.auto: event: F_TRANSLATION client: 0016:01:00.0 sid: 0x30100 ssid: 0x0 iova: 0xffb70000 ipa: 0x0
  arm-smmu-v3 arm-smmu-v3.17.auto: unpriv data write s1 "Input address caused fault" stag: 0x0

In IOMMU pass-through mode they land on pages the new kernel has already
reused. With page_poison=1 that shows as "pagealloc: memory corruption"
on most boots. Without it, nodes crash in unrelated code, e.g.:

  Unable to handle kernel NULL pointer dereference at virtual address 000000000000a830
  pc : __tlb_remove_table_free+0x48/0x118
  Call trace:
   __tlb_remove_table_free
   tlb_remove_table_rcu
   rcu_do_batch

or with a slab free pointer that decodes from a slot holding 0x2800:

  Unable to handle kernel paging request at virtual address 002613b73e862c6e
  pc : kmem_cache_alloc_noprof+0xc0/0x3d0

The early shutdown exists to avoid waiting for transaction timeouts when
the mailbox is already gone. That is the hard reset case, where
idpf_vc_event_task() shuts the transaction manager down and sets
IDPF_HR_RESET_IN_PROG before idpf_init_hard_reset() calls
idpf_vc_core_deinit(). Key the early shutdown on a hard reset being in
progress or detected instead of on remove, so that both remove and
shutdown keep the mailbox up until the vports are gone.

Hard reset behaviour is unchanged. Remove is unchanged unless a hardware
reset has been detected, in which case it no longer waits for message
timeouts. Shutdown now delivers the teardown messages; if the device
stops responding without a detectable reset, shutdown can wait for the
transaction timeouts, as remove already does.

Tested on arm64 (64K pages) servers with two idpf functions, with this
change and the next patch backported to a 6.17 kernel: no stray device
writes in 151 warm reboots across IOMMU translated and pass-through
modes, against stray writes after 20 of 20 warm reboots without them.

Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reboot")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
---
 .../net/ethernet/intel/idpf/idpf_virtchnl.c    | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 1caf52706..646b6e074 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3197,14 +3197,22 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
  */
 void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 {
-	bool remove_in_prog;
+	bool reset_in_prog;
 
 	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
 		return;
 
-	/* Avoid transaction timeouts when called during reset */
-	remove_in_prog = test_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
-	if (!remove_in_prog)
+	/* Shut the transaction manager down early only when the mailbox is
+	 * already gone, i.e. a hard reset is in progress or has been detected,
+	 * to avoid waiting for transaction timeouts. On remove and on shutdown
+	 * the mailbox still works and must stay up until the vports are torn
+	 * down. Otherwise the disable and destroy messages never reach the
+	 * device, which keeps its queues enabled with ring addresses from this
+	 * kernel after a warm reboot.
+	 */
+	reset_in_prog = test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags) ||
+			idpf_is_reset_detected(adapter);
+	if (reset_in_prog)
 		libie_ctlq_xn_shutdown(adapter->xnm);
 
 	idpf_ptp_release(adapter);
@@ -3213,7 +3221,7 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 	idpf_rel_rx_pt_lkup(adapter);
 	idpf_intr_rel(adapter);
 
-	if (remove_in_prog)
+	if (!reset_in_prog)
 		libie_ctlq_xn_shutdown(adapter->xnm);
 
 	cancel_delayed_work_sync(&adapter->serv_task);
-- 
2.50.1 (Apple Git-155)

