Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F37CC6B3A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Oct 2026 15:55:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAF3F608C9;
	Thu, 15 Oct 2026 15:55:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D3urdF1W_IqN; Thu, 15 Oct 2026 15:55:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E487B608D6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792079710;
	b=sGQepq3gtPEgNvFmbMPUgXjumVRDbH/8bIhbEyTueWJh3wROevOWe6tdStBpqkpMKwxP
	 q5OUMBGoUmAA+ACNNHe+ve1J5eYS9Jyuol8yScrWTKAfq6Nm30RbqwZk+Y65CCtMA8FxD
	 txVouAkyV64J4Suatbf3lOfEskPSJ42FvbfyCVrd13SFPMAExzWbvxWQR+YFfgIvFNQ3P
	 VsvbzwaJ8/hbtLkQWCFQvKL0f0v9Sc2LqhhcU2Lun+Ggi3NHFYkEoIXUJqrSGEVacipP1
	 N2amXhiaWRQG+GypKXrfV8vlXxDqmvRo2VdMc94GHTJMLHehAhy9CP3iSrwdmsCLpzw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792079710;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=s18ZSAeaTj3uFCQOPUAhE8p5i1eeNicCpcv0Dn1C87s=;
	b=G+Be/yJhvpfEGJuwORIIymgErd0GYzwitrK+SSaMAscTrLP3s/nuZ1QNxcxROw1zWb0j
	 0u5Dd/nVmwkhtYDboKflXS3YG5x5xG+HmpZiM18AdXNiGgRRaFow2IlJXfxtfMfioZwos
	 Ttvp0sInRkBBqdPKGOtZCYFL2HGT2COdQ3IxSFrlJz4gEUhmWpxmzhll+mH42d2cI7TfE
	 qX3qr8srdUqKvOflc9zFFmd0L6IrMulbdO5SjsiAlS943tpnjOfgeLC10knQjOSZfayUg
	 Vn+Fyq2qwMf83sC1EhrWxLnxyITPHU5Xz/We4/GvXsfnqwbGuRwV3AmYwPmQS4/4OtA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792079709;
	bh=s18ZSAeaTj3uFCQOPUAhE8p5i1eeNicCpcv0Dn1C87s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ur6ggpNkRRfFO7SJUclD8RhGTDYc19DeF/6Z9rMGYW/5Cry8scz/S/5k7i2LsP6iz
	 yMvZfgNgrhdhx2UrM99ORV6Lyl7kslPV/1pqitGJZz9myYjnzNdSEDtWVmx5kgz1zg
	 oh1mjbVgBft6Skw1jRM8OVbZapGZONF7qo8rZR1Gn38rvJmnChIRn1okOu+vpbcQ32
	 sjvho8Nzkk2oHsqbRbjxtm+ICjyxt/oTJBg7jMCtAAZxhIx3+hSZMls5Kc7J9+UhNE
	 eiQ3Q/LRaAbcCwgrQn4K228QXrkVAeuDS11TM57cl8HEn2ArIA//TvpNK3v0wlaVqh
	 vnPjZQ8PxmZPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E487B608D6;
	Thu, 15 Oct 2026 15:55:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C6A5769
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 07:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1241B407E7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 07:45:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OZcCZU_hksM2 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Oct 2026 07:45:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 428D0407DA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792050311;
 b=kdImtnBPWCICSnMfs1Of5DnTsb/f85lmzn8AnBLIIJMm4n++1N9YP6H5x9d7f4Gmpfpv
 6elRpbkN7SHOUDpGKD8z7geyAQGZG/mIdZaZDYC81R7U2hBkDGkye/pXrpdTgwPqrjdMT
 /sRFXrNTkmxonmcfQ3a2EghJ2HMPsHTQkuUJNbhWd2hVhcgAGQtIax5rCld1gmC5dTZZ1
 yxRRvz4E1+ZTYmnO48iX15+XNhKpsEWkrlN8xxarnJB1dbX1s6TZf76lNnC3pcPP6xOoj
 8ccdILqaweXVa5BNIBZHb4Yrn2LQ9CbqjCBuHoLT22dI+0Qze5QAhsdHW/l2ow/4kDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792050311;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=s18ZSAeaTj3uFCQOPUAhE8p5i1eeNicCpcv0Dn1C87s=;
 b=D+h3aKSyw9Q6y3MZXTSMwcpp4GdXnVYKBrQysyG8D/NPDLRRXYTVZMA99BjZxpME8n3U
 DDYnOS1THAgW7ua6/8e3fU/o9xIEtunREpuYrCcHvLpI93E0Q00tu23ZQd0E84j6q5Rwt
 UDNYNhEIcd1cFwDPMaYJN08NUNrYO+zrrC0D8us5E2t20thmUK+ZTuXOytUp2ku9PPj0f
 wG416S+q89ZTFMKNTnW9B4LCtGOSP4MJVskpcLshIbQhEEsxSDv9IPwPwh/+xju/HNg7e
 0kdqf1HjUXnKpHXEBCzOSWbC+jM6X4aG3VLuIw56fs9/1qyL0Fku36K+9A4D876Dg6Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nebusec.ai;
 dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256
 header.s=google header.b=dQRwOo8J; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com;
 envelope-from=zihanx@nebusec.ai; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=nebusec.ai
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256
 header.s=google header.b=dQRwOo8J
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 428D0407DA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 07:45:10 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-ccce6d9abfeso2830039a12.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 00:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nebusec.ai; s=google; t=1792050310; x=1792655110; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s18ZSAeaTj3uFCQOPUAhE8p5i1eeNicCpcv0Dn1C87s=;
 b=dQRwOo8JKl6ZVHBDQXJV14gLhKnjmed6E69/l36qUIQoK6MP2LLH4i4H83OGw7NBP5
 Xdok0FK9ATHXLL85MI1Fe9x0p1kEAyMN3nFothRc+H9E2LGHVphsxyDPf/prDBkLCcUN
 x0hOkivVE0F9nXP5AX+HOVkTW6WInM2sPXIYozfQdINg+5RvmDBfWLqBVyRHKM4Ynu0v
 3r1tiw7FqkVN4Lyao4oL2VeAEN/soEer2EB95LzpI/MT4qMh7TFThTMpBjsqdrTuNH2m
 pDw5iJfqFMCS8DBuoMdwDPypwgEBVQR7if8oViAjNok1WpzGWJ5Gso8zR8unlL+LVqsD
 1abA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792050310; x=1792655110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=s18ZSAeaTj3uFCQOPUAhE8p5i1eeNicCpcv0Dn1C87s=;
 b=IsOz49BvyKtsJScrNCqLfyapwxS+diWPa3YsOYk/Qgu1d0QD74hLQ3Jwi5V/v13xvH
 nAw/Oq7XvzXxcfopvC8gPKA4PlC8Di3N1QAQDD/qmEV/KPcqQfXLxin4+TWMz09Zk8j8
 c+uzFvx89kguwkc2pdBhnL7UYmFzEqUt1NA7yB4/FZzhCwNdrYqnV0l3BQnIBDkbSKjC
 rb2DxWn4Vn1c3G/jFUK5UWyFgXr/GnQZaHSCCOnKZD355wvGzx6KRhQBkR9oyrfCHPiu
 cHvPkwIuauYltO46fI9ZoS43d+P6rzjkXtMlCTYLhKWaM2zwCSZmGYyD/D1/OJM79Yp3
 YFwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBmnhKxz/U9sXN881nXR91Orip44sFSFha+5IReKAyo2jDfHHvFv+O7U0ELCJMJraj0wnvhTB/ysSQpZs602I=@lists.osuosl.org
X-Gm-Message-State: AFq9FYJo4Sdb1I7DGKdFZd5oERrqnBXiDdyNohhox8hk/bWVvicKW2ia
 soNiNS8b5Il5Lel+w/9RzEVaUpEaotR8xOGrNEeNWrqQ3AYCnqUA476BBQjRLfij1Qdd
X-Gm-Gg: AYBFou2uDaMjaAUFeGM0Iyu6iZWwO1FeTITgqhRcijLcNv30SGs1J1RK/B7RllFTPm1
 Dt7NYps9FYtVHMcgwso6yuLn2P70eCOs0ZyxIDMu9kguwK4o4C3mD4s7OS+vG0eJnpomV8il0H5
 3e2btUAYpZatwggggWig5r8slqXU/iYDfRc+lfxoXUCAWsy2b3f3FMJsHcg8vb1YsBo7QFGjmTE
 B8im488SsiybMQBXd5wP9wUmvK1emGGwdys0u09k4FGhucsg55a2fQf9oCG5Zn9aD1++XjU3iDA
 W4l0g3p2JCRY1HDMgq5Cc/t9tCb9JNyrG/z6B84eAWotYfI4vM1XRTzzVcQ88wBRINGrFIa1ltZ
 3npbEtXRtCAXZhqIObX559jb11GOZYmv/47T9jXnzUf7fYta/WN/LmkLhHYQL6k0cdYWG4YO2YH
 03A05ZIfulPpQQpJSPsa/62bZ3fQqtrdEgx0Cqg0tFtybTdPX8M/GOP0jr8VLl7weK7IU4k0s8u
 k/4SIkdF1veYl8asguBUkBK7cpMMA==
X-Received: by 2002:a17:90b:4d85:b0:3a4:c946:9f4e with SMTP id
 98e67ed59e1d1-3ab3acdc386mr14478029a91.58.1792050309820; 
 Thu, 15 Oct 2026 00:45:09 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac93849da5sm1636831a91.4.2026.10.15.00.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 00:45:08 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netfilter-devel@vger.kernel.org, virtualization@lists.linux.dev,
 intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org
Cc: pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, kaber@trash.net,
 jengelh@medozas.de, andrew+netdev@lunn.ch, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 aleksander.lobakin@intel.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 willemb@google.com, alice.kernel@fastmail.im, eilaimemedsnaimel@gmail.com,
 imv4bel@gmail.com, shiming.cheng@mediatek.com, sd@queasysnail.net,
 vega@nebusec.ai, root@tr0jan.top, zihanx@nebusec.ai
Subject: [PATCH nf v8 1/3] netfilter: nf_dup: preserve guard across NFQUEUE
 reinjection
Date: Thu, 15 Oct 2026 07:43:07 +0000
Message-ID: <1eca65f844ea4eaefa9ea4a852f1db27aacc10b9.1792048855.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1792048855.git.zihanx@nebusec.ai>
References: <cover.1792048855.git.zihanx@nebusec.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 15 Oct 2026 15:55:07 +0000
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

NFQUEUE can suspend traversal of a duplicated packet while the task-local
duplication guard is set. The output call then returns and clears the guard
before a later verdict resumes hook traversal.

Save the guard in the queue entry and restore it while reinjection continues
hook traversal. Preserve and restore the verdict task's prior state, including
nested synchronous reinjection.

Fixes: cd58bcd9787e ("netfilter: xt_TEE: have cloned packet travel through Xtables too")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 include/net/netfilter/nf_queue.h |  1 +
 net/netfilter/nf_queue.c         |  1 +
 net/netfilter/nfnetlink_queue.c  | 15 ++++++++++++---
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_queue.h
index fc3e81c07364..039622d48905 100644
--- a/include/net/netfilter/nf_queue.h
+++ b/include/net/netfilter/nf_queue.h
@@ -23,6 +23,7 @@ struct nf_queue_entry {
 	struct net_device	*physout;
 #endif
 	struct nf_hook_state	state;
+	bool			in_nf_duplicate;
 	bool			nf_ct_is_unconfirmed;
 	u16			size; /* sizeof(entry) + saved route keys */
 
diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index 73363ceedebe..44f182eba953 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -219,6 +219,7 @@ static int __nf_queue(struct sk_buff *skb, const struct nf_hook_state *state,
 	*entry = (struct nf_queue_entry) {
 		.skb	= skb,
 		.skb_dev = skb->dev,
+		.in_nf_duplicate = current->in_nf_duplicate,
 		.state	= *state,
 		.hook_index = index,
 		.size	= sizeof(*entry) + route_key_size,
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index a3bc00280051..9a8f55498fd5 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -43,6 +43,7 @@
 #include <net/sock.h>
 #include <net/tcp_states.h>
 #include <net/netfilter/nf_queue.h>
+#include <net/net_debug.h>
 #include <net/netns/generic.h>
 
 #include <linux/atomic.h>
@@ -368,17 +369,24 @@ static void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 	unsigned int i;
 	int err;
 	u8 pf;
+	bool old_in_nf_duplicate;
+
+	DEBUG_NET_WARN_ONCE(current->in_nf_duplicate,
+			    "%s called with duplication guard set", __func__);
+	local_bh_disable();
+	old_in_nf_duplicate = current->in_nf_duplicate;
 
 	net = entry->state.net;
 	pf = entry->state.pf;
 
+	current->in_nf_duplicate = entry->in_nf_duplicate;
 	hooks = nf_hook_entries_head(net, pf, entry->state.hook);
 
 	i = entry->hook_index;
 	if (!hooks || i >= hooks->num_hook_entries) {
 		kfree_skb_reason(skb, SKB_DROP_REASON_NETFILTER_DROP);
 		nf_queue_entry_free(entry);
-		return;
+		goto out;
 	}
 
 	hook_entry = &hooks->hooks[i];
@@ -401,9 +409,7 @@ static void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 	switch (verdict & NF_VERDICT_MASK) {
 	case NF_ACCEPT:
 	case NF_STOP:
-		local_bh_disable();
 		entry->state.okfn(entry->state.net, entry->state.sk, skb);
-		local_bh_enable();
 		break;
 	case NF_QUEUE:
 		err = nf_queue(skb, &entry->state, i, verdict);
@@ -417,6 +423,9 @@ static void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 	}
 
 	nf_queue_entry_free(entry);
+out:
+	current->in_nf_duplicate = old_in_nf_duplicate;
+	local_bh_enable();
 }
 
 /* return true if the entry has an unconfirmed conntrack attached that isn't owned by us
-- 
2.43.0

