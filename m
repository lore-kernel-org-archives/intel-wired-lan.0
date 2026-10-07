Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5CDCA6012
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 15:27:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7762360BC0;
	Thu,  8 Oct 2026 15:27:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tx1sG2QNr9MY; Thu,  8 Oct 2026 15:27:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D62EC60BB6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791473245;
	b=pc8whsJ/oLQ6JizDuc7YiPm4nbzPut0+eoXHnebMSHRNOCj2coA13s7gutcbcmEwB+wA
	 MtK367GK/XE2SngYVj8g3bZOO257x2RRsHpcVd6GAGqYnscoDb+rbpdA0E3LA6SMxrip8
	 +KCkKzr/WSpvm37iUvMMhTCfcAbD7a4xWMb8FCJTr49YPmvsnygG5/nQsqGLEVeNc7fW0
	 +IvARJWjuGf8Nvbq+goLCSzo5CZ7+kdURtkpr9yhXAFBy/f/PjWUKtBINMBp2Y/TOQYM4
	 R+7N5V+QwzMCT7mow/y3eOPVu00JUXxXojvzY2qLBtaPr4vov8iMEkNzHcJCAgYOP8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791473245;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=blrnvRK83a0BrC00ZsKjSLnGbEsSK17m6K1yrBXm/SE=;
	b=lHmJNwjgo69C2Cs1ujUcEiDNf1iSNxNzdqmAOOoEPr4PlU9QPWqSIASINKgipvsafLrC
	 S90V5utSmBb+hqyX26v+x/GZSpSLvwcu1QSNHZjUt5l0Sma+7oRSGi9+w7yfo8Ez56uOI
	 42abV5Q79nlUwdWxJevQiUSQLdkZ4rS7AUu/76C9qec82BuwQrBHOCwXHryR1wIfibI+K
	 tQ2UGYI3XXel+rSIEuLu7/MRyCEiMcywrMRiZscluhXjA7f+Uphr9ZZa2J2EMgtuIsLGx
	 wgYvrPDkgYhBBhuVBD9dgow2Xln+KR79WXse82xhP35X+MvjWnggyf+jOP57+uEM5TA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791473245;
	bh=blrnvRK83a0BrC00ZsKjSLnGbEsSK17m6K1yrBXm/SE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dA4apa5Q4G2tDB6H6TTDebMlTwFTMajLXp7vsxBrC3KnbverOcJSW5gBWHliPGNM8
	 FyF/kbINvuyQkb4uyj9DCeIwigZHujsZpEP6i6kCjs6UZuxRuhhYJIpCDcNt6rbX3W
	 jZYcHV9tfX+qKaxJZxibKwlEd1ZtD5Pn0o0MbCIF6JsetsDAuDAsU1zIpyZygpZsUR
	 FQuBdLW/pYTd6oMVguLGDUVn4lGWHcdOImnJ+tlDCZpqmRs87IWm4YZmWHDaHMuMPD
	 1zJJlHyXET/SkTJcTkr6h1fQ70RPFKu+ynq9uBkRFsTakbNrk2UChN0uSc++y9vagY
	 OtwEwxcLpYhIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D62EC60BB6;
	Thu,  8 Oct 2026 15:27:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9649932F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 937F1810B7
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nfJoG9abgtJT for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 18:16:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B9B6F80E26
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791397003;
 b=E18IOOSkDMYbxfdPVZvDsRN6YsNVUcbLw+/eKVD+YSFmgVMK/ObBejA3et/Vte6oaA3V
 NZmaNLLmv/ChNCm2CmrYf9L5G0P8shTeaQbv9DAL2jLt5bP3vMXC18uDD+dqBHJAHSlzD
 l6JcjJK13ohZ9+rv5J51lD5ozwTVWipxxPWUIII4FSozxH10F38wj/IYpUA0peyMY6mGW
 YSZsuewSLLFVZOWnPmOGPNg7bVslzGjiG6PyvZ+gNkzWZrjPDNZqlPm4npi1t419nfWBp
 f9OP9Wdp5ic+EtbsS0C+/zLGXocq14hVT+BJTgPhMxaiNvxL80XRtF+7anZRciRzAZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791397003;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=blrnvRK83a0BrC00ZsKjSLnGbEsSK17m6K1yrBXm/SE=;
 b=qMhdBn1aNXuauFv4BzaJk2CprZ6n/51kXxeteBSaaqksIjcFR/i0MUXmgbri7fYYNPjf
 IS6lO/SY3WEaDUgqrcEXxEHWamwT4yaqizUSVzVUsh3SBvm7Bypw2AfcqtKmf8QEzY+L4
 AI/DNGkMo/ypE2RLccMfYKrdDe3pVpKVqmy6PkgotM7p1/uuh1ghWGLuauYRuqguXs7QS
 4cC2OSdK/IMs5QKND2sT+BL1dCShSvO4o/GkQmxNWmZPVNjUIr73AWNNA+QRvoLpwZk7r
 vNvuxhK5Yu71Fe0O+HLaRpkpZ1eeVJ5nS1HLOYbfdRu7OWj4oRTzxkyhfyghdgW9dxA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=toxicpanda.com; 
 dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256
 header.s=google header.b=SJKGB7kT; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com;
 envelope-from=josef@toxicpanda.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=toxicpanda.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com
 header.a=rsa-sha256 header.s=google header.b=SJKGB7kT
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B9B6F80E26
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:41 +0000 (UTC)
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-5351d76e1baso34581521cf.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 07 Oct 2026 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda.com; s=google; t=1791397001; x=1792001801; darn=lists.osuosl.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=blrnvRK83a0BrC00ZsKjSLnGbEsSK17m6K1yrBXm/SE=;
 b=SJKGB7kTMCikN9vj5Lgi5e2l6JeoLqUYUhJhDV/cESRBmbfIOUTSYrgJrttyFT77I+
 vp+XIiPD9IBG0MmdBydmHPrLYKIA+Ex1/Howf1KJjRRHjOoCYZaoklWgzpUuQJEC1upQ
 +wArhHHtTwqYCXRm2804RJu9aexgHiGvKzL+kV8fov4pgOfRX6GrZEaVYuVSNvLGa+HJ
 WeUwBBKskCBj9QDWJJuop4XOpO6i3gVGHXNpc6CZ5hsXRUQjZvwvE2mM8j8Qr12k3lvP
 VjFW5f/BPHrCUssGUUQhlBONgZXeAWqky7riIbVq3XwMOKQBdxENkZ2Vjb92LgDCX4YT
 JBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791397001; x=1792001801;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=blrnvRK83a0BrC00ZsKjSLnGbEsSK17m6K1yrBXm/SE=;
 b=Tv8Dg82+0905EOciosvLozOZULhQKfp1npOw5GcvzHkdn6bx2G/kjo9d0k8xoLA135
 fV2Hcxfbbl5CjHuXrAB5+T2J14lhko/c55HgtZAQCY6C0oJIjVDI0/5WvKmbR50CYc1e
 4cMp4s3pHJ1XrB9WCeDiryBgZ12SRHPC2LAxk2j5nprzmmPTkcR80igx6mPcrrYrZA/2
 BO3ow+UWmeNtA3Q7k/IMfWvj3j1jqkVtvaJl/XgicsqbYK4a/qwoeIBM/8pM03FOE4nX
 6QzZcb6nzWvcUCsenmv2owXLJiNEsIwufNzTOKd9WetiApjzAnGfnRnyednJMdRgvs3B
 xQww==
X-Forwarded-Encrypted: i=1;
 AKwUvBzx1OtoxPGxEhcE/M1H7FKP8Num2/hngg83RNyS8lVh95mzNo2De9OutebSIy88uD+3cNBtwNI6UcA3P1ZgW7s=@lists.osuosl.org
X-Gm-Message-State: AFuF++nSSnIB8U7X130bUDdJIvCQs+3TTegkdKudhZNK+jZJnbtDhX15
 WxdkGbF4k/i5aOLEo7Ul0GKKXc66PYXczMjtKD13CfoPwaw4gHCF4Q9YDdZDdt4HGR8=
X-Gm-Gg: AYBFou11nx1JrXa1tnSUL+9zzGorud2EB5epST+elx0BeQ4jZCBGMpxWrpeCmqd6IuD
 milh1xYEB0wBn0BmwyEZHqTobX65LbpfW6grJadFsoEvKMjoNl9VUnA38OZ8CCgmQK67z6QsAq9
 TcOb1JqLmAI9b97fEtnZrcJhTAhGPJHDHGY7vH2NTp6GajWnyhS4jENvrnpoM5KPDmvRBdd+w4E
 0/HoLdG45J74Gr8zHVKwa8aSqHTwsYesd9vfkOptepMPBX/rU+ny5Run79WKlS/zDyL4e7bo1sd
 XWNxD6/OfHxuZHsPiFUbcpuLdLPoO1cy8kuE563FqcosmpMHnx4AD0JfS2UUwoODT03Qk9c6bBX
 aSgOTTLaqo3iRs3rTzSmuevZLNyP7IWz1Q053nd4WfI3hjNHddvTZ/l4vk3YMkr6vpX+kFr1pMY
 1Csqse94xqfq1whkYtvt1RrZFT56nRAKbdFnOOsDGlAKsrdyKSPdcnubyQwm3dhtjYLWVTHy240
 geKn/KbfnN4+Mk3jwwo9Y40xQ==
X-Received: by 2002:ac8:59d2:0:b0:535:1740:d334 with SMTP id
 d75a77b69052e-53575201aa2mr52033281cf.3.1791396998937; 
 Wed, 07 Oct 2026 11:16:38 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.252])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-535720ea17csm25632781cf.12.2026.10.07.11.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:16:38 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 18:16:16 +0000
Subject: [PATCH net-next 3/9] net: niu: check for failure when pulling in
 the RX header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-pskb-pull-tail-drivers-v1-3-9512b0fb977b@toxicpanda.com>
References: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
In-Reply-To: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791396985; l=1236;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=3f5WzTjnDsDOAnT0hR8gZXIWFT9KoT8c/AVMjDx6NOM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPE8F38TpAIjOskJy1CfHBTawvG2+Cdej+o6C6KckWCrmqZc3RT77tIgX51AS0sYEQy/f1nhpBP
 sPFJm2+lltwI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA
X-Mailman-Approved-At: Thu, 08 Oct 2026 15:27:22 +0000
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

niu_process_rx_pkt() uses __pskb_pull_tail() to pull the hardware RX
header and the Ethernet header into the skb head, and ignores the
return value.  If that pull failed, the skb_pull() of the RX header
right after it would BUG() in __skb_pull().

It doesn't fail today because the skb is freshly allocated, isn't
shared and has room in the head.  Use pskb_may_pull() anyway and drop
the packet if it fails, rather than depending on that.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/ethernet/sun/niu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index c74a97fe5464..d1c0e868004d 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -3488,7 +3488,11 @@ static int niu_process_rx_pkt(struct napi_struct *napi, struct niu *np,
 
 	len += sizeof(*rh);
 	len = min_t(int, len, sizeof(*rh) + VLAN_ETH_HLEN);
-	__pskb_pull_tail(skb, len);
+	if (unlikely(!pskb_may_pull(skb, len))) {
+		rp->rx_dropped++;
+		kfree_skb(skb);
+		return num_rcr;
+	}
 
 	rh = (struct rx_pkt_hdr1 *) skb->data;
 	if (np->dev->features & NETIF_F_RXHASH)

-- 
2.55.0

