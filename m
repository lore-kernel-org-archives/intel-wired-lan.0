Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71DED1951A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Jan 2026 21:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9BF5160E4C;
	Mon, 26 Jan 2026 21:56:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IA7CMTurVYWp; Mon, 26 Jan 2026 21:56:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D828D60DF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769464568;
	bh=ehmTA1o3oHWV2JS6XnM6t9zEYMHCZAFgQr8k6VR/OCY=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=Sri4W87Ht8u07LiVd7Wj2Aym+dfRZCoie6gcgALUa5yCl3aJNdkkTR0mzFhkRWWFH
	 j8nkeuUExR5Pz26JbSvLdl4o9nBJNgbNo917c+gTXSGJ10+7g5IwpIlFcmTzV0JCkx
	 dAunUrS6W+vCVr+nZ31PJJ2WstFATeJ4FydAQQenI2Hq3swqJSB4drtZmYUf+h8oJF
	 Cv/87DeC1oPU68xPW4D6KroQsS2sQfW6BxFJS6kZukLzZ90UWecIoQ254gwhZ9Cx19
	 SarSQRZv9v4pz9DJU7NIrj16xzcFBn/qqmEAm5OAbO+yDtLd7NyDjzDdl4mvkMYDPn
	 ZaxdUYjmMvjGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D828D60DF0;
	Mon, 26 Jan 2026 21:56:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5322E33C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Jan 2026 21:56:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 373B540A98
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Jan 2026 21:56:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ttfRfteh0XNl for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Jan 2026 21:56:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com;
 envelope-from=39oj3aqckd-soevnaiitbbtyr.pbzvagry-jverq-ynayvfgf.bfhbfy.bet@flex--brianvv.bounces.google.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0F86540AB6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F86540AB6
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F86540AB6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Jan 2026 21:56:04 +0000 (UTC)
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-2a773db3803so45027215ad.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Jan 2026 13:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769464564; x=1770069364;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ehmTA1o3oHWV2JS6XnM6t9zEYMHCZAFgQr8k6VR/OCY=;
 b=mDHsOpxlEs+3vrM6l0eX2E6ElcE/DRkY4dbqWIFqbmAkw3IgCntc6oxejt7Qae1bq9
 X0DOj9e4EvtyU06BXuo0BsYoenbO4bfdbCNKo92eGOk1SaqXAusacwJu2YxZ+Mwada7p
 KmMsR2X5fHSCl3JbS0FZRKLmWwEXlr4vuQTzoHHSkIEtwpIqpH+he2CYVglNAfDLfx/K
 nvRF6OvbG0yt/09qcrCmd6w3Cp6dUKMn//oHBBGt0c7lsHYzHo1TZSGMg4brCsh3QxM7
 suUSlFmpum36rmr4+4Mvc3iID6Hp7NMEYlYMIvdJ/Y9R9cNAmw+4njnHQW+fqGqUxGIr
 iW8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW72IlGG8bphAKltj+v2B8e7m347VOkouxlnBQK/Z0zYwwk2r8j2cEzEzSYRoyLnbSREikrHXmXgQHgDlbGDGs=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwLlmp3LuhxBvde0UDmj2KzCEyhDEo8TPgcHBwHu8+rX60maL9Q
 2Y7bW4G4804ISA4kyrASnBt7+AZrMk5liLH08y9rYEry8fabLMsMxkkfy6awu9+vsYgBu8oP2Za
 vCXAM1FHMDA==
X-Received: from plbbb9.prod.google.com ([2002:a17:902:bc89:b0:2a7:d253:e3bf])
 (user=brianvv job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2f4c:b0:2a1:3ee7:cc75
 with SMTP id d9443c01a7336-2a84525785bmr53056755ad.19.1769464564175; Mon, 26
 Jan 2026 13:56:04 -0800 (PST)
Date: Mon, 26 Jan 2026 21:55:59 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126215600.3387171-1-brianvv@google.com>
To: Brian Vazquez <brianvv.kernel@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org
Cc: David Decotigny <decot@google.com>, Li Li <boolli@google.com>, 
 Anjali Singhai <anjali.singhai@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 emil.s.tantilov@intel.com, Brian Vazquez <brianvv@google.com>, 
 Brett Creeley <brett.creeley@amd.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1769464564; x=1770069364; darn=lists.osuosl.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ehmTA1o3oHWV2JS6XnM6t9zEYMHCZAFgQr8k6VR/OCY=;
 b=O9SWWWGNHfX+B/8+QntB8FlpWN9cSoIAlOcjPCAQHBKa2O6XLVx7YAdc7lb3QAq+VC
 /7NO4XwtmOqG7qtVb0yVktIudqTU0JH9eLZp87CI5lhOiB7gWOLEKM+cGSG2sfrZwXzb
 /+2T75yv7E/ysWogmffo7HmTD39I5j7Juoirb3l4rS9KZx0ndgZb+WrGu8JJ6Hx/ERXG
 q0zx4e7oR3f849Dir3sx5wuvPnrL0farc+kkC/a051A1tBrQmCXN+vYU8Gy+5+nODV63
 1mSS3TO1Gv6XoIBbgUQfLZe2Cg2gGSZDq0BIPCALUmTHXa8n2bDpuUedEeJv8niiphmB
 vgXA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=google.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20230601 header.b=O9SWWWGN
Subject: [Intel-wired-lan] [iwl-net PATCH v3] idpf: change IRQ naming to
 match netdev and ethtool queue numbering
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
From: Brian Vazquez via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Brian Vazquez <brianvv@google.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The code uses the vidx for the IRQ name but that doesn't match ethtool
reporting nor netdev naming, this makes it hard to tune the device and
associate queues with IRQs. Sequentially requesting irqs starting from
'0' makes the output consistent.

This commit changes the interrupt numbering but preserves the name
format, maintaining ABI compatibility. Existing tools relying on the old
numbering are already non-functional, as they lack a useful correlation
to the interrupts.

Before:

ethtool -L eth1 tx 1 combined 3

grep . /proc/irq/*/*idpf*/../smp_affinity_list
/proc/irq/67/idpf-Mailbox-0/../smp_affinity_list:0-55,112-167
/proc/irq/68/idpf-eth1-TxRx-1/../smp_affinity_list:0
/proc/irq/70/idpf-eth1-TxRx-3/../smp_affinity_list:1
/proc/irq/71/idpf-eth1-TxRx-4/../smp_affinity_list:2
/proc/irq/72/idpf-eth1-Tx-5/../smp_affinity_list:3

ethtool -S eth1 | grep -v ': 0'
NIC statistics:
     tx_q-0_pkts: 1002
     tx_q-1_pkts: 2679
     tx_q-2_pkts: 1113
     tx_q-3_pkts: 1192 <----- tx_q-3 vs idpf-eth1-Tx-5
     rx_q-0_pkts: 1143
     rx_q-1_pkts: 3172
     rx_q-2_pkts: 1074

After:

ethtool -L eth1 tx 1 combined 3

grep . /proc/irq/*/*idpf*/../smp_affinity_list

/proc/irq/67/idpf-Mailbox-0/../smp_affinity_list:0-55,112-167
/proc/irq/68/idpf-eth1-TxRx-0/../smp_affinity_list:0
/proc/irq/70/idpf-eth1-TxRx-1/../smp_affinity_list:1
/proc/irq/71/idpf-eth1-TxRx-2/../smp_affinity_list:2
/proc/irq/72/idpf-eth1-Tx-3/../smp_affinity_list:3

ethtool -S eth1 | grep -v ': 0'
NIC statistics:
     tx_q-0_pkts: 118
     tx_q-1_pkts: 134
     tx_q-2_pkts: 228
     tx_q-3_pkts: 138 <--- tx_q-3 matches idpf-eth1-Tx-3
     rx_q-0_pkts: 111
     rx_q-1_pkts: 366
     rx_q-2_pkts: 120

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
Signed-off-by: Brian Vazquez <brianvv@google.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
V3: Add more context to the commit message
V2: Add mising Fixes tag

 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index c2a1fe3c79ec..c1f8dfc570ce 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4093,7 +4093,7 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport,
 			continue;
 
 		name = kasprintf(GFP_KERNEL, "%s-%s-%s-%d", drv_name, if_name,
-				 vec_name, vidx);
+				 vec_name, vector);
 
 		err = request_irq(irq_num, idpf_vport_intr_clean_queues, 0,
 				  name, q_vector);
-- 
2.52.0.457.g6b5491de43-goog

