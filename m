Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26149CA5FA2
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 17:02:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4E22606B8;
	Mon, 28 Sep 2026 17:02:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QvpZfBbDkHgZ; Mon, 28 Sep 2026 17:02:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C1728605FC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790614964;
	b=e/PU7KWBDmZj/XBRs604Oo3MPAe5a1/V0n9HbXvuw49uhJkOC0hkHfl8aqFXGvCQlk47
	 UtA7M6FGxqf3mZT/NyXKaQ9dfXiGQwiq4dMpLRR1/4/rIaAEkHUok7q51qU0oaLheH/0H
	 lGlZ/FW7ElyRhQJT9sHRUDo+Gg7euN9r7FZP1h5h8jjtY8PeXAFDGE342WtiM6xoJ5Dtm
	 o32CaidAjWzengNEOlyZ7F3t3Av+cpjDXL/fmOQ6Oi3ju5FXf9dRCaKZMK0J3FQm/DEOK
	 8CzyMBDhOs373uXwYFC8N2c8xR/PgfQsN5uRrSOekkAB+i+9UkEXOz6BoFwvfito+gQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790614964;
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
	bh=A6WK9Y80CiMB/rsYyBjNtDkyFYNfAIuXEKudJHh0z+A=;
	b=bIbpNppek5PIotZ/23RGdkSyAd559G0i7MGHzGGAM5kmaOoqnPYdfzRnhi15oCwuNiu6
	 PQuNe6R2SL8pj7QWQ79afpCKAxYiEiCtwQk5+FlWdYZuGkL0pFmJvPK9EaklxJjX9YuC6
	 TWJ+BdSujNoYjPRVnBEa+FQaTFUZbkBB+s14RUE/QMrvzVxeQp/FGiYFpeIZzzgidC+s7
	 jvoF4lTJH26GYPdeJLqL7ydjdXDHVSZXyBmv473H2jAphHMYtdYeFZp2Ts9vsHrc7S04I
	 a9XMipgMFE3APiFBRze9hz15AK/QKJwFjncmZFtqdf5rHqswZOvzASu4CHvjc3jjzwA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790614964;
	bh=A6WK9Y80CiMB/rsYyBjNtDkyFYNfAIuXEKudJHh0z+A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wMM20+t4n9F3xdRVJVVpbTuOGAZlmnR2/AI55COXH3zR5igOBqcpvTSO7WucKAp+w
	 ea0NfhauBkB0rwkNlAAwm1bUW64e4hWp3Jve59oZxZiMmlWrrQDXVr2guv85iiBZ3Y
	 WQNtHZnHM1Q3Yj+ocCIw00fCkQ6iY1/Q0X7J03kC0AKujHuIu4AcvjmONzajxmDlr0
	 lIg457OVtIB5sa2lVsHhRH8800SjN86W6HCK/E+3faBOCBiu4kUOb6SF30nZhGILdJ
	 Xj8ravOofJntPB7S38w7lFlN6YfXhgXeDkz8vloNupfmUdVV75M6AHMk3OwDv7g0aQ
	 5uHJomZlSMdTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1728605FC;
	Mon, 28 Sep 2026 17:02:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B7B3372
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 17:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A977580838
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 17:02:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BOWHXPgHvjd0 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 28 Sep 2026 17:02:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6B27080821
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=44.246.1.125
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790614962;
 b=MyCZfNYQ8oU25UQCHKhipCbcotGiRswRBLCC2EdSd33e8soYFui1rjhtf/RP3R9ochSx
 ZiIYc/bbzlOFwCl3vGMAQkuhH+N/mWcesEuXUO9a5eoRvFW2jIEikdB3pzjMjCgRcNS97
 bDo7Q58y53MSVyr5W6D425xhfD7a4Q2btrkjRs0Vlp+6lnRDXr+E9qXjVcoLm6f0LFokt
 ORIEVceFQNOLpc1sHwA+ufppMgKtiwhe5aMGfGNmWE+SmfjXY1fFctrbUDVYGh4x2vv9h
 UMCUN2id/a9MWxAfR7xEpJAX78+KJVfAurnUcbEg+/sJ0ncSEM8p0tkM58eQYxNvYaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790614962;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
 X-ClientProxiedBy;
 bh=A6WK9Y80CiMB/rsYyBjNtDkyFYNfAIuXEKudJHh0z+A=;
 b=ofto4Nk6Bv9t3p+mXOUDdf5CGsBKmustPtNFV0yq32tVZ2INLncErJXMv1mTeC72otPJ
 MofU35WE2b7peXGZ1VfmPH0vICTRsN4X7bSIVx0hWUKCdsk63WYBYA0ioVtCYy91zvP+r
 U+lqWyhZ49g78g2h6KiiFc46rEE7iJrEzoMOOU+gv1tBafFXyi3z4Q48QtFRlLWtsaMan
 6CSSpmvD0WzOCczllVDKUuKveNXRuhhEs4XufbvBll8npuTCReOyaJAq7bvBfbK/vKVmi
 TB6KSP+zyJlWb5qNcMU5i7BOh726DNiUEE2EJC3O1y8tFgzSFezgfw9yauDLDIAmvWA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=amazon.com; 
 dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256
 header.s=amazoncorp2 header.b="mz5/9ZW4"; 
 arc=none smtp.remote-ip=44.246.1.125
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=44.246.1.125;
 helo=pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com;
 envelope-from=prvs=7247b4c49=hagan@amazon.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=amazon.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256
 header.s=amazoncorp2 header.b=mz5/9ZW4
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6B27080821
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 17:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1790614962; x=1822150962;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A6WK9Y80CiMB/rsYyBjNtDkyFYNfAIuXEKudJHh0z+A=;
 b=mz5/9ZW4nq8xv60ksxm2OlHpvbSyVO1fsbQvUX35vMbbwbTWY4c18r+o
 bYEIEr8MX9BtO5dgnm6Bg1082D9ulkOvuKNsZ0hUQCEJTVyTTrmmSDbnm
 QeDaKshCtWb4JghKn/M8zLEooMfv6Rizx2g1bWbUfbsLtbGb1n10EGP5o
 FlCCO0BpnPbSQAd484IyADo5n41A7NJH6IMSmeAdEbJMyk0cSK3s1bzKc
 GQT+Sa9sStOYasmRTySFwk/5u3r4iTMFwmX8uNVWC2KZKxrSO2wSCjM8T
 sxKyEREU42HWaBNRaIN0NzCTsuKMHl813fTnLzAVzWaKL5e6TvqoeY4xe A==;
X-CSE-ConnectionGUID: +/9tSSI3QKyOYNOTI/JyPw==
X-CSE-MsgGUID: PdNkOt0MSl6yREab6LDRPQ==
X-IronPort-AV: E=Sophos;i="6.27,128,1787011200"; d="scan'208";a="29851915"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 17:02:41 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:5642]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.187:2525]
 with esmtp (Farcaster)
 id 719bb9c4-0476-426a-b2aa-bdff1f3c6d8f; Mon, 28 Sep 2026 17:02:40 +0000 (UTC)
X-Farcaster-Flow-ID: 719bb9c4-0476-426a-b2aa-bdff1f3c6d8f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 28 Sep 2026 17:02:40 +0000
Received: from dev-dsk-hagan-1f-c6b5e25f.us-east-1.amazon.com (172.19.159.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 28 Sep 2026 17:02:39 +0000
From: "Craig I. Hagan" <hagan@amazon.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Fabio Sabai
 <sabfabio@amazon.com>, Matt Vollrath <tactii@gmail.com>
Subject: [PATCH iwl-net v2] e1000e: restore jumbo config after DMoff exit
Date: Mon, 28 Sep 2026 17:02:34 +0000
Message-ID: <20260928170234.21877-1-hagan@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923235832.473-1-hagan@amazon.com>
References: <20260923235832.473-1-hagan@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.159.5]
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
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

On an I219 (pch_spt+) at jumbo MTU, after a link partner reset (e.g. a
switch reboot) the interface can come back up unable to pass traffic until
it is manually reset. Observed on I219-LM (8086:15b7) at MTU 9000.

When the MAC exits the DMoff state on link-up, the watchdog resets only
the PHY. A bare PHY reset does not re-run the jumbo-frame workaround
(e1000_lv_jumbo_workaround_ich8lan), so the jumbo configuration is left
unapplied and traffic stalls. This was seen with NIC runtime PM disabled;
if runtime PM were enabled, the device should go through a full reset on
resume, avoiding this issue.

Request a full reset (FLAG_RESTART_NOW) instead of the bare PHY reset when
the MAC exits DMoff, so the normal reset path re-applies the jumbo-frame
configuration.

Fixes: 2e7256f12cdb ("e1000e: Check the PCIm state")
Cc: stable@vger.kernel.org
Reported-by: Fabio Sabai <sabfabio@amazon.com>
Closes: https://github.com/systemd/systemd/issues/25925
Suggested-by: Matt Vollrath <tactii@gmail.com>
Assisted-by: LLM
Signed-off-by: Craig I. Hagan <hagan@amazon.com>
---
v2: Rework per review. Instead of the fc-latch autoneg-restart
    approach, request a full reset on DMoff exit so the jumbo-frame
    workaround is re-applied (root cause identified by Matt Vollrath).
    Drop the diagnostic e_info. v1:
    https://lore.kernel.org/netdev/20260923235832.473-1-hagan@amazon.com/

 drivers/net/ethernet/intel/e1000e/netdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab3..df7da86a8 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5264,9 +5264,11 @@ static void e1000_watchdog_task(struct work_struct *work)
 					usleep_range(10000, 20000);
 					pcim_state = er32(STATUS);
 
-					/* Checking if MAC exited DMoff state */
-					if (!(pcim_state & E1000_STATUS_PCIM_STATE))
-						e1000_phy_hw_reset(&adapter->hw);
+					/* MAC exited DMoff; do a full reset. */
+					if (!(pcim_state & E1000_STATUS_PCIM_STATE)) {
+						adapter->flags |= FLAG_RESTART_NOW;
+						goto link_up;
+					}
 				}
 			}
 
-- 
2.47.3

