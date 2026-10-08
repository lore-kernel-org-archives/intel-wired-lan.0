Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD34CA6017
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 21:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 655956087E;
	Thu,  8 Oct 2026 21:03:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WWW9PfacSMeZ; Thu,  8 Oct 2026 21:03:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D063F60872
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791493408;
	b=nycfJ/p3GddGcpCQNdZg9sR07tzCvCCaMO7ML9EVsg8c4lO9O8J77XXZEDnUim8CvePh
	 tomNCAqcC41UNdZu42ibfKIqXTOilr+zrXlcJE8GqVNeuZc6DyD07ao96uCLt7MuY+1oo
	 jGyzIKMhfMYUWSUx6G2zIMt3sv6mggaxrLa+yinuL/C3kgQX31HKX72dTgESv+CDsD2cd
	 G655jGwAwmpg/ptoGq71tZ3d78ViZn9YNP6kD3Q3zRjjPpAGEf/mdfYswWV2pGyKtaVEv
	 e4lCxAnqsQ+1MNo9u8pj8M9NHPuwYKesY+cD3Vxu/mKkviVbZeL0Mow7LcgQQlmBU+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791493408;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=a3FpKl0vN7petfzZgqIhlc2NP9KQ4OIDsR/ta4Cqq6o=;
	b=G5IOtu8KOtD6oOqUuEtPrMiPzi6TvoThIVFPmJQT88ceBmbooEnj2968CsFrXE2EFtkW
	 Bo6oICp3RVZqlRMjWPu6t6U8xNdkScgTaweEl9aSsIFbI+bQk4xB0UUEqfqHJTnR5tmqX
	 sTOrqqsjY/PPLD1qL9eiSCLddILdeRHqF1QG9Gvc1CkZKNxcTiVdDBAF90vEFE77tCOBI
	 vNJrBqQQB8i6pOIllyu7b3uULKuk98R+fu6vvIFzVGs6Rlrkn0nAQ7+6jltL0SCqJDL47
	 g/Rv4yaCVvUeDrdNzncGDOzIrjZBgueoko9NNo3AOwf+hsQu6pnANgld7kILk7DjOfw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791493408;
	bh=a3FpKl0vN7petfzZgqIhlc2NP9KQ4OIDsR/ta4Cqq6o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gwPz13pFXEj44RR+CwOHhph9NF7AURUQYBB4rsKnnVOI8ijdKRa1/gkcKI3C/ISNF
	 QoroNaoGKXCk4Bd4QMKhV2zNQgc0a3IHt7GGk928l2Gj8kjQ2DYexk+7VlktmzREAm
	 rBZ01f4h/enZ85KeSN5dI6ql/nqLWpBOGlftntkWewTEah4RCm4StTMvVroQW/dcQ/
	 pRZVwIDFu+z2X6viBrWXg1rEpy701vn/3UbienK2RNqA5Jkno5SRae0BhrvceATZsi
	 Jnv9eTuhQLgy0ps1lOwMorl9zrbYzGkA3rf5ouAFNks7NPpTsCggYJgw6ERZp/tZH4
	 HdvuwjDavDNaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D063F60872;
	Thu,  8 Oct 2026 21:03:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F02A7356
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E227E4032E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5muDzf8jxf43 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 21:03:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EFF13400CB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::731"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791493406;
 b=fEmm3y/mUMXh0Pl+tgKyW7sghpVwTHt+Xcr3X1EPoYM0IIZGl34eMeeA6JD27c3b82N+
 NL4uQ4eT9PvUNsCd7V6vlFMubmhnk9uG0Uewir13u/aCGhVMtGQ4bxMoGSzMxbK8HoYcx
 30VwBd7xaEFZc/v7x92g6MYAK/283YIpbTS0SYd3cCrXJ5RxEG5NqCgAgXkC9hDNQVoww
 6irXEbzvJzM3WRyZzH0xtYUMWFFd27KC95WUFkRyLOVO8eIhLzq2w9mOOs82xCcIfhh8s
 wAd3R3pV5jKGVFWHA2WXTuIKgP+x8aNsuaq0Pj8/PvOcg7U8ZFhCaHpzZLfToPHTLUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791493406;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=a3FpKl0vN7petfzZgqIhlc2NP9KQ4OIDsR/ta4Cqq6o=;
 b=mZLfxAtJt87SaIlJtDi4eo0sqWp1+DdDQirnBlvzHstAERS62yk+9tRFNHH+n1/7HKY9
 bBK0ZthwVvBjzbOvI+pbPakpBZM1lffN+HjK2tsyZzvc835S95uaChJmAinb8p13bSTjE
 4ARLvLO0/Bf8NL4ivUcO8y1RO5AFHXzV2IGPEKOERxI2RzNF2V14z3ZzE1Okzf6GUDJM8
 pBxcoAI71vI5ZMD1g9QC760S1049awXLM4PZYQYImRovNIDWeFbzcRKeOSRk7g97iqgHU
 obHt8iUzhxWdmpiF3ywx9xqDoAmJTXLl2SJKA+YyVFEKqZAbPUmF6qWc9we3tn35ZJA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=toxicpanda.com;
 dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256
 header.s=google header.b=bW1wByXn; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::731"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::731; helo=mail-qk1-x731.google.com;
 envelope-from=josef@toxicpanda.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=toxicpanda.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com
 header.a=rsa-sha256 header.s=google header.b=bW1wByXn
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EFF13400CB
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:25 +0000 (UTC)
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-93e55db58cfso502626385a.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 08 Oct 2026 14:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda.com; s=google; t=1791493404; x=1792098204; darn=lists.osuosl.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a3FpKl0vN7petfzZgqIhlc2NP9KQ4OIDsR/ta4Cqq6o=;
 b=bW1wByXn3wl9jXk0LtmJDfjuPHlLTpFncrWz4wkKRA8QvuLjn+53xkFoKBEHEQrCMK
 4EDppTkCf5uTVVBiPavY/Ae9Vu1IF1xKujZIqVUiSJgS3ngO5xXkNaPkJa8qdQCyP9+A
 y/Lul+3YWq6TmFOl897de/O8mcKYjsJb6b78FkMiVumNhKUV3OhEYu8vn5eGD7QFjNJi
 E8702Lf/ix/1TYbXEoLzh2MyYA+u8AJYujf4hEFBGfcSQ60fmi2g0I2uLxIqJXbRBNOL
 ZtddZLVXjFcyCtf+bT6eNHi/bh5wXC8nydGm3Yrwimg+3qullov+hQCLr57IqoP8qct6
 OSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493404; x=1792098204;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a3FpKl0vN7petfzZgqIhlc2NP9KQ4OIDsR/ta4Cqq6o=;
 b=DAA2W+s0NOgCrcEXAPRLgWGzdF1XeSWMMcnrbYfy2ktBYeAy41kJaUYoPMZumCMhvG
 P0u70BHqrdkyC9OVNtG5Rnt14ORDr4bKZjdHGcjU5P4E+FuSyqJcv3oYC3FBzX1gJ2cE
 qL/uoOQ4ACMbdAbZA++CxSHva+/zyaca50DQgWV0nI0r2Z5uTDRzUmK7YCuZTIEgtZ12
 7lYqXcFQ3VGH3n4/LpBXCoWB0NUFFPI6OJr0e7nZpBvWP8cWp3M+h2FZl4X+UIWcjC/2
 kphh7Ro+8VFydz6ugoBEklsw9MyD4kt6b4K7AL4uP9Vtq8JCJ2Vira2yGwAC7socwF9r
 iA7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJbM2fcqNZYUMwKaXTrBpRmmyyyJ7RW1+qbqj/696WzNIYg3oC0YtFZB0vgIFHicKRAL/aR785qXUyAZP15is=@lists.osuosl.org
X-Gm-Message-State: AFuF++ksXFrshtKzKRcmRoTjGqjM9HaTBwvqcQfiX7a42GktxKP7KO28
 Xp4S9P89nPjMdhp5PndUViqxXl/cKLWGyOMdCVlGdblwBeCNJXUMfU813gDRjE+ta/o=
X-Gm-Gg: AYBFou2HO/+S0zy8gvulxStGruRz0hip7lcMUMtLpCt6OybLr3l0O9KFRivK3GC4dxE
 cHvDvRhFYjAruu/JB7pw+DHzGoLgLld20fJIzliLChiKyusamvoMagnvAMLewAuFyKBdtSlPg+V
 fXxKXvo52nw3CE6OQwRLpLpukANarOnHhnfBnu1OsWxxqAPYHPejX8yFfF/UebGn8HuPGV1uFe0
 7jgj0TQ4Oug7TmA99T/p0BiMvQdelaNLTTTvYpzsgEX+EZVAntIFApQXF6Q8Kg2UTlFMdsynxKk
 qBy9abgUEZ541CLTYYVU3XSRT1Dfuua3qoxJ7NtP/AEBRwjxZtvYOT5tZLRfD6l9x/aOP0cFyqs
 mdjxujb/zkqEw+1EpZsIGxyoSnPufluCVHRBNAd6gs1oKCdscHc1SDyl/6u5M4gfKivz3/aQxG9
 GDv79un9RjqWShHWjcxyHprefgcjXSOv5q359DpLsAZde7POrWPtgxDykzK+5GM0lZMmHuB40g+
 74r2VEZLW13AcQpMryBJv2plA==
X-Received: by 2002:a05:620a:29c7:b0:93b:beb3:5898 with SMTP id
 af79cd13be357-93e9b807709mr1263365385a.49.1791493403829; 
 Thu, 08 Oct 2026 14:03:23 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93eb9724fd1sm26327885a.1.2026.10.08.14.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 14:03:22 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 08 Oct 2026 21:02:49 +0000
Subject: [PATCH net-next v2 02/10] net: ftmac100: check for failure when
 pulling in the RX header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-b4-pskb-pull-tail-drivers-v2-2-8f2bd9bee138@toxicpanda.com>
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
In-Reply-To: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Manish Chopra <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>, 
 GR-Linux-NIC-Dev@marvell.com, Shahed Shaikh <shshaikh@marvell.com>, 
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 xen-devel@lists.xenproject.org, intel-wired-lan@lists.osuosl.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791493384; l=1745;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=YaVSidg1Bo1cVWoGQJzV4z/nBT+SLxbK+9NmCYkL+oY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKPRKOQSDQ67QodM++vQrU2bAaf9t1GHfgEbAcRMIyyvBlr3tTyXLKb7mAyGosVPXukX94UmJf/
 pTxPq3ZQboAQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA
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

ftmac100_rx_packet() uses __pskb_pull_tail() to pull either the
Ethernet header or, for small frames, the whole frame into the skb
head, and ignores the return value.  If that pull ever failed,
eth_type_trans() would find less than ETH_HLEN in the head and BUG()
in __skb_pull().

It doesn't fail today because the skb is freshly allocated, isn't
shared and has room in the head, but that's only true because of how
this driver allocates.  Use pskb_may_pull() for the header and
__skb_linearize() for small frames, which is what the two pulls are
doing, and drop the frame if either fails.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/ethernet/faraday/ftmac100.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftmac100.c b/drivers/net/ethernet/faraday/ftmac100.c
index 40ba001d4b3f..a1eb04ead2d8 100644
--- a/drivers/net/ethernet/faraday/ftmac100.c
+++ b/drivers/net/ethernet/faraday/ftmac100.c
@@ -469,15 +469,21 @@ static bool ftmac100_rx_packet(struct ftmac100 *priv, int *processed)
 	if (length > 128) {
 		skb->truesize += PAGE_SIZE;
 		/* We pull the minimum amount into linear part */
-		__pskb_pull_tail(skb, ETH_HLEN);
+		ret = pskb_may_pull(skb, ETH_HLEN);
 	} else {
 		/* Small frames are copied into linear part to free one page */
-		__pskb_pull_tail(skb, length);
+		ret = !__skb_linearize(skb);
 	}
 	ftmac100_alloc_rx_page(priv, rxdes, GFP_ATOMIC);
 
 	ftmac100_rx_pointer_advance(priv);
 
+	if (unlikely(!ret)) {
+		netdev->stats.rx_dropped++;
+		kfree_skb(skb);
+		return true;
+	}
+
 	skb->protocol = eth_type_trans(skb, netdev);
 
 	netdev->stats.rx_packets++;

-- 
2.55.0

