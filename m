Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29548606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=odSq2X6K;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=VK8nZo/1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C447812CA;
	Tue, 10 Nov 2026 16:51:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gOeklPcmw4Mr; Tue, 10 Nov 2026 16:51:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1A891811C8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794329482;
	b=K8uV4Tb3io2N3y2MzLCLAHrm/rwFZY97Wv6FfJdY9h9wZCFevDVdPtZ28cNmdtu20N9B
	 rlLJOVQqVW8bxagUCRWlKfwSxH5x2r7RDaVQNw8vCsdVW5DmxLlU9xy0cyB3wSS6+Etzw
	 oeXQ2dthPQTKo1y7W3PyxV4A6rDP7hMWrP4P+GFWxqaN5hbwvoFCKvNWu3yYdEPS6fxPJ
	 BmBorHJm+qPT8GSFDDL0bHcDYCpnxVMs5hACoyWhgX/IDac6T1AXa7BNUYXmCgkX4l6Qb
	 hElnBNThNSeEB4iCp3UZFdLJYRUuhv4cz1BhFcP3j2CAxJK0fpHSwJUqpJSnRHUFKwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794329482;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PPCb0t5/Stvq5DGUybTkkPxJ34Zyvu9vKlrhKMaUpac=;
	b=AA6pGebP0761sfhrDsFVRw+4R0HYhy/+6poLh5mCJju+KYnNe7XsS3rpmIQ44JsttGZc
	 QrycR6idnFPXCPlYo+zOu8JDTIiiXsQ8h+UxCjXZFEtCQDW7sd+Mt2B0EN/ocbP5JyoCs
	 my9C0i0H0lmDicf/yqEZjnWCjoyowgKWTLlp3hdIwSlW4HMqR1z6hFZs9TFk2WieXUsKk
	 l0FHsxmEiEWKmAw3jp8zMYAC065Eyu6dC9PplneE0ldTXnNqOnQlzLUiy8/NccrFrERi5
	 9Z3UtHLKcBFdsoYt65/V7Tq825mtZaxDkHCZKrd9heYFJen/rKtVv3ymW6NVoE/Njzw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794329482;
	bh=PPCb0t5/Stvq5DGUybTkkPxJ34Zyvu9vKlrhKMaUpac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=odSq2X6KvD/VJP/6bPId8ubk9aoh7pBFz9LSGKxAHn03uGDvlp18O+wB5pclsZPNt
	 /Yqwiiq3+FrzsYCf17m53Z63s6tHRcvxUGvcgBrMwo+K0iAzq9Tpd74Cmg3FxRj3SR
	 IdJ/opgsY65CHoL0AHx0I2B+OxSKgm56CHv49Mju2+JkzwN5Bzpj+OlUesqI6R8Hh9
	 3/GBIYgwNtVA9n/YiasP0u081pHrtMDXM6e82NwAfAv2mSWYfWd7UFJfoBZLE6ZRsY
	 W+mjdAJDxT6tvW06LegvCE9AjnsZe7yPUmGrWXdWjjIue3cIiZ32HBtze5E8TXAM2U
	 A1N2BTyJGhdtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A891811C8;
	Tue, 10 Nov 2026 16:51:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F26E3AF2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:58:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E0487407DA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:58:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7w18Inlm9o-K for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 03:58:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ABE3240762
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=VK8nZo/1
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ABE3240762
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:58:15 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b704171bc9so1707343a12.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 09 Nov 2026 19:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1794283093; x=1794887893;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PPCb0t5/Stvq5DGUybTkkPxJ34Zyvu9vKlrhKMaUpac=;
 b=VK8nZo/14jkrRXiGBumwpvQlH9zouYDi6Z3KP7Vj0pDfMyB9FgpULGFBcsZ55SJgpC
 1qA0pA4QIYeVOYGsDG10U0vvgs6+xhn0+5ku9X20vVvR9vZze//0lB6JQ5ujYfYRLfgZ
 Jy20BNXFjt+5TVj6BvQR13tbBR32ka8kH1e82miVFU5naur9lEvcpi//C/iEzDRFLMHz
 Zgw4/8xqXDXrja4NqAI5u6/9fctibDs6I4x/IKJmbBiN0wac0aZjT6eAxu4n+vKJZ5dz
 zgeAWYWfGIKxPb/Kx14uv5/FXT9syRU6/AmP9Qrmfd7Rqzt5Tmu2T67VfygL0n4Ge96w
 IEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794283093; x=1794887893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PPCb0t5/Stvq5DGUybTkkPxJ34Zyvu9vKlrhKMaUpac=;
 b=ik31NK57ab9cnG8SAfsyMNcYS1didSi+1nqMjmBvHKy0Q1drNZlfTk2BPeiXfUxaIq
 tr9JNO5e9RwAguLrrinm8XPgbpdXXuGCzz33IhMRBw+3VHMpdjI8lL7rMhf6UFTRdz5N
 uGAhLR8Qk2ENyE6AATMP+u+B/x2NUI04P/+eiGdXtqHAXaRYRTW43lL4UzoeSL35rYij
 nFezCa9uJCIuPSyALfsLpD0aEfK23ym845GW5UJryyRInYcu7TCT2go96VNFoPVU2FxE
 vUgUWIGozdTQTcJOxeWF6lCxsvPMAmNa/rjHOkTnP7OU+kQmBZf757QzMo62jgGp5T/3
 yDeg==
X-Forwarded-Encrypted: i=1;
 AL+hErHeMPN1LSJRVt8dYK6XiUK1HDZG/mR0RNpeI2KM7B5VgQIf/Mt/WmYuGLHYEpaWwAzs23G+TAWhW5kTCZvHok4=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8YeuPmhe1+mb8NhfaQ5yWEEwTWwYwj2f7dvG6riX/bxOZNzE0Q
 Kf4ozhYmfuf4hXNEwmiJAjNQuGLC+HNddQhH6kbkKAyeyLC1HYxyCMelYhlePUlE4nc=
X-Gm-Gg: AYBFou2+rBJPljtaiNAY5S6a3MXU+rJUpseAr9XOiw8a0X+qtzunmXbVQ6oHRdzn9HB
 ka6+JXKdAtcxJRAYy0q+cxCbcsardlwks/hNabu5leCkbkzeb3PAlShcbLU6q39AHRoQ8jCnpwp
 sjDF0iZgKF4i7uYRnPr9bhsyICYiBeTaHj3ZZ+i4UKPD/ThMjPbI76XXgUFDGUpOcl01UGDGJFl
 0mMTo3+ac3mo3LD39CX4aFUlYQVJcduQlGj4zGSSVp+ro2zj8jYp4m3e+RjM5RqmMilu2R/72Mz
 uQJbHEQxMpnpJidspvUbxu6SXRfN+fCT9NGPKWyfqjOiW7+D1zZ9mFxm+byDw0pinUxPHoMpRjq
 oxO8UepvoejDPSD8ryBVKNm4ctqjWFc9VmCWaCc+JoWdmEy164iHIly/Ftw8a+lI+QfrhsyfEln
 MSG+7m5nf5sSf4A8X+7/cU0eeUQTAe9ynNxGZLXRpHlw6NMtGVRWSNBo71/vzvJ+FkmLcd8lhU/
 9mjZ9suYsp4idhCCvKJGzdQELHNUE5PYQJfNy4BcH5C1OB8Qi8iYL4gHKUg7xzqQgb9oU3LznZx
 Qz1govFD4BP1eBgcLsBmp+kBUnkTk+650grrj5zjc/50JVfWDNxGwhO2nWavL0AXbk0ZznztYMo
 OKKqA2id+
X-Received: by 2002:a05:6402:3603:b0:6b6:ee00:aed9 with SMTP id
 4fb4d7f45d1cf-6b756adfec4mr1037528a12.44.1794283093331; 
 Mon, 09 Nov 2026 19:58:13 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.58.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Nov 2026 19:58:12 -0800 (PST)
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
Subject: [PATCH bpf-next 15/15] docs: net: document the skb core extension area
Date: Tue, 10 Nov 2026 03:57:13 +0000
Message-ID: <a37a908598e396446c1a389e3a58a1fe44a514ac.1794281983.git.tianyi@cloudflare.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a section on the skb core extension area to xdp-rx-metadata.rst.
It shows where the area is in the headroom and lists the store, delete
and load kfuncs. It also says when the kernel sets the stored values on
the skb. The Supported Devices section names the skb-ext-pass XDP
feature.

Update the XDP_PASS, bpf_redirect_map and bpf_tail_call sections,
which did not cover the area. Document xdp_skb_ext_to_skb(), the
skb-ext-pass XDP feature and xdp_build_skb_from_frame() in the driver
section, and point to the selftests in the example section.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 Documentation/networking/xdp-rx-metadata.rst | 127 +++++++++++++++++--
 1 file changed, 116 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
index efdf5eeb49e7..61dcc24d7342 100644
--- a/Documentation/networking/xdp-rx-metadata.rst
+++ b/Documentation/networking/xdp-rx-metadata.rst
@@ -54,6 +54,83 @@ area in whichever format it chooses. Later consumers of the metadata
 will have to agree on the format by some out of band contract (like for
 the AF_XDP use case, see below).
 
+SKB Core Extension Area
+=======================
+
+An XDP program can also store RX metadata that the kernel sets on the
+``skb`` built from the packet. It stores and deletes the values with
+these kfuncs:
+
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_skb_ext_store_rx_hash
+
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_skb_ext_store_rx_vlan
+
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_skb_ext_store_rx_csum
+
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_skb_ext_del
+
+The values are kept in the skb core extension area. The area starts at
+``data_hard_start + sizeof(struct xdp_frame)``, right after the room for
+the ``xdp_frame``::
+
+  +-----------+-----------+----------------+---------------------+------+
+  | xdp_frame |  skb core |    headroom    |   custom metadata   | data |
+  |           | extension |                |                     |      |
+  +-----------+-----------+----------------+---------------------+------+
+  ^                                        ^                     ^
+  |                                        |                     |
+  xdp_buff->data_hard_start       xdp_buff->data_meta     xdp_buff->data
+
+The area is not an skb extension (``struct skb_ext``) and needs no
+extra allocation. It takes no space until the first store. It holds a
+4-byte header and the stored entries. The header and all three entries
+take 20 bytes. ``bpf_xdp_adjust_head``, ``bpf_xdp_adjust_meta`` and
+``bpf_xdp_pull_data`` do not move the packet or the metadata into the
+area.
+
+The kernel sets the stored values on the ``skb`` in these cases:
+
+- When cpumap or veth builds the ``skb`` from an ``xdp_frame`` after
+  ``XDP_REDIRECT``.
+- When ``BPF_PROG_RUN`` with ``BPF_F_TEST_XDP_LIVE_FRAMES`` builds the
+  ``skb`` after ``XDP_PASS``.
+- On ``XDP_PASS``, in a driver with the ``skb-ext-pass`` XDP feature,
+  see `Supported Devices`_.
+
+On ``XDP_PASS``, the stored values replace the values that the driver
+sets from the RX descriptor. On a native XDP driver without the feature,
+the kernel warns once when the program returns ``XDP_PASS`` with stored
+values. When XDP runs on an ``skb``, in generic XDP or when veth receives
+an ``skb`` from its peer, the kernel does not set the stored values on
+``XDP_PASS`` and also warns once.
+
+The program that stores the values can read them back. So can the
+programs that run on the ``xdp_frame`` after ``XDP_REDIRECT``, on cpumap,
+devmap and veth:
+
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_skb_ext_load_rx_hash
+
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_skb_ext_load_rx_vlan
+
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_skb_ext_load_rx_csum
+
+They return only the stored values. The RX metadata kfuncs above still
+read the values from the RX descriptor. Unlike those, the kfuncs in this
+section do not need a program that is bound to a device.
+
+On ``AF_XDP`` zero-copy, the store kfuncs return ``-EOPNOTSUPP``, because
+user space can write the headroom. The area would not reach the skb
+anyway. On ``XDP_REDIRECT``, ``xdp_convert_zc_to_xdp_frame`` copies only
+the custom metadata and the packet. On ``XDP_PASS``, drivers do not apply
+the area.
+
 AF_XDP
 ======
 
@@ -83,12 +160,13 @@ This is the path where the packets processed by the XDP program are passed
 into the kernel. The kernel creates the ``skb`` out of the ``xdp_buff``
 contents. Currently, every driver has custom kernel code to parse
 the descriptors and populate ``skb`` metadata when doing this ``xdp_buff->skb``
-conversion, and the XDP metadata is not used by the kernel when building
+conversion, and the custom metadata is not used by the kernel when building
 ``skbs``. However, TC-BPF programs can access the XDP metadata area using
 the ``data_meta`` pointer.
 
-In the future, we'd like to support a case where an XDP program
-can override some of the metadata used for building ``skbs``.
+On drivers with the ``skb-ext-pass`` XDP feature, an XDP program can use
+the `SKB Core Extension Area`_ to override the hash, VLAN tag and checksum
+status of the ``skb``.
 
 bpf_redirect_map
 ================
@@ -100,18 +178,19 @@ access to the original hardware descriptor and can't access any of
 the original metadata. The same applies to XDP programs installed
 into devmaps and cpumaps.
 
-This means that for redirected packets only custom metadata is
-currently supported, which has to be prepared by the initial XDP program
-before redirect. If the frame is eventually passed to the kernel, the
-``skb`` created from such a frame won't have any hardware metadata populated
-in its ``skb``. If such a packet is later redirected into an ``XSK``,
-that will also only have access to the custom metadata.
+This means that the initial XDP program has to prepare the metadata
+before the redirect, as custom metadata or in the `SKB Core Extension
+Area`_. If the frame is eventually passed to the kernel, the ``skb``
+created from such a frame gets its hash, VLAN tag and checksum status
+only from the area. If such a packet is later redirected into an
+``XSK``, that will only have access to the custom metadata.
 
 bpf_tail_call
 =============
 
 Adding programs that access metadata kfuncs to the ``BPF_MAP_TYPE_PROG_ARRAY``
-is currently not supported.
+is currently not supported. The kfuncs of the `SKB Core Extension Area`_
+do not have this limit.
 
 Supported Devices
 =================
@@ -120,6 +199,12 @@ It is possible to query which kfunc the particular netdev implements via
 netlink. See ``xdp-rx-metadata-features`` attribute set in
 ``Documentation/netlink/specs/netdev.yaml``.
 
+A netdev that sets the values from the `SKB Core Extension Area`_ on
+``XDP_PASS`` in native XDP has the ``skb-ext-pass`` flag in its
+``xdp-features`` attribute. The flag does not cover generic XDP or the
+veth ``skb`` path. An XDP program can also read ``xdp_features`` of the
+receiving netdev after ``bpf_cast_to_kern_ctx``.
+
 Driver Implementation
 =====================
 
@@ -153,9 +238,29 @@ xdp_frame. If these conditions are not met, it returns a negative error. In this
 case, the BPF program should not proceed to populate data into the ``data_meta``
 area.
 
+A driver that builds the ``skb`` on ``XDP_PASS`` applies the
+`SKB Core Extension Area`_ and sets ``NETDEV_XDP_ACT_SKB_EXT_PASS``. The
+driver sets the ``skb`` fields from the RX descriptor and then calls this
+function. The driver takes the area pointer with ``xdp_buff_skb_ext``
+before it reuses the ``xdp_buff``:
+
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: xdp_skb_ext_to_skb
+
+``xdp_build_skb_from_frame`` does not apply the area. Its callers set the
+RX fields themselves or transmit the ``skb``.
+
+A driver that moves ``data_hard_start`` after the XDP program ran calls
+``xdp_buff_clear_skb_ext_flag``, because the area is no longer at the
+expected place. The stored values are then lost.
+
 Example
 =======
 
 See ``tools/testing/selftests/bpf/progs/xdp_metadata.c`` and
 ``tools/testing/selftests/bpf/prog_tests/xdp_metadata.c`` for an example of
-BPF program that handles XDP metadata.
+BPF program that handles XDP metadata. See
+``tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c`` and
+``tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c`` for the skb core
+extension area, and ``tools/testing/selftests/drivers/net/hw/xdp_metadata.py``
+for a driver on ``XDP_PASS``.
-- 
2.56.0

