Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCEEC98304
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Sep 2026 00:36:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 429EC60B51;
	Thu, 24 Sep 2026 00:36:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WeJ30KSFJ134; Thu, 24 Sep 2026 00:36:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A009560B53
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790210194;
	b=TcUafx+44ob2as2pdtHDXh46aMbBhmDV4hsbwkVglvSiPZ6NXsTz0u2G5UsmUNrJHSaQ
	 IDHz7Zz1shUhbrZbTZ+SN93N+/b4w6cNym5+cPa736shjB4M+AgXGGi844neaaEzKkON6
	 qs8eNHNLRY2oggqYyZDNxkwalrwIPsHI7PKQG8eo3gGGAumO09tO+x3SgJ3X4gNc+LYVt
	 S7zWIBoU8+AoEk0ct/XH991Y03olfBjzYAb7AD62uBe7sfQKnFueWojs8pD5gcA+MBRdO
	 9eZLrJEbShstY05yQMV5UkEoPyL1FVUD39H+mm2op4UshGZ5D9jQ8VwK70d4HwwKPHQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790210194;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yR6Sw8KFOfic5kEDry7AfTNaMY9N/L+deT07wNcYwmc=;
	b=AAkmzX2tQLlXKMmlju7jiGTN1Kk61v/MfiWPub5mpafCOnr2+bZuMYTKHgIuMJCNq4kQ
	 DPbpwASWSMVM0jPpGx9CpNKcpzcPvMTp4HskoWHsSxrCuqjQQbCTVoNMXKZbvsbtrlTSd
	 EgOT9e0o/LrYbFAV5qk1d+VJw5RHaWqHFRY4AZ0jaCI4b9jh5c5e9QlLVx0KzZixQZEP0
	 0LCKiySNrc2O3de2TXEaJNrkHzzfp2Xl1BRuiXqVqmpcfZGK7NB19zGqsB29CiFCIIIt2
	 miyOnO8pAagTq8YuVam9MPHiBjwFxzZ3nVV0lyb9ddPF4WLs1XOXWfXngTUQ/zrQe5A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790210194;
	bh=yR6Sw8KFOfic5kEDry7AfTNaMY9N/L+deT07wNcYwmc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=4OaBRfE6xQSFhvafaI+MNbu7sCRkjvrGBt9ztSUY5+zjGn0Iwd5hpAREiUARcWOsT
	 r1uSAbrB55VLjMBBoFgndETREtkT9t1AacuWgLzTwPZoS7vVYJw22NHo08F2O1P1hB
	 F1ecoN3v8Q9YovmzMSjRNjSc9pIYc66kqrfFlAWef4djZL331guWgwVnop98sANkHM
	 tVlUm9YyCRS4aweMrHq0mPKMSbyB89/914whiDjJ/Mw4yzXcOjUKwioQkhkHDcA3pT
	 lDx2kwtMl6nUh5DparOPZaCuXyIYDeXyiKRNjFyz+abtiPrVbNOq0RIkqBHO3WCkg6
	 FcGa9g+5l9P8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A009560B53;
	Thu, 24 Sep 2026 00:36:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 65A761344
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 23:48:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 57BB840122
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 23:48:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zBFJCra0cfFM for <intel-wired-lan@lists.osuosl.org>;
 Wed, 23 Sep 2026 23:48:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 739D7400AE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:34::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790207307;
 b=DFpDJKlQx2uR2H52Q6pfbVUvTZjtr4Xy+bVcQ8AMKh8uhP4/NbroGUriUzAZRKEOI8F8
 xHFtJ6+/m+eSbO4j5NxU80QSAXv4Dslb3ROEqX2H45MG+eerOAgBVlpqinrstFQvcd3B/
 EPPWIhBQT9UV9831tbXnqyjzWQbGTEH4mZeFqpghs0v9epZBxSESDEVconNHajiEgF5RG
 Njt/7kzrjt9m26aRh3EGBm0huxyltP2YBVX6TGdVcN9XRcGUUS4uLGy7g+kHU08NteDJS
 baUhfHiFMjm2tQ/hu8pb4iMe9IV8HJcQnJvUgKCUAb/kohseruVAKdKyoNhvUIOn3vQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790207307;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=yR6Sw8KFOfic5kEDry7AfTNaMY9N/L+deT07wNcYwmc=;
 b=IAmgsQ4yCsCMRMH98Oys+aEHug/LgCbnw+Wc9ilsSu0eAtA+bJtzAazZgnyo01APG9ts
 hhij+oDjlAFkQ5L3cbqdOuUXPEIGLDaUc/QTAhdwobDN1P/Jhb6FVoHmLKLhviPIwVLxQ
 bxOAa0SnCeDded2rT88rv3/JPn+caZAP9Lxodb6BbevjaGAkbIjubFMFew2/OAmqyDr8+
 Z7v/Ps2JajazuChE6E6uakN/w79weExdNqBb1fOdw81/gYSU0oIssAXo0ERgMIq6tjZP7
 7GUq9kXtYtC8xHeQibB/uIU3z2X5NgzlNUJUZgVwz9MhrbjimCmkY/286MpNH8+Fmag==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=aXMmHTRE; 
 arc=none smtp.remote-ip="2607:f8b0:4864:34::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:34::e;
 helo=mail-qk2-x0e.google.com; envelope-from=oss.patchbox@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=aXMmHTRE
Received: from mail-qk2-x0e.google.com (mail-qk2-x0e.google.com
 [IPv6:2607:f8b0:4864:34::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 739D7400AE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 23:48:26 +0000 (UTC)
Received: by mail-qk2-x0e.google.com with SMTP id
 d75a77b69052e-5311edbc154so11393651cf.3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 16:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790207305; x=1790812105; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yR6Sw8KFOfic5kEDry7AfTNaMY9N/L+deT07wNcYwmc=;
 b=aXMmHTREi7zFtX5+RVu0EHA6AjBI9PuKzjNBPiuhphp1ZsHZrf42MrflOOOGhU9D0W
 CcIeOirSkmLaFwjVN2hqcgXYAMexFsEyveGWvK9tDT/2ttgdrfIWYKnlMqJ/39owkA+T
 6W4NRg6BqsDjodAJ9bTbw5HXwdBee/apk+tVl1nyK7dLW6ib1NiwoUcfcnjBCyipoG4N
 xdzMsV17KmLrW4gpQMsDqtsT2Ou4kNAd7d1mwkBOkhrePdw6osYDEtSPdt6hm9ntzXtd
 nFbMrKg8+7CIfO2DOBSHRHFwvFD/n+OtKIw8yLp305ZT1Cm97RXbi+U+k3FqWKvVqsvy
 bmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790207305; x=1790812105;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yR6Sw8KFOfic5kEDry7AfTNaMY9N/L+deT07wNcYwmc=;
 b=ljnLBM8SFgIL0qSAGfdELXfMveQ54n9czC8ThTeC80zUmQ0UoXdsUGE/4ylPweV3VE
 f7UvL8Htoc52PdqyoswLrJTAUtkHjKqnyf0VNgVRVD+Lu04Sb6sVs1IY2vryXlayXXAy
 asPJgYVLmcv0pxBgf2hS1EfcGsv5kUyljbJMvCCMwGZR0H2iiEOlvF5dcMMrFh5S4yym
 vZW+PMW2e+Qoh4g6FdFvxfcNIuZhm2wS7A7bHZD5q+8G2e/2vM+JjLeWkl0FQAVDvNVh
 JK1JCWzegWmpISv1bd7trufZZ1sITrMigFR09fgb8gfw5HL63AKektWK9Mm8KS0JJ63u
 AaHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIYDMnJUuUWlIODtKQlquJW/eDqkjzJ+KWVyHRSiG50Qhpc2zZSk3yWvU14sUIZf53A9Wb0o7CIitfRsNbyY0=@lists.osuosl.org
X-Gm-Message-State: AFuF++ldQDW4l2xPBDR0c30+vcz8CEVVCUgZcry0+YGmc/jm8b7mCJTS
 2IQX98mwdL+zzraTHazjG+KqoROoFEDQ8IsR8grzLxK86hIfRqc0HBeC
X-Gm-Gg: AYBFou2EdeZwOMm0TjzKGWrCMvWhWoWXw24YM59c62s6ccWO8yZ1R67DSgKDFOazCF1
 SP2eTNzUAsoW6XzLOnXgZY73CVkUY3Es7uz8/R+cibHD0F4SUxHzFUXuvmx1ZWiHWQP2QpYA8xi
 cpfFCGyUMFYR9nY5PrzmME3Vjm6htmtHUw6dHV3CD7EjV+1bVJxLnT/jLIfd4I+l/vN010X/0DL
 nsO4vx16/IeofJ5dbS1p9oa9mCoOqncVLOESN0E/0DS41Jixtcbzm723h75DG6jz50uCou/OYVM
 2pTnwQ64ZcsczXlv83iqbunZ1Kki9KEwsGq39icQgIeHTiXVWwHZihOdCEKbj+fTkC4e+NsDVXL
 PrOOdOow6QRULhMdMZQbGW13W+Nb9X8cVRNKA/KEpvbvrfV4vbb0uGsYMRySIDFX+3Ljw36NBjv
 oaXhtKGzD4FV9yx4EPqI3j2Lcp/enG3oG8CCWsVmF98ti/Gtstg4tsrobqaTWmCgl7tlKVKVOMb
 JdMH3oeKqXpLuTqW5F0fQ==
X-Received: by 2002:a05:620a:448b:b0:93a:3aba:a0d4 with SMTP id
 af79cd13be357-93c3633a150mr43043285a.27.1790207305188; 
 Wed, 23 Sep 2026 16:48:25 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c248a1481sm334514885a.35.2026.09.23.16.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 16:48:24 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH net v1] idpf: Fix vport IRQ name leak on request failure
Date: Wed, 23 Sep 2026 19:48:06 -0400
Message-ID: <20260923234819.702327-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 24 Sep 2026 00:36:33 +0000
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

idpf_vport_intr_req_irq() allocates a name for each vector IRQ before
calling request_irq(). On success, the name is released later through
kfree(free_irq()), but when request_irq() fails, the error path only
unwinds the previous vectors and the name for the failed one is leaked.

Free the allocated name on the request_irq() failure path, as done for
the mailbox IRQ in commit 9bff30482c10 ("idpf: Fix mailbox IRQ name leak
on request failure").

Fixes: bf9bf7042a38 ("idpf: avoid bloating &idpf_q_vector with big %NR_CPUS")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Compile-tested only (x86_64 defconfig + CONFIG_IDPF=m, W=1).

 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 4311ffa30bb1..e7d5e7923371 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4073,6 +4073,7 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport,
 		if (err) {
 			netdev_err(vport->netdev,
 				   "Request_irq failed, error: %d\n", err);
+			kfree(name);
 			goto free_q_irqs;
 		}
 

base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
-- 
2.43.0

