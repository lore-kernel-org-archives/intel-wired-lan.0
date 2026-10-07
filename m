Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5848CA6013
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 15:27:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80384405DA;
	Thu,  8 Oct 2026 15:27:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uZl-n9XnynFn; Thu,  8 Oct 2026 15:27:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C377F40383
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791473246;
	b=YuEMBIDJYccSJnaEcxiANUg4d8+KyO2cF4gjRzkG3zATyJBFJ/sZ4k3OtWdE4PEV7VSH
	 zqP5Ryq2794h9ea4qQOyy+hYEeC+OkjExDIrnWO6El7NDRRCZ1EHmJ0HZVF96BPLNwRG0
	 kIF56TKThQJUbrYfXs/TxtAseuQOGIRAhGH1A3MUnriyOaFBMDDf7S8zF86TE/iY235uN
	 pLZQHdmQd8Y9RJQ3OU1kSdKTWlIlEUPMTvBN5xbqtWtHZFJkqt335AZhl09JmbX75SlJI
	 jJJXYmN4aDlJJRCjAc+VlZEegQMgvI2FtXx65iIPxPC+JNs45MaQWF8NvNAAMtbDFRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791473246;
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
	bh=sSCgQuUXGYAa0Wwwh5eq4aENwa4g4z1qSYLp4/+HlX0=;
	b=l0l5qrOj1/2Vj52r1z4f1qqg+T6lHJuvlcPDfe++JtcqzoI2esA2Dtn3DKjkqYvcF4t0
	 +AI3Nl6COZejGsy0OGVAq5axbFRyCq9XqOsF/E6E6tyfXfE49pmiwQtQzr+BvK9bjsuu6
	 MWag0J6Bz3KTLdOX2qgHIJgLpPDS0XwFxm7G1699PJ74anQD1hEHun1yRLobK8GJZOn7x
	 8FFjyiVN1oVnKciNAR6GGL1XnnzKAwnbqB9gE9FfFBYKl9KC/pMogaa3JoapFFix99EB5
	 g6bIt3YmWF0Bu4yRQIu/cgEJKOFOje2uBqhPjRoGn9/mwEoNhkOewkus8PhWy+T+TmQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=iq+LhS+u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791473246;
	bh=sSCgQuUXGYAa0Wwwh5eq4aENwa4g4z1qSYLp4/+HlX0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E+TtAcjJqocNOA5scq67euDz6UYk8yKbacb1j2M8gLJNFxSMz4Ang7I5qvREJNS9C
	 qXNur84+Bm8eXSQanP9zZc99EIGhsdag8ooBIvjg0ScUX6ryp/MiEZ5B0BQ8F2JZe+
	 SgBCEIGDal29oNG0OmsZLHVb7oxj/b9q9/U/Ko2UzZSwISCXDi3W0p/zk7Kn9tkuhJ
	 r1WLGNw/6uTZt7FGdldvIH44czmtc6rWy4Wwk2Ji+Zq4qF+IQ9ExAsRzTwosB8jmFh
	 Z+SMqPv922VP8H8M3JzqUhZGNeU3/LHmXkOYnqCAltVeMI4OYaUGiVjrlC6Vw01/If
	 0d4gTooFvd2mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C377F40383;
	Thu,  8 Oct 2026 15:27:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A601170E
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D16C40765
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sMtHX7WMT8eb for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 18:16:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B94E440512
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791397003;
 b=sAAppUfBa1AMCr/R1ylVX4KUmAZ2wy2pqsPV26BTaAEnnzizt6BGXmrqYbzJAnQDqroz
 7MhAiaCQv1pss0qREp/k624q1geZ862GOe+4NqFX6eEJ36Vqt/FBUEZefS3b9Eex3EDNg
 dYt9r54EBywKuu315ry3J6Vn4EHponqDgnpI+XcLUdgwpH5hzvbUDdpu46xC5vU8WawwV
 gj09fYObXAUQl71oPmKZmdESJH3gfOtloMQAcDUEtZSbEcCdCdZJHkp4FE0tN/O90hm17
 ijsnKbasdvqBEHXdBGC0eSWQHgSDiu408eM93DQNAnt7HFYKLf6yyOjv1wtKTiIsnCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791397003;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=sSCgQuUXGYAa0Wwwh5eq4aENwa4g4z1qSYLp4/+HlX0=;
 b=qiFgsvRWSWaxeqquyH1mCYU2zAQcOLrk36MeBmK5i5dD4MNxef5lAhWG7lfzaODkuQJR
 Ma82G8yZ4Akn1fMQ0T8kLXMt22sZSr6bA4wYTzDg+NXQBSzeXfRHCEmeg0G96/Mr0Tz/v
 UB3KsDB70ZzM2MJ6gN0RFs7xpwvRgUpSQ3qfzRRpe8b4XwIUFO2sqrxJfC+A2qD/ECith
 4R/bes0j3nq70lQ5I0ENh/JjH0cOjn8KSb6hNE12xNt4vvdrpFI1RfcQUF/dHkjt8oN/o
 04b7paDICZTyub4ZgIYKp12FkyVMAaZR0Z6+vqttJk3GEXq4zBXwFPZPN7cSfG6SmTA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=toxicpanda.com; 
 dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256
 header.s=google header.b=iq+LhS+u; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82e; helo=mail-qt1-x82e.google.com;
 envelope-from=josef@toxicpanda.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=toxicpanda.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com
 header.a=rsa-sha256 header.s=google header.b=iq+LhS+u
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B94E440512
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:41 +0000 (UTC)
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-533972e0cccso19933971cf.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 07 Oct 2026 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda.com; s=google; t=1791397001; x=1792001801; darn=lists.osuosl.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sSCgQuUXGYAa0Wwwh5eq4aENwa4g4z1qSYLp4/+HlX0=;
 b=iq+LhS+ufKT7cJpEiHON3bRD9cg19agOhMAlgVYvAxhF9MwKdLyDKdgLl6F1qQvjR8
 /uZl1R/Q8XnFZT4vlvZuJYo6kHLiZWR54dXLYrMiZlhEB0f4SD6fmVPFkp6+BudEmpKo
 p9SF3H89ZODyH+8aYKhqzp9IFtw+B3jOwRa6umPsTyvar0buU7BZ19arCLAmvQPd4SeR
 in5Cx0E5L0zpJ9OmZzOLcZoPDcW4eARAaBFJOft1OBZkah55+TPAdXpMkR+FX/pt4Wzo
 rDsWaHkCibTA6JbtIv/geCs8Gi/ia3yeDeVOamVdaqiDv7wkRsqOQ+h+1VzmczyaqdWy
 togQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791397001; x=1792001801;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sSCgQuUXGYAa0Wwwh5eq4aENwa4g4z1qSYLp4/+HlX0=;
 b=1sjkSJDsLNmrcvin2ihTi87KomGkrtY+/vNPYFnbhTGUeWsoEVKVrgGv87DWKbB6E9
 9y3DwpAOaQK1KR/fb10RUweX3Nx+4NT4uOAEVtT94OV6Er1HwQAEwjVau0yPlsepLqPX
 9QnSgcJRPHo0DL8FR7V3PCmVMVBVfAT4EX9zroOOH1+F0hjplUFAKxQEmrXJhTov7j/2
 7+Ij5touWnU/aOyuNbWMVjwEYKlJGrhUiwrG5bh1a3DtEKlOBz9H0AnfdgJkydmSuOCK
 QA5xtuaV81RtA73u+XM4EdwzgXOiTIPsDiETNXnTW7TK9h2i4yFbipMF5Z/OO0rEiBsL
 WfvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBySkzKQ5ngnP1d6ua7tqQm/s4yYXsWL/QfGVNGiWonkui9Kd9v11Ufkws9g4siVYocQDGi3DvyI+9UvYwIQMag=@lists.osuosl.org
X-Gm-Message-State: AFuF++lXGouDzqiZngkMLwowA+ZrEa51ZFjLuM7uhGzSYx87JoM+2xCD
 sJwhiYB2a6m/SEci+4jwO+PbeU2tGC36yRWNuKWrdPiRS3twM3rZdkDYDPCOlTw/jTw=
X-Gm-Gg: AYBFou25Vz73du6ClVSywAKz154bixlVYg8pB4ZTiomASFqCINFPEpQWc0wQD+2CkPv
 sxCdmdp6gZLZze9FmF/8md2LTusQNON/1WyI8FQM0PrJEBZkmV2Rh+It4VtnsBbSzpTPOZHry9W
 2ajQK8NwVBvKU4FbU7Yn0G7gXci89tU877JQqKmCIVSnaH444IpbrsIJwUbG8OzWDxgSsuK+tVT
 cX5zdAb6bujClJYb21msbOPlC/jqNwRYUtH10k+2PBLuiVNINL9jXKR9bBziIoRKnuDReWJCOUp
 W7bxxPMAAbruzndNHpOn8+1hYFj6X2GV1U0Ymi8+Pew5EVJ4fnqmzEstkZXz4bViEo/0FfPR+cY
 bR6ZggNhNAN4Oj85YwtHqRKwipd5m46qWRl0VCliePSlK73wgfnCegoCzc4vevWhxVR1c+D+ZU4
 l15aT1vXIleUx0f6il5JbhLsVKd1jqLCBg5AFMWOfOwYALyLgrDWLaLCYKnQGWbmGypO87UdktX
 G1/o9IsB58lF6k=
X-Received: by 2002:a05:620a:29c7:b0:936:dc4c:3bf4 with SMTP id
 af79cd13be357-93e9b7436bamr598926085a.28.1791397000824; 
 Wed, 07 Oct 2026 11:16:40 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93e9915a259sm272174685a.22.2026.10.07.11.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:16:40 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 18:16:17 +0000
Subject: [PATCH net-next 4/9] xen/netfront: check for failure when pulling
 in xennet_fill_frags()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-pskb-pull-tail-drivers-v1-4-9512b0fb977b@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791396985; l=2095;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=SzoPfHs/Y0Yp5wMeUYR89lBIZmoL94dSQOZucEHgjz8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QE2mPs8pQLqezwaIQAKe007VJT1pjZBj9lcqG8tW/4kuSaDQpOlcqMEPoJV+xlZe2oi4kfjBSKZ
 BVy2K6gSrcAQ=
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

When the skb already has MAX_SKB_FRAGS frags, xennet_fill_frags() pulls
the start of the packet into the head to try to free up a frag slot.
It ignores the return value of __pskb_pull_tail(), which works out only
because the nr_frags check right after it drops the packet if no slot
was freed.

Use pskb_may_pull() and take the error path explicitly if it fails.
pskb_may_pull() does nothing if the head already holds pull_to bytes,
so the BUG_ON() for pull_to < skb_headlen(skb), which protected the
subtraction, can go.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/xen-netfront.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 2ed673649c48..6e01a883cc64 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1174,18 +1174,11 @@ static int xennet_fill_frags(struct netfront_queue *queue,
 
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
+		if (skb_shinfo(skb)->nr_frags == MAX_SKB_FRAGS &&
+		    unlikely(!pskb_may_pull(skb, NETFRONT_SKB_CB(skb)->pull_to)))
+			goto err;
+		if (unlikely(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS))
+			goto err;
 
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 				skb_frag_page(nfrag),
@@ -1198,6 +1191,11 @@ static int xennet_fill_frags(struct netfront_queue *queue,
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

