Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B56AC4451B
	for <intel-wired-lan@archiver.kernel.org>; Fri, 17 Jul 2026 15:16:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E84EB409B6;
	Fri, 17 Jul 2026 15:16:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c9iHc3B39cAs; Fri, 17 Jul 2026 15:16:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2BBFD4092B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784301416;
	bh=HMQdhO4A8i1cuDck9n7I3DxjT138z7rpMGxly49GsyA=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=21Vvv57PYxJHrPEs9XhHgC3VZFwULZBCZvIvl7Q0BSTMMGn/8o1iwohhI5TJ8Q0oY
	 PZgoQgDOA4VA+0dt/Uaidso8IZbdi8GTOuDOE9yGLBcXSwfz/ucn2zBDp1mYrLRzij
	 cf/lxUo5sgBwCyJTLFYkFWyfCsh/4DYyNXx7OrqpXxQGnGY9DTKX5poAHcquAQviVU
	 eaJ6UWXTwYDS7kVaUq7Sce43XH/ujZTFa2eyi8OYGwEjPNHhnIyZuRfS8e+dPzMcE5
	 8LExJA0y9vHh/CNx8oDDvmZYBoSpv0kBtVj1/5o6sfxHbfbdusXffNvB67hkv82O2i
	 8RUCmZIZsL/RQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BBFD4092B;
	Fri, 17 Jul 2026 15:16:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7969B320
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 09:56:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6821D8100D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 09:56:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xMQOkb5Js8D0 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 17 Jul 2026 09:56:21 +0000 (UTC)
X-Greylist: delayed 447 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 17 Jul 2026 09:56:20 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DCAA181008
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DCAA181008
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=159.69.114.162;
 helo=3b.pm; envelope-from=pd-lkml@3b.pm; receiver=<UNKNOWN> 
Received: from 3b.pm (3b.pm [159.69.114.162])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DCAA181008
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 09:56:20 +0000 (UTC)
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Philipp David <pd-lkml@3b.pm>,
 stable@vger.kernel.org
Date: Fri, 17 Jul 2026 11:22:00 +0200
Message-ID: <20260717092159.35496-2-pd-lkml@3b.pm>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Jul 2026 15:16:54 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; s=20250428rsa; d=3b.pm;
 c=relaxed/relaxed; r=y; 
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To
 :From:Organization:Content-Type:In-Reply-To:References:List-Id:User-Agent
 :Thread-Topic:Thread-Index; t=1784281710; bh=HMQdhO4A8i1cuDck9n7I3DxjT138z7
 rpMGxly49GsyA=; b=JfZaXOgrT9t//9xs3RZ/SGWRlVzcVoeYnCiCmUH//+nBi8LGaSscHTTA6
 TvdEJ41TAGpBn8MOxpugojQNDCsGHkB50A28vKGlYQVPSRV9x/JJ62i8yjnUtnYm/ktsvpPqnJo
 cMcaXj13GpKx3BEFbXJuGLT7vsnJbLEvjZJEN1OhQwqIs1PeQoEpLQrE9Nl9zmABiSVW7135P15
 H5Mgmywsv2Odt5Py698PCE7RfkQ2OxNSY7lvMMJ6RVVDhR116yIdrl7GasbkfyAygTHM2JBXv+e
 8ZmJawf5Bn16B9gA957qYC2qZRgvK64oJwRRyfit0CJlLePlcD2kx6XAM3sSBs36Fmd/8nAwT4z
 c3k5yjJTBLOPqukPmFMPpOYIR/aBuOu+jwwS6LNRfDiRLZ1Q036EEpYD++muDhtxdX4b5bXiSIW
 uqXjlOc0k1OaQLOF1Y/ZZYx2Y3NQ4Jruo7BoxbQS4JQkxp+X+N7Uuu8pWVU2HWsUiVa6h+IyHdc
 Tdvku;
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; s=20250428eddsa;
 d=3b.pm; c=relaxed/relaxed; r=y; 
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To
 :From:Organization:Content-Type:In-Reply-To:References:List-Id:User-Agent
 :Thread-Topic:Thread-Index; t=1784281710; bh=HMQdhO4A8i1cuDck9n7I3DxjT138z7
 rpMGxly49GsyA=; b=vD2J+ADc4cR/CWnE0Eee4MGFfE8SMWyJur1dXcWMdrWUwbju02eP+B91U
 F4ylWTeKCNDfAjWUJqhfxXz13WEBA==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=3b.pm
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (3072-bit key, unprotected) header.d=3b.pm header.i=@3b.pm
 header.a=rsa-sha256 header.s=20250428rsa header.b=JfZaXOgr; 
 dkim=pass header.d=3b.pm header.i=@3b.pm header.a=ed25519-sha256
 header.s=20250428eddsa header.b=vD2J+ADc
Subject: [Intel-wired-lan] [PATCH] igc: fix netdev not re-attached after
 resume if interface is down
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
From: Philipp David via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Philipp David <pd-lkml@3b.pm>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

__igc_resume() calls netif_device_attach() only inside the
netif_running() branch, so an interface that was down during suspend
is never re-attached on resume. It then stays in the not-present state
that __igc_shutdown() set via netif_device_detach(): ethtool reports
ENODEV and every attempt to bring the interface up fails the
netif_device_present() check in __dev_open() with -ENODEV, silently,
since __igc_resume() returns 0. Only reloading the driver recovers the
device.

This is easy to hit in practice because NetworkManager brings managed
interfaces down before sleep unless Wake-on-LAN is configured, making
the adapter unusable after every suspend/resume cycle with WoL
disabled.

Re-attach the netdev on every successful resume, as igb and e1000e do.

Fixes: 6f31d6b643a3 ("igc: Refactor runtime power management flow")
Cc: stable@vger.kernel.org
Signed-off-by: Philipp David <pd-lkml@3b.pm>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2c9e2dfd8499..e777c2df0b73 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7586,11 +7586,13 @@ static int __igc_resume(struct device *dev, bool rpm)
 		err = __igc_open(netdev, true);
 		if (!rpm)
 			rtnl_unlock();
-		if (!err)
-			netif_device_attach(netdev);
+		if (err)
+			return err;
 	}
 
-	return err;
+	netif_device_attach(netdev);
+
+	return 0;
 }
 
 static int igc_resume(struct device *dev)
-- 
2.54.0

