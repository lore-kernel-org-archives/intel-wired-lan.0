Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96149CA6019
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 21:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52C014092A;
	Thu,  8 Oct 2026 21:03:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cKrXh6auQYZs; Thu,  8 Oct 2026 21:03:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AD6FE4087F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791493412;
	b=dQh2EjzbFFmVy+y3yY0yjyGEZeNgV2BAkt24ot1JDRYg+rPhxKjnl6TSf6fVrXIzXUnd
	 zjT0tS+tLG5ksocv6JEe1dvm5WrqK9BNOyn+yvhVV9aIF16ly/bz2B1wlLn93jaYpxTYg
	 9KvHQ2Ut6utY1DofLn2o+ErEgXff8WqNznUWvu6CybwFmEbDjd7HZliVq8qiuam0SJpwF
	 WhNwL9cvpxUAUnV63IrK5Ek5GhSD0Ayxm8MHfHOjc9G0FjBt4ds4rO9g5nlGw5NvqpTXC
	 PjwX7AMopQTVFyTIdSAv5OEEmcoqmC7to0xR7LcmRDQ88MZc0F6uuK0MDGanxaaFg2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791493412;
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
	bh=J9GuqCKMi/hN2ncI5Ot6sRINUqKwZdItx3f86TmeMcg=;
	b=JHaw4twUVODeEiiIwvT+Qi1PkNlL+F12v2D9SS/o8Kq0QUfloPAytCw5Eb5bv58v1GHA
	 eAap6hBgn8avZ4Hx333S/ptbz54rzAZDyXM7Xwcx+J8OkDHgml2BBfZwv3Y0E8eus6ntD
	 5JYoU5oqmyk4TZT9pwhdAE6OmIp87fLcBa14FYs7zB8XK0SZ4/UH6TSjKgYzdmnNjhMrK
	 NcDxInNmfNYf3m1TVago6/kkaObVTzWkm9PeQvkxp1E3NvutcZZ6HoQFhQ7SgdfoJaGgV
	 SiCCygwueKhOR+2Ejzb2xOJ53NUSG9xCWUVHX2LBh4Jt/UUQ0INnPOfy6MKcbv9tJug==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=bb1XDWCx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791493412;
	bh=J9GuqCKMi/hN2ncI5Ot6sRINUqKwZdItx3f86TmeMcg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n4MbnM+9fyMSA1NRcZYKqEfDguIIsL8nShChzeSNdDVcZKLLvGpUducEitaKgy/V0
	 GsSaz0zo3JEW67TKFB4Rj5+TQ/yaBIAzPCQGZgtlQ61uQQlnXHpxZ3tY9ljYBykCek
	 Xx0no8BRhxoA/PaxWt0o5EKHIzgQODXduCmeoG7IWqnC1RP5wvxsQnZOj9C3+4wdQ5
	 TwVboQYG0ebrF2hcwZj1yD5rGRTqaEfKEC5nK0wMqnnlWGsd+6hF74t5CdHOXF0JZQ
	 LYlboIMeqlVoEg3BHN+7dX8Zl8kxxBE/rIAXQkvMCK3lBPgAQz/+8AZTh+9DmVcVo5
	 /yK5p0Yg746gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD6FE4087F;
	Thu,  8 Oct 2026 21:03:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 28D6C356
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1AAEE40923
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d6W6FkyRKnKy for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 21:03:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 595984087F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::731"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791493410;
 b=UvYN3XXD+uQpFvynmSqeHGU9cALz0bUZWcAgj/hsu2lQZEN2S6TippBQIPHIlNTGcrlI
 iZLRHKGdgSe+4928KeGbJqedg/T3uS3wstO58tz/WxPmWKdVCAKsIcTxnST1FLRiw0j6T
 one3yj8w4RAfMb8WyPZKmx2F2as0UYS0jC5Ly/krgcPdptEKgAgVJ3/CYLzi8h1zaJ86r
 7m1h2TjwLjM6Z0hMaplAT7hAoflfpvs7jJpyNFX3UbXSDsgilchhjcpCAHhag7ad3QOrP
 Iz0as7MLMbC7vmnOrB7da6Q+obWCNW5Jed3hvUZciV9TpwBnUTFj3YaK/56Fv0P/DQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791493410;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=J9GuqCKMi/hN2ncI5Ot6sRINUqKwZdItx3f86TmeMcg=;
 b=oqC3l+jTL/0aa9vhb+HGFE5FIjffcjYOwkbFLJ3x6Pp5goTy81Mwk34PX9PqeviJWRPG
 Rdd/Pg8HFBqjwBez2IX7nYC0xcIuNeMrtWtxAKsz8BnxmjWDfWjxI7SNN83Ok68nVEoIL
 eKX5C1+z73TST90cJ+McyqVaPPJ2HE9QpdXZp0VihrqCVF/E4S71gQyyLU8M9aCsAGmay
 wNP6JKl3KNNr6HjoO9344GLtszknR7twSng6Iigv2mC1bsvQLBYg0d2VD7M+p0kzJf7VL
 LnCdnsuQCvAyJ/Cd29oSalvbD+BTEyE6wftl+IU0g7yo3W5fZzRvuQgN6mn189a7glg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=toxicpanda.com;
 dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256
 header.s=google header.b=bb1XDWCx; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::731"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::731; helo=mail-qk1-x731.google.com;
 envelope-from=josef@toxicpanda.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=toxicpanda.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com
 header.a=rsa-sha256 header.s=google header.b=bb1XDWCx
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 595984087F
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:29 +0000 (UTC)
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-93e4e37788cso299207385a.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 08 Oct 2026 14:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda.com; s=google; t=1791493409; x=1792098209; darn=lists.osuosl.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J9GuqCKMi/hN2ncI5Ot6sRINUqKwZdItx3f86TmeMcg=;
 b=bb1XDWCxlpbcC5iizOPoafWaJdZ9RLBcTFPtmCeNtOoaudOKRql7pJaE1g1gU+l38x
 hzTjh+C2lZ74BoAwnoQlktATc8RaawOAOD26YQMVWF8K/mXecnkbBiAjrHuvKMnM92LH
 zauTqkbMk8LBElLAwvSKJ78cR1MJ0+VLp61w9zdVVWSfNlpheNlaEqKiHZrc5radGR73
 zkgIfhIO3GUCeN+2riXdW8Nr5GQksgayM9BbKJv+gF2JwWfTi15Z+HvrskUdlrYTMG9Y
 rkwYEYqYkXUGGlLUqJUaCfon7Nxo7xpOaAVRpDRO+F8qDAXQ03bKPp+/MV1YBloG6KC8
 iRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493409; x=1792098209;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J9GuqCKMi/hN2ncI5Ot6sRINUqKwZdItx3f86TmeMcg=;
 b=VguguaBH6j28o7omFQSrb2NpLQEJvCrvH7Ir51Jj8PrkuU/h75SWe7vPt4BcdMjbJB
 1BDBIQw211IXVap0B7b4ef6e78Na2Mvd6HcN72lf+NZaecj/5JSieAJ3dK2gTj9eBK9L
 S1qbYNr8s9VjeLX+9TaqrHuC4qE5HuMVSTq55UNdp5gqCXJJhTdhrHKhrEN65mroP11t
 QexQsJ7sYo3FvrMeBNrR8B1lBl4/Fe+KEj96sC2Y5Msd74xOZPMfqKgNLyB8Jp/ViUMX
 PCrKPhwny2nDflpzOSMxH+dmiPcIgY/qGvE3DQDpWn5reftCHjG0GzCmNzkm3UMR5P29
 f20w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGxIAUX9lJSFH9Wr5aWrSBW0psb47EJOHJzV3/3Pzy+IOhBryXFzha1zOOF4+WStjgAVn7F0GmNyu8wzHkNk8=@lists.osuosl.org
X-Gm-Message-State: AFq9FYJze5/vS0A4rDhrB0dbSe1+vMHM9l3wPa9y3VXN4ww0cLV2vlzj
 nV4aMNU2CTA/q6kSLfYc3ece1dhgP56gKrxAQk82O8x7he8lVFnYXUXtTikNUgpCt44=
X-Gm-Gg: AYBFou01nK/DyJHL8e1TK98VgQevikxUkfalki91aStMGfJevjNxwZ7Nc59P3rwKM80
 nTOBDA1DPkfFlWX/f4hxODXlqNhiW22kJGPzndsBYcKEs54GugFYB1fEU90QI7hfJbI4Z1UGl5n
 uoim5CTD4hrByFDXV0Hm1kvw13te/Bs0jvflQoFzSoX6pbvorYY0RIvJsLmvCE1OB1HJJuIaNmA
 Lk6/JwEswzEqkqeIuvlkXVFkBgt3UqH+m3JfVjsRVtxtQTRcrjgjSrciZtvr0MHymROoJ1Lrhat
 JHh1PYBnWgMU46p+i7fYNfboHnWppSwYYGHP23dX+nEWKg70mn0zt4AZi3qUsQYTLtSu5QjWmgv
 2HgzyUFsBVS76AydCFZKn6iQMkN2jZUkXe4yhc0wfQQV35j8lW3B9bHOd5xhKeRIHPrrped0Y8y
 CUNZ4wxIq+TR3WCNGeOsz6yORtdgrlAm3vfjn5n/p9+kJoSr95ia3SEFtlmAnrkq413CB446ZjS
 ni4Rt9qogQZk1s=
X-Received: by 2002:a05:620a:29c7:b0:93a:2a59:3377 with SMTP id
 af79cd13be357-93e9b799671mr1358007485a.41.1791493405607; 
 Thu, 08 Oct 2026 14:03:25 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.246])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93eb98c818esm23024485a.36.2026.10.08.14.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 14:03:25 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 08 Oct 2026 21:02:50 +0000
Subject: [PATCH net-next v2 03/10] net/mlx5e: check for failure when
 pulling the Ethernet header after XDP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-b4-pskb-pull-tail-drivers-v2-3-8f2bd9bee138@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791493384; l=1491;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=zznhnNGgkEt9ZSSy2T9PlgogR6INn8I/GpUQzjq8ahE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFaj9m1MCb6yydGhkDduTFS5Q4Ekj/GXk/66W/KuEGtH8miGll+pKUls7h6lvdP0A6+k8X0JuWF
 J9s3G82EktQ0=
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

When an XDP program leaves less than ETH_HLEN in the linear part of a
multi-buffer packet, mlx5e_skb_from_cqe_mpwrq_nonlinear() pulls the rest
of the Ethernet header in from the frags with __pskb_pull_tail() and
ignores the return value.  If that pull fails, eth_type_trans() later
finds less than ETH_HLEN in the head and BUG()s in __skb_pull().

Use pskb_may_pull() instead and drop the packet if it fails.  Pulling
min(ETH_HLEN, skb->len) keeps today's behaviour for a frame shorter
than an Ethernet header.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index e3f915beebe1..b1e1e30a77e2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2060,9 +2060,12 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 				pagep->frags++;
 			while (++pagep < frag_page);
 
-			if (len < ETH_HLEN)
-				__pskb_pull_tail(skb, min(ETH_HLEN - len,
-							  skb->data_len));
+			if (len < ETH_HLEN &&
+			    !pskb_may_pull(skb, min(ETH_HLEN, skb->len))) {
+				rq->stats->buff_alloc_err++;
+				dev_kfree_skb_any(skb);
+				return NULL;
+			}
 		}
 	} else {
 		if (xdp_buff_has_frags(&mxbuf->xdp)) {

-- 
2.55.0

