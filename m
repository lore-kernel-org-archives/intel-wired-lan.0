Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E80606A320
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=RfAyrCII;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=DKMqAsKS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 138578120B;
	Tue, 10 Nov 2026 16:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LDPPj1hq3L09; Tue, 10 Nov 2026 16:51:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 113C2811FB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794329472;
	b=isaVVNEr4Rx1o6S/qb//GhKMLOQFwwOAQjiMZBYzFs32qDUXmoMarJhCZKAF0PTvEovs
	 IU28NSZP2r428Jolx59P9WOHEXOkTRZjr1tvSVT1oeMPvYpSWa4SsnL2AketEXQnc9PXj
	 Gsy6smcCGDD1OGgwOg+i4UkTO5VkWKd5U7MoukyYl38U3B5rhgvjaqDlbQ4qBwi6mLKNp
	 WKzB511M39AUTU58ZhIQyDxmpYAvUGWrHBNMWHEbVQ4fVEnjaQpLuilGst/ZBAT4I0k8l
	 HvWJVWyACGJIYJ7yFewg9CnlMUL86GKirlpRBeQ1mrwq2LRk3R4T65SWu3u75i6M1lw==
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
	bh=m8+xowlUwN+TnOKNDaiztwvEmzRJ1pYtLtKYjKSdRBE=;
	b=JOMUyPnv6nklJ8PD41ITvcTn1z+Pz6d/DG6Cb1d6uJ4nGx5YztxsLSeC0eJnRP1lRj5W
	 FxK3RxGEVDUSkiUxP0uVAauZPci1d71o0ixtxr4MSC4TTf1hd5KgH7yBs5gqIhScukdLa
	 DStoRYqopqi1AC/Is4Clp923Y17QfI29attl1r4OjnyeWZv5k2VU372/8xCYAJhtexg2S
	 J9BJyErezL89abOov/BP+ruBvDaQ3y2itSUJ3cZBcjFXoC04u5hSHcd0FNnBCjPj3knr5
	 vb594vjTm9JwQN1CDQClpUA9f3qm9Gip1mfjrhN8eagHwsp+Pc83oscAF5lKiVt619g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=DKMqAsKS;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794329472;
	bh=m8+xowlUwN+TnOKNDaiztwvEmzRJ1pYtLtKYjKSdRBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RfAyrCII8z9VJUX6pKomrcHPnZeo4JMqEWSymtCz62ExyIdVXpM/dxwtEwiTVasCv
	 9Ixou706GcF4gfUYMTnuj4aS1M8TbnfB4ELUZwzFzL819vFqY8A/FaRC2Hd7tI3jId
	 ohxGTNov5G6j2GUGOGP5iLYMAVB15nXxM3E2InRie1nNUnlOiDfWwqy3JWluOvaRbj
	 5QiIa5XBTVf1Cikr187ser3Z3/mhf+nMyoYGeEOKZBOHzDFal7zpOulG8ltR0Z28Ot
	 P0f/IUz2qnl65jvLrc5z9FMyukjjH0OUMZ1wSCmWMO9XzlQIXxVnDuj+zGcKJyr6tW
	 HFPhUr0IMM6KA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 113C2811FB;
	Tue, 10 Nov 2026 16:51:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B77D8335
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A91F680BDF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gh-6rlCiFdoO for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 03:57:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5B3B0809BB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=DKMqAsKS
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5B3B0809BB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:32 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6b56c428212so2067776a12.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 09 Nov 2026 19:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1794283051; x=1794887851;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m8+xowlUwN+TnOKNDaiztwvEmzRJ1pYtLtKYjKSdRBE=;
 b=DKMqAsKSPAW39ompyMx8Os2PSSUFBFw9M4kC6XluggvV6ZHYDvsK3Kyq8oQYN0+i0C
 aRmhhyt0Gc0KePQF278/bizozT7bJIHFmbRYJxv1aQ0G3Mt/x6F1nymk8GgEhp3aDexm
 bQr0XfyVT4B1WuqfjudUB7QQFi/QACQIy4kbw3OHuYdxbK5NzujDM37incAMntTeEBBW
 LDxSiHufScjuBfJYSTsbOO7IBguGIGfOvlTBN7ImxB55+n01KWBazZEGpkiKyHhTNlEB
 OsJ4QUxS4iHgnS1kgO7T8k9RPyV16CpTiKIk/+LfaHyjjaT4VkViaTcrOo/gIse0Yn6D
 lHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794283051; x=1794887851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m8+xowlUwN+TnOKNDaiztwvEmzRJ1pYtLtKYjKSdRBE=;
 b=nSuWX0M5AfsWAL/pDQJBWrynsxFlMeBPaj3OoTEZSWgba0ebatmQ34LXcA1rTxWp4R
 nANS35yXrNZFm1pWqTF7QBy2Q7JfjyjfBcwbMdT7dIJdv0SRNgJ0feIoH1pNXQDsVW5F
 JigivJmriK+KWQYC0fozpU6HS6WgPT4iYXfqZwD9xGqJF3R8wMOb8jDM6dYGksRjNCxs
 icCCfqWyIzt6hUUZW9E87awwcjI5Yp0S3yrE53s7rKPchPqjnEWFvi4ZTDiUyqZjU8TB
 jTppNcC5r3djCK/iFzFOH4ofcO+cL6hGZ/0UQFmlRv8y57fNzm1vDZ99S/jVUYDpsfiq
 V3jw==
X-Forwarded-Encrypted: i=1;
 AL+hErHx1zI14QyRsigwO3YasYGfRUfZickKcUk+Qhgh/mt1LC6rdbfruGO09MhYAtGUlulT5bjF7GiX3rqJTeJ34pc=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+G2BWdhYDgK2eVQDxSJUyVxygjRmHLSlXXB4Bqxoq5DENKXer8
 +4KuSFqdmx7vPWhoxopbUX5JubNfI2ASTvuK0LkgqfP4GttkqPfu82yMzl0S061/4kk=
X-Gm-Gg: AYBFou1SJvgtJVinYv4NsLUYX7kK+NO4NXxmdcf+2NcCfSa9CgxOqK5h4hCdsjr3RyU
 CyV9zSATDyH2fIK6sXhzgZS+jZkPlT1vWYk2Np9R1sgtNwOir/0gL5o9UH93CWF/40kVpOp++S3
 C/8EKgBnPAfTgBmpGQYDA7oOw/Io3klltQRUCJ6KVEsmSD3HojESNtfHSbnrUgccvKMQbI4y4kb
 B7gnfPjkTkAvhQ/IIt+ZGuQa3O939WbT//7ToatQ9J+qRuOT9JqiIsV0f86S7kJJMrzkRsArpbP
 8gNYsylKv/eBqeu6F3iAWppzHEMMUfqtVtHenRYSUZxoG1td/LCf6Tz+GLICFPCgeT/UNfXHW5A
 ssI6HACEcnBy03l9RR3opV0ioF9ZtZX9SA1RiuUVBIOYYoplwFDBFpI5sV8i5rSvOnL6vm7l7Yr
 AjAL79928/+0jYcusajwP09xuFq5tol584TucjpcdL6aPyyw9fMES//Wdt0rViv9pL4uISmP/gZ
 ue2W111dLDIGNv9OJdH6zCVnAbDgu6rSu0oZPHn19tXzdKd8unXNbt9MYrsfFmC3y7y85fk6hdr
 /BySAfs3ntDBCKSaRoGuHkaDDJyit5/kyrz3O8VMWkOY8rFdllKoXwz1G5DGaok7NDM4SlCBnj2
 xlt5Hqaav
X-Received: by 2002:a05:6402:3227:b0:6b5:66cc:d828 with SMTP id
 4fb4d7f45d1cf-6b7564c452dmr973212a12.7.1794283050804; 
 Mon, 09 Nov 2026 19:57:30 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.57.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Nov 2026 19:57:28 -0800 (PST)
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
Subject: [PATCH bpf-next 03/15] xdp: add kfuncs to store RX hash and VLAN tag
Date: Tue, 10 Nov 2026 03:57:01 +0000
Message-ID: <f865ab08e7e0343bcd6eb380f7003ddd32d177e2.1794281983.git.tianyi@cloudflare.com>
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

Add bpf_xdp_skb_ext_store_rx_hash() and bpf_xdp_skb_ext_store_rx_vlan().
They store the RX hash and the VLAN tag in the skb core extension area.
A later patch sets the stored values on the skb built from the
xdp_frame.

Both kfuncs call xdp_skb_ext_add(), which reserves the entry for an id.
On the first store for a packet, it clears the header and sets
XDP_FLAGS_HAS_SKB_EXT, so stale headroom is never read as a header. A
second store of the same id, also after a delete, reuses its offset.

xdp_skb_ext_add() returns -EOPNOTSUPP for AF_XDP zero-copy buffers. User
space can write their headroom while the program runs, and could change
the header between two stores.

The store kfuncs are in their own kfunc set. They do not need a
device-bound program, so programs on cpumap and veth can call them.

bpf_xdp_skb_ext_store_rx_vlan() accepts only ETH_P_8021Q and
ETH_P_8021AD, because vlan_proto_idx() warns on any other TPID.

A BUILD_BUG_ON() in xdp_skb_ext_struct_check() limits the area to 64
bytes. As in skb_extensions_init(), the function is noinline
__no_profile so that it builds with CONFIG_GCOV_PROFILE_ALL.

The two kfuncs are based on bpf_xdp_store_rx_hash() and
bpf_xdp_store_rx_vlan() by Lorenzo Bianconi in Jesper's XDP_REDIRECT RX
hints series V2 [1].

Link: https://lore.kernel.org/all/175146831297.1421237.17665319427079757435.stgit@firesoul/ [1]
Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 net/core/xdp.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 3 deletions(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index 1d679e8fd649..97dc0e403a78 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -990,11 +990,159 @@ bool bpf_dev_bound_kfunc_id(u32 btf_id)
 	return btf_id_set8_contains(&xdp_metadata_kfunc_ids, btf_id);
 }
 
-static int __init xdp_metadata_init(void)
+#define XDP_SKB_EXT_CHUNKSIZEOF(x) DIV_ROUND_UP(sizeof(x), XDP_SKB_EXT_ALIGN)
+#define XDP_SKB_EXT_ENTRY_ACTIVE BIT(7)
+
+struct xdp_skb_ext_hash {
+	u32 val;
+	u32 type; /* enum xdp_rss_hash_type */
+};
+
+struct xdp_skb_ext_vlan {
+	__be16 proto;
+	u16 tci;
+};
+
+static const u8 xdp_skb_ext_type_len[] = {
+	[XDP_SKB_EXT_HASH] = XDP_SKB_EXT_CHUNKSIZEOF(struct xdp_skb_ext_hash),
+	[XDP_SKB_EXT_VLAN] = XDP_SKB_EXT_CHUNKSIZEOF(struct xdp_skb_ext_vlan),
+};
+
+/* Limit the header and all entries to 64 bytes, so that a new entry
+ * cannot grow the area without notice.
+ */
+static noinline void __init __no_profile xdp_skb_ext_struct_check(void)
+{
+	unsigned int chunks = XDP_SKB_EXT_CHUNKSIZEOF(struct xdp_skb_ext);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(xdp_skb_ext_type_len); i++)
+		chunks += xdp_skb_ext_type_len[i];
+
+	BUILD_BUG_ON(chunks * XDP_SKB_EXT_ALIGN > 64);
+}
+
+static void *xdp_skb_ext_add(struct xdp_buff *xdp, enum xdp_skb_ext_id id)
+{
+	struct xdp_skb_ext *ext = xdp_skb_ext(xdp->data_hard_start);
+	bool valid = xdp_buff_has_skb_ext(xdp);
+	unsigned int newlen, newoff;
+	void *start;
+
+	/* User space can write the headroom of AF_XDP zero-copy buffers */
+	if (xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (!valid) {
+		newoff = XDP_SKB_EXT_CHUNKSIZEOF(*ext);
+		newlen = newoff + xdp_skb_ext_type_len[id];
+	} else if (ext->offset[id]) {
+		newoff = ext->offset[id] & ~XDP_SKB_EXT_ENTRY_ACTIVE;
+		newlen = ext->chunks;
+	} else {
+		newoff = ext->chunks;
+		newlen = newoff + xdp_skb_ext_type_len[id];
+	}
+
+	start = xdp_data_meta_unsupported(xdp) ? xdp->data : xdp->data_meta;
+	if ((void *)ext + newlen * XDP_SKB_EXT_ALIGN > start)
+		return ERR_PTR(-ENOSPC);
+
+	if (!valid) {
+		memset(ext->offset, 0, sizeof(ext->offset));
+		xdp->flags |= XDP_FLAGS_HAS_SKB_EXT;
+	}
+	ext->offset[id] = newoff | XDP_SKB_EXT_ENTRY_ACTIVE;
+	ext->chunks = newlen;
+
+	return (void *)ext + newoff * XDP_SKB_EXT_ALIGN;
+}
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_xdp_skb_ext_store_rx_hash - Store the RX hash of this packet.
+ * @ctx: XDP context pointer.
+ * @hash: RX hash value.
+ * @rss_type: RSS hash type, see &enum xdp_rss_hash_type.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-ENOSPC`` : not enough headroom for the entry
+ * * ``-EOPNOTSUPP`` : AF_XDP zero-copy buffer
+ */
+__bpf_kfunc int bpf_xdp_skb_ext_store_rx_hash(struct xdp_md *ctx, u32 hash,
+					      enum xdp_rss_hash_type rss_type)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &xdp_metadata_kfunc_set);
+	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
+	struct xdp_skb_ext_hash *entry;
+
+	entry = xdp_skb_ext_add(xdp, XDP_SKB_EXT_HASH);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
+
+	entry->val = hash;
+	entry->type = rss_type;
+
+	return 0;
+}
+
+/**
+ * bpf_xdp_skb_ext_store_rx_vlan - Store the VLAN tag of this packet.
+ * @ctx: XDP context pointer.
+ * @vlan_proto: VLAN tag protocol identifier (TPID), in network byte order.
+ * @vlan_tci: VLAN TCI, in host byte order.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-EINVAL`` : @vlan_proto is not 802.1Q or 802.1AD
+ * * ``-ENOSPC`` : not enough headroom for the entry
+ * * ``-EOPNOTSUPP`` : AF_XDP zero-copy buffer
+ */
+__bpf_kfunc int bpf_xdp_skb_ext_store_rx_vlan(struct xdp_md *ctx,
+					      __be16 vlan_proto, u16 vlan_tci)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
+	struct xdp_skb_ext_vlan *entry;
+
+	if (vlan_proto != htons(ETH_P_8021Q) &&
+	    vlan_proto != htons(ETH_P_8021AD))
+		return -EINVAL;
+
+	entry = xdp_skb_ext_add(xdp, XDP_SKB_EXT_VLAN);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
+
+	entry->proto = vlan_proto;
+	entry->tci = vlan_tci;
+
+	return 0;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(xdp_skb_ext_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_hash)
+BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_vlan)
+BTF_KFUNCS_END(xdp_skb_ext_kfunc_ids)
+
+static const struct btf_kfunc_id_set xdp_skb_ext_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &xdp_skb_ext_kfunc_ids,
+};
+
+static int __init xdp_kfunc_init(void)
+{
+	int ret;
+
+	xdp_skb_ext_struct_check();
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
+					&xdp_skb_ext_kfunc_set);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
+						&xdp_metadata_kfunc_set);
 }
-late_initcall(xdp_metadata_init);
+late_initcall(xdp_kfunc_init);
 
 void xdp_set_features_flag_locked(struct net_device *dev, xdp_features_t val)
 {
-- 
2.56.0

