Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F23CA6007
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 15:27:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86C7060BB7;
	Thu,  8 Oct 2026 15:27:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gi9goE-Iwe9g; Thu,  8 Oct 2026 15:27:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EA37760BAC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791473243;
	b=kYDDSJ7oks36xMgiHQn81Iji1wMbGWjRCc9Vxq3dfLd6W2tM+CSHuOQlajGUSsqZWbCV
	 xKccs2l+aKg7MdClct2oUEsCobYyBxK70ZhEArP8HImXhuUJZGSMjejdNgETZwMsqNUKh
	 I0QKZRHocZs7053msDUimdTfmzoioiyaYSnuy28+vDTAUjMiF6lckTklRrhtB5K53BOv0
	 pXQY6jYr9F2wFPczjtO4fTFHi4J3Dh6f2yDr1HfRt0IouLZotOfXWGupwRZyzD5XkAyus
	 09Ss5MkkFSEDTHzSifefvdBuZjswSkyaI8MLV+amW1KViG2DxEl+tlDMf7ap8HR0sPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791473243;
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
	bh=a3FpKl0vN7petfzZgqIhlc2NP9KQ4OIDsR/ta4Cqq6o=;
	b=BkZ6qEHVTaVBnsDnNq5w4iLJ33KK9HLjQb9c9lVHB64WUp26B7824yCU3+VamqfCUXFG
	 5SStm1z01AcGc+lxbEiD0AHqX8iFmPl+R6TMZ6U4k77yYBwfsOuC768TCS3ropkf6Vahx
	 F55t067O9hwNuVbPTBlAaVu2V3q6xKL4zkqGWYISutEkP0f+EVSSUjpZSFoecsChkMoAj
	 NEswdpwli95ppnWiTClAkm3E7SPrhTCzg2eV8GgHGsP6Ma7Ik3CIKhRu+7779skV73snB
	 UFX+PhTjoJYi3ovQxX/K18z1WcukgAVAHy1G09lOnSyECgBUFvqZ2s748VBBvhs3pyQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791473243;
	bh=a3FpKl0vN7petfzZgqIhlc2NP9KQ4OIDsR/ta4Cqq6o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D0g0a/EHZ+9q2b0x0qWcGFEyuMMYHV0RcZ4TB3btyfAB8koNda/2tZUM26rGoCa/j
	 p1sPWHPTjvN7Ez2/PqlV6X+BIA7ZYJixPz7WS2TtCULukbHhP4XijrJ917y37uCVK0
	 DZNJX4iafjJ6P4d7OwtpbZJ3J9dnq2gj+v8VO5cMcm8A7BieCsY0GkmgBMtReVY/0r
	 l7k/8FtrhXgp871zDH8rNw8aXdqdSDTEX4VeDTLE/T/L7yDTYrlkygXfqCciVC/jbK
	 I/+a9E28jZ9YflhOB8mtUY9fLAotl9/aSG+EN1OUDk/TVbJ1ss8HVbKYNu0jBhIwVH
	 EjOaXmAkiNPdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA37760BAC;
	Thu,  8 Oct 2026 15:27:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AE6F970E
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 93E5B810B7
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7KvVNrYux87K for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 18:16:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C30AD80E26
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791396996;
 b=b0aQvsRLAhZIIsNsEIjgY7q4NJu0eyaArIdCP4HTnpokBMiFQmTf84WAQwMdMzfeSXyU
 p9q1ZeLUKf5NTSWgRJkeLgOQROvLw2QxbLHx2qXMZm9bf2uMYUerrwpMVEseoZEac3nbm
 3IxQPDxr/mrebQErf5gjLFLjeUIzd9pshZEFABof9S9/VSURyk/XfcEg0DppWgAMFDTnu
 WgWUEyFnyrP7jWrRBLC9TTDRqQwk6sQ9feKv8xHlLqMS8gSdcOszUobhSgpZbV8nnwVEN
 rEpFX5//cqwmteQCpccvtmsJRseWZJk95OM1pEHmaeDXyXaZl8n4dTEdzM9OWAyWisg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791396996;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=a3FpKl0vN7petfzZgqIhlc2NP9KQ4OIDsR/ta4Cqq6o=;
 b=ZjYvI9HusF1xZENm7EwKSez16BWTTcUz8cs5Wvex3MWvUqNBmUndFo2EHmNOrj6aN3EG
 1d8vcqo/Sl+vm9fajwGKBtdOtvCsOPG2pIDmWZ+kNsxoJnxpXww5+bwPNVKFYnEJ0tStz
 HScsC87lv961S+OSub4J297rEd7d/1NRYkOqX+G47TUR94rSgW8iQDPlsW1xi47B9pxv2
 ogLucZGYS12Is88Tnom+C+nbqTYYrSF3KkVZVxOWLz8FCs99pkfua/zGtlsBQ852HoZFf
 LlrgAj6nx0L4N0d891QMJqv86Jn5qapiYJPc285WhQHjqgldFzFiMmYWJZmei/29EYw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=toxicpanda.com; 
 dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256
 header.s=google header.b=jsp6GYZB; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com;
 envelope-from=josef@toxicpanda.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=toxicpanda.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com
 header.a=rsa-sha256 header.s=google header.b=jsp6GYZB
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C30AD80E26
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:35 +0000 (UTC)
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-5339173489eso25442151cf.3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 07 Oct 2026 11:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda.com; s=google; t=1791396994; x=1792001794; darn=lists.osuosl.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a3FpKl0vN7petfzZgqIhlc2NP9KQ4OIDsR/ta4Cqq6o=;
 b=jsp6GYZB8AkAzEla5jgtVO6hYeyXCQIo9Nsli6F+iUtLHfa0dJOgrFnipNeSFNsv0L
 wCb5wJGzzPmpN8OQVgB36rCVJUMTjtlGsF39ta3/LTQHZlUUPz3VK+gzl4n0NUigGEPY
 W16JvVy09HI8p7AF8hGhYqSkfxfikWVsv7VWwN7dtc9nUQxob5CUKfcQmRbXXXza8Bxp
 qRfk+BWBbwn298Pj1AN+wHvlgwcZkbJ0ijCvBIhqCWj69eOjJzinYA+2hgoPRNb64Q9c
 mf4wp9ne96wVocQWGSJbCZHkqzp0NRgmVmd8LO8XHok3X2APeo9f/COVOSM3Fgx9E5kB
 z4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791396994; x=1792001794;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a3FpKl0vN7petfzZgqIhlc2NP9KQ4OIDsR/ta4Cqq6o=;
 b=H45F3nUEO0XVwAM5VqBWT5APuM4DyTsyQ3iyrbLEh+4/yOrKJyuh4M5Rjrz9hsX70G
 U2GyEK2z/zoTBzTzESAXCe8CM6JkdQ66+A+m7oFizjYiWfZ2LyfL1w4IKG02FxAMmA00
 OOyhQ6WY3ll8vjrPdmw11OhOC+kFKDQW9wDquDhM3Ocbw3Us7wXd066F+riztlBNtkma
 5gJcCiXEDQUu57lGLnxMi+BYYRlXW/FqjUsUeOI3h7jjf+uzpeUBFBnj57/TxNxkJwj3
 0fLZCT6Sx1DFGN7qgQdfEp8SS7rR5FQdYTJ/tPGO3l+u8F1SonYpQL1tddj3PUfCEVx6
 jQSg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYcgmdjIyprHD7oRZmJ3JP7lhHvG8Lty93Wz/oBcuF2XlAvt1Vh2/G9G+y4Z/qs0svVWtglms2rjmRq2sZu+w=@lists.osuosl.org
X-Gm-Message-State: AFuF++ln7nNpGJyLzbArZwihpL/mGMq0ZzUbYmkdOSoYCe8aZx7DHPTo
 2Ps/RgiO4Nzizx2P7jlnebz7TNtq1/mJjhSkjplcs8eU2JhlKb2DLO/6yQ+noICMuI4=
X-Gm-Gg: AYBFou3GMu1lP1zGpuwK0T1SMO7LcN7TzdtUg0F+c39W5sbgwpf8HCgiugHKj/Y844/
 vkp0QwtypPaIX+mZR8bP4dDOjSlHvxmb0uo6sIO8ECGANjdhjEJBa23uwwjydvO3em7UP7jRr6e
 VPpA9kUD4KDP3s9Fh67Vf5wn0dbMXCB72GsBvox3MAYD7ydNhfeuraPSFzaN0tzd2LICJzDqSTt
 mK11sTSf9CxX+xGkWG15B5bbV368u8frCLtqxqtYFUA8zGUCGXfe91AIeecoKMXUQ2837VUlyKq
 ooHaPWvNhF4qO5mrBXrMYCufMebH4/nWw8zzFNxZdtchGiIi8RvL4YQaJAZf7LdFShe0NvgoHV6
 AqdmQPYu8VAoI+MErFB3es7xm/33LxjwN6UGds8rDh7QBo+fegj4IXAKEfm3jyLhJfKEyD73S3B
 rUyQiYChd9FSNOCsPXbe5gnK9sE630Qyj6V+kBGHSCVVhdo1dqDvgrJUs3C880Aax9malo8zNz+
 tfwy5V3xMGFoe3aw9Oj3lI9Kg==
X-Received: by 2002:a05:622a:e113:20b0:535:8607:d2e2 with SMTP id
 d75a77b69052e-5358607f4bamr14319421cf.56.1791396994064; 
 Wed, 07 Oct 2026 11:16:34 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53572163ceesm25476671cf.20.2026.10.07.11.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:16:33 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 18:16:14 +0000
Subject: [PATCH net-next 1/9] net: ftmac100: check for failure when pulling
 in the RX header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-pskb-pull-tail-drivers-v1-1-9512b0fb977b@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791396985; l=1745;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=YaVSidg1Bo1cVWoGQJzV4z/nBT+SLxbK+9NmCYkL+oY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLi6NM2cH1GaCjQ09bIeFY42DV/aexWSzx1/i1cHNG8H1PuIyQKikelvwnWe7Tmx+A2sBSVuNWU
 /fPwJUm49cAs=
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

