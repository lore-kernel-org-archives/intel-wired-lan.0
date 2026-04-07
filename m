Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AFFFF510D
	for <intel-wired-lan@archiver.kernel.org>; Tue,  7 Apr 2026 16:15:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2881040690;
	Tue,  7 Apr 2026 16:15:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IXuGNvA6PAHT; Tue,  7 Apr 2026 16:15:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E6801407ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775578525;
	bh=r39jnrPI+M4FZyBd4fpGpsC+wdUlyMZWAwuwD/2KET8=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RijpzbRGZQjWEy2YuvhsE/Ihb3dBgLqKyhd/ongSgogS1jzlfAquAFt205vUme/jq
	 JRFDTRv8tBAXvZ83qIl/8H9hWFRZJnAUI5T0TvcQBdEdaqgCzotXGM9RxgbUB+Ae8Q
	 SU4UCWrUCGnHN+eqOqTk6Cs9iUnN5NcOYV3o8jHVOgUj/IX7TnZAmty23DZ6vnnKcG
	 +Xp2uuJibwixECWvwGejPgknftyLqCdb8tp2G/b5In3pXtXG60e/Mju+VohZMSkydy
	 gK3JPMvvF8+I/vpORzMnYWpUL9RfnpagP7n+a89IiNfzxXkXZBWR2AUZN/M96hDOd/
	 kUPFC4NE/YBTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6801407ED;
	Tue,  7 Apr 2026 16:15:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8583F1F6
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Apr 2026 16:15:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 770B74065B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Apr 2026 16:15:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NEA2G0bg2__6 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  7 Apr 2026 16:15:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1236; helo=mail-dl1-x1236.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C64144019E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C64144019E
Received: from mail-dl1-x1236.google.com (mail-dl1-x1236.google.com
 [IPv6:2607:f8b0:4864:20::1236])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C64144019E
 for <intel-wired-lan@osuosl.org>; Tue,  7 Apr 2026 16:15:24 +0000 (UTC)
Received: by mail-dl1-x1236.google.com with SMTP id
 a92af1059eb24-12c19d23b19so739736c88.0
 for <intel-wired-lan@osuosl.org>; Tue, 07 Apr 2026 09:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775578523; x=1776183323;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r39jnrPI+M4FZyBd4fpGpsC+wdUlyMZWAwuwD/2KET8=;
 b=LWBMUQARuUFCoBwok117w8OvaDfZXMhyO4MBdBI+89MPS/J9Z8IfxJCZqBWIvrI7bO
 czqtY+aMUA4baZfD4YAkZrWA7PZdcwdneIUA1gQVTP2LVOwdw5cbAP1ElamO/mhZsFFM
 wtVs+mVypqZ/le7f/rXHlGxGpjU0hYmfSxLpb/jQeVQj+FSn9UFyzVkVvyJXVRwpXzac
 RbdnPPRE3CyY91LBKZzsi/C1OIWqMvLcy1G70k89vTwfVRJhITiAORLkvxkubCkghOz4
 rxIaBrAbX492M3+lko6k76u0OLKnK7IUMAxIIe6okt77iO5adjYwZrZAQoKud4qTjaz9
 1hVw==
X-Gm-Message-State: AOJu0YyKpN49/MVpgIc9UMFNnbAWXRImdd+jnILjU5EyX9WLQ5ioB2cF
 DoV5iG4t5QNjEpDZZWftZI3789cLynz9pmdsw1nOFglE+2UTQrkqMmGhpSnHJpUkYTE=
X-Gm-Gg: AeBDietKG74i51sYUi7mk52beW/iitn7Kn99zFm0Mjw8dRUF5Z9AZqc0eR3YK82jtSP
 r/Oq1O/tpanGp9Lz/jYTdNaF3iVjd5rYDWBPxfxAlPO88TKt8adt/HyeYs6dp6BpgUSeDddSTWi
 PYjSC8WDC5slXJixWnR+a70FZFRchEyyeb8e01gmYbwfldUuHtARKcgSuL7eq9PSpoH47/ZPtni
 7BPhUXw86FZMnm1Z10akcf9HDZConpOFdx8YSA/sShSaPhzCeXzoZTFPvtn5VywUS5kaw08oLO6
 lLem3bdMqhqGAZ+FQs0H9I2so1LWGxEoeOhXXof8UTZNi3h2FFYBo8uSmMCYNwY0mTntmtiKkXv
 evjL010neLsHuM3k9wrOuLG2yuN6r5Ev6LlYauE+RiLfM7EFbVeiIsYr5VJsjaldyJN3fcUxxwt
 KZ0h8=
X-Received: by 2002:a05:7022:b98:b0:128:df80:1852 with SMTP id
 a92af1059eb24-12bfb6fe54fmr8400983c88.9.1775578522242; 
 Tue, 07 Apr 2026 09:15:22 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:62b::23])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bf90973b6sm16870658c88.9.2026.04.07.09.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 09:15:21 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@osuosl.org
Cc: Matt Vollrath <tactii@gmail.com>, Kohei Enju <kohei@enjuk.jp>,
 stable@vger.kernel.org
Date: Tue,  7 Apr 2026 12:14:47 -0400
Message-ID: <20260407161447.43645-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775578523; x=1776183323; darn=osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r39jnrPI+M4FZyBd4fpGpsC+wdUlyMZWAwuwD/2KET8=;
 b=qnM7PDL4w1fqUqKk5Dx1fd5gx9MkJn3wsWeLDxbJYucWWwK+Vc0sAU1XY8n9f7Ul2r
 bDL7OhGYszf1zDb1xBIq9uODnod6NKDXWxHSHZhfzL0d5afFLxRhFMfRJnR3skjCPd//
 1O63ZcgZbGRQcYf1v9yQ4WTeE2F0GPIhqJPDMnmycuIWc5R2JYuSDiaZtE8YJ/M1LK9u
 ttzNKQ/o6E3oy/7DKyx3EFyA+St78NFqHX0CNZFItF7aQAEVw/GdvK8cN3aVEVGmoTtx
 ytnAOiZqVGhTLVPnr16Ukqi71iYNvgHtuFg2J1nmu6OPtGNiC7tjK6/5weNfO6UnvQ5D
 ju1A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qnM7PDL4
Subject: [Intel-wired-lan] [PATCH iwl-net v2] i40e: Cleanup PTP pins on
 probe failure
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

PTP pin structs are allocated early in probe, but never cleaned up.

Fix this by calling i40e_ptp_free_pins in the error path.

To support this, i40e_ptp_free_pins is added to the header and
pin_config is correctly nullified after being freed.

This has been an issue since i40e_ptp_alloc_pins was introduced.

Fixes: 1050713026a08 ("i40e: add support for PTP external synchronization clock")
Reported-by: Kohei Enju <kohei@enjuk.jp>
Cc: stable@vger.kernel.org
Signed-off-by: Matt Vollrath <tactii@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index dcb50c2e1aa2..83e780919ac9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1318,6 +1318,7 @@ void i40e_ptp_restore_hw_time(struct i40e_pf *pf);
 void i40e_ptp_init(struct i40e_pf *pf);
 void i40e_ptp_stop(struct i40e_pf *pf);
 int i40e_ptp_alloc_pins(struct i40e_pf *pf);
+void i40e_ptp_free_pins(struct i40e_pf *pf);
 int i40e_update_adq_vsi_queues(struct i40e_vsi *vsi, int vsi_offset);
 int i40e_is_vsi_uplink_mode_veb(struct i40e_vsi *vsi);
 int i40e_get_partition_bw_setting(struct i40e_pf *pf);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 926d001b2150..c7062aa476dd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16112,6 +16112,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	i40e_clear_interrupt_scheme(pf);
 	kfree(pf->vsi);
 err_switch_setup:
+	i40e_ptp_free_pins(pf);
 	i40e_reset_interrupt_capability(pf);
 	timer_shutdown_sync(&pf->service_timer);
 err_mac_addr:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 404a716db8da..7d07c389bb23 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -940,12 +940,13 @@ int i40e_ptp_hwtstamp_get(struct net_device *netdev,
  *
  * Release memory allocated for PTP pins.
  **/
-static void i40e_ptp_free_pins(struct i40e_pf *pf)
+void i40e_ptp_free_pins(struct i40e_pf *pf)
 {
 	if (i40e_is_ptp_pin_dev(&pf->hw)) {
 		kfree(pf->ptp_pins);
 		kfree(pf->ptp_caps.pin_config);
 		pf->ptp_pins = NULL;
+		pf->ptp_caps.pin_config = NULL;
 	}
 }
 
-- 
2.43.0

v2:
* No need to guard kfree of NULL
* Followed Dawid's instructions re: target tree, Cc, changelog

