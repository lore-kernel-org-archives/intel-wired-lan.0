Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F10C44507
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Jul 2026 21:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0211C40867;
	Wed, 15 Jul 2026 21:41:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V-QzQy86-6gG; Wed, 15 Jul 2026 21:41:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 361B540842
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784151677;
	bh=wcL5Jyyc2LCR42Fchxsyy0ZYCYQvT9Y2EynlDJ3nTmM=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OVE7ja89SR9ZdT/+4HY02/CpGaKOSQ0suHZbwK7Fq2kDNuYhI2aoYKy1PekeMJCIA
	 Q5jtyNPgv+xcduf1N4WhcVtzG3ocIwtAdPyqZ7B7nrV7/NlsokQF6Xx/EQbzcSnu1n
	 l3lLrVPxeQdxgUOtBkAqc20l/mU09Eeyd+Iej+82NFCIgjgxLiLtnRNDsLj6uNpqik
	 5hQVIENGfPYgFHbRQK/ZL81+geFUJ4/BlJLEBcrNS24TBclul2t0//z7QZzUq1AGOj
	 H65ISlDcc6x/5/bq7RZp6YnjCvAJUz13flmf0rF1xNG+s/AIxPbeYiCWLtRV5kJ2Ee
	 emXZVXL9VkVfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 361B540842;
	Wed, 15 Jul 2026 21:41:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E4D0C203
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 21:41:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CAB6F6069A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 21:41:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F1DZBqm173P7 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Jul 2026 21:41:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=lorenzo@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D17FE605EF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D17FE605EF
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D17FE605EF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 21:41:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 27FC743AFE;
 Wed, 15 Jul 2026 21:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567711F00A3A;
 Wed, 15 Jul 2026 21:41:13 +0000 (UTC)
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 15 Jul 2026 23:39:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-bpf-xdp-meta-rxcksum-v5-6-623d5c0d0ab7@kernel.org>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
In-Reply-To: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: Vladimir Vdovin <deliran@verdict.gg>, 
 Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784151674;
 bh=wcL5Jyyc2LCR42Fchxsyy0ZYCYQvT9Y2EynlDJ3nTmM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=j4Y0KYpGYqBa+wfiFihFc08yijSPHZzLWZXhaqiuZIK43KVvpza8+tUKXeOgg+uXh
 5EtB8hwgSg0lvmcXc13OySOH0CW88udpylDUSFf6mbhTtTxfkp0ZTfMiYZeVTXR9rR
 WZzRbpHawdTyoImSBGi+qaEg5hu1p4OYk8OufUn5VFuQcmtFTnStaXHZocVZ4MfSgi
 39KE3l+Qta6KS+qI87eEyxVqRyMa4v+CYOsaXTLB7s7Bz1JUbLldYQiTz9CXJK1Eqp
 IwiIPhgWbpmx35dzc1OCItpVEArjewyYL7YZxqRDnfXAqk00czNAdniy1aro3pwpU8
 SWDJusgruN2jg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=j4Y0KYpG
Subject: [Intel-wired-lan] [PATCH bpf-next v5 6/8] net: add
 bpf_skb_rx_checksum kfunc to read skb checksum metadata
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Add a new BPF kfunc, bpf_skb_rx_checksum(), that allows TC and other
skb-attached BPF programs to read the skb->ip_summed field and
associated checksum metadata. This is needed because the existing
bpf_csum_level() helper only distinguishes CHECKSUM_UNNECESSARY
from all other states, making it unsuitable when the caller needs
to differentiate CHECKSUM_NONE from CHECKSUM_COMPLETE (e.g. after
XDP_PASS where the driver may have set either).

The kfunc writes two output values:
  - ip_summed: the raw skb->ip_summed value
               (CHECKSUM_NONE=0, CHECKSUM_UNNECESSARY=1,
                CHECKSUM_COMPLETE=2, CHECKSUM_PARTIAL=3)
  - csum_meta: CHECKSUM_COMPLETE -> hardware checksum (skb->csum)
               CHECKSUM_UNNECESSARY -> checksum level (skb->csum_level)
               otherwise -> 0

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/core/filter.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index b446aa8be5c3..71d58ea53512 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12546,6 +12546,36 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
 	return 0;
 }
 
+/**
+ * bpf_skb_rx_checksum() - Read skb RX checksum info.
+ * @skb_: socket buffer to read from
+ * @ip_summed: return value for skb->ip_summed
+ * @csum_meta: checksum metadata
+ *
+ * Reads the checksum-related fields from a socket buffer. For
+ * %CHECKSUM_COMPLETE, csum_meta reports the hardware checksum value.
+ * For %CHECKSUM_UNNECESSARY, csum_meta reports the checksum level.
+ * For %CHECKSUM_NONE, csum_meta is zero.
+ *
+ * Return:
+ * * %0 - success
+ */
+__bpf_kfunc int bpf_skb_rx_checksum(struct __sk_buff *skb_, u32 *ip_summed,
+				    u32 *csum_meta)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_;
+
+	*ip_summed = skb->ip_summed;
+	if (skb->ip_summed == CHECKSUM_COMPLETE)
+		*csum_meta = skb->csum;
+	else if (skb->ip_summed == CHECKSUM_UNNECESSARY)
+		*csum_meta = skb->csum_level;
+	else
+		*csum_meta = 0;
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12565,6 +12595,7 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
+BTF_ID_FLAGS(func, bpf_skb_rx_checksum)
 BTF_KFUNCS_END(bpf_kfunc_check_set_skb)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_skb_meta)

-- 
2.55.0

