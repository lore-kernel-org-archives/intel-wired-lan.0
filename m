Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D2CCA6018
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 21:03:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 771D160893;
	Thu,  8 Oct 2026 21:03:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FKFlcyH0pkY1; Thu,  8 Oct 2026 21:03:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B84D76087E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791493425;
	b=AVRDrcfViJQYmcgrTU+tduWafvMU3QvUUDZ9SJ87MCX+d7VPbE0tCCMnbmXbdyUC1v4s
	 YaBiWyz2NHp4Fjt+ffN1+4+g+JhTOsEs/U8rX+yJwIPtZfBvSiZOkSI0qIptxr5BekKt5
	 YhClJV8a0z5OwYBRt4/jQaT+0d2MrHhNcLcGN9OMJW7eR/15+/WIKgRXyYFR+mUGFh5ug
	 O/uoArPhmgrTvMdBlPSGOrXG3fRJdSpy2F+KofAD8ZvY8mFiUp/LpSCED6L/9BZBHYsP1
	 P9LUgIV5979O/K4Nyoxwqb4nmAjQ3pU0w97ZZBNpHvGUkuOk7NFmmHQrt2EtWET0Caw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791493425;
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
	bh=soiW+4bnwYoMWX+4s8jp0T9nXKlporFXyr3eC0IUFGM=;
	b=Z//Q2kFebKj3CUs3GAC7tj2izJwYfYEgKVDhGUBCORHkgjN+/7DtkGWY9m/MI5vrPbdN
	 +4HYEZDCqmRnnKFeKGewTCYouAFWMxbYV50OUIVp2Of8BAS0ATWi4gosy6CG+uuM1ub4Q
	 IAYhbs+5uvWsLV+Gd1U0bt0CzA9XIuIaALgZHQSBMl4DIaIIijz9iYL22YSozn+cvnrfo
	 qwfmHMKN6FfbLlhrdgMlC4sQ3dk/hpD5Q/1h0O6SwBAzTXAUy+3MhowWIcbcElp51OBvF
	 YiSCJSsYIeOS7tSaJu6lfXvsw4QlC2EE3fAuf0NLaahdy/5LWIwfKPW4WcxtTGopE/g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791493425;
	bh=soiW+4bnwYoMWX+4s8jp0T9nXKlporFXyr3eC0IUFGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B3HKij5er++Ka/rTKy2Qp4DkEDVEZTTF+iCQIIa2h3GoXNALfZTxwReeQWkB0OKWn
	 UNJozLgvX/HQtTnXH6tb5zOORLQwmmdDCLNsBE92C3EftqEv899+q8NdPEIakvVefT
	 ska991Mc6y5NMwAWyZz0V+eLF/qKNFAT73C/9zXoXOFGS9/ZJ4ns5o5lwjYDl+iaZT
	 JaIWywpaVhMhlJxnMAb5+rbwpyJiPZ3WoJ7idj2Fr461Mh8vt0fbWy4xmQkbBGp3jw
	 VAr8mNIiFkr4telgSfsgmsR7eu0mOenwiRy3X8SYl4o2qSIpQmH8UsyEI6zFnlZzBT
	 b8Xmh46524PHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B84D76087E;
	Thu,  8 Oct 2026 21:03:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CE932E0
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0EDA94032E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FjcyrlrLMMJN for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 21:03:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5BBD6400CB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791493423;
 b=bQz+k5FAjvUcpLgEgLMSjJTieUu4oQ/+R7kpuJ3YwQFyvxsvoIS2R/y1ToUJ9O3wOjMT
 6u9UYjK96aMffCi7Q8A12sqhIpk7QYSoUCs0pT7Q+JfTxwAPuyIVdn3vY2F0lGL8h+Lj2
 QqVNBkzPr0o3tPYLaHwv0UPKm8D7TkPeQ+Mf2N/B7FtsIsijQ4Pp5lcSilwPt16JGxmH9
 PVwX8Q9QeTOdnlXqQLroR2XQsk5C/46sXiHL7gCbUJpUNA4FKukwUVmpxVNzwOBwEsUWC
 +QFaq3TQE6vSayDSSoDFSKoY5M3HEaIHSblZWExwMwn2wPtuc9O+HWnJtU6CXyP8nNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791493423;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=soiW+4bnwYoMWX+4s8jp0T9nXKlporFXyr3eC0IUFGM=;
 b=Z81efgeWdJPD3XUTL/gQqM6iV/ANdQjggYtF5FkK5pBBebzP91QWGj/pJ2rNwkwc51F7
 5jtptHZZ6iR2+hNX/C4p5dV9f+/CDIMbA7z/sz4O1D2k6qs1FpRTiJ/fgSJ9dAfEGOP28
 8u8wg2UGfw7PAr3p6DnD8ndSET3m/cfq1zTMHpi/pfavehZI3hX4zzG49FMvib3U12pOS
 efEwA6zBISDiEObTGDY/3i4IwGQJM2tYo4EFXWY036sqfCiik+u36kc7dFvq2wKwznvN3
 9ANoIK9VskpqksFt7065x3EkjGcz4PfE4rotUKtONOol/eNAY259aYqnlmMfj2LW/vA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=toxicpanda.com;
 dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256
 header.s=google header.b=qmOXRNf6; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com;
 envelope-from=josef@toxicpanda.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=toxicpanda.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com
 header.a=rsa-sha256 header.s=google header.b=qmOXRNf6
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5BBD6400CB
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:42 +0000 (UTC)
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-53582498790so25760331cf.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 08 Oct 2026 14:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda.com; s=google; t=1791493422; x=1792098222; darn=lists.osuosl.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=soiW+4bnwYoMWX+4s8jp0T9nXKlporFXyr3eC0IUFGM=;
 b=qmOXRNf6e5K9+kW0te5ENzl1t2K6gjTSxzGhERwPk1FAFDwj2LDYVXEdMFi7xo530U
 1njHlas96di/kJ7kaCqnTeWHsCsHq6QbhSbVOP21LEgDRnIsVtYTQMIuhUV6U3ohVvBL
 3OYpU6QU3QYG8NdE0hvN5UWVxqStwd6fAqjJ47xb8N7EihvCtRv0IkQy5tVaO1l/q51Y
 TXei++Xlf3FGxA2AIgptqQ19aDhqRW3YlDj1SCuL9W88M2M56j0bjV5zDnzI2YdJ1qQn
 EP6sP12q+zyht54AYnDgWfqZOLSsH4iFyVu/LxMePoSQw9rM6+NwaSYWxWzH9pJnJ/hY
 bbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493422; x=1792098222;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=soiW+4bnwYoMWX+4s8jp0T9nXKlporFXyr3eC0IUFGM=;
 b=pzoConKU6Ir5ITg7k3wxYlneyZnOUsVPfEsmgSn083uMNFmcR2BxCZiowOs+jzHyif
 XniKB0M2yVRvf26ZOcRMIccxUSvqFE6VJqXxaocrqz/r8Oxt/7XeaPF/ReFUq6nZ+AQ8
 8iLdkAe2BH8Aj8F2xSPgXEXGxJ3DCO1uCNlD4f/uobWDegDE57lSJ6yQDL3B25AVnplV
 D5u+czLS/3AcHdohSJIBetQ5+slP8x0pdV7UGF7r1ZwzsPOGevvBxGW/F46qPvHHPNMh
 bRrlgNRABr7ZdyYDif0ty8hrs7ANnXfE7I5Oep2UQrHG4WUiIFyqe8CrGsozKuuBHNra
 kBHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmAT9B5jP4uOSVDRoUUHNaXRR3Z6QuLHqv2X37eyYW8En5sbTSCai+0jXb02Ez3pFpnhN+ixagmsa0/ZtnJfY=@lists.osuosl.org
X-Gm-Message-State: AFuF++l8och9gF0shc8bjTZm3NY5o27fpAaTY7AhO7MZSXneTh7C7oX9
 obEF/1VNmSZRrKvXozr/tu3NoaO0eQKP947kM4qzxVXcGHeZ/hf8/7+c8/K/nyjRIsc=
X-Gm-Gg: AYBFou1Z5AVpWPmOHZvUpNA8sXVddpa/KoWxfBsUId2+Tw8Af81xtkwiOsNhAD6xAfL
 G/siBS6P+Er6XeOB1K/xPgaovxxMgzkQec6s2ENDYeQ0RkYCIC4UaNP0kGYpRwA2doZcjFfYqMo
 9APzoOyXH1/pnFU9R6BR2syLdNE6CmPuvVUM3etdcUbPvsF/C2hyWLOYGaIcp8uzoJ19fRx8/Uk
 X5r+7ckW9i2ZUqLCj8zkYT6oAcUHHv140fOLGzKaYvpA1Uw7pxXPfaryFeCqMWYByAD3LiWZxv4
 qEgGKot8UCDzrtStvsfZUnO2Tj//rYSB3G9Gfwp60NmRv9Rmy8xfzfJIkKOv7PvILbPmcwAxLok
 m1MOmlVHNx7a4xGvrtB3xduvEfuiHSA8Yt1X84Dl0pc4XpHQmkDVmQZt51uUvDXWN5fB9VzXWDn
 Yt3pRBoZE73XT8HDKpsFfWbUK64v7DWLVxo5rlGmmpfbH+BFOFEr6F/haZMCkmnSpCD+HN+SpMg
 q8TjKmMvZU1w1o=
X-Received: by 2002:a05:622a:4016:b0:530:f634:467f with SMTP id
 d75a77b69052e-53575391446mr121614331cf.15.1791493421782; 
 Thu, 08 Oct 2026 14:03:41 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.241])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b6fa262sm3360381cf.6.2026.10.08.14.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 14:03:41 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 08 Oct 2026 21:02:56 +0000
Subject: [PATCH net-next v2 09/10] qlcnic: use pskb_may_pull() to pull
 excess TX frags into the head
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-b4-pskb-pull-tail-drivers-v2-9-8f2bd9bee138@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791493385; l=1476;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=ySH+2yHpni3G+Qu86hbeGyzGTFoSfZJVBnTvasjUVEw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPIm2UmKVJ/FEKcAKGan3gEEsd83c98i++zBisuax140+xkclErvJSJq3lYfXk1tL7clYoB6cuo
 y7erG0zM7/wc=
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

qlcnic_xmit_frame() pulls the frags that don't fit in a TX descriptor
into the head with __pskb_pull_tail().  It already checks the result.
Switch to pskb_may_pull(), which takes the length the head should end up
with and checks it against the skb, so this driver no longer calls
__pskb_pull_tail() directly.

__pskb_pull_tail() also releases empty frags, even when there's nothing
to pull, so if the frags being pulled are all empty it still gets the
frag count under the limit.  pskb_may_pull() returns early in that case,
so follow it with skb_drop_empty_frags().

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
index 761ef3bc8193..e7ab5586798b 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
@@ -682,7 +682,8 @@ netdev_tx_t qlcnic_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 		for (i = 0; i < (frag_count - QLCNIC_MAX_FRAGS_PER_TX); i++)
 			delta += skb_frag_size(&skb_shinfo(skb)->frags[i]);
 
-		if (!__pskb_pull_tail(skb, delta))
+		if (!pskb_may_pull(skb, skb_headlen(skb) + delta) ||
+		    skb_drop_empty_frags(skb, GFP_ATOMIC))
 			goto drop_packet;
 
 		frag_count = 1 + skb_shinfo(skb)->nr_frags;

-- 
2.55.0

