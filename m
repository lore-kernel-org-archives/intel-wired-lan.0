Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBC6CA6016
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 21:03:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FDEE40921;
	Thu,  8 Oct 2026 21:03:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OqMOjPnbNOV6; Thu,  8 Oct 2026 21:03:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E174F4092A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791493418;
	b=een2QOn5J22/u9gHh5SMwEEwvcCx+l0A/6PXDGsfjhqLTu8ZUmV4lnnChIsSp4t2i0bM
	 UyxZhfi1T6mIy+1NfIyEPOeohV7CmpaDJxVgzy0n/CMQ5wCu0QP0z2WUWg4zCv+W/Ge3L
	 jdTZ9WcFu5pQumvipxh6ks3G67YFAjuCqT9Z41wvtFhNWsGLIInleUomfE8nZGMuZQTNJ
	 ZS5YyCX0hT1PtH4vX6ntUwwpvtRMBXjG4Ie8ONtcqxpTuVzP6an4JMvlZhA/Hw6SejNhc
	 W/qsJyKd1Zz6CdOSUk1/9+97C3ZB5nNAw7L4NoNdrlRw9yXVbjCT9ySjH2yuMv5yA4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791493418;
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
	bh=jXT5xqnUz/gqqG3F9wxnjnCJ7kPBk+m9Im3cz1NP6m0=;
	b=i5QNgRiz3DX4ou8iT4uJ9PHlL83ebjxjXBTA7udUnOMOcGXD64pvuNnyco5NljEFfzsx
	 si6OQGt9eWmCMZZTGX931+jwG8ATAgHPNJHHkj+TliJs5w7FGPGIVMWQp/dhZmhs2Lovq
	 0FLNdcoo1UupXN3bcSs51IY+lHNjDeYolDCMnRxj/h09ZK8KAZILq3ODmr8JAjbur5q20
	 bxRlaUdQmQdm5Eaqq1bITRvqmTzR87n2iHwf7XoYopOToiBPmTnZvs3nuSHaJo1lEwbsj
	 PXMqJXstHK723v4UarSH6fM+57qSpUccp3Zbnveqg5vFOPUlNMm/0hqPd4/cKbOj3xg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=k+EbU3X6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791493417;
	bh=jXT5xqnUz/gqqG3F9wxnjnCJ7kPBk+m9Im3cz1NP6m0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M4vc8X2XhPTzmty5/C9pZM1eNbOWLR72UcvRi6qs9HUXbEvNDsu9X0cxQt9uFYxLX
	 8V6QYvsSPVqee9/xvmKIF2PN0QsmouVQCCbiS34P+MLkGWiZg61ng5YfnYku19cE5J
	 C/8sNYnf5aquDs2JetbrnJBGQWghETCiwkvhH8EFWeajJGYwiDb676SI+DoadO0Vcb
	 18o/rymNwnPLJQxH/7SO0onGjP6FjNc5pKMzQTT0rBsDpRrVaPegc+aE4dpEUlGn5b
	 6pz8p8smUyC2QKV0tLJ+KKmhTcrfCPqhnKvj+KAwqNMUUwgfIlmm9c7pg2q5ZHGmKQ
	 29hGlU/AJ/j2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E174F4092A;
	Thu,  8 Oct 2026 21:03:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 36B50356
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1C2DF40911
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iS_hb4QWOrAf for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 21:03:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3515B40932
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791493415;
 b=NN5Ff82e6FxzAODB/VFr8Efyg1mMw6JIdDDcQtRavEx6zSPF9t0PvBDtvwM7us0Bxr7F
 V5w0M5RmHtxsiNV1oMpU1IO2hqifp0/erU4XPpejHJ1DdHFMwWb73HlZXNS9C5MptJoVu
 zkRY2Wg0O3ZumaF8HLOnjCvztQYCrni125b4Mbory4V+/IlsIw8bU4ZtholTifwk1S8Hx
 vP4f25Z2TGluVnnR62HT+fgDSIHKDU1Amey0pbIOKBaGmfzL43h5ls95vF8IH7WUReTVy
 65BEstIIYMja9wDbSg5VEmMQimFdBN0azXwmY7oM65Dw+tZzqtLeQ510GproTB5ixvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791493415;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=jXT5xqnUz/gqqG3F9wxnjnCJ7kPBk+m9Im3cz1NP6m0=;
 b=TqX0mY0tgJT0GcHombXhR3Mkoj43cc6RHSwCEfGri2hOJMXZBLONOfVJSESXqQoy9Z9P
 j0stiLgK4ujS86boW1bQzw2K+xPulqYfQP0UHSj3OrxeE7HiN34dVVNj1ZmUA5h5hUTVH
 rQb+DEh34/cG1FJSKsLTjyfOYSQgb4GbIrymg0mG/mm4tKqYi5oF8NbeFgWlaiS4n0MLq
 xxzupIThwOHAeQgiWSFo06N0fgllnVu9160m2U2fMF1GIIOQ3nvd6XZNZ6Vn0liuPEEMd
 Ohx7qdGENRdrkzNC7FAdHUDO93j1li0EERC88z8fPioX+6jgI0sezRTlC31Gy56IElQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=toxicpanda.com;
 dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256
 header.s=google header.b=k+EbU3X6; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com;
 envelope-from=josef@toxicpanda.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=toxicpanda.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com
 header.a=rsa-sha256 header.s=google header.b=k+EbU3X6
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3515B40932
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:34 +0000 (UTC)
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-533972e0cccso34166751cf.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 08 Oct 2026 14:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda.com; s=google; t=1791493413; x=1792098213; darn=lists.osuosl.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jXT5xqnUz/gqqG3F9wxnjnCJ7kPBk+m9Im3cz1NP6m0=;
 b=k+EbU3X6CihMb+uVgDTvDyVMe1FzlplKgCYS+OFWYrSBsshEpvWeBN3GxP2Ol2XRbi
 y1clgLjZPDONAQzJDvmn2tsoW0ULdO49NwZUb0RxmzCu0MgGf9fobPmSdX6BHgCJ+RmJ
 YDo5ObMN10NPSnPq4yidp11A/oE6OsagWy9yQJHcM6+7oZO3ybp52Gaf6RWfojMmY9v8
 5fzJPkVvba1CC0XJgorT5l/MdJ3RpwdTT15U2GKRPkEwz+eP5t8onP/2YNJfaQ6RGfMq
 5SrPeEO5RdcZF6W2ruqSnq+KWNY00iIDUtEGV84aDNo/5qJ0stGMviELa9Nf67r1u9GM
 HxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493413; x=1792098213;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jXT5xqnUz/gqqG3F9wxnjnCJ7kPBk+m9Im3cz1NP6m0=;
 b=hl8yh43urF3944xjOF/V/ThWZn8ab7pCr5iUzeg4LF8F41fHeBDfcBBud5MYxuP/Y6
 EUQFPnSt7zZTEMPcBdLxtJjdSnVwFfk5Rexq/vqaPCsypVnLO4ElX6lvxy0IBC8e0rFz
 7TcXZVKMjLsbWeVFA+7V8OG7rOS271qQoPyF7Zp5BOZewy4DQ4/LbP44nAxErMI3Pkb5
 XRPOi3XNbistcn/QfXk5D6YxhLRCZdIZ/VT5VssuNhDbXkTVcIt54WMwoaMitwwHR2/E
 mJAUYzG2Dz2/CUAdUvli5w3rm6gJGrQxzWPiY20+HNJwuzDwvo89Qe4KlV2V6pRv5v7T
 3ysw==
X-Forwarded-Encrypted: i=1;
 AKwUvByBnaawqjCWOaA2mLy3ifEXhF0KvCwK37SrJIDfUMWDNeCFaEvh/N0c+kpCYs1HOCA9XJ3neTsDV60N2bP/JOU=@lists.osuosl.org
X-Gm-Message-State: AFuF++nH2ASlM+MsLrU4Ko45WhCikY1JQT/HwIEdlkG5zth/xAUyrY6N
 EURmBW3azzSM1EXfpmsWKDks0vVRSa6/mTWR21s+ofkquXxptZZ3/3oS/AojW+DEDdQ=
X-Gm-Gg: AYBFou25CUU4VgU4OzFe8s0n4vz3B75WUaGsugehykK9RdGqBqBOMQ/rTD6CR3KwNne
 tj6IJ5OAhZR0FDUAfP94fztvtSJBSma+sp1QHHhHhw5v6GZ5sx3AUK+Jm3p6szRtj+vg2G1183n
 i24yu91JPmrnfPYEDW/Nskp2H8hFJkedhQoesh9fArZFcysrXAfcoGmjnoQkuLajcixDrcsC7bJ
 Sq0NwLPKpAdG5mdiVPew9+0n00TW9Gg5egt/bRJyfenIfThqeNLA27XMZf3xY4vImSL2/Mt1vkp
 GbTC9xOAK56KLnsLmVXa/VCUf+hhja2cmQWQt1cfE5/XxTS1LW1mWimk6afFIfYdVesELfLbfV3
 2+mGR94CG4jq2nuJweGBJVHe7l8NFDKF6Bih6vk7cStyRX3yK4jTLRAIY4SnBDQiD/w/HXzLbwK
 KiK4krxjAxyDpxMb9JXMBBm2h8izq0cTRebCgQCalvZrcjYhF/hgkIzEpJSmm626KpOgV8sJ8IV
 LsHACC4BJSl094=
X-Received: by 2002:a05:622a:1a91:b0:535:70c4:9a94 with SMTP id
 d75a77b69052e-535757c8eecmr123953171cf.74.1791493413537; 
 Thu, 08 Oct 2026 14:03:33 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.246])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b46dda0sm3472151cf.4.2026.10.08.14.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 14:03:32 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 08 Oct 2026 21:02:52 +0000
Subject: [PATCH net-next v2 05/10] xen/netfront: check for failure when
 pulling in xennet_fill_frags()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-b4-pskb-pull-tail-drivers-v2-5-8f2bd9bee138@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791493385; l=2516;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=eg6ZiA9VrIpAG1HGYjPkKMEWwjo8D3VwigBhj0jOQMI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAYzg3nASJLuLmRvMNvnGKJmwP15K/QJrV/X+gIw+dmiWX6S/LgMrQ8OB+kIWHKPWdMQHYgaFiD
 sh9Hj7FexRAU=
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

When the skb already has MAX_SKB_FRAGS frags, xennet_fill_frags() calls
__pskb_pull_tail() to free up a frag slot.  That frees slots in two
ways: it pulls the start of the packet into the head, and it releases
empty frags, even when there's nothing left to pull.  The second part
is what commit d81c5054a5d1 ("xen/netfront: tolerate frags with no
data") relies on.  The return value is ignored, which works out only
because the nr_frags check right after it drops the packet if no slot
was freed.

Use pskb_may_pull() followed by skb_drop_empty_frags(), and take the
error path explicitly if either fails.  pskb_may_pull() does nothing if
the head already holds pull_to bytes, so the BUG_ON() for pull_to <
skb_headlen(skb), which protected the subtraction, can go.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/xen-netfront.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 2ed673649c48..007fa3bbc9e6 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1174,18 +1174,15 @@ static int xennet_fill_frags(struct netfront_queue *queue,
 
 		RING_COPY_RESPONSE(&queue->rx, ++cons, &rx);
 
-		if (skb_shinfo(skb)->nr_frags == MAX_SKB_FRAGS) {
-			unsigned int pull_to = NETFRONT_SKB_CB(skb)->pull_to;
-
-			BUG_ON(pull_to < skb_headlen(skb));
-			__pskb_pull_tail(skb, pull_to - skb_headlen(skb));
-		}
-		if (unlikely(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS)) {
-			xennet_set_rx_rsp_cons(queue,
-					       ++cons + skb_queue_len(list));
-			kfree_skb(nskb);
-			return -ENOENT;
-		}
+		/* Out of frag slots: pull the start of the packet into the
+		 * head and drop empty frags to make room.
+		 */
+		if (skb_shinfo(skb)->nr_frags == MAX_SKB_FRAGS &&
+		    unlikely(!pskb_may_pull(skb, NETFRONT_SKB_CB(skb)->pull_to) ||
+			     skb_drop_empty_frags(skb, GFP_ATOMIC)))
+			goto err;
+		if (unlikely(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS))
+			goto err;
 
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 				skb_frag_page(nfrag),
@@ -1198,6 +1195,11 @@ static int xennet_fill_frags(struct netfront_queue *queue,
 	xennet_set_rx_rsp_cons(queue, cons);
 
 	return 0;
+
+err:
+	xennet_set_rx_rsp_cons(queue, ++cons + skb_queue_len(list));
+	kfree_skb(nskb);
+	return -ENOENT;
 }
 
 static int checksum_setup(struct net_device *dev, struct sk_buff *skb)

-- 
2.55.0

