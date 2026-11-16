Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0DC606A889
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Nov 2026 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=4oBIo3Db;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=Axxtjs/u
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F12B1406AC;
	Mon, 16 Nov 2026 14:24:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UaBWyNN_tt1c; Mon, 16 Nov 2026 14:24:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 887A9406A3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794839094;
	b=ClJTMvHMVUkJuBvcB09aPP6CcRVik4raVPw0FVzx9+updbdgy8wMxEtiPHB3Yq1vpgCi
	 o9IekfbBp9ozCaZx2nkjcbXGRjsihtsoc8GK1+OvvuSD7qcNjqxxxA4V4Prhk7bTgJnw5
	 jRmMExWyyO4uwOlo1yyd9H0Of7tQLPanhiflLmqCyGeFSVOxsXCWJ6AaMt/LE00csHia2
	 wn7B49mwWwMqLtUxAOOKiJIcmNwlmqbK/pJIhTXhuLLGwOB3emPePspLXERhH4ibnkqRV
	 yOLP6umlRPgc9ZVAmJK2IZfBHzzih2u/ViBsEdeT1tcY2Xw4zypAU5OOZv7Ne/kADLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794839094;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=otl4c7sw8cCEVIAVDR1SXI7wOGAsQDrAt72bD+YeYx4=;
	b=tQ5w9wPRTi4towaxM1B+8m3u3+rwFm5C2Z0QJDmZFHzqKhl3U3pFJGObm3L4546xtUuX
	 a6QhScBzlrMyDpwHYp4ZAm5Wz+HI9vreECsbhi6MfWZCvqTDFMzK6zDxniJb+1I9Dl34c
	 6up3mXTveHOuVcnpzK9jBizO437YT0wqyo1Xk4KWofBkbyouCAPomrvI5nIUGD6VxeRVy
	 MblHARP3vFlwFKrYXRw6YiAuzNbJHPEZWe0tA5S0AH/w6ua3jJhAKLVpiS+fAR4lN+/Uf
	 4l6nuB0icQIjztNRvy/DNo91ZUh77amoKXbGBNLWQT5mGPdAPLTNwawzIB+ggJBoHmw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794839094;
	bh=otl4c7sw8cCEVIAVDR1SXI7wOGAsQDrAt72bD+YeYx4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=4oBIo3DbfzXJbJykbon/g7ORMbtlxyUgaUOq/4hlDLw/LaJrZLbJq9cpWHtUO8bdF
	 OHLxtPV7XIpHj2Ek29zk0OBgyuH9DSpgoSSYtqXKfbTTMCDDon4ggX/DgSV5WYWZMK
	 sH+ibpZhxUWt63nf5TwjRxoNGaBnBCQy4F2NpQtlgbWoUGSW7s9T1NErwBryUAgRFs
	 e3BGzMdcGkxi+7eC7LI6ht5EhHyB95urvLHM/BixlduRm4pQxw+yiADtAH6ZRDRIMS
	 RQck84bgJhRmLDAA4s+85F1FpDtvk375AS805FUoj8kJ2vPKkOqi/eDDg77OqqDztc
	 0AbNHIocPyRUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 887A9406A3;
	Mon, 16 Nov 2026 14:24:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C03EA28C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 14:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B1C4860739
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 14:24:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zKMqzHU4IJo7 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Nov 2026 14:24:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CBC986067D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=45.254.49.198
X-Greylist: delayed 306 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 16 Nov 2026 14:24:47 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=mail.sdu.edu.cn
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn
 header.a=rsa-sha256 header.s=default header.b=Axxtjs/u
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.254.49.198;
 helo=mail-m49198.qiye.163.com; envelope-from=liguangshuo@mail.sdu.edu.cn;
 receiver=<UNKNOWN> 
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com
 [45.254.49.198])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CBC986067D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 14:24:44 +0000 (UTC)
Received: from lgs.. (unknown [101.76.249.61])
 by smtp.qiye.163.com (Hmail) with ESMTP id 54db447b9;
 Mon, 16 Nov 2026 22:19:35 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net] igb: Fix potential I2C adapter leak on probe failure
Date: Mon, 16 Nov 2026 22:19:35 +0800
Message-ID: <20261116-c29ba55625-net-igb@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1e4ba485903a1kunm4914b35410e1c6
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaS0NPVkJLH0oZTkIaHkpKS1YeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
 NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
 b=Axxtjs/u0WODD7BOmpbpeuEyjUePZDcu6qVabOD+aEna2ZiRkjECGFMWsvqmv6IkJUcFzVnARpDJWAnJhr/2VSG14tQ/4j1HZkHFx9A402wtcr/thhtQBOUcApaF68YEF5ZAdHJdeL8WnZjS0TDNO5jDn9SBjt//63YBRBRTN/U=;
 c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1; 
 bh=otl4c7sw8cCEVIAVDR1SXI7wOGAsQDrAt72bD+YeYx4=;
 h=date:mime-version:subject:message-id:from;
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If netdev registration fails after I2C setup, err_register clears the
embedded adapter without unregistering it. I2C clients and the adapter
registration outlive the freed netdev.

Delete the registered adapter instead of clearing its storage.

This issue was found by our static analysis tool under development.

Fixes: 441fc6fdb47a ("igb: Add i2c interface to igb.")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d4a897a8c82c..ffb696500d9c 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3657,7 +3657,8 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 err_register:
 	igb_release_hw_control(adapter);
-	memset(&adapter->i2c_adap, 0, sizeof(adapter->i2c_adap));
+	if (adapter->i2c_adap.dev.parent)
+		i2c_del_adapter(&adapter->i2c_adap);
 err_eeprom:
 	if (!igb_check_reset_block(hw))
 		igb_reset_phy(hw);

base-commit: 2e54b3e187300893688c2c7517894f5d96732e05
