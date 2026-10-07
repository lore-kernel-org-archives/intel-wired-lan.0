Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DA4CA600D
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 15:27:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81628403C5;
	Thu,  8 Oct 2026 15:27:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ID49ZhhXbEgN; Thu,  8 Oct 2026 15:27:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D337C40343
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791473244;
	b=ZH8CPNrqdyQQkkE7h6uXP3peOo66SEF18P4plOSSYxEy/SSfokaebKoAev3wUzi3N64R
	 bt32LKMhr5lvE+SuO+tNJ9kDAC1U8gMXsZoJ2moWjjtHztOyOJKgIIFQB11xCO6Qpw8/T
	 /WkM7FXVUttes13R+Ifi9TF2ZKrPlh2Atr2+f/6rRSPMRTy+wuzIub0T/ruR9eySQlyiK
	 KfMJ+qThliMN12+RfKikzFxkcGfTr/wfU7EqY0f82yUpQ4TOmmhyKL348N7otC+9NAR6+
	 ig/8Iu/XmsFuMFHLN1Ui627QcwD93LBLfgylkk6kwJMVol5HR6O4EWKdsE6r+/eLe+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791473244;
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
	bh=J9GuqCKMi/hN2ncI5Ot6sRINUqKwZdItx3f86TmeMcg=;
	b=BZVNNkg74+QItMZiFXbjOt53OBVQnDU5O4R6aKmtsr41u0IuWVT7Cv57KtKozw61wNAm
	 OomSXlBMsnWSeWlGWqntj1pNxJg/kVF4vyZmFXCuqjVA8fo128Oq3ZFrhTvRoRbcqCUF8
	 dISOgd0MavSZVEEX71s4Ll3aVALV0vF2jyI0areIU0vDUVqOHSjL2s38GExp3ig2as9jA
	 6Fq2Me47R3EBRNFy48QzXxnsTyVYchZxf1onXm+XONn5hNr/h9E32JBzJVd2HJA8/t3As
	 f8PeA12RHgRaG3/928DhubMHFDymcMVwG2sf1A6MVhQso9jSeIiT4aPsO+q2vrahsEA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791473244;
	bh=J9GuqCKMi/hN2ncI5Ot6sRINUqKwZdItx3f86TmeMcg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1lgVnmub/L24X5+NWMPVo7fR4eKGP5/mQaIBrz8oODtevotIBWR/RSATaWfILF6n4
	 IhZ6KPoikVBHj/yORp7s97N5bTBk/1k1AOEKBKoqMKkskdpkRmS1ZY1kS1L2GeyvHT
	 9FNuuMoQpP/w6ICUHiGlJpvDviJRgN5dLIjzjxfgLEW0KbbnD5o3GmarDKtEUDHeCY
	 rb49+xplwk3jp7XWhr44AOThokdrGfkAKHt6SF1nrKVLClBqUJGQgNrpcjQ5ophYEG
	 ALEQ4AKtt6wu4XUiA0Rxp9N8JCioVoL8GK9fLkHhYgfVvI9n8sG8s/WdIF8F9SS04V
	 FDtu3iEx9rkwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D337C40343;
	Thu,  8 Oct 2026 15:27:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C0422B2
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 829D640381
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ku-9J_JtNtBP for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 18:16:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B13B640367
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f2c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791396999;
 b=bDeSMyNj9Xzx1Y/58o7SqmODjSSXW6hix0+lDUkuzcNCiH3GUk4/Qpoks8d+XuN0PISU
 fKyr6Qg/IfQ7y1wF+IMv4I8vvp7yoOrizuHPlp5QWtCDbvR0OP4NqxJArXJbu0uMU6J3T
 mq0YzRxpw45j6S2IPutURqwf9U+Dno3l710JN8H0KBmGBL0qfMM9V1iswKbPpEqQPtw2j
 1JoC+mgMbiwt0QE9ijfBncB455RGvz31xkdKpa5/G1kDVHjnN+yCWRoOpOxkg2DWw42ux
 5mw4wha1EPgLMHhwmZp8Z7kr5uWOfEMeP/O0AP/mShuYLvKwo2XsguK9y439QTgqyXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791396999;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=J9GuqCKMi/hN2ncI5Ot6sRINUqKwZdItx3f86TmeMcg=;
 b=Sa6ZfgeWVOqvMDwPwUQHMgM9U8b1tplYle1wHvwzCH9b4AbpiERiuSIf9WFOSqrK8WEn
 fCmm4z25CRVvdAY59q3Z/ggGGfa1S1dzOUUG+M3jZCB0q1DWXqUjUFsVyOay4Y/aVeqdm
 VK+Orlt+hmvA0ZBtaDox2T4rivOuemoafeIcwIhRDpOoMcYV1t8rk6Fb5XH28KO3wYRc3
 kJAC9OHz+wg1z6wOJo0PR7U+DrMf+iwhTiuNG725CQRsTFcjlj60kvI7ca+SDkw+UCoBg
 5EGcHKfkgVxvpOeKdVRgVD3UbzciwgcJxXwYgtdcK/iJ7/khQ8uaW0YFjoa1xZiXM8w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=toxicpanda.com; 
 dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256
 header.s=google header.b=NKm7yjJe; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2c; helo=mail-qv1-xf2c.google.com;
 envelope-from=josef@toxicpanda.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=toxicpanda.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com
 header.a=rsa-sha256 header.s=google header.b=NKm7yjJe
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B13B640367
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:38 +0000 (UTC)
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-91986c5cb75so22868616d6.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 07 Oct 2026 11:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda.com; s=google; t=1791396997; x=1792001797; darn=lists.osuosl.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J9GuqCKMi/hN2ncI5Ot6sRINUqKwZdItx3f86TmeMcg=;
 b=NKm7yjJeQAn5LEZ6DkYlHMc0YHpTfwFcCbT6qdLhwOW+5ssX51iegmt7sn3yILlNRm
 //TGN68tpq4wRpdHv3AADa9vVJ/YfIYL4TSkfskd3blFBX17DsF66Et4DXaS86lulPIS
 lmwfQjzwr/ZxvweGTpN2kmsKhLusMhcIFAMBHUOYk+zghPQlmFx8BghIiGS5GQORxCm2
 nGxMQf6Fm7zi0uorK5uvze94t+Jt99NrI4A9MCaDwrjZCsBAV3p2kKpovPP4L2IjgtVO
 RLLEYbDRTF6vobG/7tpylLfvF6QcxAI4/oSpgEUiunDmFWR+Iv8L3Jnh5+JR3sd3R3xu
 ty6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791396997; x=1792001797;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J9GuqCKMi/hN2ncI5Ot6sRINUqKwZdItx3f86TmeMcg=;
 b=GVNeIETzQ/bWQdxGsU9X0n86jfCp5qtCrwBLqFd3cyqNNDPDyIgYOQIBUDa37MEhoT
 Or6pa+XbLHehCB/43up+y2ryyB+2HT4QIMKUbEFyc4Lx4lV1eSxiFea3X8ZMXs/PmkyG
 A6maMYlJIyCX6tIa6rNS69NloEERWyUgHMn+YI4+Hz3mWrw9of/XRVeR71dsbZkntb3Z
 kcD5hoDEPodeAztIWnUulbcod7fZ8Gmu7zMsQY/AEaKUam+OirwhA94QsXwXPVs7QvFQ
 UTK1GxJw/k8gZo8ZD2j7sMKsysvytw8CAwf34seSbA6Q2RnE5rLYMzR9YBjNQhEyE5G/
 nQ0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCSZjSumscVrE1gBZezjHEMHt7fjQj3DHr/8KMaNT+UDzC/zG6q8HVd7MiQT81wYN4S/25knjUJ6RqzHffu8o=@lists.osuosl.org
X-Gm-Message-State: AFq9FYIl41PibzkKnqeBjOIb8fC7gcMae1LoTUSf4syCWDig4Fz0GDgm
 poAI1rD+0L30l3qHytGFO69WkyxWVjz91vKdyddaG6bbmZ6cQnafSmflP0jzKyR+uYk=
X-Gm-Gg: AYBFou0ovnZC2lqUx4L9J+94k7vzdX09KjPL+eQ0lXR/6kK1+eXEhmyggZSJG5tUV/E
 UxPuDE/8Xk/qyv7UDx5oXBnfMPP+452VbuOYReyZ146bCyi9lVG48Ky09GHPChG7HUIGl9hRQlX
 81jVwQYwagYYhrUVGNwi7liFj67y4VAjWEvrHGhetj3PxitF/INgNRjdBimJHdBGe8E1RSR9GuS
 hyfTNksBy//TNOi58qcKrvH9hvUz9MCWE69OtGNXf/DjdBqF5t1xeObyrZ/AE9zPK1L3N3Yk5Su
 QZVecfUVoBIKCWyq0p93iaBunbOqNtw2MM2853gQYoTPSMGd3M6bR4nTzBtSaVnB0AxZui28XFv
 VtTNPHmYI3dobQ1PZYdjakGVqDAX/ggn2HdN/8oF0ZF4vuhdJYU424Su9gSqzOINMJJLq99KDgi
 S7fTZJlCcKEIemfx1XdxgpkXTnqlpq4/+FbdHUZkY2Ylq3S5bjDvpEaXmB4Ob9dRhwKISb1jo2T
 tSvdSnJUpE9hXo=
X-Received: by 2002:a05:6214:29ea:b0:917:8400:5eec with SMTP id
 6a1803df08f44-919976fd758mr60391986d6.5.1791396996945; 
 Wed, 07 Oct 2026 11:16:36 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.252])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91996bac803sm26531506d6.3.2026.10.07.11.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:16:35 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 18:16:15 +0000
Subject: [PATCH net-next 2/9] net/mlx5e: check for failure when pulling the
 Ethernet header after XDP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-pskb-pull-tail-drivers-v1-2-9512b0fb977b@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791396985; l=1491;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=zznhnNGgkEt9ZSSy2T9PlgogR6INn8I/GpUQzjq8ahE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QM+jiGljpi2X00qowHNyzmeos/hw24wETOq7O8HQRrlF1LPa5A0l/9HtyUoj5T4Hstal4F6tvLe
 zEFqab3/2JAY=
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

