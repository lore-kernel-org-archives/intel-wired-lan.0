Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244D9606A32C
	for <intel-wired-lan@archiver.kernel.org>; Sat, 28 Nov 2026 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=cObQ0n3i;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ylBfmaNP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0181760635;
	Sat, 28 Nov 2026 13:37:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BLiutUfM0LyY; Sat, 28 Nov 2026 13:37:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E0A726063A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795873066;
	b=b4N3Np5ELx+nw1vCbP7e0WIPrudwgRiMusDIh0T+WKIV9lbEWtB8r0BkxBasXJir3lJL
	 NpD9frRaftkX9OtRVsOgHX9v+X42jbbpfpevicfAwFDZk5JOjDmHsVffcbuy8g5GFpJjO
	 bMs707njY2JJly6U6+VH1h8wXhJu3Ho2Ncn5lUGPZJlKmOl92fA807/UcDZQJS5yz6kiI
	 g7p3WUhADsxAMfQ33eio3j4lIwNQJcCBcaUDBBKr6hOYEdff+eNfEog5gGCXRKJSJtBa1
	 nWUSSU9jKzGMvAWOGIisxJ61txe2827VN7LjVNBwOiybP7VdRPYptc5MG7QC93Za2GQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795873066;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0mQsJ7irUzhfshN0tVy8gRkAjHlT+WDYsqq+luK1uFo=;
	b=bJjF+Z1qEkMCBpRmIyraPTPguZebMRN+RBdHxS/M3TP7j8ERHLxlJj2hYbv7iCAhyHXp
	 2hTnI/HMW05WU8BTVxw/OB8eyYe4ncmdSGhpTS7j1+8wmH47V1rq1BB96Pau7mBqTqAZ/
	 EVR2nC5aFYjQnWx1YDxIJ8n4Vryn/9y5hQvBwwVxPdt1MPMB3nHfKJz7lPkW7qkstHMvn
	 AIN5W67K8/WG3kFYbq2M5kxy6LIeEYYTlUilWojrQhQZDqMhY0FE5qtgU9Gq/oYg+CPVu
	 +Nucn6xLv/iG6t0J8fkZ66o39sN8sKZhGYd/pvQIct1URnJMNs8/AcbVALmU9hNnaFA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795873065;
	bh=0mQsJ7irUzhfshN0tVy8gRkAjHlT+WDYsqq+luK1uFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cObQ0n3iAwS5TTIpvPi8YpnXMhRPRJfSSE05fjQHS9zupLp1ZiXdAtUGK3WryluaR
	 AOZ+z1lYFEEFiNHFnrb/XysFuKZ3GE0sSlutVZgYEL2C1NZ+dMKi3+vBrAShmPnS8w
	 0C5k8Tvuh0tdIYUcRijxpdUVTqhBxcS9qn1weFk7q1AvXMJK0dmikl2kfBK8aord8Z
	 qjgV8/BYZEa5dGR0aKMcWyVgWNkjDKCOFAJ40jSDFncjPODeO8HgZK1OamWxoxh35N
	 0Z08RVa1K4xEyn8HOroDr6rjfcZf3aOoqhqCvzcAq7P+e5FajseT4+BsHvOCCEIMAD
	 xFzsCMXF0kXwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0A726063A;
	Sat, 28 Nov 2026 13:37:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BABB472
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 13:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1102740683
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 13:37:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1CeMHN-AMkvV for <intel-wired-lan@lists.osuosl.org>;
 Sat, 28 Nov 2026 13:37:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A466840680
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=janislacis06@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ylBfmaNP
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A466840680
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 13:37:43 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-49412eb1474so5909266f8f.3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 05:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795873061; x=1796477861; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0mQsJ7irUzhfshN0tVy8gRkAjHlT+WDYsqq+luK1uFo=;
 b=ylBfmaNP8bvvree1DuzaLQNwshPr4McQM+rpmfN1LFIOzTvA8Rg4dln1B7cbARiMCe
 Xm2JzWOGfhfbQHzkjyM17YYbTRnx41Hyo9Wmw/tkFIfHEurpF+TptbYo/1I8BbnNWIuX
 KQxgESjEnewVJFvuduTlcDMvvoOL69fyntJ2JYHiSjh5V3sM/RgwCTxLJsfzO1MDJUNS
 usUyKozOWIiavBniCcB1yyrrJtX6Jnh74GpGGocLgf+skwqcrnKLa4QFG6E65y2Uzr+t
 /GU6q76mtUUlXJLnxtwh+Rvja2uIbx/igaGqiexHXvd31Kdc0pWkfN0OZPgIjkPH8T09
 f1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795873061; x=1796477861;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0mQsJ7irUzhfshN0tVy8gRkAjHlT+WDYsqq+luK1uFo=;
 b=2hIUCqka9HrsXMFaCvCQODsnavkb1U0/BXsNFv7j9w4Vgst29PW+QDmK5+fct+JvyV
 YPsSSWz3+6rvYJh2t8aKhYy9zGFiXAA5NN9ure+X7h66hf4fGKuP2GH8ZL9r6whOsirN
 QqBfvJFqowss6a4MhB1TfSkxZRxzmn30M9bFft+mMCaG8Q9pbcAZupM0t5m7CT5w6zc/
 n7XG+26DTJXiyg9AfUsrhMryAWWyXQ1ZM/V9ajbW7Z01TiU3gA6mFh16YIEfl1bZumd0
 3taRT5hBj0OiRFJuW0gfuxhgQcFpCyjkYCz5hpouGPxBVlJ53YD8Nvy1EuKaWjC/u4c2
 AdCg==
X-Gm-Message-State: APuU4Z84r88FKf1+FGLMPwaPyUFGDBEguyXiH1X8nTbisAas5s5Dxt3L
 cj6hnCaLYyekk1O9yKFd47pqMUbsSNW3CNiZTX2U9KCtPwmnJeGkbBr+
X-Gm-Gg: AZFdTZfKZrLxjuYeW8nurZMKEWzEE3DXbifY8nQB5Wf4+RekRbZkwih3tGwask8uRmt
 nc5SyGN5YVl+w/FGBgiWIUB9xF2dCZrMxZ5mKjP4ZsiswgbfSXO+uQh9g5jEiaNOGfcwDJ9c/Lq
 gZ7zDqnC4VURrUXhVa/7SfgZI2maBMGOGtx/8tRomD0r/v/7nFgWum8h1xvyS2pNBgJWUE8wVI8
 RYkPjvVnEbbQGdz/Xd/m+KH+ICO5o+8A6qhnP+yZ3Q0GTL1bMtkdRccY871Dg8BeHxSODXf83ca
 5nOSQJD1aWQBAYQem8AlabpVgfnKGPy7+64sLF9UoNU8fTFJPWW3HPa7AIdvv06kzZpfXtcObyJ
 x8d0woBgW3eMbZrpKImB6bWUv3RcHpXxjcGsCe9aB1oirL9ySW357D09MBNu+tm2b4Rbg7cthjR
 J/aSBXgfw1uwsw5M/fH9b1ldwJZQSajuYs0xFSoMilb/TKztHiUHjZZbk45KEFYiHsR/3thdK5v
 vAoUYasQbXWKYXXsEHZM1mhgSuK6cgx72eQ/mnhpMiPH4Jo7vRmxaJCc91JhlSWYOtbf8aDLPk1
 NkW/+7uYuNxkfff6D87iixuZiCQoiwPXnQL/C6rYnE6B0vEDQge7BLQyTrjqQyX7ziZiA2qV0NJ
 UsKKZIag94HdxJIu8/KQjnfQDajJh4Bi7SHo=
X-Received: by 2002:a05:6000:4a0e:b0:48b:451:4f19 with SMTP id
 ffacd0b85a97d-4abb7971c1dmr52301677f8f.51.1795873061121; 
 Sat, 28 Nov 2026 05:37:41 -0800 (PST)
Received: from pc.tail250202.ts.net ([87.110.86.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d60sm54300422f8f.3.2026.11.28.05.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:37:40 -0800 (PST)
Date: Sat, 28 Nov 2026 15:37:39 +0200
From: Janis Edvarts Lacis <janislacis06@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: intel-wired-lan@lists.osuosl.org, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v5 2/6] igb: fix RTNL assertion when resuming from
 runtime suspend
Message-ID: <mopuzlp25nt2tl5yogp2uwfhyw5jomop2lver6lx4ohcymxbk6@mnofvjbmjwz4>
References: <20261124235723.1135808-1-antonio@mandelbit.com>
 <20261124235723.1135808-3-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20261124235723.1135808-3-antonio@mandelbit.com>
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 25 Nov 00:57, Antonio Quartulli wrote:
>Since commit ac8c58f5b535 ("igb: fix deadlock caused by taking RTNL in
>RPM resume path") __igb_resume() doesn't take RTNL for runtime resume,
>but __igb_open() still calls netif_set_real_num_{tx,rx}_queues(), which
>require it. An asynchronous runtime resume (e.g. after the link comes
>back) then triggers "RTNL: assertion failed".
>
>Only set the real queue counts in __igb_open() when RTNL is held (open
>and system sleep resume), and set them from a work item taking RTNL on
>runtime resume. Until it runs, after a fallback to fewer queues on
>resume (MSI-X to MSI), the stack can use queues the device doesn't
>have: drop those packets in igb_xmit_frame() instead of mapping several
>stack queues, each with its own xmit lock, onto the same ring. The
>stack can't be kept off those queues instead, as __igb_open() and
>netif_device_attach() start all of them and changing the count needs
>RTNL.
>
>Tested with the 82576 emulated by QEMU.
>
>Fixes: ac8c58f5b535 ("igb: fix deadlock caused by taking RTNL in RPM resume path")
>Cc: stable@vger.kernel.org
>Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
>Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
>---
>v5: no changes
>v4: no changes
>v3:
>- set the real queue counts when RTNL is held (open and system sleep
>  resume), and from a work item on runtime resume, instead of not at all
>  on resume (Janis, Sashiko)
>- until then, drop packets for queues the device doesn't have
>- stable: netif_set_real_num_queues() needs 5.15+ and
>  dev_core_stats_tx_dropped_inc() 5.18+; older backports can use the
>  separate tx/rx calls and netdev->stats.tx_dropped
>v2:
>- keep setting the queue counts in __igb_open() after igb_request_irq(),
>  only skipping them on resume (Sashiko)
>- drop the reference to igc
>
>Note: igc has the same issue: it sets the real queue counts only in
>igc_open(), before requesting the IRQs, and never on resume. A fix will
>follow separately once it has been tested on igc hardware (Joe offered
>to test).
>
> drivers/net/ethernet/intel/igb/igb.h      |  1 +
> drivers/net/ethernet/intel/igb/igb_main.c | 73 ++++++++++++++++-------
> 2 files changed, 54 insertions(+), 20 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
>index 8c9b020..79d7fcc 100644
>--- a/drivers/net/ethernet/intel/igb/igb.h
>+++ b/drivers/net/ethernet/intel/igb/igb.h
>@@ -586,6 +586,7 @@ struct igb_adapter {
>
> 	struct work_struct reset_task;
> 	struct work_struct watchdog_task;
>+	struct work_struct rtnl_resume_task;
> 	bool fc_autoneg;
> 	u8  tx_timeout_factor;
> 	struct timer_list blink_timer;
>diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>index d4a897a..2f51edc 100644
>--- a/drivers/net/ethernet/intel/igb/igb_main.c
>+++ b/drivers/net/ethernet/intel/igb/igb_main.c
>@@ -110,6 +110,7 @@ static void igb_init_queue_configuration(struct igb_adapter *adapter);
> static int igb_sw_init(struct igb_adapter *);
> int igb_open(struct net_device *);
> int igb_close(struct net_device *);
>+static void igb_rtnl_resume_task(struct work_struct *);
> static void igb_configure(struct igb_adapter *);
> static void igb_configure_tx(struct igb_adapter *);
> static void igb_configure_rx(struct igb_adapter *);
>@@ -3426,6 +3427,7 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>
> 	INIT_WORK(&adapter->reset_task, igb_reset_task);
> 	INIT_WORK(&adapter->watchdog_task, igb_watchdog_task);
>+	INIT_WORK(&adapter->rtnl_resume_task, igb_rtnl_resume_task);
>
> 	/* Initialize link properties that are user-changeable */
> 	adapter->fc_autoneg = true;
>@@ -3889,6 +3891,7 @@ static void igb_remove(struct pci_dev *pdev)
>
> 	cancel_work_sync(&adapter->reset_task);
> 	cancel_work_sync(&adapter->watchdog_task);
>+	cancel_work_sync(&adapter->rtnl_resume_task);
>
> #ifdef CONFIG_IGB_DCA
> 	if (adapter->flags & IGB_FLAG_DCA_ENABLED) {
>@@ -4123,10 +4126,31 @@ static int igb_sw_init(struct igb_adapter *adapter)
> 	return 0;
> }
>
>+/* Some settings need RTNL, which isn't held when resuming from runtime
>+ * suspend: apply them from here instead, if the device is still up.
>+ */
>+static void igb_rtnl_resume_task(struct work_struct *work)
>+{
>+	struct igb_adapter *adapter = container_of(work, struct igb_adapter,
>+						   rtnl_resume_task);
>+
>+	rtnl_lock();
>+	if (!test_bit(__IGB_DOWN, &adapter->state) &&
>+	    netif_running(adapter->netdev)) {
>+		if (netif_set_real_num_queues(adapter->netdev,
>+					      adapter->num_tx_queues,
>+					      adapter->num_rx_queues))
>+			netdev_err(adapter->netdev,
>+				   "error setting real queue count\n");
>+	}
>+	rtnl_unlock();
>+}
>+
> /**
>  *  __igb_open - Called when a network interface is made active
>  *  @netdev: network interface device structure
>  *  @resuming: indicates whether we are in a resume call
>+ *  @rtnl_held: indicates whether RTNL is held
>  *
>  *  Returns 0 on success, negative value on failure
>  *
>@@ -4136,7 +4160,8 @@ static int igb_sw_init(struct igb_adapter *adapter)
>  *  handler is registered with the OS, the watchdog timer is started,
>  *  and the stack is notified that the interface is ready.
>  **/
>-static int __igb_open(struct net_device *netdev, bool resuming)
>+static int __igb_open(struct net_device *netdev, bool resuming,
>+		      bool rtnl_held)
> {
> 	struct igb_adapter *adapter = netdev_priv(netdev);
> 	struct pci_dev *pdev = adapter->pdev;
>@@ -4179,16 +4204,15 @@ static int __igb_open(struct net_device *netdev, bool resuming)
> 	if (err)
> 		goto err_req_irq;
>
>-	/* Notify the stack of the actual queue counts. */
>-	err = netif_set_real_num_tx_queues(adapter->netdev,
>-					   adapter->num_tx_queues);
>-	if (err)
>-		goto err_set_queues;
>-
>-	err = netif_set_real_num_rx_queues(adapter->netdev,
>-					   adapter->num_rx_queues);
>-	if (err)
>-		goto err_set_queues;
>+	/* Notify the stack of the actual queue counts. This needs RTNL: on
>+	 * runtime resume igb_rtnl_resume_task() does it.
>+	 */
>+	if (rtnl_held) {
>+		err = netif_set_real_num_queues(netdev, adapter->num_tx_queues,
>+						adapter->num_rx_queues);
>+		if (err)
>+			goto err_set_queues;
>+	}
>
> 	/* From here on the code is the same as igb_up() */
> 	clear_bit(__IGB_DOWN, &adapter->state);
>@@ -4242,7 +4266,7 @@ err_setup_tx:
>
> int igb_open(struct net_device *netdev)
> {
>-	return __igb_open(netdev, false);
>+	return __igb_open(netdev, false, true);
> }
>
> /**
>@@ -6617,12 +6641,7 @@ cleanup_tx_tstamp:
> static inline struct igb_ring *igb_tx_queue_mapping(struct igb_adapter *adapter,
> 						    struct sk_buff *skb)
> {
>-	unsigned int r_idx = skb->queue_mapping;
>-
>-	if (r_idx >= adapter->num_tx_queues)
>-		r_idx = r_idx % adapter->num_tx_queues;
>-
>-	return adapter->tx_ring[r_idx];
>+	return adapter->tx_ring[skb->queue_mapping];
> }
>
> static netdev_tx_t igb_xmit_frame(struct sk_buff *skb,
>@@ -6636,6 +6655,17 @@ static netdev_tx_t igb_xmit_frame(struct sk_buff *skb,
> 	if (skb_put_padto(skb, 17))
> 		return NETDEV_TX_OK;
>
>+	/* After a fallback to fewer queues on runtime resume, the stack can
>+	 * use more queues than the device has until igb_rtnl_resume_task()
>+	 * updates it: drop those packets instead of sharing a ring between
>+	 * queues, which aren't serialized with each other.
>+	 */
>+	if (unlikely(skb->queue_mapping >= adapter->num_tx_queues)) {
>+		dev_kfree_skb_any(skb);
>+		dev_core_stats_tx_dropped_inc(netdev);
>+		return NETDEV_TX_OK;
>+	}
>+
> 	return igb_xmit_frame_ring(skb, igb_tx_queue_mapping(adapter, skb));
> }
>
>@@ -9639,8 +9669,11 @@ static int __igb_resume(struct device *dev, bool rpm)
>
> 	if (!rpm)
> 		rtnl_lock();
>-	if (!err && netif_running(netdev))
>-		err = __igb_open(netdev, true);
>+	if (!err && netif_running(netdev)) {
>+		err = __igb_open(netdev, true, !rpm);
>+		if (!err && rpm)
>+			schedule_work(&adapter->rtnl_resume_task);
>+	}
>
> 	if (!err)
> 		netif_device_attach(netdev);
>-- 
>2.56.1
>
Reviewed-by: Janis Edvarts Lacis <janislacis06@gmail.com>
