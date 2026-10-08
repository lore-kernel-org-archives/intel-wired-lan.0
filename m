Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91AECA6017
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 21:03:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C17A4092A;
	Thu,  8 Oct 2026 21:03:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ye-BtAtWcQ0D; Thu,  8 Oct 2026 21:03:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E404D40938
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791493419;
	b=p2Py1Lk4bvfHVZZF37pIeFLix2K27/tx8PcuXwHLifXyJcSxyfk8BDXn2wHcVO6tNGXE
	 k+8hUykOV9+xsVk+1QepYDh/YPd0uirUhUslhT4rzbACRiG5KDpKEPwe9ARkueJkw/QOo
	 GzbXEIvxkdWy16u5sKPJz8RYneURhZ+aW1Ioj1Nxw4y9eFt9ke40tFH5TRW7DkMHS92Dl
	 /Uh6u4ZpPBJXfsNoO8A3tdqoijjcOOTNW1e4hi/5i4qcoO6VtFVkYBVeaZlgL9OyueGmQ
	 Q90yWY6Y84lGK6DfUmDOJVYXaz1PEJHVQph6kM80Z+XGtp4HFdxQ1dcF2Sv+VChZVIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791493419;
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
	bh=jtyJNESs2NfaCrmwRAvvPnxlfOHCunirXFuek+zM5MM=;
	b=jZNocgg1iim2G6iuZziMVcbOdkSAst/uFCxoW4h/I+EXjUBHuITldyrT7MuWjpubqE4N
	 BC6O8XImErYN3A1LZDvz+rhPY9I1h4LGL8FYdO2KZNYyq+lVh8WzjUkmGC19sR0pVXb6y
	 MWVBDh2rn5j/r5zLI1obb/WkWeYaY0S5ucLASrj7sy9i3bHsF3mH7U+SjbAH1cFbtS0ET
	 /d2s04snKwYxesm3ATGQBxsDqQiSJPLY4WMP+2S92qn18WkurBdDw29WB+PtZkplNKgbA
	 PNC0vi5Pbd0LOHZScVpQuB5KAukuiNSpEBaRwjBdT+zeZfBkcwxkq21VtlCH/sVQGcw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791493418;
	bh=jtyJNESs2NfaCrmwRAvvPnxlfOHCunirXFuek+zM5MM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=39P99THHdkPuFBaouk6n8mS19NYnutNsaRZPa33VjR7Zr+0CRtphVx2Ty9a3d8FuR
	 +JAxftm/ECPucJxu2oclQ2N5tMPtjpCM7FqqVtzq9cePdKDSFrZq2h1mHmncY/W9Aw
	 5fjWoxrTwTcJjpmr5ZTKyx8BqKQe5GiLIzZCEYSC5ctbb9A0alTZ3dF5vSnagm49pp
	 DfDd0wy6gLVLOwbdeitqm1aPcj5UfvR0O+BAGgz8wSVzdsVvD0ht+/0v9Q2QBdPEh1
	 cYbCB4mPOVPNUIY8gEAVAjf3WhiiNUBejUNbhCiGD55+pXcUsvLbh0/wS4bZvS/Ho6
	 3rtxqKevZ6bKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E404D40938;
	Thu,  8 Oct 2026 21:03:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D3C4B2E0
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D1885403B5
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YRTIUVWFQfGb for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 21:03:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0FF22400CB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791493417;
 b=DR3C/z79g4HUo0Bf3ntTpQFLNvnXGdYFiKVm2XkJlCVPIz9S3BYrEExqCDKGmbPF/W0l
 1PSU3Ubf/GzXy+xoCyZKwpuSAZDi7caUoqSKQAwASPzA2PCmolMfC989uOgdV+DHmcydx
 hi59UMIOAOIb2vPLl6h8VKE8YKOSKA5qkUgO4buj9k3PQ6HFeIfxnrarn+44R2btr2c97
 QjyC7bsKo8AJnKsQnsPYfrLpJMP2mQZe5vM8dcDc9VoUkwLD+X/nb8lOMmUZmoVr5+i5/
 VkLv2jPKtV6L+0sblxjfuKMiA9s+kBu2G8n0lbYs6GMh4eDkVjdgnBIGSsHBmOAdEmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791493417;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=jtyJNESs2NfaCrmwRAvvPnxlfOHCunirXFuek+zM5MM=;
 b=mGdDZjmO2LhoJ1DEbqrgOKk+YX7U0lR/sQSA6wzvluRDzG+DTwIjfvHVh5kWw5uV/m9M
 go2YvIVTbTnP/yNkvRUy7vcwK7zSl17j2iaxNbq7nxoArGAsrF/+PIS2iQIjZf+oviyr7
 wSmP5WJPoNALktC6CMUNXKlkV/cWm5lUCnDdbePG/NaEtVL733QzAk30BHHE+P3xYmwmi
 lqLQLA4GjWEulvHBgsqQIvepSnqwLKByzMIXcXwJekwfGVLTzuwcWN6DFLLhUFqK2wWck
 jEqAgvDcO+AWx7Bk67wglT1QG41CcG3oDuugvJeX7YOfOMXQQeBAbhBVjdVhJ/kFVaw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=toxicpanda.com;
 dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256
 header.s=google header.b=aoJJ3A4n; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com;
 envelope-from=josef@toxicpanda.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=toxicpanda.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com
 header.a=rsa-sha256 header.s=google header.b=aoJJ3A4n
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0FF22400CB
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:36 +0000 (UTC)
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-533972e0cccso34167151cf.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 08 Oct 2026 14:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda.com; s=google; t=1791493415; x=1792098215; darn=lists.osuosl.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jtyJNESs2NfaCrmwRAvvPnxlfOHCunirXFuek+zM5MM=;
 b=aoJJ3A4nfkVeZJoAicBpn9igecWvxRJRxS5ZgghQvLGH9cC8zS9Azheg1Bfe42/9q6
 Y67AXSVSCo90w+pUEwAspbgOAMlcAVbEvk0BO0k5RfpQcv60IKG/sDoI5OPKiPZtHVoj
 EL/5vo6Go6CeIGzPRYGPzlGuNiJ0ReX6M8eL/XEP+OHfwD/EM2TTvOx5DbwrjtIw7Lvt
 5QaxWpHtOh2MlNoSsmv7VGBS0eTwM92p399QvkBnUjeW+nM3GdF+239l7HasWIhnVVI7
 w1D0vJlXWsjLyn+Xd+pmvW9uYUVUfFbEY6vIPN4D5XtLbfguvALYguFNooBTnMVipKfl
 sXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493415; x=1792098215;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jtyJNESs2NfaCrmwRAvvPnxlfOHCunirXFuek+zM5MM=;
 b=pSZOyLGlXiDXPEL8Lvogmd1iDtJ0tqOO50P4DGs5UJNXELtnKTgFlYT5WnBgmHP6wd
 MZCsh+QdggSu84P92xkmgNjcYf/JYuTxsEkxAGVuxdWAaUVEeves7LxYFq6udP9iZNwG
 CF3ham8OMyYA98A10O3MPn7LjncHW/j+7FC9qhTw3pkSyIp/tBWFv3OIjmPdayiepr/g
 Vm9qpT8sYi4jmRR7LxONRcCzdNIaPvradZVDve2Cp5ve+SlHmGT/XRpoBeJ1WA82D7no
 5obcWQ1v5uQe//7nJj1ZkqFmsh5y0QiOq8lyrkwiuyugjxURxFvoUQzIry0sZHjMuCZK
 Mzng==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWeJdaQamUc+/L787MAo4ViKcuAgNjlMfeaR8MIBBFK0xO098Z66TR/PIvOe2Wi4wcQuuPbJQaBmjnzhJZ6cQ=@lists.osuosl.org
X-Gm-Message-State: AFuF++mRhO6Jz05GAd/vCrMMEiSgMvm00TT2YWoYw3aeiohqDJfaId1N
 IsoK949EcFr8CJ2slVAt6VwHL9YbGjqe3WP9fjT+t8IDpOoo/lMlxdSW447IJLqG4IQ=
X-Gm-Gg: AYBFou2WVJ+SzI14npjlFncLfv6PUDfaakMwO/VcGb02WUzPn3qZZab7HPAqQ+NIafU
 ApoNAACvJWXbVJkFE/m7BynCabSVTqMgP7JJHDoP/tV6xNzvXZQyooRG4oqaukKLVK5ZTkWas4q
 DbKg0RftaWYjAdDI0hqE28ooidLcC89qYtTWi8esDiOrQDgPqLirxud+FamzMnrr2XXyRvGmw1c
 lISS2kZtsNtaNNATu6wkcFjCGG5tM7ukt2HOVhxyKr2/KIb/9lQTfw+Ga3REEUTXGG/u1LecyRg
 /lNS8RG+yN0c+l6HGSLohNwht9Ui0d8uQdnUpo9AhA1PJi/+mHuPx3lF1DlN8oZG56Yqxwjywop
 UMVVc9CyHnoMFwqlQkdNclEw5J42SUzQU2KLv83/NVbo9XJR/iH45RfxlZsrqhyG1uelTcLzH7o
 Ly7qrsZao31dsLn6GwrS4oTqyPZp7kCPWvuGx7MCkezTNgs4WmtDrU7CErhMJVITBHl3XoSj/Um
 ZvP8l6viPkFdDQ=
X-Received: by 2002:a05:620a:4613:b0:934:ab73:ac53 with SMTP id
 af79cd13be357-93e9af42cd2mr1369444185a.0.1791493415593; 
 Thu, 08 Oct 2026 14:03:35 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.241])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93eb986c0e9sm24158885a.20.2026.10.08.14.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 14:03:34 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 08 Oct 2026 21:02:53 +0000
Subject: [PATCH net-next v2 06/10] e1000: use pskb_may_pull() in the 82544
 TSO workaround
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-b4-pskb-pull-tail-drivers-v2-6-8f2bd9bee138@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791493385; l=1221;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=yldyXc+k9IUGHFBVvbXY7100U73O47dmandGyjhHpkE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QO2CfzCzBOeK9ZW88WGSv+B3RUqXFGdARFKgVlna7gjBWdR0TdJniqj/mr2mdJ20mJNMEnviLw3
 DiEJcfynbhAc=
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

