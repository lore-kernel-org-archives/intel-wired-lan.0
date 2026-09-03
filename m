Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE8BC624A4
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Sep 2026 07:54:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0450360A5E;
	Thu,  3 Sep 2026 07:54:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3A45v0KyIEm8; Thu,  3 Sep 2026 07:54:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F3547608E2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788422079;
	b=eDZ4iyUaICBJJPzaeamBhsWlSbHhjP5wXDLRPCrRH6q5ZmtXYG2DbxIZHzyOB31XoKVt
	 yg0YpPyo4X2LVlvNCvTqEhUphWFOaCabPiXbV2zpWCxxlnYdEeM4JF9I135wCKSCSXphl
	 fKfGaF7AG5RtvHdUvS9/6Ox4e1+FFw7Op1Kg2sdIGAPR3iT09KBQ0YJavlFW5muQa1sLW
	 TIuOXD7ZtZlBLIKpIYd1TkkFgoJyNXS8+shnPrwz3WTJS9+yWLcaPlF/JsRTYhSUtq+yr
	 qKqR3lBfPiu0X8pf/Vewnn9gzYbG6BlhhoVRZVIqC5pjuBFk2TnRdWJKWjuI4HHWDuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788422079;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PUZRPUihB4/zYB1wxGPC0vA0+5hiy7QBITAZAVWHgWA=;
	b=X0A35tWS1Jh9bPLArPTN0mgcqJTLH5vXev/FnLv5YHDbf2uQodGGSPoGvXNlGzgDrHa2
	 95tZk0jAVQ+OeXrWJ/NVu+Eq092LYig5H4ilvMbrZ/yBMUvPK8ubPeMqPs23WK9SugG6A
	 T+1N5TR29qEJCQe+FTSu9qstMQcMB5GDa6g7muOBeF/ab9RHbfrOr7zdxp5zMldDQZO+I
	 dvku0znpcB5QBPtL8YeR6w1M72v4qO1tejTjLjgrrGjFWqJzynRvNckw3FD6B2srGn+Xq
	 MJFOYDN0psVuhIM2ffQmOooaVSjaaCBCoHTmg0a5VDoqoWpCm2C3llGNln3ukWzGR4A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788422079;
	bh=PUZRPUihB4/zYB1wxGPC0vA0+5hiy7QBITAZAVWHgWA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Lqvt2/CbRxdJZ9Dr78ONjH2aY/du6vQQbPuaYNXf3HylJVxLiGF03NzcdM961CUfA
	 5nYv6LYtUfAGjEZUPqdwurn6E4dHZU9AJXPLSMplqm0UYe4ezjVw0Qv59XLuMVEws+
	 siSxghCTgwxd9spTMcUALNxiMgwz04fqF0GTkk6i00jNawlp7lMh/eKniEzfhus1Dq
	 VqMrBzEpS67luCYaM39IqNWud56PBP7X/wdjHOR9s6BEHw9lwujbVTVC2zRsAnDjOR
	 iIOycbKw4fnjrFHGOJlQ62P8bLOwensEgs1/25O1FwXwS0XED34nb/yu5t5LOYD2Nm
	 46PK9vpspTS6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3547608E2;
	Thu,  3 Sep 2026 07:54:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C4A3C230
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 07:54:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C1C0681016
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 07:54:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SxA-9xOT8blK for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Sep 2026 07:54:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 22C6281010
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788422076;
 b=s3p5AZOt6CpwW6yEB+qOfnZVDAgOvIr4LnaMOF4XZAwFeOkSpQnW0tbd6j4W3IZxEBBQ
 J69u6ry9N7AcJwn+LNnJabHYnzL+SdB8WtkX6jBduoZcn7/ko9NQtIBt8ELphp2v+yV3b
 A0a2AtPQB7CPri/di7vNTntb5v2rxNG62j2vaNW1nX520jUdiQTcS2hlUqfyeEwr4L7qc
 Z9Zv4tk8AazNx88+MAFWj/fvopflnQ542tJZHngkodBk/3egwxkr6oOg8QGMpFJ0OOn7Q
 SKqfg0g/C6BGDMu3YOv4hb4NM4pdtj3sSNakqBwf460aEa5j2r0YmCyg6ZM5tT2a33g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788422076;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=PUZRPUihB4/zYB1wxGPC0vA0+5hiy7QBITAZAVWHgWA=;
 b=F+kCnciLsm22hcaIlz6d3wmPNor3Zv0+Pg+ViFu3KOU7Np7R2UAe/UOs8V0Lfpr6hVPu
 Z+0jf4DdZfq/5UCs4jY7yjqg8u2zhYC4lBfk0PFJs8iBFfzrgAFUtXYx6r8WdXKwMF5oX
 gLNBuzyYpEyXaGucmhVXpwfCeQ5pD2+UUZxawW2nYCpxcXar83vmDoFUuyFI3DPuIuOYW
 ajLXacP+8jArtNiT5IJ/1rK0w8yD98ndPMJaw6AAj5uJaWD6F7LfT1SnYSEplPQNt9ouR
 lY1+dIiXR9D+IAtJIUKWGpe/julL9SP0urrdPqbZXIklHiduMopaBAWWd8+KFZrsv4w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=obK2Wn5i; 
 arc=none smtp.remote-ip=185.125.188.122
X-Greylist: delayed 422 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 03 Sep 2026 07:54:35 UTC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=obK2Wn5i
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com; envelope-from=aaron.ma@canonical.com;
 receiver=<UNKNOWN> 
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 22C6281010
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 07:54:34 +0000 (UTC)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 50EAB44B97
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 07:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788421650;
 bh=PUZRPUihB4/zYB1wxGPC0vA0+5hiy7QBITAZAVWHgWA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=obK2Wn5ihqs29IhgbFk9zOmrCOCRMjG0gJAPGkEO/lfK5UOQxdwgZMHDNbgcvnHxI
 lUn4MJj8zpBruVolRdTJ6lvALs0kNiefDgi9wHQ38cZ/euBssCAaUq2aV1IXJRTEhr
 yikOVZyxEn6WfJE8biX/yRO7uxoTKvkLb4rX1PWm8goxM0FmD17mDIBBphKpkBssFe
 Uueybydwv0jESHXPqCp4YK28XySwTFvD50CzAGL4PBNmog4JPeF0yfwjqLhQala3+e
 6s/4cANbDeILLbj3MKkVTwe5KYVUAGKdenCkhYi7JCo4nvqDQbz13+sPnR/mD3smX1
 azpdY2xcgybPnMqaV1qn2qpwBsgZmd1s7P5Y8aGz5ulX1hPhrO9F32bFPSb81zsgQ5
 szauhwlm2Udk5duU2ENlrKmCQe1QdZsEgHa3PA0d1u/s02AcDffIg+d40UeWoO4u4e
 FvUbHxJqG4qAkspoicCKWsNoXN1B0jg0JEhww4RfPLmppTK4yFRebMruO2HfOQ4yON
 Ko7Sg7ujwC18m9vdEIopWQv5Z1RnIpM1NbMRvzW3bF++yLzOEJttePB1qBL9hClUEx
 RxfU8fUyvYv2Xk8x0wooz7lOfLt3+DnmdQlFuO9AlUiVmF3EAH6F535tLXaeuEX9uO
 NqwfUU994Ne4t9CpQ9sTKgM0=
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-398e1f7d1a5so3300514a91.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 03 Sep 2026 00:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788421649; x=1789026449;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PUZRPUihB4/zYB1wxGPC0vA0+5hiy7QBITAZAVWHgWA=;
 b=gxZqxFPIpAHg3isywXJs8sthq0AYeTcYr4Bw6adrazNse01oJxNUa473QIOz1H7qLD
 D9sB4UIweh/S6CDbL99x7GVXWKDYKjREkq4gxE1fY3nQw3X2q50SYKk22CpauYn5oRbe
 GfRRS72d4vMvCNHfuWsmC3PSQLhwlvi2jLSFemLrGnNndnIjDmzWNd7i++Ooy1TjT2sE
 7stbbNeAh/KosbdgTu2GRcCHqsFvikkt/d8SfuA98dCN49maHXHbNH1/xoror2ACERxa
 8gdkOGgbqUAaEoO8w+DebpP63Hy/jIn/OZnd3vz+4jFrZSYbSkIdywWqxwYuGKK1XMKE
 O9ng==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjrr0dzvlfnD2CCcfCYxiA9WRcPk9mapc2xUlXftgiuGNjsiYfXgrvZxR/r/GK2He/rRGYo1NC9hvqN2wSlcs=@lists.osuosl.org
X-Gm-Message-State: AFuF++k1A2NlxL3cJqqzxJCxsrHSdvkNLien+bIAuGujTpDKhjKd2jI6
 X7Nfy0AWDEdaTctVAMJIPF5Rno3shD1cfLkiqn1LIKVTa0RRrxtsYJWNdJqVB7U/BeTsr1GE1uW
 pIamQb2ppKSB6H4XHpykX5//c4uhcYqZjxVaOGbYAC7eA/E9iNZ08cyQjQJsdjd6yc9ecfW6w2B
 o+STi/kt6PPxs=
X-Gm-Gg: AYBFou3l40mpHxiw9Z8Bh7MEFhhjbH7P5zqs+3cA+Ct8ukwrP6PFUy+DnpGY74PqGth
 msa87RK/g/txtZ+2PdQsnjuR2ctzpg7kOrJe06Z0pOCsCW9ZGW3ZMwUBLObKZyhABQZdKEszdsj
 pQLX2ilgi0x274n8Y9fNANN0DioIlHGe/ZYr39U63/sL/XNR6XB2TNgLyPh4KeB/2S4KI7geukt
 /od1/KyUfjASDAWACihsXrn2lQDlVZDCmCXbuLgQKK/PB4NR1j7wnXzL70fs/zmtA1W8lNJXwAg
 xJ56KmAx9rK1broO0DskN0cR0FQsR66H3hP9fgwi14Bh71VtziFUYssZpMxwEblAxdxEglqyeeL
 Q6UhNbYJqE3cNJuvzz+YSDbCnrCp/GpGvGWm8SgPQJz7+GCIqDe99+uQe4POnvN0127H/OWxIBo
 eR615GDl1vHGtk88gRjvHkUoHULmtpoj7sc7aAzQ==
X-Received: by 2002:a17:90b:4a8e:b0:38f:18f9:785 with SMTP id
 98e67ed59e1d1-39aedf73060mr14440441a91.8.1788421646798; 
 Thu, 03 Sep 2026 00:47:26 -0700 (PDT)
X-Received: by 2002:a17:90b:4a8e:b0:38f:18f9:785 with SMTP id
 98e67ed59e1d1-39aedf73060mr14440335a91.8.1788421646219; 
 Thu, 03 Sep 2026 00:47:26 -0700 (PDT)
Received: from u-ThinkPad-X1-Extreme-Gen-4i ([103.155.100.1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39ae62a54f6sm2991223a91.1.2026.09.03.00.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 00:47:25 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Henry Tieman <henry.w.tieman@intel.com>,
 intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS)
Subject: [PATCH 1/2] ice: restore DDP state during PFR recovery
Date: Thu,  3 Sep 2026 15:47:05 +0800
Message-ID: <20260903074706.602087-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The firmware package and switch recipes are shared by all PFs of an
adapter. However, each PF rebuilds independently after system resume. The
resulting package downloads and recipe updates can interleave, causing
firmware timeouts and leaving interfaces unusable.

PFR also clears package-derived firmware state on affected devices. The
existing PFR path only rebuilds the driver's block tables, so VLAN recipe
programming can fail after the reset.

The failure is reported as:

  ice 0000:04:00.0: Update pkg failed: err -5
  ice 0000:04:00.0: package load failed, -12
  ice 0000:04:00.0: Rebuild failed, unload and reload driver

This was observed on an Intel E810-XXV-2 adapter (PCI ID 8086:159b,
revision 02) with NVM package 1.0.0.18 and ICE OS Default DDP package
1.3.43.0.

Serialize rebuilds across PFs of the same adapter, while allowing each PFR
to complete independently. Reload the DDP package from its cached copy and
restore the default DVM recipes before rebuilding the remaining PF state.
Abort recovery if either operation fails.

Fixes: 462acf6aca85 ("ice: Enable DDP package download")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.c  |  2 ++
 drivers/net/ethernet/intel/ice/ice_adapter.h  |  3 ++
 drivers/net/ethernet/intel/ice/ice_main.c     | 33 ++++++++++++++-----
 .../net/ethernet/intel/ice/ice_vlan_mode.c    |  2 +-
 .../net/ethernet/intel/ice/ice_vlan_mode.h    |  1 +
 5 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 2dc3629d6d0f6..7de9223e971a7 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -64,6 +64,7 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 	spin_lock_init(&adapter->txq_ctx_lock);
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_init(&adapter->cpi_phy_lock[i]);
+	mutex_init(&adapter->rebuild_lock);
 	refcount_set(&adapter->refcount, 1);
 
 	mutex_init(&adapter->ports.lock);
@@ -77,6 +78,7 @@ static void ice_adapter_free(struct ice_adapter *adapter)
 	WARN_ON(!list_empty(&adapter->ports.ports));
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_destroy(&adapter->cpi_phy_lock[i]);
+	mutex_destroy(&adapter->rebuild_lock);
 	mutex_destroy(&adapter->ports.lock);
 
 	kfree(adapter);
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index 4f695f32da3d8..f9265de973efc 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -37,6 +37,7 @@ struct ice_port_list {
  * @cpi_phy_lock: Per-PHY mutex serializing CPI REQ/ACK transactions.
  *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
  * @ctrl_pf: Control PF of the adapter
+ * @rebuild_lock: serialize PFR recovery across PFs of the same adapter
  * @ports: Ports list
  * @index: 64-bit index cached for collision detection on 32bit systems
  */
@@ -48,6 +49,8 @@ struct ice_adapter {
 	spinlock_t txq_ctx_lock;
 	/* Serialize CPI REQ/ACK transactions per PHY (E825C only) */
 	struct mutex cpi_phy_lock[ICE_E825_MAX_PHYS];
+	/* Serialize PFR recovery touching shared FW global state */
+	struct mutex rebuild_lock;
 
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d88835482d3aa..a97a1941cec6a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -659,7 +659,9 @@ static void ice_do_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	 */
 	if (reset_type == ICE_RESET_PFR) {
 		pf->pfr_count++;
+		mutex_lock(&pf->adapter->rebuild_lock);
 		ice_rebuild(pf, reset_type);
+		mutex_unlock(&pf->adapter->rebuild_lock);
 		clear_bit(ICE_PREPARED_FOR_RESET, pf->state);
 		clear_bit(ICE_PFR_REQ, pf->state);
 		wake_up(&pf->reset_wait_queue);
@@ -704,7 +706,9 @@ static void ice_reset_subtask(struct ice_pf *pf)
 		} else {
 			/* done with reset. start rebuild */
 			pf->hw.reset_ongoing = false;
+			mutex_lock(&pf->adapter->rebuild_lock);
 			ice_rebuild(pf, reset_type);
+			mutex_unlock(&pf->adapter->rebuild_lock);
 			/* clear bit to resume normal operations, but
 			 * ICE_NEEDS_RESTART bit is set in case rebuild failed
 			 */
@@ -7674,14 +7678,27 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 		goto err_init_ctrlq;
 	}
 
-	/* if DDP was previously loaded successfully */
-	if (!ice_is_safe_mode(pf)) {
-		/* reload the SW DB of filter tables */
-		if (reset_type == ICE_RESET_PFR)
-			ice_fill_blk_tbls(hw);
-		else
-			/* Reload DDP Package after CORER/GLOBR reset */
-			ice_load_pkg(NULL, pf);
+	if (!ice_is_safe_mode(pf) && reset_type == ICE_RESET_PFR) {
+		enum ice_ddp_state state;
+
+		state = ice_init_pkg(hw, hw->pkg_copy, hw->pkg_size);
+		ice_log_pkg_init(hw, state);
+		if (!ice_is_init_pkg_successful(state))
+			goto err_init_ctrlq;
+	} else if (!ice_is_safe_mode(pf)) {
+		/* Reload DDP Package after CORER/GLOBR reset */
+		ice_load_pkg(NULL, pf);
+	}
+
+	/* PFR can lose DVM recipes after system suspend. */
+	if (!ice_is_safe_mode(pf) && reset_type == ICE_RESET_PFR &&
+	    ice_is_dvm_ena(hw)) {
+		err = ice_dvm_update_dflt_recipes(hw);
+		if (err) {
+			dev_err(dev, "failed to restore default DVM recipes: %d\n",
+				err);
+			goto err_init_ctrlq;
+		}
 	}
 
 	err = ice_clear_pf_cfg(hw);
diff --git a/drivers/net/ethernet/intel/ice/ice_vlan_mode.c b/drivers/net/ethernet/intel/ice/ice_vlan_mode.c
index fb526cb847764..58fb191903a75 100644
--- a/drivers/net/ethernet/intel/ice/ice_vlan_mode.c
+++ b/drivers/net/ethernet/intel/ice/ice_vlan_mode.c
@@ -240,7 +240,7 @@ static struct ice_update_recipe_lkup_idx_params ice_dvm_dflt_recipes[] = {
  * ice_dvm_update_dflt_recipes - update default switch recipes in DVM
  * @hw: hardware structure used to update the recipes
  */
-static int ice_dvm_update_dflt_recipes(struct ice_hw *hw)
+int ice_dvm_update_dflt_recipes(struct ice_hw *hw)
 {
 	unsigned long i;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vlan_mode.h b/drivers/net/ethernet/intel/ice/ice_vlan_mode.h
index a0fb743d08e20..5dc705435f56a 100644
--- a/drivers/net/ethernet/intel/ice/ice_vlan_mode.h
+++ b/drivers/net/ethernet/intel/ice/ice_vlan_mode.h
@@ -8,6 +8,7 @@ struct ice_hw;
 
 bool ice_is_dvm_ena(struct ice_hw *hw);
 int ice_set_vlan_mode(struct ice_hw *hw);
+int ice_dvm_update_dflt_recipes(struct ice_hw *hw);
 void ice_post_pkg_dwnld_vlan_mode_cfg(struct ice_hw *hw);
 
 #endif /* _ICE_VLAN_MODE_H */
-- 
2.43.0

