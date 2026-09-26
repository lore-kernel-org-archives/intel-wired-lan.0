Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC282CA5FA2
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 15:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 710FD40552;
	Mon, 28 Sep 2026 15:13:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RkfmqXVjFAGB; Mon, 28 Sep 2026 15:13:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 76C1B40675
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608417;
	b=MGwk3oLUez1KRFrzW2bPv/TzfyK8cSMVRPavTR3TY67qujkB/Rp55N3tzvgD8qP+VS5J
	 Hxr+8PGk+yBoRZU9x9h9b0wK5knetX54gST51/O2aYf/LehFOK9f4StPjszCi3aE6uMdZ
	 ofJ8J7fYFh9m4vog3LCgpg/HOiBsg0LW5oaxRa5AJfJl4Bcdo4alFD2G05VsqUJfmifCd
	 9aXSILcKQXRthrcDXgjxGHeruGLfQcF6x5Ibw/ACUVI97krEwl8AsWTHuU8q1f+O1aYaz
	 YOTyPGEIVleBuYLd7gBytzLJ0KrUuOMPXMQF51lWGwgvS/9nvNFhJmpEGAl6wIZ6q+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608417;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4ZNWJ/PVqA7Unu2QlmPXwBTiLGNdMXmik3KB4LNGEMU=;
	b=p93IqOK7eSUpSOkrXzTLtDvGwwThvpVpXfIk0bCTQoXi8I1wWrc245N+j7Aj5AEvdVxm
	 AH0HOGiBUg0bYwCFtN8aI9DgLeWC9+om96C7FCUdau8cfW4P4km/NpzHSYwf3RYcsWN2M
	 fz0ixXbrNdMqvN+GlHKceLtRqwanfFp+HG61ESeg2Zt8yLBc8jD+YPRvxoCP5d5EUgwm+
	 O2pJHfeJGKhNyJ+FK7Bq9joHUPzlKQPbsHzu/7ndWjeGOmIMyfF3/wpKSZqOXM2G1Q+dN
	 WYzKm+La5ahz515ioyswnooz7oKW2O0+53w4UDVH2ikJ9zw9+l9L4nBywF/GsbeOWCg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=k4HGFsrE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790608417;
	bh=4ZNWJ/PVqA7Unu2QlmPXwBTiLGNdMXmik3KB4LNGEMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tMhWoU5bnhjL9sJBjNPYmROWdtxWA4T7DcxGCrOEcXzm6YU8K2S0TS3bkrBJkcz1T
	 MOPnxqmcaokM6iWMhopm82drHJZvWsNpyaE0NhH0uNYgndXOfTER4tobWCwirg9GwP
	 YF8KiW3L0DoMK67h/UfBvlH+t9zbN/43i7SG8WRZhvmETzqiiBO1jOZt5Bi/GgJwe6
	 aZvc3HNeuodaa7H2nSwcjWmKbYa2UyFIsi+W/Ipmo7BFMjiZLWsp8jdmn5By8vIQw4
	 KVNa1TFDK+7oCb7g52KzpTnUS1xrxHEHtJJ23ClxWrKFyybSOgGr72yuh7xczFahCV
	 M/SDmJIQepotg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76C1B40675;
	Mon, 28 Sep 2026 15:13:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 56BC8335
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 18:23:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D5CB40A30
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 18:23:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ef-9Rlk8jbzU for <intel-wired-lan@lists.osuosl.org>;
 Sat, 26 Sep 2026 18:23:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AD01740A2F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:33::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790447015;
 b=RCFUC74RoiKE+Zx/twaPwpPa1THxQ1FHvo14aEpwlZRNY9oE1CQ94GrEYQimA7b7y7tZ
 rgJLQLSdTf9jPPIO/xDIMKhXKxxFnzN6ljGv3GdkKpL8K+YZN7D+NyiAPyLMmL749r0IP
 2qQt3dTam1v4N00N6z/BkPQPyhvq3HL4QiUMeUB+1qcMSNfNTgxg0LGfDIP08nFKyTrMH
 le7ZwkvnVBJDMX7203spQL2OTI+AiZ+IkUZI5abI42Am3hIRvTQDoq/Ak/3WSLZ6PBBH7
 5kYh2Fmp5GgTmGCiuu+ufXlC7hqbqc90BwXTArm2f8VFwZ+0uY5XtGPYq688svPoT+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790447015;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=4ZNWJ/PVqA7Unu2QlmPXwBTiLGNdMXmik3KB4LNGEMU=;
 b=MFn/XRLjFcZGvLvJiii4T9pDbMSbtJ8lladOSxAhebzehzsgMOzCpDDPEmSRCH/oBi3S
 lpM+gE/D0GxNrMLCKOJ3qMB6k6fWFJ89J7A48Kc1VaZK9QvoTZHgR43KUaWR+WpqVGxe5
 1H5cuhxh/hJqog+nMUl/JqsGZQ/3PH6e8Gg/k3vb26JGxiIOHCb5rijcczqFNIw8Nzdfm
 URsWbBqos5aU0lkWO/8AQ/DPf5kYtPEgec2SpRjwIffMqUF5X8Wpo7CiIRJW3SPLAVUFc
 RNBxgVbiDxj6VMdKYJ0lrb2LwgTIJIPs0+POOcZtLTJohloPa0kzY5Lrl8F11XmAM+g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=nebusec.ai; 
 dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256
 header.s=google header.b=k4HGFsrE; 
 arc=none smtp.remote-ip="2607:f8b0:4864:33::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:33::e;
 helo=mail-qv2-x0e.google.com; envelope-from=weir@nebusec.ai;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=nebusec.ai
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256
 header.s=google header.b=k4HGFsrE
Received: from mail-qv2-x0e.google.com (mail-qv2-x0e.google.com
 [IPv6:2607:f8b0:4864:33::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD01740A2F
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 18:23:33 +0000 (UTC)
Received: by mail-qv2-x0e.google.com with SMTP id
 6a1803df08f44-9144f89ce90so4232726d6.0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 11:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nebusec.ai; s=google; t=1790447012; x=1791051812; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4ZNWJ/PVqA7Unu2QlmPXwBTiLGNdMXmik3KB4LNGEMU=;
 b=k4HGFsrEWo+DmRZ+LrwxhU6IY7qDU1EuOycM0kqQ7FNJ1yxOlp1P5DJ4v1iVBGSwbl
 KDwX4wgeOjGXZpRocKY8lhbGj/MzhpP7ml7gBVAIM2zEs7NmdDyiuJTu0g8k6dEHXsF5
 sN9qM0YT/mNR0q8nBqIYyG+ZZ7wM2m/v3b3cTCJZ88dqVD0VBh65BgKAH+knxSzgEAdv
 hhB9PymkoLciqGyJ5gSFHie/h19TB4A+1/ZxNAOC5Ska49z9ReL8hhKr6O0Nx93VYjMI
 ynU6v42hZ7CLaAcEFCKNulixqQnCIi64f1xx5SuuYUZF3gsXVfLy9B6sFBYWTf/jmB6h
 3tEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790447012; x=1791051812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4ZNWJ/PVqA7Unu2QlmPXwBTiLGNdMXmik3KB4LNGEMU=;
 b=L0Rc4QDo0NbVBNRhTG6svw0GcJAglkR1ULNfyKkk4lUN2z5ZxcczyuSZVlZ9LoyfDg
 wm/G7O5vm51o98Gkch8W+YyavM02Bl7r7Zv1Zo6MjISGBUZa59Jlsbz+g/H2H5ilixkn
 JgIc3dyQMC2Eh7OB/5RvMXIBEQly/J5R/qR0o7RO8y7KSj2poJeg0mAc/gQAmMmgH5nF
 bT2ocIg7wXGXQBJClYWuAMKmxP1De6E0KFm1pAplSP/lYvoIVK9fCiCvLeiedEbKWw1P
 y7r8gsj4vlXoG8fUFMRAodjmaIWYuZfU+B+m+pbcTbh7f2/Y412lsZHZRuu9xwi/YaOU
 5oaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1490XtaqF2DZ7ppxdS1lI56Dx9ZiSb99stN8D1R6WDwo42xov68CGcdpHPnjpGjGgW1N2EhwvOCYXi8TCiac=@lists.osuosl.org
X-Gm-Message-State: AFuF++kB/Ig3VEkQXCQrBkUHUmM95VwFkiM1A08F/AMmmj22qpiIFGJp
 KI8U6Tl6n3+Io1H4XNC5mvzZlgpnMuYNe9wzZlCbnQ9b5UtQP90qfC8ncBoCHDZrI89f
X-Gm-Gg: AYBFou1BFaSoKeSEywndILXfLpADitFgMafQ9Mg1fDlW4DEt5c9TCCZxFegrp8GsMFG
 u4G3y+YBTbV5ZYPZX/tAssM99CoBPOB2+mEXhnbledube2sU3Zp2mPPElTjyxN26LsHpGJdyQR3
 Irswgi4GIeU4kwGGvzApUTbPjugZfew7il+nkLV7tB7NVK+hEEVgC1ndkBYbFSt+zqPUWDhWjJS
 MQIVZPB71xv3samNho0mY/lg95dKxLrwrLmLL0gvzQgrg+/k6fykV5bb+cDZRFospSIyVh0twTG
 CMyrBdLgQxWx1K/kclprlfQt2MuzlLY9zEPBfeQwnGvJTTIkz6PSbYVtU26WNcGU0KzmDHwVRom
 76ob5xv4EBj26c6WoX1NREzrjZau89k8CSJ7YMXVhrspmq37gE5d0VbS2o9zqX0uiCBsvlA7Szz
 N/sdGdH0p+sP70rWsHFmaqi0JTMsILBGyBkHEYkMiD44UOkXEv6RUnKY/eIlXZv9CTZepPfyGes
 gnYdmQCN0ZRxzW4gw==
X-Received: by 2002:a05:6214:590f:b0:914:2c1b:7d29 with SMTP id
 6a1803df08f44-91441fdca4fmr70787736d6.6.1790447011987; 
 Sat, 26 Sep 2026 11:23:31 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([202.8.105.119])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91430ec87e3sm43970006d6.47.2026.09.26.11.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 11:23:31 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 lucien.xin@gmail.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jbrandeb@kernel.org, sln@onemain.com,
 fw@strlen.de, petalzu987@gmail.com, weir@nebusec.ai
Subject: [PATCH net v1 1/2] ipv6: reject truncated extension headers in
 ipv6_skip_exthdr()
Date: Sun, 27 Sep 2026 02:23:08 +0800
Message-ID: <f9abb4c3ba2b50f982ddca240012f8a782c9958e.1790082243.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790082243.git.petalzu987@gmail.com>
References: <cover.1790082243.git.petalzu987@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 15:13:34 +0000
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

From: Zixuan Chai <petalzu987@gmail.com>

ipv6_skip_exthdr() derives the length of each extension header from packet
data. When the packet ends before the declared length, it currently
advances the offset past the end of the skb and reports a successful
parse.

Check the remaining skb length before advancing over an extension header.
Handle the resulting -1 in the consumers that use the offset or classify
the first fragment: reject malformed first fragments during IPv6
reassembly, including conntrack reassembly; suppress ICMPv6 replies; and
abort XFRM BEET GSO before updating the transport offset.

Update the helper comment to describe the -1 failure result.

Fixes: 25a44ae93d1a ("esp6: support ipv6 nexthdrs process for beet gso segment")
Fixes: 6f297068a069 ("esp4: support ipv6 nexthdrs process for beet gso segment")
Cc: stable@vger.kernel.org
Reported-by: Florian Westphal <fw@strlen.de>
Closes: https://lore.kernel.org/netfilter-devel/aq1HaYS96SNn7HJY@strlen.de/
Assisted-by: LLM
Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 include/net/ipv6_frag.h |  4 +++-
 net/ipv4/esp4_offload.c |  8 ++++++--
 net/ipv6/esp6_offload.c |  8 ++++++--
 net/ipv6/exthdrs_core.c | 14 +++++++-------
 net/ipv6/icmp.c         |  2 +-
 5 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/include/net/ipv6_frag.h b/include/net/ipv6_frag.h
index 41d9fc6965f9..5616f6e7428d 100644
--- a/include/net/ipv6_frag.h
+++ b/include/net/ipv6_frag.h
@@ -125,7 +125,9 @@ ipv6frag_thdr_truncated(struct sk_buff *skb, int start, u8 *nexthdrp)
 	int offset;
 
 	offset = ipv6_skip_exthdr(skb, start, &nexthdr, &frag_off);
-	if (offset < 0 || (frag_off & htons(IP6_OFFSET)))
+	if (offset < 0)
+		return true;
+	if (frag_off & htons(IP6_OFFSET))
 		return false;
 	switch (nexthdr) {
 	case NEXTHDR_TCP:
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index abd77162f5e7..a29e79a8b924 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -168,10 +168,14 @@ static struct sk_buff *xfrm4_beet_gso_segment(struct xfrm_state *x,
 			skb->transport_header -= IPV4_BEET_PHMAXLEN;
 		}
 	} else {
 		__be16 frag;
+		int offset;
 
-		skb->transport_header +=
-			ipv6_skip_exthdr(skb, 0, &proto, &frag);
+		offset = ipv6_skip_exthdr(skb, 0, &proto, &frag);
+		if (offset < 0)
+			return ERR_PTR(-EINVAL);
+
+		skb->transport_header += offset;
 		if (proto == IPPROTO_TCP)
 			skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4;
 	}
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 22895521a57d..2fbf6f567a50 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -210,10 +210,14 @@ static struct sk_buff *xfrm6_beet_gso_segment(struct xfrm_state *x,
 		if (proto == IPPROTO_TCP)
 			skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV6;
 	} else {
 		__be16 frag;
+		int offset;
 
-		skb->transport_header +=
-			ipv6_skip_exthdr(skb, 0, &proto, &frag);
+		offset = ipv6_skip_exthdr(skb, 0, &proto, &frag);
+		if (offset < 0)
+			return ERR_PTR(-EINVAL);
+
+		skb->transport_header += offset;
 	}
 
 	if (proto == IPPROTO_IPIP)
diff --git a/net/ipv6/exthdrs_core.c b/net/ipv6/exthdrs_core.c
index 4a9748338cf4..60e20036c1bd 100644
--- a/net/ipv6/exthdrs_core.c
+++ b/net/ipv6/exthdrs_core.c
@@ -48,15 +48,12 @@ EXPORT_SYMBOL(ipv6_ext_hdr);
  * "nexthdrp" initially points to some place,
  * where type of the first header can be found.
  *
- * It skips all well-known exthdrs, and returns pointer to the start
- * of unparsable area i.e. the first header with unknown type.
+ * It skips all well-known exthdrs, and returns the offset of the start
+ * of the first header with an unknown type.
  * If it is not NULL *nexthdr is updated by type/protocol of this header.
  *
- * NOTES: - if packet terminated with NEXTHDR_NONE it returns NULL.
- *        - it may return pointer pointing beyond end of packet,
- *	    if the last recognized header is truncated in the middle.
- *        - if packet is truncated, so that all parsed headers are skipped,
- *	    it returns NULL.
+ * NOTES: - if packet terminates with NEXTHDR_NONE or is truncated while
+ *          skipping extension headers, it returns -1.
  *	  - First fragment header is skipped, not-first ones
  *	    are considered as unparsable.
  *	  - Reports the offset field of the final fragment header so it is
@@ -107,6 +104,9 @@ int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
 		else
 			hdrlen = ipv6_optlen(hp);
 
+		if (skb->len - start < hdrlen)
+			return -1;
+
 		nexthdr = hp->nexthdr;
 		start += hdrlen;
 	}
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index a95b0351824f..8896ac90343e 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -145,7 +145,7 @@ static bool is_ineligible(const struct sk_buff *skb)
 
 	ptr = ipv6_skip_exthdr(skb, ptr, &nexthdr, &frag_off);
 	if (ptr < 0)
-		return false;
+		return true;
 	if (nexthdr == IPPROTO_ICMPV6) {
 		u8 _type, *tp;
 		tp = skb_header_pointer(skb,
-- 
2.34.1
