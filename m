Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5651EC7EE23
	for <intel-wired-lan@archiver.kernel.org>; Thu,  1 Jun 2023 15:07:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DFAEE84267;
	Thu,  1 Jun 2023 15:07:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DFAEE84267
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1685632055;
	bh=vV7gPXKA+xvYehMdZK4ddchw0BgmINqkVGG7Obo278A=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=YJM8s+Msu5BuNM2WfsfcyInxRDLcK0CFjvH8mM60fxjj0mVJ+XssWF7j6zwga+9iN
	 4JISdlHW4cGuyBPlC5gcwnm6S16isYlaoMpNcwM5zNuiiw0Q4LA/IdzgAit1gyVC7T
	 rkKoYjjCV61TIcQMHRGssOujbQ6ERo6lGhlTSTiyi+yVXIUNp3b7JSAolpAN68W2V/
	 Bf7hpB7sJrOfu4Ez0CoeCRSTkfEgM6Bjz2XkwWlGPLpF8BPpXsp/0vTHDsTsXZxWZo
	 eYzq6/xQCKP8mobLzN1zEnI35lk1dM9//9jDcrmlNwYUM+qv/FaApwcDKLB0B+ROQk
	 lSvnfsX5Vt/Hg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dEXlv-4WZPnx; Thu,  1 Jun 2023 15:07:35 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id E298A84271;
	Thu,  1 Jun 2023 15:07:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E298A84271
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 0693A1BF82F
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Jun 2023 07:01:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD1CB42082
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Jun 2023 07:01:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DD1CB42082
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id olmI9fJp3Xxl for <intel-wired-lan@lists.osuosl.org>;
 Thu,  1 Jun 2023 07:01:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E02C142081
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E02C142081
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Jun 2023 07:01:05 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5552cbcda35so421043eaf.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 01 Jun 2023 00:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685602865; x=1688194865;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ufZlzhRbgrp2ECAGGL+klhy80faTIJsC40pw0AO7I/s=;
 b=J8Koof4vo2Jg6E4912JU74Bp5EjXIHRxPvrjkz+RlhQbEBuzfGOoeL5c6OvyKz33ek
 tJYoyq4utFyv8qkLLh28P5gGf6EF3CAPBkrbW9raUgGrDrjMS0wmeDRspZpJ89rwC4cQ
 AbhwN7Mv9z0E1ho20D0ZMQ7/7Im5Uk+SI8BpBo0jYGhVzMDxz1aeXOciuOV7dR0a6yK7
 tyjRTJrJRFbWsNopvrnaF64egaBI7CmwBBk7OKu+kJFGZg9Z6/TgXhMV5FO4HEjXYaOL
 yQWTDEWM7XejbJOLwoGXyA6LqWrMDFO8CfY26LcjF49BHsh790MOWuInRKl9BxVWtKVT
 Ujog==
X-Gm-Message-State: AC+VfDyEFMMhp+CIPob7154e2htaEhmiivykPrQYCfxvlepEdDiH5Khs
 a76ANyT0q7cGhGtgN9tHLv8=
X-Google-Smtp-Source: ACHHUZ4baPIwOegGnCejHi+mh7aZuQhlsdJwMQ6jefUHQyPArJwNd9ujW+n/AO/1O63Z2BURJHViDw==
X-Received: by 2002:a05:6358:419b:b0:123:30e2:4cfd with SMTP id
 w27-20020a056358419b00b0012330e24cfdmr5972236rwc.18.1685602864726; 
 Thu, 01 Jun 2023 00:01:04 -0700 (PDT)
Received: from dnptp-9.. ([111.198.57.33]) by smtp.gmail.com with ESMTPSA id
 s34-20020a17090a2f2500b0024df6bbf5d8sm712591pjd.30.2023.06.01.00.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 00:01:04 -0700 (PDT)
From: Yuezhen Luan <eggcar.luan@gmail.com>
To: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Thu,  1 Jun 2023 07:00:58 +0000
Message-Id: <20230601070058.2117-1-eggcar.luan@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 01 Jun 2023 15:07:21 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685602865; x=1688194865;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ufZlzhRbgrp2ECAGGL+klhy80faTIJsC40pw0AO7I/s=;
 b=YStVcwYM9hqQJgsRY155+ZbILLF0giQbOMCgHsvoLaIGmWRAYdASz8Wl56wm6r/H9q
 Jsj/WQiM1qH3TcQ32k8TkLSRqu/EPfPGo69MgOAqjwLEXFfu9kiPbjjoRrxO6AM5mP/b
 JRf3yrWLDEBmxdGQG85LcPICjjP592buGPWHAt6cYZtHlRkFsfex1eom5FrDjhAOQKYZ
 EiuhRLFexR1Tbbp9cvG7u2nCbY3HnzemsEadP/UNabsQqAlGqIVv4srG1ooiPdN1S/2x
 366sRBsmGhW/5Fkk13AJ8/X7XQnI/f0qU9j7TqZqRd8XsM09FdYYpgVBntPNvZ/Pcb1/
 cmKA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20221208 header.b=YStVcwYM
Subject: [Intel-wired-lan] [PATCH v2] igb: Fix extts capture value format
 for 82580/i354/i350
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, Yuezhen Luan <eggcar.luan@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

82580/i354/i350 features circle-counter-like timestamp registers
that are different with newer i210. The EXTTS capture value in
AUXTSMPx should be converted from raw circle counter value to
timestamp value in resolution of 1 nanosec by the driver.

This issue can be reproduced on i350 nics, connecting an 1PPS
signal to a SDP pin, and run 'ts2phc' command to read external
1PPS timestamp value. On i210 this works fine, but on i350 the
extts is not correctly converted.

The i350/i354/82580's SYSTIM and other timestamp registers are
40bit counters, presenting time range of 2^40 ns, that means these
registers overflows every about 1099s. This causes all these regs
can't be used directly in contrast to the newer i210/i211s.

The igb driver needs to convert these raw register values to
valid time stamp format by using kernel timecounter apis for i350s
families. Here the igb_extts() just forgot to do the convert.

Signed-off-by: Yuezhen Luan <eggcar.luan@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 58872a4c2..bb3db387d 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6947,6 +6947,7 @@ static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
 	struct e1000_hw *hw = &adapter->hw;
 	struct ptp_clock_event event;
 	struct timespec64 ts;
+	unsigned long flags;
 
 	if (pin < 0 || pin >= IGB_N_SDP)
 		return;
@@ -6954,9 +6955,12 @@ static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
 	if (hw->mac.type == e1000_82580 ||
 	    hw->mac.type == e1000_i354 ||
 	    hw->mac.type == e1000_i350) {
-		s64 ns = rd32(auxstmpl);
+		u64 ns = rd32(auxstmpl);
 
-		ns += ((s64)(rd32(auxstmph) & 0xFF)) << 32;
+		ns += ((u64)(rd32(auxstmph) & 0xFF)) << 32;
+		spin_lock_irqsave(&adapter->tmreg_lock, flags);
+		ns = timecounter_cyc2time(&adapter->tc, ns);
+		spin_unlock_irqrestore(&adapter->tmreg_lock, flags);
 		ts = ns_to_timespec64(ns);
 	} else {
 		ts.tv_nsec = rd32(auxstmpl);
-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
