Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65149606A321
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=yfdPL30c;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=dqruUTCq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EB72405D6;
	Tue, 10 Nov 2026 16:51:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iDN3Rcot5TCn; Tue, 10 Nov 2026 16:51:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 19ADB40572
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794329471;
	b=HdQVjweawJEJs7Aa35e9TOfwmBaNlYLF0nA2fu+jOpRlOQQF1lTNYy4ajZ6qWt7vdeqa
	 psNaFU9TF4ITM97Yji02Eey+weEtx1VBm/XeObpjaf2pOtso2/o6f8meN78LzPD/FlUJQ
	 uMAdfBTYA9LPDJjAeoHT9wtewqx5LNdsQLUm2ppfrQ6elIwagIm9axgEmR6NAa0LuTzw0
	 GCMHos29RXKxlf+eKinrHSsNdUH9zAXDvW0wNtdB5O3FHFK8MDoVUYmN2njsXJr1zwCXj
	 AeqymOiw0HTTlqgEcGHmxK08g8dOZ1CozlS1lMUKok9L6S5dn5izvn8W8MmfyNl79fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794329471;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=L0xaW/62AQgxFhpajczQ88yBj65kDwjYHTXkn62rfdI=;
	b=d6MH0vPq+uPVs8dPM10vDJwNkGfEcfBuptqFDRVG2nWbCMqfpHlDNcTcsYfN0vxHkzAn
	 Y9C7HlgohUxehUamlnC415rS55fG3yR301ArI+1Brk6faRdni2fDF3XovxXNmasB9BhMF
	 vQg1CPEjK1BB3MlCb47kjNSsIqBNhoOE6AFsnBk1taJlAKXlKdPqaGtRSsnMV1mRMNN/k
	 DH7vprw9KwJn20F9vHTX15WBhvAdPKetaavOKfLsELjxdOsfABYzpanYaRf7OGocJGhFP
	 wluc/Fn1GXI/bHEeiV8LSWGwXolJVL8Y0jGLqNz13nh9tuuEtima8SPznwlv4D3vBdw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794329471;
	bh=L0xaW/62AQgxFhpajczQ88yBj65kDwjYHTXkn62rfdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yfdPL30cY2lzao7h4R+kfHWAcCseuK8Em9X2PLv7Dh7sfdp/GBtJNnRvxM0qYPj7r
	 u7ZVfyMa+Yd9C2TIoJRE2HFrKSLZXkv9U0mrHF8FY/V+XLizUxTGDkZBx1S8+rC72R
	 +vv2zWaGQxWo9khQNi+zp/PsfT1KTWZjZux/wEhzR32ofrvSrvbfZFXEQ8YBWT2MUe
	 VwXm5MP4sVQ/MFWHZ//Ge1IENoJwI6IMHZpU3xiTcqdMKtkimpKofrgQVtaaT4ib3C
	 7K7XDqY3iwqRBwcMsgtvoR8Vrd/c9x20gv14nUWkDG/rScrgHwU5U+Ffvq1irQJnRi
	 h6Ija4gcooLKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19ADB40572;
	Tue, 10 Nov 2026 16:51:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1540F335
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF8E640312
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WhJDdjmS4y8J for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 03:57:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EE0034008C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=dqruUTCq
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE0034008C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:28 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6b70d5b07faso1938716a12.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 09 Nov 2026 19:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1794283047; x=1794887847;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L0xaW/62AQgxFhpajczQ88yBj65kDwjYHTXkn62rfdI=;
 b=dqruUTCq9vjDPN33sKQCAdaoZAPE0D5CNyo2x8KzaVM9pmG0Xon0MZ1RlLgegg2um/
 9D2xH1QDTeVhqeLQDtEOCF/Qp9TAzszEtjEykL7Dq7PZn8UBbzoX5PnQed0Cp3VgGEtu
 JKxccjcOzDEtdqzbxc3FW7Co17baDGUUjo0eObrLVQ25JO25IJUp5iLDsZPYR6Lpi/VL
 dal+Vf5DNrtUEmWE6/EVsgOtTvE9zi/a2pbxwK+GGoBbkYx+KxKXsPZ6KQqo5No5Zn7o
 xCsDZ6yfTCyJR/R01y89LKsy5wMawojYQOOilG+ESvrqEu8qpNzOXG+eiK4V2oteIYWT
 UCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794283047; x=1794887847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L0xaW/62AQgxFhpajczQ88yBj65kDwjYHTXkn62rfdI=;
 b=wcwTfw0axJFHE9RaSQIVVgTdN+X+Nb0rBcBerldXJZgkZLxcGZigeYV3jB0behBExO
 ZYj0vRgzo2I9YArGIunQl9J3HQ+sot468qgu9Ilm32Hw/GTUkp7ASjYD8O3a7BHqge5o
 dTjTJYpVCkde2U+UfpmjknDqNIs27KYSv4KNLGtZFwNEW4i/gdospJ2NXiKUvjzluq9G
 6C1n/hOJ+rW4YYfFOydLJgfd+w5p5Da2f3GXK3M5PX5yD427Sizps8nTPwcoscGsrbrw
 2FRgljFZNG6lACR6vjrTJpnmnFYLCyg4833YWeNaNj4ockHwuE4vN806cJKJAYDXfk+D
 tOqw==
X-Forwarded-Encrypted: i=1;
 AL+hErFmS56UgpTk4SH/Vh3IDfDz67cJivuS4mtahNQgcFkdF/srG2V9bSdZJK7Ytdcx2VjvppH8MNno5z00HhWkQws=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/yhabN8lZl9jd5g2OVpiYooHz3NUPOw3Lb5i+InKe3df8udgYn
 5HBtV82Jpzoqpr1ZH+i6oM1TXLmj+J/w9RcsAFI3ur1muu6B0ENZHpbrg3BB6SSufAQ=
X-Gm-Gg: AYBFou0Naqh/esj8MN1WFZQPxhPLOYRjIYV14WwDk5/GoAv50BXoJDgIAsu67Rl+ZBa
 YC1N+SEQlldGhe9wJos09J7JUQwqfUki8rt1zlnlS/uIy1AJv6yQGXZ/WK8KbiyOfpuhNXaTs7G
 5ijc8ubc+EbGkfuJspHqHmQd6/nKsqkPrsXTe6Le32A1ckFFNpUjsKPxZb2e9UM+mDkiEsoA700
 yt9ymkx+JdvlP08EWihkYW2VqCvMMCDV9DcZnpgi4pF39t3zdo6vTlxTkYy69ct2ZOuiTMEiuxi
 Rve0HQMG5XEyBiWvhyYhnCSJTQb9pipG5ltVDyqfojeK6nCRoOu/OTBDuVWauhbN3L0xF+0U3M7
 GEzMXRW6/WqDhcRpDjLLGBHOe5dv34PFebi78FwQ2E7JnXyORTupQqrrPeBjfPSJ1iq96oNoLxp
 khlSYs1iDB2CZN4uoSrW2jJ7Tj0qCwwEDcX+1o6C9ICtSFbN86Cjpsqbastta2GD8jeuU8U6fob
 pmQ0kkgSCK6ITS5AdyPv1SQK+RYuieLII19qxk27z8S0rXKh5Kuy+44pdrWUv+tF7YSwfOV6Om4
 JxuoAQduTMgyrQRKNVh8ycWc089vOUJlqnOAOcZ117xflW/dG5bITcAcuAG6kKkp4Pm/6zsJYEs
 lMACROmKW
X-Received: by 2002:a05:6402:c4d5:10b0:6b1:d344:c62a with SMTP id
 4fb4d7f45d1cf-6b756ae6169mr667065a12.30.1794283046684; 
 Mon, 09 Nov 2026 19:57:26 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.57.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Nov 2026 19:57:25 -0800 (PST)
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
Subject: [PATCH bpf-next 02/15] net: dpaa,
 dpaa2: clear the skb core extension flag
Date: Tue, 10 Nov 2026 03:57:00 +0000
Message-ID: <bff7f72c7c28f67497e23a6629b9e4db74332da6.1794281983.git.tianyi@cloudflare.com>
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

dpaa_run_xdp() and dpaa2_eth_run_xdp() move data_hard_start to the start
of the buffer after the XDP program runs and before XDP_REDIRECT.
xdp_skb_ext() then returns a different address from the one used while
storing the entries. These drivers have not implemented the XDP RX
metadata kfuncs. Hence they now clear the XDP_FLAGS_HAS_SKB_EXT flag
before XDP_REDIRECT, and their redirected frames carry no stored entries.

With the A050385 erratum workaround, dpaa already moves data_hard_start
before the XDP program runs, so the entries remain valid. The flag is
cleared on that path too, to keep the change simple. This can change
when dpaa implements the XDP RX metadata kfuncs.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c   | 2 ++
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index ad2d8256eb8d..4cafc0b84dc9 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2654,6 +2654,8 @@ static u32 dpaa_run_xdp(struct dpaa_priv *priv, struct qm_fd *fd, void *vaddr,
 		/* Allow redirect to use the full headroom */
 		xdp.data_hard_start = vaddr;
 		xdp.frame_sz = DPAA_BP_RAW_SIZE;
+		/* data_hard_start moves, so the stored entries are lost */
+		xdp_buff_clear_skb_ext_flag(&xdp);
 
 		err = xdp_do_redirect(priv->net_dev, &xdp, xdp_prog);
 		if (err) {
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 7227a35dfaf2..fcefdc9daf2b 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -472,6 +472,8 @@ static u32 dpaa2_eth_run_xdp(struct dpaa2_eth_priv *priv,
 		/* Allow redirect use of full headroom */
 		xdp.data_hard_start = vaddr;
 		xdp.frame_sz = DPAA2_ETH_RX_BUF_RAW_SIZE;
+		/* data_hard_start moves, so the stored entries are lost */
+		xdp_buff_clear_skb_ext_flag(&xdp);
 
 		err = xdp_do_redirect(priv->net_dev, &xdp, xdp_prog);
 		if (unlikely(err)) {
-- 
2.56.0

