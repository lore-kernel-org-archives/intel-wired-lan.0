Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC1BC98332
	for <intel-wired-lan@archiver.kernel.org>; Sat, 26 Sep 2026 13:27:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E826810A0;
	Sat, 26 Sep 2026 13:27:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SeXEEou95KC8; Sat, 26 Sep 2026 13:27:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8492281065
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790429275;
	b=i/I+szSfeFPDs3et0b7jb4RsGpdwK096Mp/SzsaczPx+Blk3mzzhk3qud+nn9QlecdBZ
	 qIQf0gRPgaky0KWwhkfsPVhQ7R5XwNwbBnw77zyU9T2jGQ0Ke/tfXldPmnSVTw21zaNgL
	 40uztwIRXfl+K3GsOjDdLWJz9knsrHg5uTJiEBq4tjXjcSABwWlrTfYmX1xfgFg5NJYdn
	 N+YzTF34ladA1vN1kC9rqPB2gmcylMBMZg/VAkNIpIH/lswFcOw+XnJwSTcrxeg9RwXgB
	 svD6te4eAFShcw0AfwqiPFxQwZgvAA/TXc78VOLvVlEYYyC7xzXCa3UPqmmY4lHIy7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790429275;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 Received:Received:X-Farcaster-Flow-ID:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=SvyQxUuoQfRvxhBnOj0Xsuc8gwJZCfMFGw0CG6ch8bo=;
	b=nQ3f67RN5fYDIvjB/qCRz3706aX2PcfO/XoEEJsbmlKj6lw9BLJVPI19SEji9Xk15Ic6
	 v7czz6wOf6KXhDxbubFKTduDcYXRGm00fuTEtVXwsgAoVrqQbU8XzndEq2m7m9vwfmJiG
	 1MOFJs412oucldGa2gCjosLFRxuTqs8bY+noxWD4Mzzzc1u5i3pnPvpsUvijmrtBqTTzp
	 lhY/xxOdymsBAAppLvBZHALy+ZTkKdFATPNuyCwGMXtSYd1NGLR2JNRARD4IM6Mp6wwoX
	 +12TU9CQhi5XKLl6I+VUbS1njyrTUmnFQweWvzRNElhKuOy7NJT2MuD+F+06ZXkSWWA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790429275;
	bh=SvyQxUuoQfRvxhBnOj0Xsuc8gwJZCfMFGw0CG6ch8bo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tNw6hmhzwpWE7EQot6vqttUrC0TLU2T+aPZAgsT6kn1bjFipUsEuN7JDAehyGiYwl
	 3Uv22jL5uOh+6VzBXZeu4N6yppsE2SKFesuyJekS8hwRfIpyXLoz2nknAt//xfSHLr
	 k//5K0V+K6Mpgg2EUjciOsuas7yamgj3U7+FlXj8nbYIWLnT+DonB+YvhxVn3EZhUQ
	 9oVZFFZMoQdwH154ve0J4zJSYAtmOPiyENLY/2nordJRnOfrzo3xbZPc8ycXNtdp0j
	 IjoPzA7gJdqyBIfXpMw53VFSkuNKl9038eqZD1qln5DFL75rQd9AFPrsU61Qy/rK1l
	 fwFcCp4nY1U+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8492281065;
	Sat, 26 Sep 2026 13:27:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EA06334
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 13:27:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2057E40059
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 13:27:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ahUo4kLBdj5w for <intel-wired-lan@lists.osuosl.org>;
 Sat, 26 Sep 2026 13:27:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0263140050
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790429273;
 b=oiGadA76mgurWmopevUS4KYajMB6Cy0coufd0Q4dSVq4zRGNNFdI+KqrJMnzHiI1vM0Q
 AGrd+j399+JUPhMFhka9R4RTbdAN+1ReSV9R38x5CRKJuKliWSlzEOAE15BX9d1Tje4GP
 er1/L6dHTbYnUi7hLPbnN4kl0M4/Pilq2zOw8jiZ3KfKkMSF7HeMX3id9UQauJYXtMRWJ
 5hqcjpEdOTv5F5OQ7yiFzW7K58DDfjbYYs5VLnOMfHrN3LzKUGDkMVSTFzMXNllk4ix9m
 KkChTpmPHv3/uWVdz+cTJIyQ3JnIx3DBmUwlez4dER0pZVxSUJI0VRSAVplHYa0IHJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790429273;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
 X-ClientProxiedBy;
 bh=SvyQxUuoQfRvxhBnOj0Xsuc8gwJZCfMFGw0CG6ch8bo=;
 b=TVkta4mAO1d0IEfJdpi5vHT9jQ2nk2SoSp91WhWEOt+68dU9HxNvPBUJpHZJipRtBQCl
 ns2XjmkXr2+T7L2FF9COH6ymfyX6A9VuGaKlU4h94axJVtR+96s8hKA9JNxp2bVQ8Rb02
 g4FWbLnhML1HWqHNQQNxrkNSGNpG3vAltmrj6hXlGddLECa5ONgfQbQUP+x7+qmNIhC8J
 9Za+rbO9uoRhMkDMrA2K8osI2wztE5y8nz2AmHgSw8+gMGW3YK76pfxLo5VoNlxw8c8ij
 yzOoKV4r+VFRnEIAfA03B8Xg2D1alSopko/NHApb0D7RP4PwwwKhJMT7usfrJof16HA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=amazon.com; 
 dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256
 header.s=amazoncorp2 header.b=EHszLx7N; 
 arc=none smtp.remote-ip=52.12.53.23
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.12.53.23;
 helo=pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com;
 envelope-from=prvs=722cd8cf4=hagan@amazon.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=amazon.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256
 header.s=amazoncorp2 header.b=EHszLx7N
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0263140050
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 13:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1790429273; x=1821965273;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SvyQxUuoQfRvxhBnOj0Xsuc8gwJZCfMFGw0CG6ch8bo=;
 b=EHszLx7N8t6rjP9BMFkuFVJjFKtTBpIto8owhwlmt5YniCTuVKVbjjo9
 f6bX2hDMHA+oD9sfkKEtKg/77vu+ghQHcnHbyKpbZAym8yUUraabYUO3i
 Sh9BVWzU71l19BAbbQ4k/RDBYPuKJg7N8Sa1owD15Lly/cXUvq2cHauxl
 ve3/3OxEXW4lWTBYEtoUkuFVxdqY+I0ToyLayp4qWtN3ijYG22K0XJbwm
 UJji4kf8ePygCdtrhLF9sSG/cJcgigsH+/n2/CKdtEF8wEP2VoafEqfie
 P+TYpaTPuK7nmIcS0/d6cEQCjOkAFWoVA9+SZF6df7cd3ysNpHf7uMt5q Q==;
X-CSE-ConnectionGUID: i/P1bY0nRx+RXw8Mg/RmVA==
X-CSE-MsgGUID: me5NK4IVSQGoCmyAqv5xmw==
X-IronPort-AV: E=Sophos;i="6.27,124,1787011200"; d="scan'208";a="29576764"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2026 13:27:51 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:8094]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.144:2525]
 with esmtp (Farcaster)
 id 9d715496-4bc2-4d89-bcee-5a783de8659d; Sat, 26 Sep 2026 13:27:51 +0000 (UTC)
X-Farcaster-Flow-ID: 9d715496-4bc2-4d89-bcee-5a783de8659d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Sat, 26 Sep 2026 13:27:50 +0000
Received: from dev-dsk-hagan-1f-c6b5e25f.us-east-1.amazon.com (172.19.159.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Sat, 26 Sep 2026 13:27:49 +0000
From: "Craig I. Hagan" <hagan@amazon.com>
To: <tactii@gmail.com>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <hagan@amazon.com>,
 <intel-wired-lan@lists.osuosl.org>, <kuba@kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net] e1000e: fix flow control stuck off after link
 partner reset
Date: Sat, 26 Sep 2026 13:27:44 +0000
Message-ID: <20260926132744.24777-1-hagan@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <42cccecf-ff14-41e1-811d-e5a44f3d1aab@gmail.com>
References: <42cccecf-ff14-41e1-811d-e5a44f3d1aab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.159.5]
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
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

On 2026-09-24, Matt Vollrath wrote:
> I didn't try your patch, but there's a four line fix. Where the watchdog
> resets just the PHY when the MAC exits DMoff state, set FLAG_RESTART_NOW
> instead of resetting the PHY, then goto link_up. This works for me at
> both 1500 and 9000 MTU.

Thanks Matt,
I've tested this approach on two I219-LM boxes, each attached to a different switch:
one a TP-Link TL-SG108PE V3, and the other a Cisco Catalyst 9200.

On the Cisco with jumbo frames, I'm seeing, via a diagnostic message, that
the fix appears to fire and work. I have also noticed that I no longer see
it on every boot, but this may be correct as I've not seen traffic stalls.

With 1500 mtu, I'm seeing it engage fairly regularly with the TP-Link but
not the Cisco. I'm guessing it is related to how the Cisco negotiates. In both cases
traffic doesn't seem to stall.

I think you are correct about flow control being a red herring since
both switches advertise no pause (Flow Control: None) before and after
recovery.

I'd like to drop my patch in favour of your fix.

How should I proceed, should I propose a patch with suggested-by you, or with your authorship and
tested by me?

For completeness, here is the diff I tested (I added an e_info so I could see it fire on the
test rig; happy to drop that line - it isn't needed for the fix):



--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5254,9 +5254,16 @@
 					usleep_range(10000, 20000);
 					pcim_state = er32(STATUS);
 
-					/* Checking if MAC exited DMoff state */
-					if (!(pcim_state & E1000_STATUS_PCIM_STATE))
-						e1000_phy_hw_reset(&adapter->hw);
+					/* Checking if MAC exited DMoff state.  A bare
+					 * PHY reset here does not re-run the jumbo
+					 * workaround (e1000_lv_jumbo_workaround_ich8lan),
+					 * so request a full reset instead, which does.
+					 */
+					if (!(pcim_state & E1000_STATUS_PCIM_STATE)) {
+						e_info("full reset on DMoff exit to restore jumbo-frame configuration\n");
+						adapter->flags |= FLAG_RESTART_NOW;
+						goto link_up;
+					}
 				}
 			}
 
