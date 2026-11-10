Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3368B606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Zt049GWK;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=bxg9hI/5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1631D40572;
	Tue, 10 Nov 2026 16:51:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iUjnkSrncDW8; Tue, 10 Nov 2026 16:51:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 39E8540820
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794329481;
	b=mhChtEUUyRGiO6MSAhcoqSVx7cx3Q8LbLRvo1O0no6K4hjH9sODRv0haxkHnfnT0zGy6
	 MFtFZDJNVYC8vKCu9A0lrHTw7OBwmuIo6w+2ewFIf1I/HEl9SBNw68m5il18oLTkhpoWU
	 cCbfGZ+pOgCD23mjye/e2rm11yEUR+NSSQL3PhiMsqu42++ZpJ2ouskuL394CXSkgFWKU
	 Z9Pt+BJLYbDxCKEcIWpmzZpeNJxbi/Nedbde7VuQPNb6zd49H6GrR5S8798b1HBUJ42Og
	 APgQBR0i+EI9duq9IYabq2klrpPJyhq0D9vLkR+JECmWSfB+7WcTNzskFo/Sy1ZNaRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794329481;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MSk1Tsr4MwxHYw7iRh7y9cNVx4+IdLtKhJgZHhSE8Jo=;
	b=UzWKBIK1r5O6pbBo3YJnrdwWVm6wVchoIhhlnYTEFtJ6U3Lk2a3nadHjh+8SEfRI+xsB
	 CU4t9qEVMN0O2foGwM2UDy5qkpTD9bSiM9nis6N7w2t+P6OwWmPouUV9L+APH04QZQvHM
	 WaXz7BH3114Gynyi/tbDKMG/3cZZGyL+sP5ZZ7ZYk75viVYnt44GOSZMmvKNoamYWeSgy
	 nbifiyrQAUebgkfvWw1BreGAz6hFYv0LPMUA4rKB9/DNxM6GcAYoNFCFad20IGXMvMMMU
	 6jc3z+M/M8DP8mSpe+CBT4FAiYXRX9dLb/SEKUy6kfkWAxOnMErX84ai1RN5uDwjQ7Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794329481;
	bh=MSk1Tsr4MwxHYw7iRh7y9cNVx4+IdLtKhJgZHhSE8Jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zt049GWK+RAjghHLwtgGLWEC1ch0p9ZBKto7chM6Z63vYEpvWxHxz0uQPuHL8zMvl
	 UuVevPbna1pKRjgZT3xgYcTYKpRotW3pG5U5EdCURA448DRCpZ0/rOlicuhw2OfDAD
	 DkqQCj6z6FaVI+pWJk2hypTWPdOi6ulNxhsUGkUulLD2mJ+IuWqSozizIWlQoU1cv6
	 5xbqf9LC3HB61oQahd/6ZFgx2Lxk712VQRPyQOivRV0ErHHwBlrKJvefqCV3mXbKTZ
	 EpaAgqZWeLXTlEb3Z9cfYHaR05CihvUisDpsCutOVP5TqDODRsPGvjeUFOVimGtx/e
	 vG2pwZhs/bMhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39E8540820;
	Tue, 10 Nov 2026 16:51:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A2EF335
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:58:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BD4C8100A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:58:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CTtRlpwbhwVV for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 03:58:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1B323809EE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=bxg9hI/5
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1B323809EE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:58:11 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b587591414so1742948a12.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 09 Nov 2026 19:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1794283090; x=1794887890;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MSk1Tsr4MwxHYw7iRh7y9cNVx4+IdLtKhJgZHhSE8Jo=;
 b=bxg9hI/5/zsOSqF5+X6uTucMZRCfaWNKtYZRKZNerVhRHMrPvobTzWXXOEG+wsvuwl
 MWz11og3NmebuDFyR4iRRJeM9VrLRmk410n7t9Ev9uCEL/N8elpXsJtIgr/Ghepx0ZcC
 GF05tzTlogkD94SQLOndGAsb/nmcygZHSLK9bMv19g23dJCaiOSxHaLgxVKXTOngVbAB
 Rk0Pz5IkTWMssVhDUmEHGqMJW1+v4JWo7ebT2xuL2Lf9Rf06tDfR4IgovHR6MWya4l4t
 RCphhTJ/2IwH5U5maO50J6NyREzffh3jhHXjrNSb6306utu7bbyryGw/gkLQpfMG0q54
 vSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794283090; x=1794887890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MSk1Tsr4MwxHYw7iRh7y9cNVx4+IdLtKhJgZHhSE8Jo=;
 b=FzTONQvHVoH7o39WSlWt3ABaVSz0LQzfSJiAkP5IXrN1CnagcdLqQ9p4gnjZFg0sfJ
 UQRqE1Zo2QRrha4VPF9f/ZZvnVN8APHN7R1qSM0a3JAu858zdv6BoO09W4cINUZ0rCRW
 VrptRX4TMeSZyQG+TYc5c9OIhQxouiLHSfUG34fq5/5hjmRg6nRIs0b7AHSSeh+KwpAm
 b5jCXJQX/Qh0rosnf6h1hsjh39BReML8u8l3M3rBbBXmFKk+TW9wtvgh48GkPSEtzy39
 402BUh++ydiTftVC04exFRGDL1FpwAtXWl3KVjTlN5TNYe2CSdkLdvLekP0kjx3XcfZM
 0jjA==
X-Forwarded-Encrypted: i=1;
 AL+hErHsMNTzOMx7CIpp//4R+vgcekX/WfqRnt5UxBk0A0LwZI5EB8FDj0X4JRNafLxuS+9r0d4CFttM3bnEAxo67Zo=@lists.osuosl.org
X-Gm-Message-State: APuU4Z9POVBmUb0lGEUUK5D1hPEW4PvV+IkEPxFX0kUjwwQ8tfFVhDDd
 6JBt1wz9+KK5v8WMpVZCITQnmzZeX7muuoCno8+DVX8rFhRHcZwLHrxa7ws04wqiEEY=
X-Gm-Gg: AYBFou3xFfs720+4v+7IS1P0uGWUKxkUJqpFpRG/+TxFVeZxn997sDdGqGP6Us5dP1B
 HG4Y+ObacqqR9DPduxrFfUQLhCOBOjPa+LqnWizZFXBcLKghhplj3WIeufUe3Xzpp0/UjDx6UFl
 4wcP3LZvVybsZ6EqUCQatcfnr6W+GX0jg+ZsTXXIpaPcK+wf/ibaII4JwboX00A5cTNwTjlyqVx
 R6Ws91oUErXVjn6d0g3gHMkwwoXY0GR+FPVn6sR4LZVwBlE8zEuEockbqPnCd+SsRHK+SGzOROR
 8twZNrjXiUJdLtFaH427Ouc7SH4C+FpEQO7REZGELe8LGrEI+XdAG8nBY9I7tmq3Fa4qAk6FQ31
 wkT4C9+hs73PvXQmzZYiWdqK3mpi5NwM8NGphO8btqexw9qoRcE4mA9efiu/AuDNRSDmYTjrLGZ
 3P1mRbNnCmHbTmO0tpM+DPjr2ok+RemgQDsT84kPhT/yNrPCcea+diMEP6RIQnLsmTw7rLVTz3I
 81692TT8LgPGlAlgNfPBNL/qHyHeKx6Jhey9sCmdYFde6CHv9havnqux3cGHzOYRmuKK0IYaNSH
 /3XpbFZuggsuhCrrStuWFnDoUl6sYDOHRpAqSWV+D+QYhcVCZ4YDgIUidhgXfZdF
X-Received: by 2002:a05:6402:5626:b0:6b6:efc4:9eb2 with SMTP id
 4fb4d7f45d1cf-6b7556282afmr914079a12.0.1794283089889; 
 Mon, 09 Nov 2026 19:58:09 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.58.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Nov 2026 19:58:08 -0800 (PST)
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
Subject: [PATCH bpf-next 14/15] selftests/bpf: Test the load kfuncs on cpumap
 and veth
Date: Tue, 10 Nov 2026 03:57:12 +0000
Message-ID: <87e20fe4ae289764205f33920e90f3283a478e8a.1794281983.git.tianyi@cloudflare.com>
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

Add a test for the load kfuncs on each path of the xdp_skb_ext_to_skb
test. On XDP_PASS, the program that stores the values reads them back.
On cpumap and veth, the program after the redirect reads them. Each
test case compares them with the stored values. A load that finds no
entry, also after bpf_xdp_skb_ext_del(), must return -ENODATA.

With BPF_F_TEST_XDP_LIVE_FRAMES, a recycled page still holds the entries
of the previous packet. The live_frames test checks that a load returns
-ENODATA there.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 .../selftests/bpf/prog_tests/xdp_skb_ext.c    | 47 +++++++++++------
 .../selftests/bpf/progs/test_xdp_skb_ext.c    | 50 ++++++++++++++++++-
 tools/testing/selftests/bpf/xdp_skb_ext.h     |  2 +-
 3 files changed, 81 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c b/tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c
index 64c6f0268d60..0811c09b7747 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c
@@ -7,7 +7,6 @@
 #include "test_xdp_skb_ext.skel.h"
 #include "xdp_skb_ext_success.skel.h"
 #include "xdp_skb_ext_failure.skel.h"
-#include "xdp_dummy.skel.h"
 
 #define XDP_RSS_TYPE_L3_IPV4 BIT(0)
 #define XDP_RSS_TYPE_L4 BIT(3)
@@ -167,7 +166,9 @@ static void set_case(struct test_xdp_skb_ext *skel,
 	skel->bss->want = c->want;
 	skel->bss->del_hash = c->del_hash;
 	memset(&skel->bss->have, 0, sizeof(skel->bss->have));
+	memset(&skel->bss->loaded, 0, sizeof(skel->bss->loaded));
 	skel->bss->store_err = 0;
+	skel->bss->load_err = 0;
 	skel->bss->pkts_seen_tc = 0;
 }
 
@@ -191,8 +192,6 @@ static void check_have(struct test_xdp_skb_ext *skel)
 	bool unnecessary = (want->fields & SKB_EXT_FIELD_CSUM) &&
 			   want->ip_summed == XDP_CHECKSUM_UNNECESSARY;
 
-	if (!wait_pkt(skel))
-		return;
 	ASSERT_EQ(skel->bss->store_err, 0, "store_err");
 	ASSERT_EQ(have->hash, want->rx_hash, "hash");
 	ASSERT_EQ(have->l4_hash, !!(want->rx_hash_type & XDP_RSS_TYPE_L4),
@@ -208,6 +207,24 @@ static void check_have(struct test_xdp_skb_ext *skel)
 		  "csum_level");
 }
 
+static void check_loaded(struct test_xdp_skb_ext *skel)
+{
+	const struct xdp_skb_ext_vals *want = &skel->bss->want;
+	const struct xdp_skb_ext_vals *loaded = &skel->bss->loaded;
+
+	ASSERT_EQ(skel->bss->load_err, 0, "load_err");
+	ASSERT_EQ(loaded->fields, want->fields, "loaded_fields");
+	ASSERT_EQ(loaded->rx_hash, want->rx_hash, "loaded_rx_hash");
+	ASSERT_EQ(loaded->rx_hash_type, want->rx_hash_type,
+		  "loaded_rx_hash_type");
+	ASSERT_EQ(loaded->rx_vlan_proto, want->rx_vlan_proto,
+		  "loaded_rx_vlan_proto");
+	ASSERT_EQ(loaded->rx_vlan_tci, want->rx_vlan_tci,
+		  "loaded_rx_vlan_tci");
+	ASSERT_EQ(loaded->ip_summed, want->ip_summed, "loaded_ip_summed");
+	ASSERT_EQ(loaded->csum_level, want->csum_level, "loaded_csum_level");
+}
+
 static void test_frames(struct test_xdp_skb_ext *skel, const char *path,
 			enum xdp_skb_ext_deliver deliver, int ifindex)
 {
@@ -232,9 +249,12 @@ static void test_frames(struct test_xdp_skb_ext *skel, const char *path,
 		if (!test__start_subtest(name))
 			continue;
 		set_case(skel, &skb_ext_cases[i]);
-		if (ASSERT_OK(bpf_prog_test_run_opts(prog_fd, &opts),
-			      "test_run"))
-			check_have(skel);
+		if (!ASSERT_OK(bpf_prog_test_run_opts(prog_fd, &opts),
+			       "test_run") ||
+		    !wait_pkt(skel))
+			continue;
+		check_have(skel);
+		check_loaded(skel);
 	}
 }
 
@@ -266,6 +286,7 @@ static void test_veth_skb(struct test_xdp_skb_ext *skel, struct bpf_link *link,
 		goto out;
 	if (deliver == DELIVER_CPUMAP) {
 		check_have(skel);
+		check_loaded(skel);
 		goto out;
 	}
 	ASSERT_EQ(skel->bss->store_err, 0, "store_err");
@@ -275,6 +296,7 @@ static void test_veth_skb(struct test_xdp_skb_ext *skel, struct bpf_link *link,
 	ASSERT_EQ(have->vlan_tci, 0, "vlan_tci");
 	ASSERT_EQ(have->ip_summed, CHECKSUM_NONE, "ip_summed");
 	ASSERT_EQ(have->csum_level, 0, "csum_level");
+	check_loaded(skel);
 out:
 	close(sock);
 }
@@ -292,7 +314,6 @@ void test_xdp_skb_ext_to_skb(void)
 {
 	struct bpf_cpumap_val val = { .qsize = 192 };
 	int ifindex_src, ifindex_dst, tc_prog_fd;
-	struct xdp_dummy *skel_dummy = NULL;
 	struct test_xdp_skb_ext *skel = NULL;
 	struct bpf_link *link = NULL;
 	struct netns_obj *ns = NULL;
@@ -330,18 +351,13 @@ void test_xdp_skb_ext_to_skb(void)
 	    tc_prog_attach("veth_dst", tc_prog_fd, -1))
 		goto out;
 
+	val.bpf_prog.fd = bpf_program__fd(skel->progs.cpumap_load);
 	if (!ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.cpu_map),
 					   &key, &val, 0), "add cpumap entry"))
 		goto out;
 
-	skel_dummy = xdp_dummy__open_and_load();
-	if (!ASSERT_OK_PTR(skel_dummy, "xdp_dummy__open_and_load"))
-		goto out;
-
-	/* veth_dst takes xdp_frames only with an XDP program */
-	link = bpf_program__attach_xdp(skel_dummy->progs.xdp_dummy_prog,
-				       ifindex_dst);
-	if (!ASSERT_OK_PTR(link, "attach xdp_dummy"))
+	link = bpf_program__attach_xdp(skel->progs.veth_load, ifindex_dst);
+	if (!ASSERT_OK_PTR(link, "attach veth_load"))
 		goto out;
 
 	test_frames(skel, "pass", DELIVER_PASS, ifindex_src);
@@ -354,7 +370,6 @@ void test_xdp_skb_ext_to_skb(void)
 
 out:
 	bpf_link__destroy(link);
-	xdp_dummy__destroy(skel_dummy);
 	test_xdp_skb_ext__destroy(skel);
 	netns_free(ns);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c b/tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c
index a63206ff993d..34db1a986f3b 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <vmlinux.h>
+#include <errno.h>
 #include "xdp_skb_ext.h"
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
@@ -14,6 +15,8 @@ SEC("xdp")
 int live_frames(struct xdp_md *ctx)
 {
 	__u8 *mark = (void *)(long)ctx->data;
+	enum xdp_rss_hash_type rss_type;
+	__u32 hash;
 
 	if (mark + 1 > (__u8 *)(long)ctx->data_end)
 		return XDP_DROP;
@@ -25,6 +28,9 @@ int live_frames(struct xdp_md *ctx)
 			reused_ok++;
 			bpf_xdp_adjust_meta(ctx, MAX_META_LEN);
 		}
+		if (bpf_xdp_skb_ext_load_rx_hash(ctx, &hash, &rss_type) !=
+		    -ENODATA)
+			reused_bad++;
 	}
 	if (bpf_xdp_skb_ext_store_rx_hash(ctx, 1, XDP_RSS_TYPE_L4_IPV4_TCP) ||
 	    bpf_xdp_skb_ext_store_rx_vlan(ctx, bpf_htons(ETH_P_8021Q), 1) ||
@@ -51,7 +57,34 @@ enum xdp_skb_ext_deliver deliver;
 struct xdp_skb_ext_vals want;
 bool del_hash;
 struct xdp_skb_ext_have have;
-int pkts_seen_tc;
+struct xdp_skb_ext_vals loaded;
+int pkts_seen_tc, load_err;
+
+static void load_all(struct xdp_md *ctx)
+{
+	int err;
+
+	err = bpf_xdp_skb_ext_load_rx_hash(ctx, &loaded.rx_hash,
+					   &loaded.rx_hash_type);
+	if (!err)
+		loaded.fields |= SKB_EXT_FIELD_HASH;
+	else if (err != -ENODATA)
+		load_err++;
+
+	err = bpf_xdp_skb_ext_load_rx_vlan(ctx, &loaded.rx_vlan_proto,
+					   &loaded.rx_vlan_tci);
+	if (!err)
+		loaded.fields |= SKB_EXT_FIELD_VLAN;
+	else if (err != -ENODATA)
+		load_err++;
+
+	err = bpf_xdp_skb_ext_load_rx_csum(ctx, &loaded.ip_summed,
+					   &loaded.csum_level);
+	if (!err)
+		loaded.fields |= SKB_EXT_FIELD_CSUM;
+	else if (err != -ENODATA)
+		load_err++;
+}
 
 SEC("xdp")
 int xdp_store(struct xdp_md *ctx)
@@ -99,6 +132,21 @@ int xdp_store(struct xdp_md *ctx)
 		return bpf_redirect_map(&cpu_map, 0, 0);
 	if (deliver == DELIVER_VETH)
 		return bpf_redirect(ifindex_out, 0);
+	load_all(ctx);
+	return XDP_PASS;
+}
+
+SEC("xdp/cpumap")
+int cpumap_load(struct xdp_md *ctx)
+{
+	load_all(ctx);
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int veth_load(struct xdp_md *ctx)
+{
+	load_all(ctx);
 	return XDP_PASS;
 }
 
diff --git a/tools/testing/selftests/bpf/xdp_skb_ext.h b/tools/testing/selftests/bpf/xdp_skb_ext.h
index 11feee2fa31c..64d4a0511d0a 100644
--- a/tools/testing/selftests/bpf/xdp_skb_ext.h
+++ b/tools/testing/selftests/bpf/xdp_skb_ext.h
@@ -30,7 +30,7 @@ enum xdp_skb_ext_deliver {
 	DELIVER_VETH,
 };
 
-/* The entries that the XDP program stores */
+/* The entries that the XDP programs store or load */
 struct xdp_skb_ext_vals {
 	__u32 rx_hash;
 	__u32 rx_hash_type;
-- 
2.56.0

