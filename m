Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBBACA6012
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 15:27:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6DA8B4070F;
	Thu,  8 Oct 2026 15:27:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xKOFnfvcr_ee; Thu,  8 Oct 2026 15:27:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C978A40704
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791473249;
	b=VyB9VVgK0HnHgx3nQtO2DJDS+GM2xuNMvHWo/ogNjTrK51QFee0jYOAnlhTab1Kv4a+r
	 lScFyx2YaSPmtw5/sgXhFL9uCcpHfGqFuUlocU9/WG9+F96wq9MHxjNruJZwQSXdk0Nk2
	 +V2Vay1z1DsjM75US5R+PExpV/YLYaTYNi8vEyCf9AgFFQZd39cw6ezpD3q1oZtpcuSeE
	 L7WZpQr67QV/nl0h9QfrHWl+uR3fB2KGE1/YFPDDPdbfgDqEj4wNdprb3N+bq6h3bo0p8
	 UrF7+ZYTcOgFVW49OAI0bW+tOKu2Kj+n7ua+t33BzEVTI1llw7NjY9cl3d1VujYXYqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791473249;
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
	bh=HlPhbKKLwkJ8jfy0wR1jO0OPJAX2t4fwgDWWxi6hd3M=;
	b=mMAoEqkxinxONn2P1eQ4Uov/i/V33lt/0OnR306SbUhcb3smTXl8qzcBjE4FG6O+VAsn
	 sbujp0809MIvEYnbuqufLwO7oCLNG5ZFvs7GXcHp17ELobGd5WkIdPuhzad4+zoWuZMVr
	 mLiWvNmCigDOCbb6BhIuJXvruZ2S4fws4LMfb9rkuV7oxnzmrO+9uooW0tITU2w2BwlRX
	 Sdi6hiMHQL37zWI7HIqqhAmQfojQgX33UWkAQeG6EUWMxGS6q7+iCIoLrQDYbYpw+Ip8R
	 XedYrcItE6EQABW+1o+vGx8YP0RLf+3hYoYO8FhBWW9dY0YnKqpP8wiomZ16YOGcN3A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791473249;
	bh=HlPhbKKLwkJ8jfy0wR1jO0OPJAX2t4fwgDWWxi6hd3M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kwWs2vzxtH0hlAwpD3BbufCftKf5MXmKDjELeTN8T6KbEO0b6OqJMydXEy8rVTQeg
	 OL5YHhFB8WZ5ep2ZA4eTs/RCgLLNZtTSjH26e1a21shL59laSXBu958eYCfh/O0FRf
	 GdQ5LZ2vnom2iRazuUynSR3ZPMUIwCNb9pOrvwZZung3jjjhhx2ntNyQeZhVqX0x56
	 s3YM75H6qYvFAezcv4SLinv+n/FKbtFUd1EQAFu9MIfz6SEMxOA08dViK9BivKP45B
	 jcbZflc1s/RrVja9VXgjTyN/TXwyl0wLd+Sm0tgwZ3cElYtzsV1jRYNu9OefmzVgSw
	 kFuhrCH/osvbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C978A40704;
	Thu,  8 Oct 2026 15:27:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C7CAC2B2
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B9DDB810B7
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eEoJD-MSCJds for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 18:16:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0702180E26
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791397009;
 b=qQ3rWgce3xUUaya6gR415R4CemH+UGhWd/olqstLWTDp/lT3HwkAFQsyGviI1Ll1QIQH
 jhxIDAOvIRswAZICLTVtOBGZHID7ckQrFelaARq64SON+KwZOHEX/Ehvrz8WcDsRAaY3F
 0RHbar3dqws89xeWqHBhqk89RN+xD7IpM+34xNhLXzXl5DfA7a+868hkTSEP5iA85B2Em
 Q+q+99TY+UCJKiNHQzIzyen3HBSotQYA79pEf/N0covXY3oqR3a7ZIZ8bQRVVH1MOEwQF
 Cly8L+PG5E+Zwa58KKzR2r6qB3G0T7QX1R2HAk2Th2bMtRNEo3T53oCrkHO9iNGbs9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791397009;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=HlPhbKKLwkJ8jfy0wR1jO0OPJAX2t4fwgDWWxi6hd3M=;
 b=WhLH4mC3auhAsIAeU/Ol8jRHwN64V4oikgiYpkmNixDg4Yg9px8Q3NuF7KgOjMCntMVA
 iGTA0KlZXci37YewfAhDMdVrM9x4rmJDVpx1EkstGajS+0kgEfn9dKOaehSR7S2hNAJw9
 v9S1YHKIZ5IAkhBEl7J5Jx8p4z4mZIN71cvsIF1DlO+ZBVJ4EFDYzuiLCb4uXZdgC3/C7
 AvvDJgtAxtd8rTJw+anAn6IEKzGytHeM4Sq82Aygmw6bDln7cbeKEGJ8o/rty9liL4ccr
 ZaZV1VDTzEnSonR03KMbHIA9TdGfPV0bulJ2PFmRfZF06x/ylrF81g3dI2qLClwYKrA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=toxicpanda.com; 
 dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256
 header.s=google header.b=C4Ss8MYe; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82d; helo=mail-qt1-x82d.google.com;
 envelope-from=josef@toxicpanda.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=toxicpanda.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com
 header.a=rsa-sha256 header.s=google header.b=C4Ss8MYe
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0702180E26
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:47 +0000 (UTC)
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-5338c1197easo35627951cf.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 07 Oct 2026 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda.com; s=google; t=1791397006; x=1792001806; darn=lists.osuosl.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HlPhbKKLwkJ8jfy0wR1jO0OPJAX2t4fwgDWWxi6hd3M=;
 b=C4Ss8MYewcPWiNMa4fvV9FM2eyroivAu9Z05NxbokxI5grekM/ygcPfUGrFjFiJGWv
 Xpf0x+P72G38jtn5XHvhf0EjLDbQNLeDZZyjKvSwIjMMFKVLI11Wf2MxzOc7WF9iaNOi
 SDImPr5ewm2zSagaVOFOl385QGQ/CjAyr/Wn/qnKWTgYlqrng04q0swXJ/1dfAQ0WcGz
 dVksXBR3ESET45k7pklKFoeSJV4TZ5lMTbRNQPvyKWRnuwj2EUlJKo45xreWaPRc+vKQ
 a0nG8q+hFV2Q3bn6/bLul42hGlVT2CzEASlUlE2o6A6mM+gk9wbOy8ptoh+e65hwvsxP
 wMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791397006; x=1792001806;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HlPhbKKLwkJ8jfy0wR1jO0OPJAX2t4fwgDWWxi6hd3M=;
 b=ojAUT5/C9olPYo21fmy7CUWGjPy4I60XCESrXa+L2eC8Ygn5ayVdAOTIb0QoolZ3Iw
 Mb/u8R9QjfpVTOn0yUIAMPJ4JBTwXHNMKBJLNbpSZpPJjoKSqW7wXSUiiT3DGaAsXKPH
 B79qxCaEaUMdkXuAhoIn+nzuH2YYjG89/n410AKfjHIf8UHfxQ3nNYpqSiqOsSht3zuF
 GyBF+ozuZ7bWstbB+/7CefME3ORU6vdyciYf/+cS70R1+r/3wxoGE+TmjypjXLueWySb
 qCPHcnscDAaC27N9UT7bIXg2N59Z1gc+jTT9SeKO+KupT9dX1ZZVeW37wQnP/QDi9YT7
 eVJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxyrPK90kB6rYQ35eP2V962L5HPWpACw50e6qIedgrMj1fDEnxY6+9YnS/dh8dcuezU1xtp5NzMuBU48eXtE7s=@lists.osuosl.org
X-Gm-Message-State: AFuF++nOJR789bodp9kXHx4qVIqlBWEi9eaeQMhVfTSlSHBtGwS0vbB4
 QPZf7/A07p0h0Yi0fsW4u6A2mBjqjB/8KU5C4ysiGWX7HsdtPbkEDhKswFIDtdfEClQ=
X-Gm-Gg: AYBFou23wGcbw6+Jva2z/+aDMKxGB0pMV8S5Z0jgwZicqpi3J1LU1i3KKU/74vj14sU
 Si+3l93ezL4ARwCBU31SFGmMLz+yDkMFVKPtic7Pe2D8WHjRhIVSGkYxafrFaXrzds65JTzhNZX
 mMa4QFIPqLF5ag1pkud73e5JXv5doNJHPaarxhq9IKklY5EXBmxrVcYBOgKyOl1Ta8hs87zjoeQ
 GL6H305b4fcpxb1d2LPmayg8Y93X9gzFeIask5nAPmSYO2ensaBZSjECM/jqf84rqieUGQL7G7M
 dsEHBw1sEPgWzwbb10pMHgn3HpNtD8bMOK9d2iVop0fPjPPbVaeXkI0OKxgf7P+nTFPXOMFdWQn
 rcuqghpHm59f/RqZkqC8j7mf7PHyyQ+Cwr588lxdLsPyxaClxxOepcjN1/1tMjg6+UyzcX9+87g
 nKb05x6C8s7gaQzE+9CYoF3fbiKN8c+RhnWc8rImWhay2Eg5mJfOG62JOD9sQUeDONmhFG7QP7j
 qYyBdmDYI0Gwsc=
X-Received: by 2002:a05:622a:4106:b0:533:3d48:37f0 with SMTP id
 d75a77b69052e-53575555c86mr50817771cf.47.1791397006325; 
 Wed, 07 Oct 2026 11:16:46 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53572103ae6sm26011521cf.15.2026.10.07.11.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:16:45 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 18:16:20 +0000
Subject: [PATCH net-next 7/9] netxen: use pskb_may_pull() to pull excess TX
 frags into the head
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-pskb-pull-tail-drivers-v1-7-9512b0fb977b@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791396985; l=1110;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=McO8YjXlypOeoX4QkYeNrhdO3XuQh8G3BcccmslsJYQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEER6Cf6YiSeQas1SDvrXyD48BT2JMKt5v+EgNKlM2X9W7DYLscC2uLR/v/alcS1X9KdG7G/jh6
 TE0kjRM5PRAc=
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

netxen_nic_xmit_frame() pulls the frags that don't fit in a TX
descriptor into the head with __pskb_pull_tail().  It already checks
the result.  Switch to pskb_may_pull(), which takes the length the head
should end up with and checks it against the skb, so this driver no
longer calls __pskb_pull_tail() directly.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
index 67d9bf69f8f2..202deb64ddef 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
@@ -2045,7 +2045,7 @@ netxen_nic_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 			delta += skb_frag_size(frag);
 		}
 
-		if (!__pskb_pull_tail(skb, delta))
+		if (!pskb_may_pull(skb, skb_headlen(skb) + delta))
 			goto drop_packet;
 
 		frag_count = 1 + skb_shinfo(skb)->nr_frags;

-- 
2.55.0

