Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D368C43219
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Nov 2022 13:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CCE58400D1;
	Fri, 25 Nov 2022 13:30:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CCE58400D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1669383058;
	bh=exwULrZnJj+YJNR+5AaZVNmHbTWDdyUaDx+Gla6OzZk=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=QQS3UIaFgc45YN1N7wo5wzulG97tQCBXiN+p07pw/Ip5Aymcb4QxXRMkSZcq4FJ9G
	 UPgpXVlJfzIdq9VG156CeTmaDCxJ7CNmx5l4Oun8PbWts3jEq+RXL5XN3OMnXfTWWp
	 H1KR+RUF0zgba4x09pVZNspMoprOLcXbSoy5N2R46HHW3AVHgVU8pC3SGs1ZY6bhv1
	 IYU5HcO7Z8BljCUBvtrrs4GxPcldg5qVmf8l9836rrBWAQj6eCkx2Eh7furilIuQJT
	 DlB0B4H8kpwEU8bIlghGUlj1ELN0r+9fJKgkkVIZSWghwg/Ez8RZHz+jWW0zUHSVnF
	 BWUXTcKjwTBBw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YfmmW61V9jfK; Fri, 25 Nov 2022 13:30:58 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id D628740126;
	Fri, 25 Nov 2022 13:30:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D628740126
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id B69551BF35E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Nov 2022 13:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F67F417BD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Nov 2022 13:30:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F67F417BD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w2HQ69TKNihd for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Nov 2022 13:30:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 202F7417B7
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 202F7417B7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Nov 2022 13:30:55 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 3-20020a17090a098300b00219041dcbe9so3002343pjo.3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Nov 2022 05:30:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G0f8po3oGM3AyA2xY13NNMcDFWQESZf/ZoND6qGqfcg=;
 b=RvNsSjUKPBx6DRRZv7eSmWNKE57r3Yxfy+Gd9n+T9mTrIr0tB6Qp9nn4qQQJ+8lJpt
 BollPH4KfvQjAN2XfXKDeNEsgp/rHNMiLAADd1vUaoWW15BB6rCklaC3egPruIxCZxEY
 v9Jqm2h3bLmtTQPLH7+BoJZaO2f3tRc92as7YLvpLBVYyVuo/63oYu6P1oCaWzjD0+ES
 iF5LXwikDmzVSPuCrnxbTuLwOuLyRb2H8kypctxqNR6RkuG0t+iyHLzQy9v9vhNTF5Zb
 JMaTBcSQ24QUb/bzKqOx0J/I1HGhXRIK1BEZC8+VyFDKUEU1k4BMytz1flh9AVbKGUCO
 rqRg==
X-Gm-Message-State: ANoB5pnmOmBS9ZTeC+cGK1GZUpGcuyHpwXUcRu4AH4S6wNOhtjh4t/xp
 3zHI3cTAAsX8afQI/Edws/ltGg==
X-Google-Smtp-Source: AA0mqf5IgZE1vhZn3LC0O+/Hr5RHzVVnpy8tovknaO0Qu5PeTaEqKfe4sUYy0yA17rIHnhmqu7+MDA==
X-Received: by 2002:a17:903:40cb:b0:178:b4b7:d74d with SMTP id
 t11-20020a17090340cb00b00178b4b7d74dmr18455477pld.83.1669383054458; 
 Fri, 25 Nov 2022 05:30:54 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a63ef04000000b00476b165ff8bsm2640369pgh.57.2022.11.25.05.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Nov 2022 05:30:54 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Date: Fri, 25 Nov 2022 22:30:31 +0900
Message-Id: <20221125133031.46845-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G0f8po3oGM3AyA2xY13NNMcDFWQESZf/ZoND6qGqfcg=;
 b=hIfb04YR66SoWfN62oM3s21bvxKs1tiBUExmZ7hhHyPEfAsPrs1aHO33+wTX091uY9
 /0ZTIRcp6Gsfqf60+12xk9PQXHtZ+D5DWHIbjnc50U4juOV2D7RZli3OO77qrQReb1vQ
 V43B096wuGQrkSNeRIXacDV+0bR/v0SrelJL3ucwFP3xwPEPIzXs6RYtsXPzqSoFnEIl
 2SIF6L3qFQqeAdNewtofzukglB8pkbAMwYAvQxdgjoAxQG0K6JSAv+HCNcgfizESIn7U
 7x6nS7BFarhRuFF2bhr49E2ryaEXh6Twyey6ufMrH+bsrhMzaFIIWqsTGIsl0xGdpCW+
 6Yow==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
 header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=hIfb04YR
Subject: [Intel-wired-lan] [PATCH net v4] igb: Allocate MSI-X vector when
 testing
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Yan Vugenfirer <yan@daynix.com>, intel-wired-lan@lists.osuosl.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Without this change, the interrupt test fail with MSI-X environment:

$ sudo ethtool -t enp0s2 offline
[   43.921783] igb 0000:00:02.0: offline testing starting
[   44.855824] igb 0000:00:02.0 enp0s2: igb: enp0s2 NIC Link is Down
[   44.961249] igb 0000:00:02.0 enp0s2: igb: enp0s2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   51.272202] igb 0000:00:02.0: testing shared interrupt
[   56.996975] igb 0000:00:02.0 enp0s2: igb: enp0s2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
The test result is FAIL
The test extra info:
Register test  (offline)	 0
Eeprom test    (offline)	 0
Interrupt test (offline)	 4
Loopback test  (offline)	 0
Link test   (on/offline)	 0

Here, "4" means an expected interrupt was not delivered.

To fix this, route IRQs correctly to the first MSI-X vector by setting
IVAR_MISC. Also, set bit 0 of EIMS so that the vector will not be
masked. The interrupt test now runs properly with this change:

$ sudo ethtool -t enp0s2 offline
[   42.762985] igb 0000:00:02.0: offline testing starting
[   50.141967] igb 0000:00:02.0: testing shared interrupt
[   56.163957] igb 0000:00:02.0 enp0s2: igb: enp0s2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
The test result is PASS
The test extra info:
Register test  (offline)	 0
Eeprom test    (offline)	 0
Interrupt test (offline)	 0
Loopback test  (offline)	 0
Link test   (on/offline)	 0

Fixes: 4eefa8f01314 ("igb: add single vector msi-x testing to interrupt test")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
V3 -> V4: Added Fixes: tag

 drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index e5f3e7680dc6..ff911af16a4b 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -1413,6 +1413,8 @@ static int igb_intr_test(struct igb_adapter *adapter, u64 *data)
 			*data = 1;
 			return -1;
 		}
+		wr32(E1000_IVAR_MISC, E1000_IVAR_VALID << 8);
+		wr32(E1000_EIMS, BIT(0));
 	} else if (adapter->flags & IGB_FLAG_HAS_MSI) {
 		shared_int = false;
 		if (request_irq(irq,
-- 
2.38.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
