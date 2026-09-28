Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253F7C9833F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 12:38:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D16B080CA9;
	Mon, 28 Sep 2026 12:38:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sWegXDUqS4oJ; Mon, 28 Sep 2026 12:38:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 152F380D05
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790599117;
	b=IfKmTh8xzDzhfX1FgjsE1YSQaQOEAxV/H303TeZC5s5fBqQbTvdtGjhc8Y1df9Ohz81N
	 h5iOcMOmdLydybIf+pHcr5pO7xU1ZoNmk0Gzp3R2t4zSJtW3ODEd2zB6ZG745EuDpmw8d
	 RXJ9Ea04BpuoXWwaT3TUIw+1vPuD726IPsrxp3ifmTbspG8wRWC88V+AFItv4LQQR82ox
	 QWdhgbR448/nduZo9LFZKGKfV1iHnbHA/inEmqt6tcmobOmCjxv3wM5Y0nxJ0931/vN2y
	 9XybXcBDqcaWfVH+aXm57x5IiAEHekIYOxhxAj9tl3ePZUho2TSTyeu0TlIcPi8H0Gg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790599117;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=D+buAjiyG4ncBlcUW+2BpEu2Hb7PWv2fVmuPggXs8iY=;
	b=mDS04sKt6inhaOdVOrfC73Mfv39vQkJGwQSEXiyfFhMy39U5eeIgcoi0nsVerKH64X4A
	 500tasFQ8hWfq2AqeL1xLH/c+GDkIg/Be/p1LmGbThMYxv1F5c2QlIIZ+zVjDjLbzZ7ok
	 aKSa61ooV/W9XCQ+kVpnQlJ2q/5snbb58KTf4orzpz47pUAuUrcNVOrW59F9dnFtpDd7F
	 VPM45MEOJjGmvNgsQYTHynaGKCFQ2lr5hkXLf58ayXHVh0ok6/jQWmQEq46vnH7H8ZoSK
	 9aOjQScsR5Y/g4GQfYPJfHAEM9kgWsn8+txW6b/6+Ss4ceTmIO9rmJsUoAGu/g+Kbig==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790599117;
	bh=D+buAjiyG4ncBlcUW+2BpEu2Hb7PWv2fVmuPggXs8iY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hH2xMt3PcUv3ox+gNj/TP35YmG+dlN+OuqVkaA1moS+9t0QtY3ovUeU6O+FboVNcf
	 0e/5JOLCiOiDG/olIlAExQk8PXPO6VRS39zdIZYDTCRiqHbXqvIThfaTwe/QCOVhtX
	 U6bDbhFu7s8D2pzHeVoM6VMtP2IrOUXPko2L6PoSLGuCvkNVR/D5juhbC/VqcaHb8W
	 DmA4dGitwBMWeGSdSTHW4uTTsdOJ+1XcuAL/P5c2t4MzNbzcekGxgJ4BUCjXG4kaSB
	 42gGKGzbaEeS9U/a07rpGSBED7hmwUoz8nQJ3PLJ7dNFmareiGGsE7o/F4WTrXPi4b
	 g6aV1wyXQ3UWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 152F380D05;
	Mon, 28 Sep 2026 12:38:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E3DB2B6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 12:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 841BF60672
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 12:38:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vutD3BF-3TnH for <intel-wired-lan@lists.osuosl.org>;
 Mon, 28 Sep 2026 12:38:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5E02460662
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:33::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790599114;
 b=P7qqBFDthickalKVBrncPQXvluZtO6cnnkD51fGuPUnABdKZVhajSUDRDv7lhRsq6WOL
 fRl8TVivRppsULe7Z9uE20yJsUZygYqlSnAQycQNledpYALRptWtQ28YLsmLyg9OzSxPA
 zghrPGCKkMhUwp86T4a1wNYpgrUcZyF2ycqxHuEI+isuPlqdGO7HieVIBa1V52pQKzl8o
 L35tYQM22AAZNirxp8qUm5vKXisZICrKggAnHOVVf+ApdAyzC1503dlvVGVY6Yg8Ubar/
 JoqzFCYDl7hOs+SaqKBHtHpnkC4k38QaXav8YlFwfTBw0QrAmPIdBk8jtzKqX2cK+7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790599114;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=D+buAjiyG4ncBlcUW+2BpEu2Hb7PWv2fVmuPggXs8iY=;
 b=GXDL/Ne5ANozY79t1iLnfnyNHmP/RWdSZf/hxGTG5yxZKyY7VYkR4BQVfq2j5leMqFAl
 h+tJVTlLZQq1Fs8OqbOt5PA2QweDkFjcqs8f4R5PTUQFeE4hH+i3Z+AzwEx4+p8+3MwwG
 7PJ1xtPlbfJjpYA5y0cVQs/wLVa2AQLAcLhlAJwcc7JRtQ7O5FfCM0E6VpO/CJ5r3dOgg
 uZ95FShyjXGhm2SZLtw4yRPKCVN/SuQO67fifg1kEOoYk9Ngqns94+OnZdUAMGTxfq3tr
 06fvSwrsSjKH4lWcQ46pcNhDxn5nQypetaOzL+YDTJ4t3v25gvFYQ1NEFUwyyoJz0lQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=I2nfKsTh; 
 arc=none smtp.remote-ip="2a00:1450:4864:33::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::e;
 helo=mail-ed2-x0e.google.com; envelope-from=nsvatoslav515@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=I2nfKsTh
Received: from mail-ed2-x0e.google.com (mail-ed2-x0e.google.com
 [IPv6:2a00:1450:4864:33::e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5E02460662
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 12:38:33 +0000 (UTC)
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aaf688ebb0so3133793a12.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 05:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790599112; x=1791203912; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=D+buAjiyG4ncBlcUW+2BpEu2Hb7PWv2fVmuPggXs8iY=;
 b=I2nfKsThFvd1RoGsnCxX24hNq76wef589pq5ZKdW+T8bve4svQWkz7ayOYlaKSH3xr
 /srM8+bmYK/o9VtN5ybAQsusW88U2ngaA/63naQjFQ4cMnAldWCI+LYs0i2tUWI2zflA
 DWptmcwZ3u7nqwkXD096wJROm2SiU2xabDSl/BMYOWgLYbMVBUdYRUoJiMDPVQikJtgt
 GpPdIUbH5plzFkgjaHSFXb4Fr7IEEj24iRZ7rgRPaCrYV5yTAmRQpfd9lq3H+HXtqpKE
 iHLfsPzbNbWyRokTHXj6dJOkTtEVLcMXtzGgTEZl/r3i/ZOKsaBiJtRiR+D7gjuXn8Dt
 Y3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790599112; x=1791203912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D+buAjiyG4ncBlcUW+2BpEu2Hb7PWv2fVmuPggXs8iY=;
 b=C9s7fT1DwOaIfl2btHgLhJ8c8ze1pEpfEei5kIN/ZXArXOSoxl6wp++Xl0O7UKZ547
 ePwY63Z1Bo3S0FAIAfmhW1ZRNZqaSTjSQ7z+1Nyq1RrDTTuBsLyQKO5WPphlxVf3vM8k
 j3Id4kzMgbwlVsR7oyZnbKKUgL6U9XaTomXOobjIbLfq5HvmweJrxvzcVUg9okiPepti
 QDGAjaYujolOwB3+tvveG57WHspVnHsHYpKvIkHKv1BIcjADGz+Nv46Xbdh+AVdwfVY8
 BvwGsGCAepnmcJpM/GohF+3E02vwQ/9ReP9H5bcg88U7zFT20W62b1flDDgDLL5vfU26
 ty3A==
X-Gm-Message-State: AFuF++lC/jT0tIyyYMWdG2Pqv8fgo18E3vIulMTzDATrnNWUJ+Cw+vRc
 Ka6FHB/daVnqgZA7kuWVB+9/qXFix3fwE9dwUBUP4SYQFNaI/jdUhhQV
X-Gm-Gg: AYBFou2TXX1jvumIIo0birSgu/nWFCvN0l5Lw9UdWT2GaSmO4WdRdciLdvRqHo+7PIb
 3rPuIIXxBxVIJAM60hR4f6FcbG19hWhJ/id29p8lOrTnRkwXZEbpE0RIOb/9tSLX1Z9HGYZgfoh
 EHQoThvV0tKek2+/jCIMWKzhn40j0cLwkXCpR77gTlwLygrNgzEHwMj+TtJQtJRWlRdbPYWVMPy
 CLndcCeMNz8OtQc+JEcatB81UPIs4ol+Oqn37+Sf/Os3TYTK8lVwlTruUzFzWQCeUAjCzEnwR5Y
 PPPRGEoPlodO194lZBfSo8ECCk6PDEYZMhA5Xq8mgvLGn2ekK8McZdEYrPYamwbNmujLeF4ZbEW
 wPf7tNHpU6Y0KyH5QNruIyxwUiOcrey22aA8jnu60ixKtWsgDLtPE1tgFP6RPs9/jgD5d6R7mJU
 wYPv8y/vg3iYwineZ+F381EuIq0m6CFN0KqGFBbnyXVKyKohodCyfJ4A/Xbo3r2vrBogfOj9NSm
 XUs8seOP0u7jOsL1w==
X-Received: by 2002:a17:907:97c3:b0:c25:9102:ed with SMTP id
 a640c23a62f3a-c2ac2311b07mr1040138666b.5.1790599111445; 
 Mon, 28 Sep 2026 05:38:31 -0700 (PDT)
Received: from localhost.localdomain ([94.240.182.136])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2dd69d4f65sm161462966b.22.2026.09.28.05.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 05:38:30 -0700 (PDT)
From: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Svyatoslav Nikolenko <nsvatoslav515@gmail.com>,
 syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com,
 stable@vger.kernel.org
Subject: [PATCH net v5] net: e1000: fix warning in iounmap on probe failure
Date: Mon, 28 Sep 2026 15:38:13 +0300
Message-ID: <20260928123814.2605-1-nsvatoslav515@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In e1000_probe(), the error unwinding path at err_sw_init unconditionally
calls iounmap(hw->ce4100_gbe_mdio_base_virt). On non-CE4100 hardware,
hw->ce4100_gbe_mdio_base_virt remains NULL.
Passing NULL to iounmap() triggers a WARN_ON_ONCE on x86 architectures.
Furthermore, on CE4100 hardware, if probe fails before or during
MDIO mapping, ce4100_gbe_mdio_base_virt is also NULL.

Fix this by adding a NULL pointer check before calling iounmap() on
hw->ce4100_gbe_mdio_base_virt. iounmap(hw->hw_addr) remains unconditional
because every code path reaching err_sw_init occurs after hw->hw_addr has
been successfully mapped.

Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ca1ef9e2e234b8d3599b
Fixes: 13acde8fffc0 ("e1000: cleanup CE4100 MDIO registers access")
Cc: stable@vger.kernel.org
Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
---
v5:
  - Updated commit message and changelog to accurately describe the NULL pointer
    check implemented in the diff.
  - Fixed subject string in the Fixes: tag to match commit 13acde8fffc0.
v4:
  - Actually include the code changes (v3 was sent un-staged by mistake)
v3:
  - Switched from pointer null-checks to checking hw->mac_type == e1000_ce4100
  - Removed redundant check for hw->hw_addr since it cannot be NULL here
  - Added missing Cc: stable tag and Closes tag
v2:
  - Expanded commit message to answer reviewer questions (reproduction details)
  - Added appropriate Fixes tags

 drivers/net/ethernet/intel/e1000/e1000_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d7f5c6f16142..d7e279b739b8 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1227,7 +1227,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	kfree(adapter->rx_ring);
 err_dma:
 err_sw_init:
-	iounmap(hw->ce4100_gbe_mdio_base_virt);
+	if (hw->ce4100_gbe_mdio_base_virt)
+		iounmap(hw->ce4100_gbe_mdio_base_virt);
 	iounmap(hw->hw_addr);
 err_ioremap:
 	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
-- 
2.47.3

