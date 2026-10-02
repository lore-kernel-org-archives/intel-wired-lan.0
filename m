Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34683CA5FD4
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 09:35:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD8BA40C00;
	Fri,  2 Oct 2026 09:35:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DsddqFIIcsuy; Fri,  2 Oct 2026 09:35:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 36E3040C9C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790933738;
	b=sfC1mmnSpB6Z6yyMw5bsEXIv/UILQ43t+7mb0dDpUsdksJ5/xN+0TIJq8wBs0h4MbW7p
	 bxu3zZc4OVqRAWUuy5lx6PqNnwGAw/BNhKiUyDJS5wBW0gIOQkGnpFJoaTB/hX3Fz5Xmt
	 bX5Z9KN2tpJbQ35rg7edvW4RoF9o6uvUzEnaD3gdTGLHi7imm9sXNyMlLMh4NVaQyPUdR
	 EgfNr6nEu6Efr1xnCmFjRadJsrWD405+xMB35dkAcrCsGhyZEacDLsswizyvkFTdN9YYf
	 k0qLHNSa5qchlJHhUnRFYoq84AUM7sKVWfNrnkvATTPMhSnYBNRcRcv0PfQUrAyEDyQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790933738;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=I9C+MwkRKEgyp5dd33r0U1X4vGqsk0ZlI4nawwmJ14I=;
	b=lzJ09Fge9J+fTjF7De+xQMLGWY7a7gi6hbQTMNQTpkaYYrzewmmIi4oSFzcMr+kqIcuh
	 rb46dFawawRG5OwesyCOMebHG2tlE46Aol64aYJbPjgC7yrr51lRJBmYvWeHduMCwR8cw
	 +SfjIdvrOEuz2/ajYZMZD9WND7jYew73foTyH8vtd3GJeQxnuM6EMFvBhK/wrvEPr7fcK
	 vEt2jHr8NF5vzA73xxdob8K6FM/AL4tZYVsLVH178sZ3spaVYXJol0rWJhBjhLnrW5PYz
	 TxoEmlNFEWd0iNQqgQJ9PscCJCvOxjuCTKs6z8Y7Kergz9UK8hBRRdkUfCEQYMIHFvA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jnOknNtn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790933738;
	bh=I9C+MwkRKEgyp5dd33r0U1X4vGqsk0ZlI4nawwmJ14I=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=39+O4N1cGKohgA/ctEii/N9IBuLQFrE2rqDHV7GHQignq3Db+vrgsBAQth67RDpk4
	 eFifeuG+M7+Un6+Xr2LfC12j6UlDPsYBa/A9aMYO5W4ITZBdNvW/kjvDvyZzWEFXdy
	 QhXDDKI3u/t6UFb1oBml3Gea/V0eDZcTWQ75hGNB2Mzbyo7EEGzLsY8AD3wuPl8EXg
	 N6bcrILbIONYV08wru0EodbV0jmvlDJpXpn88V5uWnGE28cUQT3rWYJFPgQzlBKqNB
	 6oFmCHsgzKGIkxjUWuz92vBZmsHyLxzKywvNTj0z8qS0cDuD3cUiEeZs3iEhlQXyi+
	 xJo1gmVRfqYiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36E3040C9C;
	Fri,  2 Oct 2026 09:35:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 00ACB3AC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 09:35:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E678C40CA6
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 09:35:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zTRbPV7Wivpm for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 09:35:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 069DD40C00
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790933736;
 b=bwyZcc4VYMAphPSQFhOhhmWiANDpk17/ssc7fKgPMu8fBnaMzDV6haFPFQzGbSUt4AHN
 sMYEi+1TvYwdu3jxnSgFO601+p8KNv2Dgz7rA3BGURKklrTvHiTmT5ySZ+yL9lCZIH6+U
 7g7tsfhICRMTu8doIvHICJkqhx+CXKsovReBEISDtob2NKQI4nnXQpBXpdHpc7y7xQU2A
 2pESFCY9HssvTOmuhxyqD5dukGXQQWhGNKOws/WYP6yP9v6qAl5lTDs2m2ih4vrhwKA5l
 y0uLPWp67DVXmb5dApexFCtwyy4T3DQH5MOc1Jw7N3fBqkG2wOrpgGWSbQ1apMTQrcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790933736;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=I9C+MwkRKEgyp5dd33r0U1X4vGqsk0ZlI4nawwmJ14I=;
 b=DZnwZDN71lK70iPuAmpYz3n18lRccrK9wuXgP/bpjBNLmjptM+6hQJZdjO1mxcmWuniC
 ejhZeDXyZX9+bPtgRa1RpjBgaTbL+GUMwXmAqD5lOJ9H+LJNBrByAgDXU0GUQynloZwcQ
 OKb1uA37TtCfYOg88ze5q4WMBRCrguhY9qtAyCGYFKw0J4B+yMiFwxDaYY/hym7ZOIhFb
 NvUzPSoquG+s+/8tXhij0GOtLEoUiJPvHOsB+DxNVFxT1Sdd85DOovOnyd4PT/wLyCLe6
 Gk9Zl5wgj5+lGVRj4oxMwK8PMqcXbuN84s2vjykn74+hmBdMQBPht6L0xXLiCMohhow==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jnOknNtn; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=sashaneftin@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jnOknNtn
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 069DD40C00
 for <intel-wired-lan@osuosl.org>; Fri,  2 Oct 2026 09:35:35 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e6598dd44so46808455e9.1
 for <intel-wired-lan@osuosl.org>; Fri, 02 Oct 2026 02:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790933733; x=1791538533; darn=osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I9C+MwkRKEgyp5dd33r0U1X4vGqsk0ZlI4nawwmJ14I=;
 b=jnOknNtnIeJG0S+hP+bgQWD+jjsst+6UWz+f8ruaTlFvfDFOT6uXF0DNexAuxZtyAU
 fFn4Nu5wOkOSUio43Kk3Ivtk5jycvoBmzCYpfssAlWevaXNN7lY59ebW+JfN0TlAEyEL
 uSc8OV78HHIDiseRkemSvsMq/30qxBjZyjGh+Z2vXNw1jCdoOOTxNSn7Pks83sZBmVCK
 kTL5EfXigHlIUxNen0UfDKfjpEVnu7g21fcMT7nsvlGTGwcYxj+1BvTOID1fh0Zc1nyq
 XMnTm0dKx49uM6R3U1Z07zEW5ChGqkX5tLh7i0ke6TkmFAcQzPeLEY+O74GRx9B9T2Xs
 R5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790933733; x=1791538533;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I9C+MwkRKEgyp5dd33r0U1X4vGqsk0ZlI4nawwmJ14I=;
 b=qJ6gOMY4HlalxtCeFHvRCksMhj6kS+qBMnBLfjFpcRL2UDi0Hx/LtM9D6aFzI6P6BK
 8WIdufK98CePAvOKElJA9eAhe0Kp9EQPVJyos3bT2lpGo1t2u7dWxYd8h6f3i2SErs0p
 WUc3ieILcT1TJyScyryHIPEpCURZnP/k90IcPmGmVYOEgw2OPYf5sD5b9QG/6Kz2OLmB
 OsFJw4j82KP+pik8zu7QTnp+LvKo5qdwHfRVdfI30Yr+Rc+JDKfrbDRl9cLNCoTW4s5S
 /aprKkC9QK/FVhNrh9qpXsvzPtuQhNgWme5k5wrrDe+ygaqanGCjoSX6JGoUdWvlcfhn
 xotA==
X-Gm-Message-State: AFuF++kHuCxbliQ6PKqhNhcIpHJ/UlEudZIRTRLfudZNFHqX/meSwfny
 rTGDizS3qfuFayoq4xM80ilOIZPPtGCNeuflKseISdfoHZTzAF5g+KG+F9FgSIr+
X-Gm-Gg: AYBFou2hxUdDTgf7/7H+0/noiAj1M/grB092mmtcKUWIBthRHcCXilUNlYgURL4znDS
 y6ysk2R95BIm2ty2ySERgQH4M7Gix/xtTnfrX8gjb/Jzrhm5hl/vy4vvViR2XaxEZWoeixHu9US
 IFYuzuw5Y0CdQRYYYprCPxRTdjphhjm6TqH8PT8UYkiEpiOLP8+eWSvuMaYu6HPGuPaP6SoGAJ0
 yB5H9Entfc6LjVhZ6JOtPBnYmQ3XqCNs1EOtIbVCIEUU2z42iqUYINazj1Qh5y8mzn/JfMIx4PH
 lxMjYweSG8jLxQAtfaWO5ZYqUTws+nWj604XGTTejY3YlQWk/E4Cv+CEycROLDMSIS/c63cJLQ2
 JchXpC9eQH+vGJ0fjtGUlT3TlsbGSGfOTAbofsuJemNiSxyZD3nnORAr0m+jS2URWjORYYm30iG
 kfW0zsiPDd5CpksU+6Na2qNDpTSWKL/4bNqdyyVtNnt8/saKwrGJjlVMzUWtNO+TC2RC9SWge99
 /NCDM70mSf4PH3+UIe1sKb6nafjTa4W9ZO6SyASr5L58O9PlkqDxqTVdzoPYiI=
X-Received: by 2002:a05:600c:c084:b0:4a0:2835:6fd3 with SMTP id
 5b1f17b1804b1-4a028357000mr25668325e9.17.1790933733001; 
 Fri, 02 Oct 2026 02:35:33 -0700 (PDT)
Received: from sashaneftin-pc-GB-BSi5-1135G7.home ([185.175.35.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380fada5sm4134284f8f.24.2026.10.02.02.35.31
 for <intel-wired-lan@osuosl.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 02:35:32 -0700 (PDT)
From: Sasha Neftin <sashaneftin@gmail.com>
To: intel-wired-lan@osuosl.org
Subject: [iwl-next, v1] igb: Fix typo in IGB_NO_QUEUE macro definition
Date: Fri,  2 Oct 2026 12:35:30 +0300
Message-ID: <20261002093530.150023-1-sashaneftin@gmail.com>
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

Correct the macro name from IGB_N0_QUEUE (using digit '0') to
IGB_NO_QUEUE (using letter 'O') in igb_main.c and update its usage in
igb_main.c.

The typo in the igc driver was likely copied from this original typo in the
igb driver, which has now been fixed previously in igc.

Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d4a897a8c82c..73a08ab27221 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -754,13 +754,13 @@ static void igb_write_ivar(struct e1000_hw *hw, int msix_vector,
 	array_wr32(E1000_IVAR0, index, ivar);
 }
 
-#define IGB_N0_QUEUE -1
+#define IGB_NO_QUEUE -1
 static void igb_assign_vector(struct igb_q_vector *q_vector, int msix_vector)
 {
 	struct igb_adapter *adapter = q_vector->adapter;
 	struct e1000_hw *hw = &adapter->hw;
-	int rx_queue = IGB_N0_QUEUE;
-	int tx_queue = IGB_N0_QUEUE;
+	int rx_queue = IGB_NO_QUEUE;
+	int tx_queue = IGB_NO_QUEUE;
 	u32 msixbm = 0;
 
 	if (q_vector->rx.ring)
@@ -775,9 +775,9 @@ static void igb_assign_vector(struct igb_q_vector *q_vector, int msix_vector)
 		 * or more queues to a vector, we write the appropriate bits
 		 * into the MSIXBM register for that vector.
 		 */
-		if (rx_queue > IGB_N0_QUEUE)
+		if (rx_queue > IGB_NO_QUEUE)
 			msixbm = E1000_EICR_RX_QUEUE0 << rx_queue;
-		if (tx_queue > IGB_N0_QUEUE)
+		if (tx_queue > IGB_NO_QUEUE)
 			msixbm |= E1000_EICR_TX_QUEUE0 << tx_queue;
 		if (!(adapter->flags & IGB_FLAG_HAS_MSIX) && msix_vector == 0)
 			msixbm |= E1000_EIMS_OTHER;
@@ -790,11 +790,11 @@ static void igb_assign_vector(struct igb_q_vector *q_vector, int msix_vector)
 		 * lower 3 bits as the row index, and the 4th bit as the
 		 * column offset.
 		 */
-		if (rx_queue > IGB_N0_QUEUE)
+		if (rx_queue > IGB_NO_QUEUE)
 			igb_write_ivar(hw, msix_vector,
 				       rx_queue & 0x7,
 				       (rx_queue & 0x8) << 1);
-		if (tx_queue > IGB_N0_QUEUE)
+		if (tx_queue > IGB_NO_QUEUE)
 			igb_write_ivar(hw, msix_vector,
 				       tx_queue & 0x7,
 				       ((tx_queue & 0x8) << 1) + 8);
@@ -811,11 +811,11 @@ static void igb_assign_vector(struct igb_q_vector *q_vector, int msix_vector)
 		 * bit 0 as the column offset, and the remaining bits as the
 		 * row index.
 		 */
-		if (rx_queue > IGB_N0_QUEUE)
+		if (rx_queue > IGB_NO_QUEUE)
 			igb_write_ivar(hw, msix_vector,
 				       rx_queue >> 1,
 				       (rx_queue & 0x1) << 4);
-		if (tx_queue > IGB_N0_QUEUE)
+		if (tx_queue > IGB_NO_QUEUE)
 			igb_write_ivar(hw, msix_vector,
 				       tx_queue >> 1,
 				       ((tx_queue & 0x1) << 4) + 8);
-- 
2.43.0

