Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3355CCD1A5
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Sep 2024 13:58:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 830A742429;
	Wed, 18 Sep 2024 13:58:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wPXQSf_IkeKG; Wed, 18 Sep 2024 13:58:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 91B2841D7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1726667897;
	bh=SPn7NyA8EvFtDI+rj2RU3nMqRoNcoHgRdtft+sybg/g=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=81Oib0nOTRdn/uqi6y+MXZ74wd7mvpe/JlImB9T61081rsticZphOlLSt7zR9p+MY
	 wjsZWcu53P0X9IR/RFknZIAQCT5V7WbvfHIB0kboDndJq1AcPFvIXGU4ryyaq2YlpX
	 +Swt4xL/LZ/8Cp4QWJGAsP2pu2S0VLmpvzqub8zvONsTdHGLcJTiLYmjVo0eiyNR6h
	 YoncvUrnewoeCRYgNl0paZAw+WdueiodsE13YQCpnXcP1KzIh3yvZ7U9SaG/QDUyhh
	 W5bDZtjkld+uRXUifTc5maMMgXeM2Pe0MJ7yHMr07LgiuAcpvM1IqGzXuzehpwc2Ab
	 qQKbzJbIbyPpw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91B2841D7E;
	Wed, 18 Sep 2024 13:58:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id ABA891BF4E2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Sep 2024 13:58:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 997BE6070F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Sep 2024 13:58:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RPWC8jcjiIRe for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Sep 2024 13:58:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=jdamato@fastly.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8485260629
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8485260629
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8485260629
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Sep 2024 13:58:15 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a7aa086b077so862375066b.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Sep 2024 06:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726667893; x=1727272693;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SPn7NyA8EvFtDI+rj2RU3nMqRoNcoHgRdtft+sybg/g=;
 b=LC+TuUnmaHKytt7/bWITf00TDnQ/RrDtEpBeX5VovGhRhPqg4bZLgmrGk+B0WasBau
 zAd7BOh18KeVxl2VWrSiLGFcLYfPBt45TNdEWr4tTiTjJMvJcUAD/lbeyraznoSsY2k1
 OkNhXjcWq2GbB39ohGMTpuu320IPbGJLSB4wfUzDWQNPqTDEAZHGI903JYK1xyQME1/A
 0ej4S+LiCScxJG6JzqoADvUDtq1CbOJ+veX/2a9dLe0size9pB9OGh0oBTNU1ammSedL
 TgUUwop4qeHn474uXZILptn3TBnOruY8C6SvsxOEqDMIcloCpN7sSs2BI61Jykkkz2W3
 dS2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZgYd/PkUPcMP/zuQgKtFSugf5L4Q/KRKNZRUXv8qzwKrrGLscHVykGquItNQ1C8RXBDrfkitYDn/av4x8GGc=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyGbbc9qs206ziqFo4b+1I3fN1OUijYfgl86G14g2dZ8hDHSdVL
 OrNLKx4O0qJ0ULPLwGsPCgugKP4GR5gyICnTJiaNvnke1vEz4YM0eAGcahVRyfw=
X-Google-Smtp-Source: AGHT+IFmawmX5JiRVgNf/0L0WpQV3DqIK1N/ZTMHGP5g/mV8702xqodsE7+50nL/fybsbo9t4AkL1Q==
X-Received: by 2002:a17:906:6a14:b0:a90:4199:2a73 with SMTP id
 a640c23a62f3a-a9041992ae5mr2018156266b.5.1726667893278; 
 Wed, 18 Sep 2024 06:58:13 -0700 (PDT)
Received: from localhost.localdomain ([83.68.141.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90613315d8sm595283466b.214.2024.09.18.06.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 06:58:13 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Date: Wed, 18 Sep 2024 13:57:26 +0000
Message-Id: <20240918135726.1330-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fastly.com; s=google; t=1726667893; x=1727272693; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SPn7NyA8EvFtDI+rj2RU3nMqRoNcoHgRdtft+sybg/g=;
 b=GLRwgzkVnQrGVc+w3GkEj9jdFcI/o66D0wNnpC/weE/bsuA/kPWonUhvf3XI+MwQCI
 neMnFc/oK+JYfY+kbWpndYLUfqKNhiDU08MRfD9dU96NqqMdQkews7O45WszeDBOLIcz
 rwlW79ICx/Cmnk2nz3PMImbv0cN0jmSRhXcIU=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=fastly.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=fastly.com header.i=@fastly.com header.a=rsa-sha256
 header.s=google header.b=GLRwgzkV
Subject: [Intel-wired-lan] [RFC net-next] e1000e: link NAPI instances to
 queues and IRQs
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joe Damato <jdamato@fastly.com>, open list <linux-kernel@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Make e1000e compatible with the newly added netdev-genl APIs.

$ cat /proc/interrupts | grep ens | cut -f1 --delimiter=':'
 50
 51
 52

While e1000e allocates 3 IRQs (RX, TX, and other), it looks like e1000e
only has a single NAPI, so I've associated the NAPI with the RX IRQ (50
on my system, seen above):

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                       --dump napi-get --json='{"ifindex": 2}'
[{'id': 145, 'ifindex': 2, 'irq': 50}]

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                       --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 145, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 145, 'type': 'tx'}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index f103249b12fa..b527642c3a82 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4613,6 +4613,7 @@ int e1000e_open(struct net_device *netdev)
 	struct e1000_hw *hw = &adapter->hw;
 	struct pci_dev *pdev = adapter->pdev;
 	int err;
+	int irq;
 
 	/* disallow open during test */
 	if (test_bit(__E1000_TESTING, &adapter->state))
@@ -4676,7 +4677,15 @@ int e1000e_open(struct net_device *netdev)
 	/* From here on the code is the same as e1000e_up() */
 	clear_bit(__E1000_DOWN, &adapter->state);
 
+	if (adapter->int_mode == E1000E_INT_MODE_MSIX)
+		irq = adapter->msix_entries[0].vector;
+	else
+		irq = adapter->pdev->irq;
+
+	netif_napi_set_irq(&adapter->napi, irq);
 	napi_enable(&adapter->napi);
+	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_RX, &adapter->napi);
+	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_TX, &adapter->napi);
 
 	e1000_irq_enable(adapter);
 
@@ -4735,6 +4744,8 @@ int e1000e_close(struct net_device *netdev)
 		netdev_info(netdev, "NIC Link is Down\n");
 	}
 
+	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_RX, NULL);
+	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_TX, NULL);
 	napi_disable(&adapter->napi);
 
 	e1000e_free_tx_resources(adapter->tx_ring);
-- 
2.34.1

