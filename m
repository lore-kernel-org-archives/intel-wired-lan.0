Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB870C3DA4A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Aug 2024 15:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8480D40276;
	Wed, 14 Aug 2024 15:05:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ga5LlNUkDIJW; Wed, 14 Aug 2024 15:05:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 702CC40499
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1723647918;
	bh=lnvp97S/MR4yUiKbd5n8jwMTfUiZvb9HbFkBv7V13WM=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=l/rlI4GUx52LOWh18p3a7W2Bwko9nMH+nsTNkk8Af1RsyRSgvttdgH1E7pEuhW4x3
	 7kLqKudvbKAsK+C3n45J4nonL1D9TNjLzSnGj8IU6TRt5yPUO82+QO7VqJcvDxY7Gv
	 1SOgdAyV08MOofFdg1z4ylJ6aGrXskAZXdsuscjUh5HX04syDwz5AOt8l4Mmjfwcdd
	 /sx/sqLFNFK67WncQju7JCUx6NTAwTJtJCiRhESsAaiSrDwf8sfqqOcKo3v0FbcoIt
	 XoJDumi6xZVMBFSdvfgtgqIZ55pvpU59omavoNuIsMpGY5YexA6tAp+VwRlGVVDN9s
	 AAKBJnbjUqTdQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 702CC40499;
	Wed, 14 Aug 2024 15:05:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 6A79E1BF2FB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Aug 2024 04:56:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C017403A1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Aug 2024 04:56:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cZee155e0KeO for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Aug 2024 04:56:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::114a; helo=mail-yw1-x114a.google.com;
 envelope-from=35ti8zggkd4qliq4mqtqowwotm.kwuqv1mt-4qzml-tivtq010.w02w0t.wzo@flex--daiweili.bounces.google.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0BE394032E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0BE394032E
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0BE394032E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Aug 2024 04:56:07 +0000 (UTC)
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-690404fd230so131101947b3.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Aug 2024 21:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723611367; x=1724216167;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lnvp97S/MR4yUiKbd5n8jwMTfUiZvb9HbFkBv7V13WM=;
 b=vnm5d2ZkkWH1etpss7rJZKqoGkBoBNMixDIUdajGXVDdNKUawZWdMBRtvgcx52Lxnu
 tTY+Z4fx+oOZ1zGSquPwivR3M4g3ZuLMXz2oGpRTPHhG4T+igjXzxZbeWcNlbLJSlZdW
 kstf9A0iE9rCv6Zl/xm2CMo9zi+CWa5hYgyTmDxoGDNP5FZlgUPPRMZFnl8tXdY6GNhO
 wMxMTYCDnjoyeN/MrJ6WpMV3D6gkngavHTwvZgcN/dfAYYuS/oSjWLjCGXj89mxmbF7X
 k4hh0xJt7d77sX5yEPlh7ee5iU8PzMUGfuNFC5EVOPRGJGZBzCBHVmSzz1HNodPOYSHr
 SqJw==
X-Gm-Message-State: AOJu0YxcWMWqu9kU2nwjoQSuxfEAKxrOh7ZIvUaW/lA3b4Qg63QoxaJE
 8alHSPTcewYkPwrT3ipCCCNzgwir1bVAIvF29Kz5TAq/lkg5t+RUWZ2f790QlCRiHqUWqxsy+MK
 8fVpeNwqvsUba8/t2Fx1iMcZwxQzUGERCFHXbfuGZ5KouCpjfgkdkQty0nnsLbJhp3/UDlzqbyE
 LdYiZG4PDiVdht3IvlGVDexUib5GHckNIedmD0HIL1R2Qj4/E73weGkTI=
X-Google-Smtp-Source: AGHT+IG49Fx2xiRVWQlRuoz0zvxLK+LtnKos04NNqOiwZh05DlnfFBZtQGQFWYfG84ZKnZq//Q5fW+6FXooL0w==
X-Received: from ditto.mtv.corp.google.com
 ([2a00:79e0:2e0b:7:febd:a120:fb9c:be25])
 (user=daiweili job=sendgmr) by 2002:a25:d6d1:0:b0:e03:59e2:e82 with SMTP id
 3f1490d57ef6-e1155bca773mr2220276.10.1723611365685; Tue, 13 Aug 2024 21:56:05
 -0700 (PDT)
Date: Tue, 13 Aug 2024 21:55:53 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240814045553.947331-1-daiweili@google.com>
From: Daiwei Li <daiweili@google.com>
To: intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 14 Aug 2024 15:05:16 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723611367; x=1724216167; darn=lists.osuosl.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lnvp97S/MR4yUiKbd5n8jwMTfUiZvb9HbFkBv7V13WM=;
 b=c3dCDBUO6GeO1aGUzHujsD2dtWyG94b8K8+pd7vstjIBk3S093OuJU7k4EPEUwdLyJ
 fLnlyTDJORwKAKBjDs10l3Gjty/U6ywRMYpRY4q9CaW41YAjwBuqIAdTBXYZa4/mn0xM
 7WpuiuMs/PEic42uGwWunSH19L1c8yyDppZLoWXPCEhho8HpSdXj1515nVFyxEu8MBED
 FOfNzsDE7DrZU2Uzm3K8BHA+PZHhxUgN6tnAmUXNquCyjnjqhrS21sV6gmrS8bF53WaX
 qUUbIixZ3neOF3MSu0OItuabAcTODsLkDoXsJQw0Pl+8xLh6YoSMxFk/B72wnH7j+/FG
 axGg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=google.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20230601 header.b=c3dCDBUO
Subject: [Intel-wired-lan] [PATCH iwl-net v3] igb: Fix not clearing TimeSync
 interrupts for 82580
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
Cc: Daiwei Li <daiweili@google.com>, sasha.neftin@intel.com,
 vinicius.gomes@intel.com, netdev@vger.kernel.org, richardcochran@gmail.com,
 kurt@linutronix.de, linux-kernel@vger.kernel.org, edumazet@google.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

82580 NICs have a hardware bug that makes it
necessary to write into the TSICR (TimeSync Interrupt Cause) register
to clear it:
https://lore.kernel.org/all/CDCB8BE0.1EC2C%25matthew.vick@intel.com/

Add a conditional so only for 82580 we write into the TSICR register,
so we don't risk losing events for other models.

Without this change, when running ptp4l with an Intel 82580 card,
I get the following output:

> timed out while polling for tx timestamp increasing tx_timestamp_timeout or
> increasing kworker priority may correct this issue, but a driver bug likely
> causes it

This goes away with this change.

This (partially) reverts commit ee14cc9ea19b ("igb: Fix missing time sync events").

Fixes: ee14cc9ea19b ("igb: Fix missing time sync events")
Closes: https://lore.kernel.org/intel-wired-lan/CAN0jFd1kO0MMtOh8N2Ztxn6f7vvDKp2h507sMryobkBKe=xk=w@mail.gmail.com/
Tested-by: Daiwei Li <daiweili@google.com>
Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Daiwei Li <daiweili@google.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index ada42ba63549..69d7e8b16437 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6984,9 +6984,19 @@ static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
 static void igb_tsync_interrupt(struct igb_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
+	const u32 mask = (TSINTR_SYS_WRAP | E1000_TSICR_TXTS |
+			  TSINTR_TT0 | TSINTR_TT1 |
+			  TSINTR_AUTT0 | TSINTR_AUTT1);
 	u32 tsicr = rd32(E1000_TSICR);
 	struct ptp_clock_event event;
 
+	if (hw->mac.type == e1000_82580) {
+		/* 82580 has a hardware bug that requires an explicit
+		 * write to clear the TimeSync interrupt cause.
+		 */
+		wr32(E1000_TSICR, tsicr & mask);
+	}
+
 	if (tsicr & TSINTR_SYS_WRAP) {
 		event.type = PTP_CLOCK_PPS;
 		if (adapter->ptp_caps.pps)
-- 
2.46.0.76.ge559c4bf1a-goog

