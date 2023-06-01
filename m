Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCFAC7EE24
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Jun 2023 15:19:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4BB71400FE;
	Fri,  2 Jun 2023 15:19:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4BB71400FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1685719181;
	bh=4RWbBbKBv3pAPAYjZ+RBVguB5Easwd6rea3HBlFROBY=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=hWrwGh+sPC5CEApFL5kcyOrlJlrT+UuHSqS/9eM6wnwrJG0NMYhPHczOdRaq3p0S5
	 m+B/Y1HiAxvbe9JlkqFdpnU83pav2bHkNLp3SsVVgonb1t6+dbtg/0WdS9CcLScown
	 tDcYs0z6KZv1ntQpb1MSKUXJZIi3wHPerOvjBWCLeIg+As07zs9MjuDU2shGFfk2sc
	 q28366qKSkR5SOPNtzsO2d3EqIM56164L13cT4haAo4ZVu0CdjK+npMuy23Kz7GJhl
	 doZ30MPymVmMJW7zGF+dKokjiyD6JYzLxQFISpuKKaC4LC0HuygKWHYTAYOGgr7YRc
	 IjcD05OBpkrxg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B89FfItkZnB8; Fri,  2 Jun 2023 15:19:40 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 61DE24187E;
	Fri,  2 Jun 2023 15:19:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 61DE24187E
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id B18121BF3B9
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Jun 2023 18:54:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8915F841AD
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Jun 2023 18:54:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8915F841AD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6L_naruqT5vw for <intel-wired-lan@lists.osuosl.org>;
 Thu,  1 Jun 2023 18:54:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B91F383CC8
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B91F383CC8
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Jun 2023 18:54:10 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1b00ffb4186so7563845ad.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 01 Jun 2023 11:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685645649; x=1688237649;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6z35WZemd1C1qxdgJ7Uu7pPGTsI9iEFAJXMocijQgVA=;
 b=Az1ZBJwiH/IVv3aKo1LRiwIbR2dFe4FoBpclCluga0iHLzGLdCvQxreEGWDLXJ1DrY
 lxvoUr5vPOu4qYENNR67bEZsEYviR4OFi8wEzFbxhiz7jTQrWBCWacW86Fp/JW0wfgR3
 Fb5dsn/ZmMvZSlfe6fUh+GbIp3fT4WCQlHUs9FVonFb1dcHiy7CBKqe19vX4XeIkP4el
 gJtp3Enj1UEtgP7MKscsJ0GgNmb/6SiOmSlLDflARJ736jVq2AuA6mpb8gn9LECxRJnX
 6MU2eoELKLz0D7q0595LOg8163fSTFV1gxu7oXmbcAYGhKZjA+Erz1ijnVVO980rEksd
 asyA==
X-Gm-Message-State: AC+VfDxj40hbP2QQxmaKSI8v2zhSd1/ZSpX56p2NRNRieJN2bS/BAhs2
 7ogDBgCcHFsM2rUSUmkClulyrZbuM9O6iD8Wczg=
X-Google-Smtp-Source: ACHHUZ4Vu16KOC6zAlANO0YIaKdbNzGQu4mGZFJi0DdcQ0YsV1Tv+kWbpgfNlS1nHW6gLvL0fV1q5Q==
X-Received: by 2002:a17:902:ec84:b0:1ae:4562:14f1 with SMTP id
 x4-20020a170902ec8400b001ae456214f1mr317058plg.9.1685645649639; 
 Thu, 01 Jun 2023 11:54:09 -0700 (PDT)
Received: from arista-Idaville.sjc.aristanetworks.com ([74.123.28.10])
 by smtp.googlemail.com with ESMTPSA id
 b7-20020a170902650700b001a922d43779sm3885066plk.27.2023.06.01.11.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 11:54:09 -0700 (PDT)
From: prasad@arista.com
To: intel-wired-lan@lists.osuosl.org
Date: Thu,  1 Jun 2023 11:53:53 -0700
Message-Id: <20230601185353.17012-1-prasad@arista.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 02 Jun 2023 15:19:39 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=google; t=1685645649; x=1688237649;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6z35WZemd1C1qxdgJ7Uu7pPGTsI9iEFAJXMocijQgVA=;
 b=MOTm/SKdXld6hejjXnny4qtDZg9mt3PA+2vjd2wM8SfWY0CA87biP+EPlu1EKC1BKv
 2QnKcI1KyJvvGNb6KErbAS34wBgkLaK3FyDmQvTZ/36YhEWdSoUmM9yFO1wFYWab8y+4
 s5SPEyAsE+wmFJClA3Y/sg+gzF8bFqy271t1n6CY8RvIW4FnnVLa92OKGF6+iZN1Y21M
 iB7pr0dma2gp6fnbBtEQHst3d4FQnKTv+w1AVp4smFwfN4U44BpcswMWiuCim57h5oAm
 bvokWGDAewrUpTFh4t4usFk/IurVmfw8W/AQrbHqnRuifIR2vZZQkkEzUyQ8uxHMwnjX
 lufQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com
 header.a=rsa-sha256 header.s=google header.b=MOTm/SKd
Subject: [Intel-wired-lan] [PATCH] intel-wired-lan: igc: set TP bit in
 ethtool_link_ksettings.supported field
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
Cc: gilligan@arista.com, prasad@arista.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Prasad Koya <prasad@arista.com>

if the physical media is twisted pair copper, set the TP bit in the
'supported' field

Signed-off-by: Prasad Koya <prasad@arista.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 8cc077b712ad..7d197fa80d5d 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1707,6 +1707,8 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 	/* twisted pair */
 	cmd->base.port = PORT_TP;
 	cmd->base.phy_address = hw->phy.addr;
+	if (hw->phy.media_type == igc_media_type_copper)
+		ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
 
 	/* advertising link modes */
 	if (hw->phy.autoneg_advertised & ADVERTISE_10_HALF)
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
