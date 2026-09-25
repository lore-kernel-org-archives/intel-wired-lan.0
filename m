Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE9CC9830D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 10:12:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE75140B20;
	Fri, 25 Sep 2026 10:12:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uTuY06M7AHyl; Fri, 25 Sep 2026 10:12:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2B64840B27
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790331138;
	b=tKIVR5sgG888PufmuLNBiKqEPdWCzqsXUiHH6C/BzgIQBKcnvpW7Au6nXxgXw1tWMDzF
	 M6Xm7MOZqJHRGUz3mSjUzsO2MGeEp6nU0Rt5Ud2ljutjRx7dcq8Gcm258aOXcYGlgcN+j
	 FmeMZ1UWmA6EEM+VGE45LP041XZ9uSAgFPCNVoCtmNFLmfNR0BpSwU8AMGPJySo/qzcav
	 i29UilFrDsodflxBN/JnKqFRcvF3QHS3VlORXjrwXd9hTBmy5oO7KN1ASBJZuT+lTdW4y
	 4WTva6L7vJlpWCS7mHhD89LRZA4l/e3+qyn7GPwM2Sl9zLTQ2Rn2PtsxmjqiZFeD3Zg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790331138;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4sWh1h52uep6M0d3xNuUUre8IOOS0G6QVb1k83cOF4M=;
	b=BChlyXQaYSyq9RkY6vXXb3pmoMX6g75xP72nR5hrjC1nmoAFQe97N/5ZndPUEXm2C201
	 bUdiE30acRsj/HnvFL62f/kQsrU36g4MMtBA6Ux7S+CKm2uunvyforK14chBE1ltYa8dV
	 jnjmKGLBuasQF4feZ/9sSz9/jKObeYJDreXkwZH5B5h36MHjJ2anBCOuemzWYzokGI2Fm
	 nM/0CjR8leN74qkcd+7sc4TJJMyA+8yx7tD/K6s7O2/8AuAnAbKgp0EzcUffkTBmpfxkK
	 Ki3KOgizCSFjc8v8kbtAd//nn7M4boOFyGOaKaVzBYxnIcONkB6zv60X+VwL8Gb4fpg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790331138;
	bh=4sWh1h52uep6M0d3xNuUUre8IOOS0G6QVb1k83cOF4M=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WgRwPLyoS8vyWR14mhMLDC4zJZsKLQdoJiwLbrmfM07cAidgbwHNLs0AOkjOP1Hnb
	 nijS0VQp/Fn1s5edXX4dgPKf4m3w1f8dITMYbG4rpOBliwkRDoTzm4885hxSYmWLrS
	 L+YLhbIQ2QbCIBEQwgPQv/pXOoam64ZCLJvpi1x0erj693v4BuWX/4kTjJ4+Wk94Ld
	 /yWN5xWofBUWaZyhZ2m+hmx+lIvm4KnCxs+bcdKu+qpCMOBM+45d7qsuTBcboalgj4
	 QYFDgmJ4Tz3vqJMc4FoMEAxxaKzSxSUh9EddH2cmqI0GFYMUiHQleY2RmOmiP9rb4f
	 rYfo9fmUY+p5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B64840B27;
	Fri, 25 Sep 2026 10:12:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D1CB232F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 10:12:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B78B060BB5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 10:12:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JXsZrCJUdNaI for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 10:12:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A3FCA60B65
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790331136;
 b=lhso/ivnL1y0qAnWtR4uXYJdqh7uLIfLdxT6kg4hjsbPIlkgQWr4i+tA+RRnj2YHnTqK
 3K/TFNHAB+4jruuzSdOb5MBhjBf5uFhHzZKPrIoZWQmSMQcC/yIKa1QBtCYdAr30JhLPL
 a9B5G4zkboA7DJW/kkk94q3nLt2dAzTnR4MJ1n51/NarqAbBz10yXQsbcRvhlv56OGlDS
 U4tIvzgZUMXCdKk/mNstNC4eur5MjZmobR6ZgMQkWem7bTpZv2uJ1cHYvzKhKXEP14E5z
 6dqcifQDbcrU+1gLD9QHaP3lU8YNAmlyILx9FwFQTGH5LXLajnx62Xu6q7vbugyrgwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790331136;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=4sWh1h52uep6M0d3xNuUUre8IOOS0G6QVb1k83cOF4M=;
 b=IxdrewgrPRQbH0lEWmOObOApmT7Vohi3bSW02VXcEo6ivD5Bbf3bbKW7dWx0Zl/2bYF6
 uBM12PzO10m8WVXs6p0Q3VKSagZVy/B8FK4lXC7x4l4UVgkcBHKW29EWo9vLa9r8W3zs7
 EzXIGMMPzMXCuUxocGOdNyT7uIk8K+XFIzLQSSyHC8XvLt4bI33uKaprEOh6/xOE7mn3X
 UpPp4XICfUU3FJ/CjGTo2qa7oTMYsYBWdBXkaXLPdRQAWC8zFcj5LIDG4JbqBIjMyF0aW
 wQY2khb95gGZetqKf/yT8pJ/YopWHEdUTeqHWLb3Ir2u4pE2CY43DbYR77zo7NXniWw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=EsKEypSt; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=sashaneftin@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=EsKEypSt
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A3FCA60B65
 for <intel-wired-lan@osuosl.org>; Fri, 25 Sep 2026 10:12:15 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f63546c3so542991f8f.1
 for <intel-wired-lan@osuosl.org>; Fri, 25 Sep 2026 03:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790331133; x=1790935933; darn=osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4sWh1h52uep6M0d3xNuUUre8IOOS0G6QVb1k83cOF4M=;
 b=EsKEypStPDgjPME9la/vPn/UNOwJ46VIZVeXjHU53bkII6X4QSQ3MNaAKbN5W4y4Rp
 lI4vw99UG2qUj2I0G+YznBnt62JZWnyKumd1v2qOsqrL/HvstBe34JDbOQxurxJNrs3E
 El30Vl5KpUlwTtPoJgM6Xwy5PI+qYbb+kbxA+ULLWygp49eU5ExIq29vumiDwF5djPVD
 u+5Go9Ld/C9Pu8vkiKZO/YS+7lE0bumAyfMEkyl2ZGMko8CG/MPOfxg+TnmBJswZm/O5
 wTwjhaEOx9rtIufll1BdJvW7xVx1THVmh+a+OILvgXX1yW+KhRdVO1LOYjkw9pdDb2AG
 Yoqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790331133; x=1790935933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4sWh1h52uep6M0d3xNuUUre8IOOS0G6QVb1k83cOF4M=;
 b=HAtb+g4Q1k+l3mtZxWV9v6gAg30rIeGa2Bcj599qNZy/Xap2Mf8IHAwhsAHryfGrDe
 OcYAhYeIMIG/Assqd2zoKoK5ZcyV0TpANODUdlcfXc9A1tdg7bfLWrosudQmMKwj2JWn
 l9qGimlpGtRZHzofPxE95SjpJ7P5GYtivn/T4daTl0ROHDaEJ3I6f/l+m6IoeV9rrhF4
 yAG6yxRS8KOvTc6j/LNxEn5KalbG+rarw48+03aMSI5UR+RmEAuIR5VQ/l3dNG6eYzK3
 4zKNk8Xbq30UQn8VtOSERfpABqO4KGsuigyGB4+VGndyu/MBZKzVRSxAu70YyhOF4YSB
 q2aQ==
X-Gm-Message-State: AFuF++luImtBwK41Eflm75E5bFOiErAjwL3SQMzatsty9XI5kclbdio/
 8XDLnhOHDRJO6pc0Og91KRVF33kYpzMIbMtMRXewYm+Ir+R3AIDfL9HCD2fceQWe
X-Gm-Gg: AYBFou1qrSdy06+422D5s4DU1HVhSOgQzQg+6DcfaHpk1JAUkGQUWCpNqxW02j5zFo+
 u/Hhhe1DB3GdnXmk5TJ0PGJbxJ/7FgPq97/Fn1uD2/LxHEp4TfDn851Fsk1Yu7B0AnoglryFzKz
 NcYlz55LEwLWPQ5kSWNHVC9C4oHPXMxtEN2ByshqxjxLM1Tcl1G+ehZwbXakWkx/Rq32M3cIDpG
 dbiRp/4+HyvX7ztZnP+W/McU8MAAAAfMceMtWuJNqrzSZCR7RjvgrB6SVJfUhC1Al6hESvJfo9S
 h1i8SwRPgG0QfbVELaUmfWBBrH7fwp8a4llkpqjVqvg2SqZJb5MWdGbleK+aFcD+PFtTAfHCXiS
 p1g1reZUfFpK+6gkt/M3c2zTV3WJDni0ru6xicJRExwFjAcE6IJ7S2gc3E872H8HA+GwyELMd5S
 xAPGtiQxMPisHZNUNy9WZob6Dw6WLobxqO9+cvGTnIAD6p88Bw+ObAhDMShZnmC021flnYHbXo9
 myIO7T2cFSRN87JXeMf3vszrzuND383IDWWvgQeSXzeiOwXodN5Sk2+rpjTAA==
X-Received: by 2002:a05:6000:4012:b0:487:36a:c870 with SMTP id
 ffacd0b85a97d-48871714563mr8582420f8f.11.1790331132913; 
 Fri, 25 Sep 2026 03:12:12 -0700 (PDT)
Received: from sashaneftin-pc-GB-BSi5-1135G7.home ([185.175.35.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a744fb5sm5435436f8f.33.2026.09.25.03.12.10
 for <intel-wired-lan@osuosl.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 03:12:11 -0700 (PDT)
From: Sasha Neftin <sashaneftin@gmail.com>
To: intel-wired-lan@osuosl.org
Subject: [iwl-next, v1] igc: Group frame size macros in igc_tsn.h
Date: Fri, 25 Sep 2026 13:12:09 +0300
Message-ID: <20260925101209.34832-1-sashaneftin@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Move the IGC_EMPTY_FRAME_SIZE definition from igc_main.c to igc_tsn.h.
This consolidates frame-size definitions for TSN and frame context
descriptors into a single header alongside IGC_RX_MIN_FRAG_SIZE and
SMD_FRAME_SIZE, making the constants available across TSN modules.

Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 --
 drivers/net/ethernet/intel/igc/igc_tsn.h  | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 1fb5f3cbe93c..b0a4c2893ccb 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1137,8 +1137,6 @@ static void igc_init_tx_empty_descriptor(struct igc_ring *ring,
 		ring->next_to_use = 0;
 }
 
-#define IGC_EMPTY_FRAME_SIZE 60
-
 static void igc_tx_ctxtdesc(struct igc_ring *tx_ring,
 			    __le32 launch_time, bool first_flag,
 			    u32 vlan_macip_lens, u32 type_tucmd,
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.h b/drivers/net/ethernet/intel/igc/igc_tsn.h
index a95b893459d7..e08f48543d99 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.h
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
@@ -8,6 +8,7 @@
 
 #define IGC_RX_MIN_FRAG_SIZE		60
 #define SMD_FRAME_SIZE			60
+#define IGC_EMPTY_FRAME_SIZE		60
 
 enum igc_txd_popts_type {
 	SMD_V = 0x01,
-- 
2.43.0

