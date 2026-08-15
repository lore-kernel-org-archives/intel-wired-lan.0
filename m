Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D39DC5DF66
	for <intel-wired-lan@archiver.kernel.org>; Mon, 17 Aug 2026 15:27:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FDF94076F;
	Mon, 17 Aug 2026 15:27:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O8kLnIShnfoN; Mon, 17 Aug 2026 15:27:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 50BBC4071B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786980439;
	bh=2WaeFHY8Amefx+z0iRX7zRmJGE/YSFA3BET5wf4LK6c=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EPNYvJ1k2EjkqiIhEkFUEDoCWWWIAtqvVwoqcO+Nv1iWJeAt31lDCXUlteJf6l9Rb
	 YAS5A9dbkfJdKGS6jAtkm0v8+sIoKdfzLiwN77ZwgAYnefvepydhpH7dvj6TvgsqDO
	 0ct6pe5RLOXAffd96qoYYa/9yvp/pwGK3is2Yszi1EfrptlzV2RCyyn0LpltXWqpLR
	 OcqpJArE0RBK70tVIZOdaum83/r9vtUbrA/ojnLWDyxeZYm4DXgXU1nYKsKznV7Oa0
	 eRqwc772s6UQqPB+6aOqTNLEfIVaDPdcqc4MChQojqqTuIPDx3wH33lEDSs2vqB8t1
	 LViNDp04vzV+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50BBC4071B;
	Mon, 17 Aug 2026 15:27:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EF063DF
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 01:08:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3C54860AB9
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 01:08:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0uwM4hnHwWOw for <intel-wired-lan@lists.osuosl.org>;
 Sat, 15 Aug 2026 01:08:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=shivani07g@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 75DE560AAE
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 75DE560AAE
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XfMc+NMp
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 75DE560AAE
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 01:08:28 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e6b5737bb2so2074203a34.1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Aug 2026 18:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786756107; x=1787360907; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2WaeFHY8Amefx+z0iRX7zRmJGE/YSFA3BET5wf4LK6c=;
 b=XfMc+NMp3wA9KJuthy4slo/F5vC2lRRPSiFGxtUKc/q5sZEPbtqsg0Rs68XptuMQUO
 GrcMQXnJRQsHiXx6kBEyDZp254BYrId7Xlyj8O77/xHaLgbX4e8t5EMtbWKc5utA1C6Q
 LLSFnq94t463cJ9D1Z6UaybgQD2LX8p0Y4bbMAoRXTe24XVSwXU7NSADBQiX9qvajavk
 Fa4mJDDKoJDOvPK2lJU0MvCX8xk5JhRtlJiyBxfUJ5T6cv8eiKfbxhxYlAFCZEQSIc36
 3zKfLprrsF0lzf8DiXnfnFkC5Sf6tT5Vu0udxneoc+Q1feM8h/MF+faHZf/HPJ0KmUPk
 fCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786756107; x=1787360907;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2WaeFHY8Amefx+z0iRX7zRmJGE/YSFA3BET5wf4LK6c=;
 b=XhSah0Fdm7T/LpNzGmCvcFZlSrMmPYuWQLGxaHnYWtyr8oCkd/cR3HKboS6rumEgVq
 TwKLm7PCdcNLXWqTolQxPxayKSFPIFJuSbUfzfLFA3TMyOQPaG+K7u2zr8dAGWE+JOvy
 N3lYeN+Cp8MCG1dD+X5clxJYc23TAItQOeguYWzHIzlyTxmZyriK7U0MaUgsxn+WnQi7
 +9B6JtizUsPg9x1K58Kl6sFsKYY/3GNOcuMcLmDD6X1N455M9MVH+RFeu4+u7p1WQSVS
 gDmIuuTj5MF9QIuDJBZSNiJIVo5LjDOILAQvVOIzfooYo5ce1WJg3tguG+HEj99bZK9p
 cgDw==
X-Gm-Message-State: AOJu0YyWv1z/gg5reCWCgzywz7EpvdRLCug55s/kylZpQP5ehLw8Kmze
 Cd3OuncjWzHhT/SEcE1MbFwfpA6SAkZR2MAVshvHk4QazRe9feJnjGJsgC++I7wF
X-Gm-Gg: AR+sD13oCi/G5DaInbSupz/4V2YZOhDGV25C2C2/wOj9fks3+G+AMS+TIw1puC1LgJ1
 ZTvQ2DzSFhVorWjUyioRRAcQkUJNQ0t6RDcMKhPqIW/bBujaUCEbxsmW4Tfjh/KZxASvJkVVbOk
 NISE/TBKR2+i/qLNk0q+0OhS8ctjPluRM+r0L5MKWEQxiYvB0O3gAFaHx0RLAJxPtq5+Q+kEyJ0
 aaVmVlIR/14XZkcSKt6XG1YwiGTjl5Ro8xwXGvifJM80h70JGXyE4LtriHmMekDXrzGIH2zD2uy
 OsHQY1aJPF/YjT0jQodcLiqMrp83TVllJES28lBWw5VkQTjy0eC1fLhaYprSi9RKrU8jCsDR7mU
 uSJIq7bkRNquNtpbBpU+AzXJ/jWEH/mVKzji3gvYk3tLVyYqSUrOD7pkHEsHFfb3eJvXACNi8T9
 73kBJBSsCJFfUPW5aEC/GsVYYX326x7GxLjNdjr2EgcH+/+Ew/l9jm1HOT2L+pXkqk6PuZoU9B5
 gO0l0mNFDpZWW4AiTlwk8dJj+GXymY=
X-Received: by 2002:a05:6830:3813:b0:7e9:d3aa:e391 with SMTP id
 46e09a7af769-7f3de4ea83dmr9379236a34.6.1786756107331; 
 Fri, 14 Aug 2026 18:08:27 -0700 (PDT)
Received: from shiv-machina.. (174-16-201-18.hlrn.qwest.net. [174.16.201.18])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e869f65fsm2320947a34.26.2026.08.14.18.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 18:08:26 -0700 (PDT)
From: Shivani Gupta <shivani07g@gmail.com>
To: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>
Date: Sat, 15 Aug 2026 01:08:15 +0000
Message-Id: <20260815010815.91898-1-shivani07g@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 15:27:18 +0000
Subject: [Intel-wired-lan] [PATCH iwl-net] igb: Reject hwtstamp requests
 when PTP is unavailable
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

IGB depends on PTP_1588_CLOCK_OPTIONAL, so ptp_clock_register() can
return NULL when PTP is compiled out and can fail at runtime.

Commit b888c510f7b3 ("igb: Avoid starting unnecessary workqueues")
moved the PTP locks, work items, timestamp configuration, and clock
reset behind successful clock registration. The netdev is already
registered when igb_ptp_init() runs, however, and the hwtstamp entry
points were not gated on registration. On 82576 a TX timestamp request
can therefore schedule a never-initialized ptp_tx_work.

Initialize the passive PTP state and hardware clock before registering
the PHC. INIT_WORK() and INIT_DELAYED_WORK() do not queue any work; the
overflow work is started only after registration succeeds. This also
ensures that PHC callbacks and the netdev timestamping paths never
observe partially initialized state.

Reject hwtstamp get and set requests with -EOPNOTSUPP while no PTP clock
is registered, and advertise software timestamping only in that state.
Successful registration retains the existing behavior on 82576, 82580,
i350, i354, i210, and i211. On 82575, an OFF request that was previously
accepted as a no-op now reports that hardware timestamping is
unsupported.

Reproduced with CONFIG_IGB=y and CONFIG_PTP_1588_CLOCK=n on the QEMU
82576 model: SIOCSHWTSTAMP(HWTSTAMP_TX_ON) followed by a hardware
timestamp request warned in __queue_work() before this change and
returns EOPNOTSUPP afterwards.

Fixes: b888c510f7b3 ("igb: Avoid starting unnecessary workqueues")
Signed-off-by: Shivani Gupta <shivani07g@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c |  9 +++++
 drivers/net/ethernet/intel/igb/igb_ptp.c     | 40 ++++++++++++++------
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index f7938c1da835..4ebd447117cc 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2396,6 +2396,15 @@ static int igb_get_ts_info(struct net_device *dev,
 	case e1000_i354:
 	case e1000_i210:
 	case e1000_i211:
+		/* No PTP clock, no hardware timestamping. Advertise what
+		 * igb_ptp_hwtstamp_set() will actually accept.
+		 */
+		if (!(adapter->ptp_flags & IGB_PTP_ENABLED)) {
+			info->so_timestamping =
+				SOF_TIMESTAMPING_TX_SOFTWARE;
+			return 0;
+		}
+
 		info->so_timestamping =
 			SOF_TIMESTAMPING_TX_SOFTWARE |
 			SOF_TIMESTAMPING_TX_HARDWARE |
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 638d8242b66b..01992a73b37b 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1104,6 +1104,9 @@ int igb_ptp_hwtstamp_get(struct net_device *netdev,
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
+	if (!(adapter->ptp_flags & IGB_PTP_ENABLED))
+		return -EOPNOTSUPP;
+
 	*config = adapter->tstamp_config;
 
 	return 0;
@@ -1285,6 +1288,9 @@ int igb_ptp_hwtstamp_set(struct net_device *netdev,
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	int err;
 
+	if (!(adapter->ptp_flags & IGB_PTP_ENABLED))
+		return -EOPNOTSUPP;
+
 	err = igb_ptp_set_timestamp_mode(adapter, config);
 	if (err)
 		return err;
@@ -1378,6 +1384,25 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		return;
 	}
 
+	/* Initialize all state used by the PHC and timestamping paths before
+	 * registering either interface. INIT_WORK() only initializes the work
+	 * item; no work is queued until timestamping is enabled.
+	 */
+	spin_lock_init(&adapter->tmreg_lock);
+	INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
+
+	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
+		INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
+				  igb_ptp_overflow_check);
+
+	adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
+	adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
+
+	/* Initialize the hardware clock before ptp_clock_register() makes its
+	 * callbacks visible. The overflow work is started after registration.
+	 */
+	igb_ptp_reset(adapter);
+
 	adapter->ptp_clock = ptp_clock_register(&adapter->ptp_caps,
 						&adapter->pdev->dev);
 	if (IS_ERR(adapter->ptp_clock)) {
@@ -1388,17 +1413,9 @@ void igb_ptp_init(struct igb_adapter *adapter)
 			 adapter->netdev->name);
 		adapter->ptp_flags |= IGB_PTP_ENABLED;
 
-		spin_lock_init(&adapter->tmreg_lock);
-		INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
-
 		if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
-			INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
-					  igb_ptp_overflow_check);
-
-		adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
-		adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
-
-		igb_ptp_reset(adapter);
+			schedule_delayed_work(&adapter->ptp_overflow_work,
+					      IGB_SYSTIM_OVERFLOW_PERIOD);
 	}
 }
 
@@ -1513,7 +1530,8 @@ void igb_ptp_reset(struct igb_adapter *adapter)
 
 	wrfl();
 
-	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
+	if ((adapter->ptp_flags & IGB_PTP_ENABLED) &&
+	    (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK))
 		schedule_delayed_work(&adapter->ptp_overflow_work,
 				      IGB_SYSTIM_OVERFLOW_PERIOD);
 }
