Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A507CA6017
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 21:03:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2981460727;
	Thu,  8 Oct 2026 21:03:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1qoMTUjtgsin; Thu,  8 Oct 2026 21:03:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 83A006084A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791493421;
	b=s8858+Xo5LjgnD+NwV5zCdwfCS6fve02dcyT86ciPJwzuoQjyLN2LElRZwPqg85U3Yi7
	 adfn0VCvt5lGHdtXB0TNzXC5PWJcQdmsYGgevkBcAlqCCZ0JVTZo3SIdD8YRxL7DMS7U8
	 kkJ6nXvswT5TPfQ2ctppLV3PgX/yS+Gb68EvlgLfCAVcfFl7gNRkpjH3IDITyJngQfL8R
	 CRPo+uYyzyCxjUEeRyJTcYpDONLqykqU2RHEvs7tNv1zUP6bgfWbNwQOZiioEGZs/HsrJ
	 9oG6CIJRGXMGrtLgT7yHAIQeSa8oVBNPKYrD8YxvQg56XUZCV7Nv/s1WDcJQssu4WKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791493421;
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
	bh=pgpiLoGoqA0xV5yWN2rO1XVw1oOPWsG2lgMDpzrz1ts=;
	b=PRov1L8SOND7I36ZlSg32VskFKnZg1azF6+f9fWFLr3lGXsh+sE8KGwYylTD4VWaIjJi
	 frC0wu6Z64Vx63u4eltjrZnoGicN+LHX+0yE+uJb5VcQVgmvdGtZ5qY1iscSbo/el1bmw
	 f7m5qi2PTCloQx5SXtmZaJZ3eb7fpROrqeTb5NX/h2kE76D90zY7FomToUrY4gMQCgU5j
	 QVh/w2h0km66mhjhV/LM0PNdb9poeaLzisX5UmvJx9yCQ4Bdelq0DzpAf9cySZK+v5Ofv
	 clEK2XiuhMB3EamcGPCea3+W++2vvWS2slrejzdxqQ5Wm5+Ytg1WLti5OGpFsJRgYhA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791493421;
	bh=pgpiLoGoqA0xV5yWN2rO1XVw1oOPWsG2lgMDpzrz1ts=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LSCYjtbzynR1xzqn2kfpNhDwZagWosbtuVr5ntvXys2yRdAR2agWSlM+AfzCgEv2X
	 dpqtkpxLYR+m2Dndg04bX+/eoBXu2ZkAzgyXjbNXbXo5NKRH6VKrVCIO3In78b9Dl4
	 FMR2X8yZSNASF5mqfAdKfO+nOGT0HgS98x5b8z3uY9UVDT1frPAOCjYIuUWwjXFRY+
	 ndahsDZ+7PZhVBl+yVDRvQJizt3abtck9+YSk7nWm9OkXf2EG12gy5Ij1tFnJ3pI57
	 uh/dPeI0K1lazYnP9ganOo9zYxB8HKHezgP9eDz8jt6Pv7At2N3whdcciklsskqn09
	 7qg8CC/SV0KQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83A006084A;
	Thu,  8 Oct 2026 21:03:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C5CA2E0
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E2DB81258
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kFyqf0XQX3Ne for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 21:03:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AC61E81255
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791493419;
 b=N4rqZVeqI+IbhnfDdIRCDfmqp9SmzlWU9SYyU4jTt+Cr1T+t09ZRUm0Ky8YUKbyYdJr/
 uOW+wUVDEwekCn2gEswduhvBolIslFBKoNqSzLBzD2CJudyrzpA7CPhv2+1S2ws5V/SO0
 jKaiRFZhBOYU1qbBOt3imIDzIUPnjDL+HlBqv+3MZ//CmktGw6noYBisFUeyicCk8SPoS
 hPzXR8eDJ8aLu4UKuvMX1ari+16T+aY57H62OgFggbIjfddcSg+vzLnqYCpZ1fKtjUSO6
 FAj1Z9zBombY6abo3TzcKhME3UEuICa5ZQhbQrvnwaHf+KeFy78gPxLOlRuN5drWHFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791493419;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=pgpiLoGoqA0xV5yWN2rO1XVw1oOPWsG2lgMDpzrz1ts=;
 b=bT1ZAin38mYBkds5IHwMPG3B/BM5LmFo+G8aksfvzXkWiuxBTkpMsHXDNTIK0qyQEeX7
 anFQKHRewKJ/hWBadhhg5MAJm870IPJvhWwP0X2WPNlWBcRln3nKIKgoNIft3AOwcqNSl
 u5JUeNG1NYFVxEhKenuKMRJokSGj1plSdm0p82isllmqi3lChrrAwWmhks5Pd0IFku7Lu
 vvPC0muRyfJ9mnuC8/59wbMrJXEh0c5i7geU2x6fzWybs9PSCi+lSFHBQbU88gCx5nanN
 +1GU+jHUU8cpApkNOX+Ng8uEJkiel/jQP5pkARu3I/Ka2GHQ2bC7QAE3FEp5sFSs8rg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=toxicpanda.com;
 dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256
 header.s=google header.b=r6yGkeD5; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com;
 envelope-from=josef@toxicpanda.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=toxicpanda.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com
 header.a=rsa-sha256 header.s=google header.b=r6yGkeD5
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AC61E81255
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:39 +0000 (UTC)
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-5350cc60b51so54327631cf.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 08 Oct 2026 14:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda.com; s=google; t=1791493418; x=1792098218; darn=lists.osuosl.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pgpiLoGoqA0xV5yWN2rO1XVw1oOPWsG2lgMDpzrz1ts=;
 b=r6yGkeD5aDDTjdapBtU3lRJAZ+B/Hf2V7AWr5seMvjIsoiLB2zxLi4fYC7pHRnZy7X
 N4qEN0Op9shHqDE6e7l0Irf3pw5se7CjwRvAmbJBKnRRgvgx/vGfUEwUzr41aub1Lzme
 leVmBot8j8gtNOAFywEuacrfcNmqh4ovQwyWAmMI9pZQRYlgWT9/PxUvk9QAFPt9jHKh
 j7WpSKR2DunkX329CPQtlFk8cjo4dqvez8k+yIOhM8sNWdgIZKCxFveyM1i7FSoI9/kv
 U0fFPY0TdzcuAw4qc4WicnT7b+LySwst6U0MVo+d8W1u/h5jsoaXbfyprxL8oj9dqDOd
 pprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493418; x=1792098218;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pgpiLoGoqA0xV5yWN2rO1XVw1oOPWsG2lgMDpzrz1ts=;
 b=ssMZgczCpwerH1qTraL9C+RHtyBQJlDjOFlvDpLGPsDyi9lPRxUrAkK4axVLgbzQcY
 D1oCmzdNEi/TQxuuhSEB3aK69ZMgVD3Dq98/emcTHbUpcps9BSilsroSs0Yu6KoRDW6H
 CiF6h2YzTf+VWURfV4SBtRbLNahRv37Jl2YsgQi+LHH8WVnfgl/QYgUHYE1Yul7rLUCP
 XWm2+MnOSpcHSy8Ca16iqVTMCsL4fkAYud6wHpmTVg2+DXMsXYkrfYZw18fQtxiHvMfx
 RHihDusim9vanuKBwiotRJazJ3l/1+8TlxUfPaJM5Ftw2xc+XHu2RbAphFW44D82oOJD
 VXPw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwsgJFyokoBpsHK6EITHpHn6a6aHLnWmceyYTXFLpVvhreye6HDPhOS50RF2622v8uYQdjtIP5ZuV9FiAI6fQ0=@lists.osuosl.org
X-Gm-Message-State: AFuF++nPEZBnjLHOCLvlm5jaXMQM0fAwICe3W5CXU7sVc3VqXo7mRtY1
 ZKxlCzIX6ZyoNHB2rFhtagQRAHskGY6g1vbqb6rxnD6l8+MNrsfYq0Axx98ygtVBkwU=
X-Gm-Gg: AYBFou0i18uM8yYbqIZuOYVxmJ+lW1mxoj7lUtQXEYrkvaAMdueliBir8wJuuyMpMl4
 4bpUKCXgtgyJdE8KG5lAoUiz/thQ151UOQTek1j9osV+Cp9iH67kv44/hKHe04/3Au/lh2egDSJ
 mKSBxTjn+26CiSWzlZe03Jr0UqrzG6t/dZwkqYpZ2c/czBCcWoxmyVV+qyej2wZ/7pW08av/k8Q
 oOx1U3nh9cO6rIhjwBTCokJhqPt3Sin+w5cvdTxFDqIHVWEm94ycs00Ngb8UuvFbLLXfwRX5J1I
 AFwGaFjjjOY/gIAHvZ0mhvRI2cg7VzSsW7wrlhe4gaeqdwdMxPUCDqD5hlkUIxZdgjFQbIQtvmj
 X5l4MhxNBf7aL393188BTurWp6pTdEJw3QVVJ9Or59ZIlhHiZMm29BZ7HracYdDT8yDg5WefMVP
 A0GhK4LSt1ue6z9TaXBU5UitURXNI4FsmCRl/S8OJQsOqHs9ug7OL4ZMjnb3Hj1pAHXAQeK/taf
 fyf9QAbMGPiOzM=
X-Received: by 2002:a05:622a:90a:b0:530:e52a:8ef0 with SMTP id
 d75a77b69052e-535754fe4e9mr117963541cf.26.1791493418024; 
 Thu, 08 Oct 2026 14:03:38 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b7ecccdsm3179791cf.30.2026.10.08.14.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 14:03:37 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 08 Oct 2026 21:02:54 +0000
Subject: [PATCH net-next v2 07/10] e1000e: use pskb_may_pull() in the
 82571/2/3 TSO workaround
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-b4-pskb-pull-tail-drivers-v2-7-8f2bd9bee138@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791493385; l=1188;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=2XY23bjEEEbmilzyi/OT0dLNP6D+zOB3zspYb8/aVZ4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAo/dBnlSZS1Mj/EC08Jadkujj6NZVKDZ6T6FMxXeYq/Bm8xNWGafGFpWL2jadSBYVOawvF0VKq
 O0PAtfO9A+w0=
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

e1000_xmit_frame() uses __pskb_pull_tail() to pull up to 4 bytes of
payload into the head when the head holds only the TSO headers.  It
already checks the result.  Switch to pskb_may_pull(), which takes the
length the head should end up with and checks it against the skb, so
this driver no longer calls __pskb_pull_tail() directly.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab37ad..e216868e15cb 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5859,8 +5859,8 @@ static netdev_tx_t e1000_xmit_frame(struct sk_buff *skb,
 			unsigned int pull_size;
 
 			pull_size = min_t(unsigned int, 4, skb->data_len);
-			if (!__pskb_pull_tail(skb, pull_size)) {
-				e_err("__pskb_pull_tail failed.\n");
+			if (!pskb_may_pull(skb, len + pull_size)) {
+				e_err("pskb_may_pull failed.\n");
 				dev_kfree_skb_any(skb);
 				return NETDEV_TX_OK;
 			}

-- 
2.55.0

