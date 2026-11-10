Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB1C606A321
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=FhwpUOga;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=A1tE9cDj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A05688124B;
	Tue, 10 Nov 2026 16:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g-7m7zSnIiRH; Tue, 10 Nov 2026 16:51:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C97A381202
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794329472;
	b=K9ewpuXux7p7fQQ4V4vnDifS1XTIhV/G15e8uxHX2dpaf9i1bBdBwM/KVS9CM5SvYm2w
	 RrDKd4QDBmjuWHJaP8xgS3E29BIVcvN5eJqmYEBvw68iL0CbtTub1Z3abb5xm2l9f30ec
	 aFlaUMaHwJNlNMSXiMmdtMoQrhzlLVPgOUTYUDUuwhUDO7tEQPDTwoA+QkpuAKD6SVwoA
	 6eCEqJTrgTwiuiF30in9N3eTOgTCy7CRhmA11n6Ouzx/B8QSQZOhFWS8u3rWohcbVNzlL
	 vuvia7VWPg1rjUZOC8n+4v4OVKPPkzg4jECcWgUycsMlr4rJcOy93KZte9r/AEUcaUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794329472;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EC2CxfAA6gR7S2oAAPp+eS1dDml83jpwhvD444kpRqo=;
	b=EUvNjR9so8kYuWZrOvxhWMWj3JGgwT5j7LnQxagnLAxul5nxj3c5ZuoHhecJyAKcVlq0
	 T7ojDWwVQ/a7FS6TJsp2CVSkpCuCfxmHYU1dD/8AyPaxrp/U4PRZ4vFVZxnGRFAeEtEFs
	 r07MOLRQDWi+9xFBsGct9FJcmSR3jfbXFrw0Tn6loP9jugLmHb7aiTYQ7WtdS8M8togeH
	 jy1/ikpLeLYW9Hbb9uhsP6QD2/r8c94qk8KUmYYUKG8MxZLsPo2Z+eTnABKzrs3Hlk/uk
	 lIeewrSaUfuolLV+kKs1qZwmsy76JG16BYNAj6277WTLfikUFiUNnsjDqAIOJkQt6VQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794329472;
	bh=EC2CxfAA6gR7S2oAAPp+eS1dDml83jpwhvD444kpRqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FhwpUOgau+7r2a1+TRQmYs/WPZywTGVxCH0s5pXigbwB9BKJLNjXHHlusLwNSwhKq
	 phwS2CHELWBbgZYhzBXRmCYL61acGoz3tKcbG/O7PluZehRAauZT/sSBGePTKrMb+4
	 gVytdMI/ZZCzlx2HG6h6et4BQpnJ4UiyVajyp23vA9pKEqwGAZ5kRB5nodTGGWxc7q
	 MPgrFAX50cJVmpES4CMb5oGNcHA8kx1qBKgK18z7i/RrcUUMS0Bix+UKcIfbXrZWz7
	 vAJc3LDfEEccUZ3kRwqo2e4yzHPE1pHLFyZHa9frN/y2xu3bXKuLcaL46TP+jJ8J39
	 2n7QahOV803ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C97A381202;
	Tue, 10 Nov 2026 16:51:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D7425335
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D44044059A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x-Cy86LSsvet for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 03:57:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CA3654070E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=A1tE9cDj
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA3654070E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:36 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c4682977f9aso193870666b.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 09 Nov 2026 19:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1794283054; x=1794887854;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EC2CxfAA6gR7S2oAAPp+eS1dDml83jpwhvD444kpRqo=;
 b=A1tE9cDjtmTOuOmQIoafOWomhRXVoTgj78gX+ZSt6dj5X0EKhUgTH5h5HFIKVAGV7u
 lUqeLOSxGHGgfC5+ulfR77w2FOD/pj5Icd9MJPd4W+HV46XWXj2X6RDbjrTxd1xo4N0R
 FvCYv3UYT4zh5Bz7+Q4fxj68RZjAU3lUFIP410wYo+HrTwNgmP8CDjHsWqUbB+mAWKdf
 Xz1gYxvGnYmeYYWTXH8uNgvBSvkj2/AVE2YuVuGeUa5ph0HlbrOT+yvyiBurMTqy2zw2
 bZW026ELf666T5Pziv8Pq+GuB6wnrfg1aukk+u0248dA77Yh93IMsKGxqIaF1Zq5kme9
 o/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794283054; x=1794887854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EC2CxfAA6gR7S2oAAPp+eS1dDml83jpwhvD444kpRqo=;
 b=QeJL63CHUbF7MLprktm+xbjhZZ/NeqhhAGLZxcqWA+k4Ne+bXoATDfhUma638bfuV6
 5c2L4U3xWKbRcR8Iddspj8cQ1ujnrIUTLiPddjDcJ3zVOpkN4/xo13KPpdHZ/uje57Xq
 iXWbjwWaTnVPVdOCk8fe8jjZRNGiZn+N4e9E4xqy1xZ9ipOsn6j+4jtrEvNmwdiaIkLc
 44usyAA+K+Q9x36aggNgSd+p6UfRedFJt0BekG5AFVp2zmTCdr0FVBamsasZx3dygvej
 yJbwumgBVe5sYp20CcCNfIO23Mgc3Ie698iG35FV95WkS4D7SH7wN0nVIcB0CGz7wuWq
 z6Aw==
X-Forwarded-Encrypted: i=1;
 AL+hErFAIfapL0iXMLk9PTWU1BSwTODuEnWx+th/5Zh0sr3GEpdrVo5TJ98dOz3DhySGvZSa+kcoMhVaTTgxXtLyEnE=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/LKKTJp6daqrKmV9VglIqpt3y5aIPmQ7sXabTxeXk51vVmHMpk
 WJW5/n9VeHxKrkWW6/uao7zX6A+Xxvq+pneGK+NWkGMedHeqDCE558LIkOhv8579kow=
X-Gm-Gg: AYBFou0E9P8wVzlmag87EuNYwwX/OOf6EUoF0ZrnZJxNCc4PILORrieDZWM7ht2YnUv
 o8PZ8NM6UY/+KekT6vyhnCFrbtnZqaCAFrkhEzh+KMttHs6amLJkJ27735hFijo8MkRG5N8sez4
 G6w7RZXdf9LUemO7+2t7p8ql3kvtzcM5bAUCVaJHx6wraMxlIHESCHKWgqFTRKU5CSiGXoPvXy8
 3bdcMsGQ/5wPz1w7DUyLAXRSzuWb64ZMP9Q6LlAn3v0Hgp1U7X3SqKIoj90Ph94SZMnKpBZTAlj
 3WQJI4cZTrrXx3rzDzmSwnTPsHXUOmRIxOdLVMzSCA1KxE456aU7MObwcAVOuFs0ikjO86PEivk
 M6mGzt+oPXQtd4OVajwI0Md6x/h1UEY62pvZmbIOThsB7f9pwdg/+xymy6Rnz2huu1pFeQgTrde
 NvmmmFRzmPqMn6oDpIEOFW8mpElO4EwY1eVJ3s4ywDlOHBbaTijFJ9Xe2VPn9bXIjAktgSwsZjD
 0vDqYP8c/wqoX+asMOCdE36VttMkFmBj2PwgcOueQvS1DxI6EtAkOPvyzE4V43pQ2lCvEkFm8Nz
 9TOqCx0ONEuL3p3n+B6w1xtpzm2uC9dfVann4n46/kZzZxqUz3IhCJW4OXStSts=
X-Received: by 2002:a17:906:364f:b0:c2d:be57:f73a with SMTP id
 a640c23a62f3a-c504952c083mr70409766b.13.1794283054469; 
 Mon, 09 Nov 2026 19:57:34 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.57.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Nov 2026 19:57:32 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Vladimir Vdovin <deliran@verdict.gg>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Donald Hunter <donald.hunter@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Madalin Bucur <madalin.bucur@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Chris J Arges <carges@cloudflare.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 llvm@lists.linux.dev, kernel-team@cloudflare.com,
 Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH bpf-next 04/15] xdp: add a kfunc to delete skb core extension
 entries
Date: Tue, 10 Nov 2026 03:57:02 +0000
Message-ID: <2892d19e606e3809c268de0610a4ccc8bf68625a.1794281983.git.tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794281983.git.tianyi@cloudflare.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 16:51:07 +0000
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

bpf_xdp_skb_ext_del() deletes the stored entry for an id. A program on
cpumap or veth can use it to drop RX metadata that an earlier program
stored.

Without the XDP_FLAGS_HAS_SKB_EXT flag, the kfunc does nothing, because
the header bytes may then belong to the packet.

The kfunc only clears XDP_SKB_EXT_ENTRY_ACTIVE, so a later store of the
same id reuses its offset. The flag and the size of the area stay the
same, also after the last delete. To give the bytes back, the kfunc
would have to move the entries after the deleted one. The cost is
headroom that bpf_xdp_adjust_head() and bpf_xdp_adjust_meta() cannot
use.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
__skb_ext_del() frees struct skb_ext after the last delete, because it
comes from a slab cache. The skb core extension area uses existing
headroom, so it is not freed.
---
 include/net/xdp.h |  8 ++++++++
 net/core/xdp.c    | 26 ++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index c888353425d4..23c976e92898 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -486,6 +486,14 @@ static __always_inline struct xdp_skb_ext *xdp_skb_ext(struct xdp_frame *frame)
 	return (void *)(frame + 1);
 }
 
+static __always_inline struct xdp_skb_ext *
+xdp_buff_skb_ext(const struct xdp_buff *xdp)
+{
+	if (!xdp_buff_has_skb_ext(xdp))
+		return NULL;
+	return xdp_skb_ext(xdp->data_hard_start);
+}
+
 static __always_inline void *xdp_skb_ext_end(const struct xdp_buff *xdp)
 {
 	struct xdp_skb_ext *ext = xdp_skb_ext(xdp->data_hard_start);
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 97dc0e403a78..2c1d5ec3311b 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -991,6 +991,7 @@ bool bpf_dev_bound_kfunc_id(u32 btf_id)
 }
 
 #define XDP_SKB_EXT_CHUNKSIZEOF(x) DIV_ROUND_UP(sizeof(x), XDP_SKB_EXT_ALIGN)
+/* A deleted entry keeps its offset, without this bit */
 #define XDP_SKB_EXT_ENTRY_ACTIVE BIT(7)
 
 struct xdp_skb_ext_hash {
@@ -1119,11 +1120,36 @@ __bpf_kfunc int bpf_xdp_skb_ext_store_rx_vlan(struct xdp_md *ctx,
 	return 0;
 }
 
+/**
+ * bpf_xdp_skb_ext_del - Delete a stored entry of this packet.
+ * @ctx: XDP context pointer.
+ * @id: Entry id, see &enum xdp_skb_ext_id.
+ *
+ * Return:
+ * * Returns 0 on success, also when the entry is not stored.
+ * * ``-EINVAL`` : @id is not a valid entry id
+ */
+__bpf_kfunc int bpf_xdp_skb_ext_del(struct xdp_md *ctx, enum xdp_skb_ext_id id)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
+	struct xdp_skb_ext *ext;
+
+	if ((u32)id >= XDP_SKB_EXT_NUM)
+		return -EINVAL;
+
+	ext = xdp_buff_skb_ext(xdp);
+	if (ext)
+		ext->offset[id] &= ~XDP_SKB_EXT_ENTRY_ACTIVE;
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(xdp_skb_ext_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_hash)
 BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_vlan)
+BTF_ID_FLAGS(func, bpf_xdp_skb_ext_del)
 BTF_KFUNCS_END(xdp_skb_ext_kfunc_ids)
 
 static const struct btf_kfunc_id_set xdp_skb_ext_kfunc_set = {
-- 
2.56.0

