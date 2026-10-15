Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A65CCA463
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Oct 2026 15:55:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6572B60857;
	Thu, 15 Oct 2026 15:55:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vWFb8RV95IFX; Thu, 15 Oct 2026 15:55:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CFAD9608D9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792079711;
	b=ARr3ayyk+FZVAiTm3jBCebsmNXideHJsAFRkZyxzaTHEKgl93c/+QSCM0lIF+2ddBQVZ
	 kHswwmRr2/e8T5BxqnLNx/1u9cSg8Mr3Qb738GMC9tlhFXmAmvffeZrlanc5MlwFuQppk
	 CRojZkTd49Y7qRdhhBfT2VBzxEz2Dvfl3SYmq6VsLkX+wkJjv+AOOpn23oP46pddsXiU3
	 /ugUo5L0ufCmZPja7nSJyb2PlSfv6FkhrCgFrHTfZGQnJeu8T4IGl4FiFWwfWiJfJcwk0
	 S6PQjyErQTEkbxu9db77fju9g/7TFP6vDJnJUTidg8rdDlVWF+wgJe9nu+n/QCAVsLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792079711;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tn7PQz7YO2FDXiLMjVOvk9Md6NqVD6EXEzozd8X+sL4=;
	b=jmu6hHiagVtwh6B7DPBDId2CPJ1/xDrXU5yQ6uOib1k8dYFYMmTJOCR3vy4cOX/CDYdm
	 /uACSUAyMu1coZcYx3iAAZyJs2LlebsrDK7hqH7K3kUfYQ8bfRrSICVf3VRVrNE/4ZClH
	 Bs6jN1VW1RDt0edusB17Y9+e1NmvEF4UGDkc8X1ej/HRccuoB+ztwB9hJFGOLnDdHwtdq
	 xWH4llT/Icl/HPXken/xrwdWn65sWP12uw4kl5oQw9ENd+kTzpxOFjJJEDXK8dy66L/5I
	 aMZYhLrT5hZyXFiotLW4oIWWyLV6sfW645WsPupQUPz7Ariu4sbXWdoFlzdy8k96O0A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792079711;
	bh=tn7PQz7YO2FDXiLMjVOvk9Md6NqVD6EXEzozd8X+sL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AD/WSHYv2UpP64h/3TZCMEpTOBPTMOQAvkhvLPCbkIW6WhBvPsU9P4YMAs+qTg7eO
	 YoFoxKNytR6BcE9BGHwJIj5LDXJIt7uPqr7SwCMAxjkz0QhwUUqzxC24mmAlMdH1Jx
	 rG2sJITAQvcvurslMFNAVAzEzYaDe1eRqAD/auq+RsTiP3ckkklp0Ee7R7h3jJGLZN
	 6efgY1HP6bLOrxVY3b3/gCGprSSzIwCXK9VtpCAhyVBFiUT+zcLNqXziDQkBFJYy6J
	 RxzW4DQwuc4tKbcLAXTHTEpKanG6yoZXGVg4s4VlBmQzSw/72b2LhtfnSDJ22GU2hj
	 KRXz8u49FIHNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFAD9608D9;
	Thu, 15 Oct 2026 15:55:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2604D1DE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 07:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0BDEF407E7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 07:45:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4oiH2nlf6xb6 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Oct 2026 07:45:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7645C407DA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792050331;
 b=G1sCwufFyI226L2pM8239muzVsFbMatu0BolBMR1X5/ITAh0F7G5Pgp8UGoBp4hGTnvz
 HDtxyceDjavlJ/kAhzRhWRYZW0cfKyye3NZSOWwxcF9VtfM3n7QWIkn+Z0477k2L9GT4i
 3lSMRcd8GW452kb2zIIb4h5Hy2CH3Ba0Q+E1ytcFYG/akCYZJznweh6iwnEvlUAGhwXlu
 kkDlYSgw07gfxPn8wcIT7ggkpo0ihOAQ2qu4dGl/P271LPGRf83xgix+SMAYtllMnQVCp
 8Pm4jovQbOs3YWlFOozw+9EJBXSjURZ2mPcKvoL02LgCthhg22m+Ecbur60+UpAv7vg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792050331;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=tn7PQz7YO2FDXiLMjVOvk9Md6NqVD6EXEzozd8X+sL4=;
 b=O74fvAKYC12jyGCXX9peU29VpWAVVrcfyAdZvA3IQPpAqj4bYJL4uP2UGgnlvx1RJ1wE
 dCD370Df0cl6trlSLyWecMeyJpHRnaOm1AOm2c6qgCcSAK7G5wkJAy0rw610GryT5cQFD
 uK2S1trIUTDkGYijpyb+3E/QXE8DqEfwCSix3PaRFyGgXYxrhQhiglbf8fM4Tu9X8wApe
 CsRG4dtN+WYwpr9Zw8Ja4JCrwRcNmX90MPaiKmLFLMsHcFHcF15ZttB8QiZCVaPi7Rt4o
 4GYHPV1Z2EX9B5Fju03uHX07URXwotA4cVeOo0x9IieO2/8W86IhrNld2fxGUNzBMDA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nebusec.ai;
 dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256
 header.s=google header.b=T2oKBAOw; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com;
 envelope-from=zihanx@nebusec.ai; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=nebusec.ai
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai
 header.a=rsa-sha256 header.s=google header.b=T2oKBAOw
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7645C407DA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 07:45:31 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2e7006bbf77so11423055ad.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 00:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nebusec.ai; s=google; t=1792050330; x=1792655130; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tn7PQz7YO2FDXiLMjVOvk9Md6NqVD6EXEzozd8X+sL4=;
 b=T2oKBAOwk2e4TBVM7mn2RIn8b8O4wbvOisoIoXG4NUGaUFX2aP1qDYISDFNIhT20NU
 8ugm0AaWsoY//7CJbBaC1DhdPy6kMnciVLg+yCFoMf01SA8CIP2jbhe4wBYsfHTGtpbG
 15zDv8i0/yH7zZg6CQ/HIjJ1Bsix7G2Vz1drV4RWa0kWsG6exjjF+LPMLRWWtyD7JqCS
 RbBXfuU4AdNxB5WNygw5zKsdEXQ1DbZ7fqcg4/nhUi54pRr1HYPZLLCJfoydFUOkFwQI
 zhiGwbWUF6ySIUE3Nrygc7WLoigBw2HG/7QC5cTqXsW0Ehi11ou3XSXsv60/Ks+zbGVm
 PkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792050330; x=1792655130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tn7PQz7YO2FDXiLMjVOvk9Md6NqVD6EXEzozd8X+sL4=;
 b=YfRnfJyHMgqBgUyOyEHIPYsQmrP2XEaR9hAw7KEe44GOde+JrsgaD0kphkuU2nX+fk
 DZz8JgP3jwQYcb3+3eDukqP42rXeWDYinCNrWvyIMtYr+szWangXvu+a8bQmwGP/WDw4
 3E9aj2zGXSuBkREUtAIGwFbZTlouuDNh5GvXSfjf76nQoDuw9lDLYb9OUDCOSV7jLLXt
 Oiwl2wYRk04LV1a3KXuJNFLaDc3KDFAjH9hnlEMRXBpxENdJFWXVaPxc5JDay/HTnpAx
 yNn6B38VSfswdjSk/xBOOaoH75euqbmI1xNTrq+D7/8nNBNrDAxpwPfth1uADKdr2jAx
 W41g==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2Ki9xc+Cihuz7Lpr6lT3aopDEYo+7hATep2RFRNfL7x+opbgffeta3Oq4+LfXmFNmMNSjVaKRDSPqIoCL6L4=@lists.osuosl.org
X-Gm-Message-State: AFq9FYKTo3Xgvt3/6X6aOvcmYfCpnonpop1f65wWBXewKXtWYAJEvKF3
 Avjv5DP5HqXH0WC+hoXtlp4dgOTVPWhddsdwjZJ/2BvgqnTdBYYhDD1gKT8rHCo4x7Xu
X-Gm-Gg: AYBFou1pJQEdXeeyeLVWyFR2rcve6qjAUXFDelSoZsN24m0RzgGfWbMPbR0WKSyqXNp
 hGT7mP5JykiDnw8r6t7brEWInL+MvOPiuJdMkdzd+iJK70FDznKFuo8VZbClbL9EgvMlZOStPdl
 qdTty61llSx7ivHG7X1n47niQlUVus54cQ0491hFMRrUJZfaV24r9ytrh9T6BLBElWCM7aaTLzF
 YkJQzPPlF9g7Jy0TuTouPR2OeGDSovEVUAGlMvefTWXPcKBVWIwPhUftZNtMS/uqbNJxFegFPyw
 nNKaqCJPEQdISI8GHbieXkC6Clb5h6gpX2T+6S6GqUlIvVd0vDoZbgE4gXEaDpy50uCQWLV7n85
 0BZpD5Hhq6z1/rsM/z0C2IRhMKS/KAwODrJxkkttP71XCcJxuPjfvZOem6fVets9XMQ/o6ZLxu0
 /wkRmVobiYcWUJADQ05nOoWH4RqJVG94j8k6hRqpg9FaAAtnRXyrVcH9XGKEhfTCiqps8oZJdZQ
 pv7hXTIdRcmXaNAOB+yO2+7RgAemQ==
X-Received: by 2002:a17:90b:3b4f:b0:3ac:a7ee:6780 with SMTP id
 98e67ed59e1d1-3aca7ef2dd1mr318175a91.66.1792050330377; 
 Thu, 15 Oct 2026 00:45:30 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac93849da5sm1636831a91.4.2026.10.15.00.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 00:45:28 -0700 (PDT)
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
Subject: [PATCH nf v8 3/3] netfilter: nf_dup: prevent TTL and hop-limit
 underflow
Date: Thu, 15 Oct 2026 07:43:09 +0000
Message-ID: <3db2db978957de74be13ba48cc16c5e0829003e3.1792048855.git.zihanx@nebusec.ai>
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

The IPv4 and IPv6 duplication helpers decrement TTL or hop limit for
copies processed at PRE_ROUTING or LOCAL_IN. Stop duplicating when the
value is at or below one, before a subsequent decrement can wrap.

Fixes: e281b19897dc ("netfilter: xtables: inclusion of xt_TEE")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/ipv4/netfilter/nf_dup_ipv4.c | 3 +++
 net/ipv6/netfilter/nf_dup_ipv6.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/net/ipv4/netfilter/nf_dup_ipv4.c b/net/ipv4/netfilter/nf_dup_ipv4.c
index 9a773502f10a..5f9d6c473fb0 100644
--- a/net/ipv4/netfilter/nf_dup_ipv4.c
+++ b/net/ipv4/netfilter/nf_dup_ipv4.c
@@ -56,6 +56,9 @@ void nf_dup_ipv4(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 	local_bh_disable();
 	if (current->in_nf_duplicate)
 		goto out;
+	if ((hooknum == NF_INET_PRE_ROUTING || hooknum == NF_INET_LOCAL_IN) &&
+	    ip_hdr(skb)->ttl <= 1)
+		goto out;
 	/*
 	 * Copy the skb, and route the copy. Will later return %XT_CONTINUE for
 	 * the original skb, which should continue on its way as if nothing has
diff --git a/net/ipv6/netfilter/nf_dup_ipv6.c b/net/ipv6/netfilter/nf_dup_ipv6.c
index 6da3102b7c1b..5095f9623001 100644
--- a/net/ipv6/netfilter/nf_dup_ipv6.c
+++ b/net/ipv6/netfilter/nf_dup_ipv6.c
@@ -50,6 +50,9 @@ void nf_dup_ipv6(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 	local_bh_disable();
 	if (current->in_nf_duplicate)
 		goto out;
+	if ((hooknum == NF_INET_PRE_ROUTING || hooknum == NF_INET_LOCAL_IN) &&
+	    ipv6_hdr(skb)->hop_limit <= 1)
+		goto out;
 	skb = pskb_copy(skb, GFP_ATOMIC);
 	if (skb == NULL)
 		goto out;
-- 
2.43.0

