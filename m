Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BD3CA6007
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 15:27:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81A5440637;
	Thu,  8 Oct 2026 15:27:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qtlK6khZrQuK; Thu,  8 Oct 2026 15:27:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E9DAA4060E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791473248;
	b=PvJTiVz9vgPLRa5gQF5GJeM/yW+8kl9v1SbY3/czvwigGIlWhIgYfX28M+1soAt2i1Uu
	 WGKCY2rOKGRuzXv2Sj1vFWKAL+h+PJExb6NY2YofdsNy+b02Py6d8NgagT/BbUxfzshIC
	 EjrdFkITpzewmPseTVwtCuGQBiWyk07+MENNdDLKACNJ3v2egfezy2ml1bKjYMPV4MQl9
	 TmZy4OnD7V5bxjQLXD5fpgpcheqjLHFgXltKQKzcGQlUaCrTz2WP66OnWQIz1BvQaK7M/
	 fOAe8adBMsUJ3lxRM7Vo10zz9msrl7cKx8fyQAVKiLe89HJAHBRPKUu7WSd7wFEKCZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791473248;
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
	bh=jtyJNESs2NfaCrmwRAvvPnxlfOHCunirXFuek+zM5MM=;
	b=LaWkOLqv8nNj+8Z4o4IT3EOH9INsVaVF2/zh2phiS43uSCExvlhroP9jnlCWjVO/5w5x
	 TINMiXEQ8TqEA6oZUryPXUG40gaBl7SAtD6nuKnkJxU96LIz0w2S1kAIs0JvAJH1whFk1
	 gq+sPa1Mik7SFmXBzE6NHEHB8eLxtngxOYvVEgMuQ+S0D/UWsSKVaPeWktwNj//pNb4jV
	 hxDSUJIt3ysOjwbZVY9sNC0zQsVWkhkN9XpZ1+NroGak8a4XAgPundMifpZLm8eC2FZgg
	 pEf5nJvybqlN6fNqx0BwXUAX9zoN+U9Hjoyq0yod/ltQqjvmXu04xT3rJuIeEwLUScQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791473248;
	bh=jtyJNESs2NfaCrmwRAvvPnxlfOHCunirXFuek+zM5MM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NgjjbYf2yfFma4J9eblt2hXNWZgqKTf6bVyKUXmYPzJq3ZmevttsPf89QVhiO+EfS
	 1lhCZbw2zBAQhCPZvEbKDS633YHkVT4zEOc8Jl9OQSCV7gd1bf4znQCGjkq3wMk6bB
	 +kODN9zmvygg54tPmT+TvMPcUPGTW8OLlSIeuFMh38IwcsqYIMH3KrMtRiwQnBCdU6
	 ucA4AfVJR18NPAaUK+GMMwhQoPSxfWYOr1mJkBmv3jScTpKqqttGwH7dJY8JQVFQr4
	 n9V8DKRIMKWe7KZYFdVXpSGbMvB9WrTa54nFXOT/dsODgoj1eOwZe0T1LMLBVdmTAE
	 xT3fGTB7X1CEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9DAA4060E;
	Thu,  8 Oct 2026 15:27:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5AE642B2
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 586E860871
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I0a6KK1c4slI for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 18:16:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 84FAA6062C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791397004;
 b=iRhn+7alezHHWXWV8oQAcksMQkqZXY9SojCU9J1J4iWFBf4pQ8FRVq1eObsRUdud0fG/
 3i5ep0QRaF06dMCi13BOtNgTukinFYkW4n5WW+CEr1Z1Qw5IjqIREBAvmEZ83WqBhnHJb
 jpQMgzjQZnbirVtLhfBnSrtlY9PcXOOQsjFfiT1dOaUrAF0B1CNlZ7CBV5dQ8rtVf8NdV
 m/0bGib5HfSI0oRwWFql8LJny/Z+LUVMH3DaHoaPIqXMKeXY1Vnu+cO1uOwc0rj4HV3hk
 bDL9Yve5k5AC4Z302Yu0NJ4vxGyjz2VNQIQxm4OO9iOv6cM6XWJ6KH8M19maZuLyTig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791397004;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=jtyJNESs2NfaCrmwRAvvPnxlfOHCunirXFuek+zM5MM=;
 b=UnjQ0biVZVSun16tjXt0Pl25vbbleuUxLzdnGw538bE9dopIrDJ+3FpHU8foUAeI3LDY
 g5qnBo2NKSzkeYsFA4nvqiChBYC88CJztDnD1BD8GgY/i4qBbhqOweL345CBvKPBt38XR
 e09PYhhT0/WfVHy+fNt5SZw9FdLx0hdTGtppevnGwL4NbBAyomJiMmoYSHzV7aWgtSvsr
 wQ2ebY5X5txFoMU5N4mmh44WN2h4QnU4rNkWhIppz0nHA57jAZaUwfZpQVE+F8NjYq95s
 HmvizPRFE6ca+F8SBys60Y8Fcab/JgSrK3YMDqSymRxSJsOeB6aLyU6KPKT7hEGm0uA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=toxicpanda.com; 
 dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256
 header.s=google header.b=il6QI+4v; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82d; helo=mail-qt1-x82d.google.com;
 envelope-from=josef@toxicpanda.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=toxicpanda.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com
 header.a=rsa-sha256 header.s=google header.b=il6QI+4v
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 84FAA6062C
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:43 +0000 (UTC)
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-5352a876d5aso24837801cf.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 07 Oct 2026 11:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda.com; s=google; t=1791397003; x=1792001803; darn=lists.osuosl.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jtyJNESs2NfaCrmwRAvvPnxlfOHCunirXFuek+zM5MM=;
 b=il6QI+4vBmKp3cAVN29mhIMgIK6b0cRpcCcLWo/d5nucEnDSaqH1Rl7VTRX7wf17WQ
 vKw3eBdB8cpEyyBKVKGhvBMfvU9C7gcv+Euna+AxBHbqJFY7a9/Lcm/pUbwg8wj/BNWQ
 RcTA9d6NI5kzFnzdHQDi8vlp0GyPy3VV93c+ucyqMZNOoSzNIGKK4Nf6XpryLlERptc8
 H3msJSRZY1anHgrbdDAsrP/22TYm1mOsTnkTwPl8C1stBcPdCPQBojcHD2cd67UK9GOl
 sabJzOWYCSCxXXqdWx5br/brGdwd/lbn75vjwX6N6ODNkV5uUhwmYcKgPQBNDvZEtZ8U
 0mcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791397003; x=1792001803;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jtyJNESs2NfaCrmwRAvvPnxlfOHCunirXFuek+zM5MM=;
 b=yEU8q/bCIcVosa2QYcXYC2QkP3SphNVe6X4TQumhQOtlMtYY898aY3OLLwpMcNh4gG
 aEHu1R3lHNdaQLJhJVWnp9a24GdGfZo/R6PnkPZsndvkGFKUmxREcmP192cdwnQQBVuY
 FObU/AyuSIga/BsHdsKNvyOjSPcAenEik5ffyTkAuHMgkNxz7bYxKYgwtDX9n8LouqPV
 fHZIgQD0tOugwy8RFB5xz3il0rDyt8q8S91nJEyZn7tH5es9kWElEL460KRLatLOZN3v
 xeRNyL3HAXkFm9PDVSkAfm3NczGBbrHK2run5ovS4Ip+x+mgvho4uZVxntgrtoQ/BiOA
 bHaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBykRTm6iqrsSuq/uE/ZVHPTygtwJC4dwoySTPO/1NodqNhu/UFjnTxM1td/yldjMg3v1EGtxkUSzk6If6xfXO0=@lists.osuosl.org
X-Gm-Message-State: AFuF++n8xLjRh138rHzxLLelu9hTaOJy1nYwblidslbsiyjtqABmJV2D
 fxUth4U2GwFtiiWOEbm5u2KLzNgPKxj3h0wxYXxzorsChgtRJk6M60bdxopdJoP/LtY=
X-Gm-Gg: AYBFou17PxqXManCkBWE3zGPzMWtBQdpYcO3y5QdM6NulzSonfoKHcBkxeAEmboYjqj
 fnIerhKdRiN3ssZ40uhJ5sS7PJcw3mzxe7Hmu2bBTkjmGOOc+YN2mc1pq7pNjr+Ms5zvWpXjABu
 avAUCGt0TibCbNOJJfkOBiCruN4yrIq6WUX275f8d8Xx8yZANx4BPyN7GwwUUYNG+jnJqjjXfCt
 nEvRum1sIrs8TrNNUrzPdfrR5usiBfps1mdkDYjQ1XzH7tFWgJDsGWKsABOW3teOUMtSbTVT5N+
 bZN4wogPTbOiRoqCR1qHWyNK8kB8XPjFXOwkm6r1fWzL5iJ6c96ByREKo+p+j+TW4/0Qp8dM4oe
 8lW1/v6vcyneJbuxxIPJ95eI8r3hJjv0Pl077hnPU+/8uB7oVOrGR9LH9q38kp8mi9AGqGYMun5
 UbT1UiBgiqSnlMezKFVUDwYlziPCYuPssvycW8rRbCzUPfmK47xwEdFUU2AR4115WfEDZ91MZCA
 Qa6Rj5xWAKyUF2pUsm5FYR6Zw==
X-Received: by 2002:ac8:6f10:0:b0:530:5152:75f0 with SMTP id
 d75a77b69052e-53575522f94mr50565161cf.22.1791397002737; 
 Wed, 07 Oct 2026 11:16:42 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.251])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53571f185d7sm26074811cf.2.2026.10.07.11.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:16:42 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 18:16:18 +0000
Subject: [PATCH net-next 5/9] e1000: use pskb_may_pull() in the 82544 TSO
 workaround
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-pskb-pull-tail-drivers-v1-5-9512b0fb977b@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791396985; l=1221;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=yldyXc+k9IUGHFBVvbXY7100U73O47dmandGyjhHpkE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNqFTCEFL30xWoiEbNRl0xB0Ou+bDMfIq1Ujmi8Mmc+Z3YK0ZHA9JyEcAtxrEeF+xJvGJrfmT0r
 2sKFeMZQHNwo=
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

e1000_xmit_frame() uses __pskb_pull_tail() to pull up to 4 bytes of
payload into the head for the 82544 TSO workaround.  It already checks
the result.  Switch to pskb_may_pull(), which takes the length the head
should end up with and checks it against the skb, so this driver no
longer calls __pskb_pull_tail() directly.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d7f5c6f16142..3a55b211f5a6 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -3155,9 +3155,8 @@ static netdev_tx_t e1000_xmit_frame(struct sk_buff *skb,
 				    & 4)
 					break;
 				pull_size = min((unsigned int)4, skb->data_len);
-				if (!__pskb_pull_tail(skb, pull_size)) {
-					e_err(drv, "__pskb_pull_tail "
-					      "failed.\n");
+				if (!pskb_may_pull(skb, len + pull_size)) {
+					e_err(drv, "pskb_may_pull failed.\n");
 					dev_kfree_skb_any(skb);
 					return NETDEV_TX_OK;
 				}

-- 
2.55.0

