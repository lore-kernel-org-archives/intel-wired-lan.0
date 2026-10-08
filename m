Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECA6CA6017
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 21:03:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73C1B40923;
	Thu,  8 Oct 2026 21:03:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dLCoSDmaxpca; Thu,  8 Oct 2026 21:03:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C0EE740933
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791493423;
	b=tNbyc3gcatpThO4T28QoMWaj4hmVZ3PKt8RCiSsW13Z/4R7k8LBnqXmd4JP5UD4VCj2l
	 qyWrrQtDvq/tO33H+QabYZ+KEL62zKOQGbDaShy9aE1Tr/Le/itGlfUa1ryfc16CLCMwz
	 +aV4Xr6MUjEqAWDvYLg0cZw3uMBMlBH4PAobxRWyb1iMnkE3zoIqr9tdpUJqLKXxaAZD2
	 us/c4+t35Ky/U6OG0wDMrFgOrkRe21xJrufwoOstHOxD1ufOruCX1TmHv26eFQc3UkzJe
	 PN7oOG5ORf5eQivdraCiI8JNmAO/49LWJrnpVCVEBcvlXY76XyECkG0DfYBHZl7Whtw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791493423;
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
	bh=hz4PLreF7SMRfFt85q6B38gbUo5+Y+8z8sLQb0vICiM=;
	b=NrwEBL7fklKmHfD8AcCPWpDecsimwD1lQHWL7nQCpFIAE4BU4elSu4pxKVvUFvp0hfKj
	 1MzU8kz5KUZWzp6ownYyFDl46Ce5cbhqiNr6VDoZhB6g5Wq/I5xOL0yatds8+oNNlnFW0
	 IAOd1XbjHKrmPtyD/lPePHNDzZU3VaNQoOZqyyy4iq/7fqviuTjaz3zdHCwEDiDXxQgcf
	 n7whUEK1FEcIDTWEVPpYIUyMtcSDOwCGcXhthEfA76VqpsQ+y3EdTgHhNZ0pGVARiz4ly
	 i4ea6xLipCAnTMMrCoV9jo6i0/tTP/uI95CUb2TZG62CeiHBooZW73Vx9qsDsWHkO4Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791493423;
	bh=hz4PLreF7SMRfFt85q6B38gbUo5+Y+8z8sLQb0vICiM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SSQPIu32mjll1D+KwYq5bEKU6I6hCAJUHNA7y6GGUF5ejLVCr6ttVep64HIZUPOl7
	 IULlrrzqT7VUPS10spM8MhhDOgRLfsb1wti8ZvIbRtOkHx/UUwom5uJBWKSbviLXPz
	 DKJHcxr6GB6AJ2cpuPwtR5ssEm3Bdpw+m0keeyHQWC987c2/EyL1yyVUVO3yUeo3O3
	 2El6cjVuImvKL84bdu2MnIoL3R57+D7BmJpYw9OZYn9NPveCvWL8oLC84OQqcPojeh
	 i02IBvt6JlGkrPDZhAU+v27H4nSA21ItiIwl5fZXH/5gfEMHIl4Bxk/EvWgLCIcCRq
	 wTymgdXJBLLig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0EE740933;
	Thu,  8 Oct 2026 21:03:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B029356
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30DAE6084A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id od4-JDcsW8RT for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 21:03:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 612F660808
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f32"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791493421;
 b=ggzAgcaasWsxU1BGDGCa7ElWbZK4ON4WMFcLdFkjA94FKw5xh1/G2sMY5zlz273vixci
 Ch/6WLU3jfhlweRRanLSANBLM9oMGX7OLesD6FXf5xKeFo0Ka0Tele353skA6JV76r+7t
 +q0hrw+oRYS2D7raNdVVQgAdNifBscnfQ1GlRnH60Qn6b7VFhYPnCLO/LNMJZNa8NbJCI
 5Fo1v/sOUaa4ham0yMEBdhNXgyK7g4U20zl0STMW8lBBsHugB2HPaRtZO9REaCs1XniNo
 Y7Uyo42huEwfSFKhD26qWbvybaSO58fMbIGvvCShrKM9mE37fsxVB4FMINxTHou+g1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791493421;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=hz4PLreF7SMRfFt85q6B38gbUo5+Y+8z8sLQb0vICiM=;
 b=r8GrfKzet1knd2vWpavRrNdab5m9TyLxZ4uU3LttzOJHxXLYLLObw38VdL8uCz3aoNrZ
 amPgztoCTD1LwovLKR+4Rlt3Gxv0yBFIB4CONFPK/qv7182oa8od24vnbZih/ZDfz15GI
 uINw+QJZc0Nf4Fe3XKs+efN4EHN/Q86uumUHrC0eFmMyb/u9RehjVacp3ROkmgdkdQs9R
 iadZ8fGt0Pj1ZUG3OQ104RXeLIIEzHMswJYsu4VWYnku3EICJFIjewxcU9XsvzAJHf/dX
 JVPe0UCVekWibToPRxrOtgm4L7qpVLalGC7DxgzDAnCm+jZ7akdOwcfLGWRIXk3m9wA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=toxicpanda.com;
 dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256
 header.s=google header.b=FXhamsJq; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com;
 envelope-from=josef@toxicpanda.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=toxicpanda.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com
 header.a=rsa-sha256 header.s=google header.b=FXhamsJq
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 612F660808
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:41 +0000 (UTC)
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-91957ec418cso44542096d6.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 08 Oct 2026 14:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda.com; s=google; t=1791493420; x=1792098220; darn=lists.osuosl.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hz4PLreF7SMRfFt85q6B38gbUo5+Y+8z8sLQb0vICiM=;
 b=FXhamsJqRiU36Usvzvz67dXaaTM9DYOcY3+qPuc44RP2YhywKcfzJ/8G6AvVqmiHTJ
 WW9vXca1xaPG30qmOTdzv0z2qed5kBCTHzGK8nCAozutkZplmnXFRuljrLJwYIzEHwUO
 7HR/XSmaCI09IDHrvDqZeACQML4+o0NTvn+2+qw5um3eb+d+Nu0wtg+uGvLmk+RGhDpn
 TFVploY5EUwebM5eKusgCB3HLz7W+mePNO+lUSWcxtGOUoL/yew5c4kQOnGqPFSKBnEU
 GRmD2jVD45llIm78PzPSvOaEK859FKpdd/LRhOcJufeV1A2t+ca6gShSeQKMULsmFQlS
 o15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493420; x=1792098220;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hz4PLreF7SMRfFt85q6B38gbUo5+Y+8z8sLQb0vICiM=;
 b=xymo88BWoAkJn9QmKsWQvXyG0qZ3vFjOnSFawd7J6aPru5195YK0e9mbWy1PNScQRK
 oUPrkiLHmF+eaVGN3WHW32KaGw4WCmTjlOqrS+iUN9rkeW/P+sa1kzjTWrRs5hWEEEL0
 LBw4xmRyicGfkMifKhJGwcVsQ58FyFR3CzAPd/14GXtlP8vbEgqv6x1NwWgG7z3GV9YP
 DWLS0qt9hr+7TrDMmLbAw/DIRXOFj1oTVd6xKxZrRpCSfkdl1O7/5J6GLGexLgIy7/ZZ
 TyidvSgJt4NzQfFq8f3v7p5qC+yDkcd9k1IlVLRVMEMpn1X9lM1/bbbvRPvva6eiYL3j
 yaUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTRb+IxnnOkegMBY5g41nQJEOquqs6Xmo1hJpb37Gm++uOjCNyNdbCXVtYlW3RsQbROzqrVvVoVcMNq3724lg=@lists.osuosl.org
X-Gm-Message-State: AFq9FYJGGdl0kGOtMeV21ofSSIfm2SKWAyI4ZFMPTlnnK7Hy8Q+uAdnU
 Jf87XaBD7ppQE/3H7tdh6geEJGMHqz6D9dJCyEE1a9o+NZN7Sdr3Yz9/0cGaGBRQeMQ=
X-Gm-Gg: AYBFou11LZtEgkv8F02wm8ObFe5SivbGD9dK8mocjPpYeWnGulqU91OT4MnAaQQ1t6d
 g2F/Vf3qdXeuxtQEVU+DMtwAp+FsksiKaR3lRrKDAYWW0lOTEdcV+GwcZ4snuhoxTNsdzCbZFqB
 fFvxtzGwXm8hzrfjaCY2GnBUzFokJuCQUIApAAVwuipY0lgwZV0+yItvihahRrXmFYt64x7X6yO
 it1VgO67fRFeujzOFYlk6s9P31cfbPpS6tHddN7QPEFQszkNY+Fp33ExeOzZ7gMCBNGBKl+l9uo
 4qOtys8P3zkOd/5iThj4tEEhL7IDLbnP2+ak5AqrexGjSWYwtmB2ojkPy467O1fTXx3JPuEOwnv
 GnK16z6U+MUsPpNXxyZGITqqIGCWZ74V5fZ9S336R83TvgYqYOkM/TZUPJV0DXVQd3cUkzudK8S
 x+DEEDnBYI6bwtjWJN+MZnYyDFrlvu6bhg0AiW1fkFPj72fC4O9mzRTdNzGfdn63tKMTO7qBiDT
 wB/EogGTOEsYGw=
X-Received: by 2002:a05:6214:2b86:b0:919:952e:588d with SMTP id
 6a1803df08f44-919978d6737mr122288916d6.56.1791493419767; 
 Thu, 08 Oct 2026 14:03:39 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.249])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b550ce8a5sm77746d6.40.2026.10.08.14.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 14:03:39 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 08 Oct 2026 21:02:55 +0000
Subject: [PATCH net-next v2 08/10] netxen: use pskb_may_pull() to pull
 excess TX frags into the head
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-b4-pskb-pull-tail-drivers-v2-8-8f2bd9bee138@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791493385; l=1424;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=2MH/LzfAfYyw21+HKj408easdoK7+Tc42GivpUT/gq0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKxQbKwa+3oPMIR9/8wstf89TfYBkXylWZ+7HP6SNMiYKVAMjbRgDk4LveZCkr1O9fxCwKO82Xi
 ZBjyd9+CX/ww=
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

netxen_nic_xmit_frame() pulls the frags that don't fit in a TX
descriptor into the head with __pskb_pull_tail().  It already checks the
result.  Switch to pskb_may_pull(), which takes the length the head
should end up with and checks it against the skb, so this driver no
longer calls __pskb_pull_tail() directly.

__pskb_pull_tail() also releases empty frags, even when there's nothing
to pull, so if the frags being pulled are all empty it still gets the
frag count under the limit.  pskb_may_pull() returns early in that case,
so follow it with skb_drop_empty_frags().

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
index 67d9bf69f8f2..f5f89ed87d95 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
@@ -2045,7 +2045,8 @@ netxen_nic_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 			delta += skb_frag_size(frag);
 		}
 
-		if (!__pskb_pull_tail(skb, delta))
+		if (!pskb_may_pull(skb, skb_headlen(skb) + delta) ||
+		    skb_drop_empty_frags(skb, GFP_ATOMIC))
 			goto drop_packet;
 
 		frag_count = 1 + skb_shinfo(skb)->nr_frags;

-- 
2.55.0

