Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B31ECA5FA3
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 21:06:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3124B80B49;
	Mon, 28 Sep 2026 21:06:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kSd8LGdzqMv9; Mon, 28 Sep 2026 21:06:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 60D0880AFE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790629562;
	b=o/KqMO/UW/nVBr2QvACJgh12sPZbf8mrgeVFC3ld7cOE+PIo02eaaM9+p12sJT0dUlmN
	 IWU9BewgpP9+uiQUqAHQAsiG+uEvX7cV83JPIESodNmEkkKvHS7FrXzrO1a6cobDSh3bX
	 rUhcTRwmFlR2TzVWy3BJhf8p0SYap7LcZlvEP2uNycQeSycROUaqdunB/b1J2+JbEA/02
	 TrpCQGG1/nJVACtV3zNTNXMcA/0G9DKahruCjEqrQ6oNgAI8m8zqB1CDYB1hkP9wunga6
	 Ja05+8CapKfEhA4r5sdy87M47FZVgS3TOcRmu0tnn4os/fBoWKETn+OpMYiaRGGcR1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790629562;
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
	bh=tNvKZbvCsCLtftmndSEfAYbnBNeVdMmjscu91WBu6mY=;
	b=EXQEM+Kpno4rG9t0DMxfT+Yz0qNnX1F3FM6HLpuG8ThvSEBi1o07icYCVYACLMABoWYb
	 mi2WvIvmj6PgjHNDKDornSs5fKPSYcJvR6+XeWOdOARhNncgcYEGdpUVDxYJMmXFRUiG7
	 Q9TZ/n1aLToYBXYZHV0gelAFy21lRc4Ojl99Gb2hNE0hPqQl754KlBkSOjp0/FU2Vx4N0
	 RsHtsScS63XmMWPejDFGdwFxxjBJsBJJ8F8lJWy0mlsnqvK+BC5mqy1HvLb91/RRT8u3o
	 jJl1WnR5J3boqkXQbEQpLtL7/Pi8efKL74VjGhGJrpfh7gO64wwaE3iobg3IqRDGEWg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790629562;
	bh=tNvKZbvCsCLtftmndSEfAYbnBNeVdMmjscu91WBu6mY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nQDRAvm+dKg5mtsO4s7Ig5ish8rX5z/8x3v38v8rltxMbWXUazdpGbgim35QlKzg6
	 ABXdgpsw5uDg6HdV5YUrw9LjiDtObP4W5Suz77dUymeTnb+J1sNg9EWPBzdW6siOFk
	 zTDPj3YjoMgGeOXwlFXJX0A0JEv1T5sONIjOOZ9t41jggT7FbdvbwQKYZKI62RPlwq
	 MWCLOv4s0UmP+M+HQkKzWVQrRkGs4IhgzhFXqvCjTDvpBlRcJE7TU1GiB0A3JFvK+F
	 IUyMAB+GyZghtGhDqy43iJ/bR7Erl+z0jFikF3zIzspYKHvbKTow64xFJ3W+M/5w7y
	 eunA18ElZweKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 60D0880AFE;
	Mon, 28 Sep 2026 21:06:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 041183D8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 21:06:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9A5460615
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 21:06:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YJ_ddTGyACb3 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 28 Sep 2026 21:06:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C6A3E605DE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=52.42.203.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790629560;
 b=atfHpxoiU8ecuWZIYrXqUlyRlrb2J/ghRfGbTN9oROk3eWUdVX1jYLsDTJ3iw4XsNSP4
 daGcfMpBGMGD2/P7XD0sjbI3m03bCZhrAlaoKKKNETy1v8GbWGEVE3VpTIHtLs51KkvKz
 XfLnU161Cj5udYrtu1H8a0FMFnw5IBvA7ykOyruTQGzzhP5OdPCgIuJ6rrqowolt3KAv6
 C6ds/ZIkcZD237XrKPb9cCRINjD/pwaGdp3qbh6308zrpSQns65g7mWBwEGWUntv0MA74
 rBH33usn6knVzoMce414NpHE2XVbMUvHtEnOGmzd2ig/dSdBJHTxmsafI3fDbh5xORg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790629560;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
 X-ClientProxiedBy;
 bh=tNvKZbvCsCLtftmndSEfAYbnBNeVdMmjscu91WBu6mY=;
 b=QL4Dqb0WnQKUOS3hAZ7mORb0T3KzZbqjKw+6TQTz1SFPrse3CBdxLmxPom/e84ZHhUDp
 pFDbdp2VWVATaxiIN+4SH3jcXlcL34SlkbR1QT4BBCjBLudKxQzB1rYO6LqRvVrQ3So42
 9b9fjh9njX/zMQ8dB33CJ7IoDb0a+rlJgq2n6o3ry2Lu2BDJDXctEj7nLStfujO9tEi7a
 PnhctkKCgGEDWK2x/5uqnfuJV3vR5pVUghKSQkriVQn+prAAbCtpnpOuniwbqrmdrUI/3
 3C90tRrwvI+Pm1zhJzXHVgLi/seQqiP7da3DciCiWL6XceJPekh3J9hz6OJJw2HZXGw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=amazon.com; 
 dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256
 header.s=amazoncorp2 header.b=gGBAZIgK; 
 arc=none smtp.remote-ip=52.42.203.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.42.203.116;
 helo=pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com;
 envelope-from=prvs=7247b4c49=hagan@amazon.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=amazon.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256
 header.s=amazoncorp2 header.b=gGBAZIgK
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [52.42.203.116])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C6A3E605DE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 21:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1790629559; x=1822165559;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tNvKZbvCsCLtftmndSEfAYbnBNeVdMmjscu91WBu6mY=;
 b=gGBAZIgKGklyOQqs/EC9LrSuRYXjE4Pl//3rF7sOXS7aH31Al/PVueOP
 K47o0jb52E92oivEVejz/VRfliSdcQupF8upDEppadgSk8J3gCNo0OqzO
 HTgR7FNFRfBHO3BOoFAj11tvvgg05MhrGP3RMBKe2jZlvV+uUyM0pk9fH
 wCCiLn2tgjxPNBpmTb+zEdNjYkM5C/VNf+8raVGoGVu+6FiWgwcN9MDFI
 GvzKEoxiMwJjPObRZcmzP+gG66eLSMNa69CtbPg8iL/xOG0rHLbABeLqU
 3glCjsMHJST0zUSel8FqUU3xOZGV0JbIdOqnO0WSGBVxNVagmDT9RNa8R Q==;
X-CSE-ConnectionGUID: 5pmLN4V2R+G43Ca+EuE9Fw==
X-CSE-MsgGUID: qj+ylq7qRTGk3cBUw90ouQ==
X-IronPort-AV: E=Sophos;i="6.27,129,1787011200"; d="scan'208";a="29899893"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 21:05:58 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:10223]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.18:2525]
 with esmtp (Farcaster)
 id 106b90de-cb53-4848-b400-37e7ebe7ecb4; Mon, 28 Sep 2026 21:05:57 +0000 (UTC)
X-Farcaster-Flow-ID: 106b90de-cb53-4848-b400-37e7ebe7ecb4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 28 Sep 2026 21:05:57 +0000
Received: from dev-dsk-hagan-1f-c6b5e25f.us-east-1.amazon.com (172.19.159.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 28 Sep 2026 21:05:56 +0000
From: "Craig I. Hagan" <hagan@amazon.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Fabio Sabai
 <sabfabio@amazon.com>, Matt Vollrath <tactii@gmail.com>
Subject: [PATCH iwl-net v3] e1000e: restore jumbo config after DMoff exit
Date: Mon, 28 Sep 2026 21:05:52 +0000
Message-ID: <20260928210552.13266-1-hagan@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <b6db5335-cb5c-4a91-b823-1a114fce75a1@gmail.com>
References: <b6db5335-cb5c-4a91-b823-1a114fce75a1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.159.5]
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
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

Fixes: def4ec6dce39 ("e1000e: PCIm function state support")
Cc: stable@vger.kernel.org
Reported-by: Fabio Sabai <sabfabio@amazon.com>
Closes: https://github.com/systemd/systemd/issues/25925
Suggested-by: Matt Vollrath <tactii@gmail.com>
Reviewed-by: Matt Vollrath <tactii@gmail.com>
Tested-by: Matt Vollrath <tactii@gmail.com>
Assisted-by: LLM
Signed-off-by: Craig I. Hagan <hagan@amazon.com>
---
v3: Correct the Fixes: tag to def4ec6dce39 ("e1000e: PCIm function
    state support"), which introduced the DMoff-exit bare PHY reset;
    2e7256f12cdb only added a pre-condition. This lets stable reach
    the affected trees (v5.3+, including 5.4/5.10). Add Reviewed-by/
    Tested-by from Matt Vollrath.
v2: Rework per review: request a full reset on DMoff exit so the
    jumbo-frame workaround is re-applied (root cause identified by
    Matt Vollrath); drop the diagnostic e_info. v1:
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

