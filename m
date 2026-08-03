Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD75C55182
	for <intel-wired-lan@archiver.kernel.org>; Mon,  3 Aug 2026 15:36:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EF926060A;
	Mon,  3 Aug 2026 15:36:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MV1oMzwqlQ2v; Mon,  3 Aug 2026 15:36:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BA37A6060D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785771370;
	bh=1wA9zD8wavSvGOW0aSs81qe/j2d+7UbxR14kkq6ItL8=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=HZlpX0OeqMkXzj7bbWGeRMc/bvryOgQe84eAERaW4VdOnyeJiajWutGYhFaj6fEwZ
	 7RyOFpP1jZU7RIti10lpoKHdGNGAqgFyEO6cPN2ZVuJyDR/o1JocdNMgpmFNzU/vYp
	 abKkIF6zZN27NUHy/946vAkdErtwrHVFsV3PE3IPmSgmMAOUy4nzIWfufHrwO7awip
	 Nu7sQin2wtO9K2DtLDHHLmNNVHRz+mWfHR7GY4M+impuuTQdZuOI20vRtzq7un2z9F
	 TNiKJOgHLqMtY9BgpV5X3R6tRj/OYErVdkHx+JO+wFypCf21qA9SFrMqFsaWwcc32k
	 KuakwdASu2lAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA37A6060D;
	Mon,  3 Aug 2026 15:36:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DB99F218
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 15:29:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD6344056C
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 15:29:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5BvE-rqsAWHX for <intel-wired-lan@lists.osuosl.org>;
 Mon,  3 Aug 2026 15:29:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=bryan.fraschetti@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7040E40567
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7040E40567
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7040E40567
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 15:29:38 +0000 (UTC)
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 780463F98A
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 15:29:35 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5276aa86d00so36480801cf.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 03 Aug 2026 08:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785770974; x=1786375774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1wA9zD8wavSvGOW0aSs81qe/j2d+7UbxR14kkq6ItL8=;
 b=gjqLZQ4xADhbOYhLOssqZatEsQhtFAYTBm/KYes7E+N43bC4Y+f0CaBjbhdDx7XMcp
 vqF//BaRE4M0jwEuRrevJ9FhSOz3ko04ASoPKrDNi/fChSnwAg+y408ojLnWNBg6cfD+
 eBdqvL0lpd+JhkWAZIVjmCG+6Jj54atfWV/4KgnZaJpOUo2c2Wki7zFOhd/sbIFkZwST
 wssbcHStSws5t1ghXdznwuqISa13+EzNn/xtJjbQsjJ352wE+xgwf1vQbOEIpno7eYGU
 nBbMAxXX+j9eVhn9nVkO3qZ45vKjIMpWLXt1LMa5eMxGZq67X9sJW4lJGlGLtwAIkA9K
 WNtw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp5k9B2UQs3MpGgSyPqmv7Hl3N1jv1aTyYVKk2zeLdjpRAZypt3DbgUNjJo86cHE23bKuh4Q4p0OqZ3blST6IU=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yx5XbCpkui4h6BPx1qOpXo/h37L+PAR5ucFZF+KR3/7N/Fv1udE
 Dlq6QRDjQvZ4og+Auprj1XsyunluuVKJFJgaGZxU07cyxGEZVP2WO56FS30DAnNaDtxd+XO2WjB
 sgYizWn+Rza9uUzE9I8LQFSQynoearSwCZdkd61L4m93sLhYRuGWSm0RbferdNcXPuaYeeX8JXg
 se25EdEsnd8m0=
X-Gm-Gg: AR+sD11FqMHEF4axtV9oW1QS+m+mBHOnMGFcvDXroIylDuhvg+vWw16+ZSjLHIhUeu0
 LQl8d4xUf+miTQxUXoth2VM0F/mU3RT/C7HR3s6MUXDo+LDebg7TIIF+/JjBs3WLYNDc4vIkqe8
 dj0N9BxJ5d41Mpy4XrFtu+4QrERgw5RdXb50pQpgAxecVcKPsHPu+tXBZNxEoT79ObfugA4Wp50
 byvyeLCvx6iAXI4dgKY+2e3XhrKr2nLTtm4sS+vhsyHTmjl/rqvCb6UNQ/J3/CA3lQU3QRIdwyT
 zA/6QGIOCQLU3lTTWr5XcqGKc/7a9FDLmPMEScfysrSGxOX+d/+nXb/WWtpaJQKE0aBO5l59l2F
 j7KbRyZMp
X-Received: by 2002:ac8:5941:0:b0:516:d812:c35e with SMTP id
 d75a77b69052e-52b56752f32mr189669121cf.21.1785770974153; 
 Mon, 03 Aug 2026 08:29:34 -0700 (PDT)
X-Received: by 2002:ac8:5941:0:b0:516:d812:c35e with SMTP id
 d75a77b69052e-52b56752f32mr189668341cf.21.1785770973581; 
 Mon, 03 Aug 2026 08:29:33 -0700 (PDT)
Received: from atlas ([142.112.164.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52b4e7ee283sm63597211cf.6.2026.08.03.08.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:29:33 -0700 (PDT)
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alice Michael <alice.michael@intel.com>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: Bryan Fraschetti <bryan.fraschetti@canonical.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon,  3 Aug 2026 11:28:52 -0400
Message-ID: <20260803152854.305298-1-bryan.fraschetti@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 03 Aug 2026 15:36:09 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785770975;
 bh=1wA9zD8wavSvGOW0aSs81qe/j2d+7UbxR14kkq6ItL8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ZGd5peLdWm0e9u16tXHtV8FtoeAAYqEvWzGCQ9ghITeJ777HLBTb7/j4KJqkiNZND
 zAiqad6FVW5ERulAFxx59/F72nMp5MC6oKRmuUD+Qc+5AdDm8m9lz1ZyOJuvn011uv
 +JabZH9qi38Y5DdgK4xWrbamSipv8vNLuADrzL6BERnTZOT0pGiYHAy31wgo20LYHm
 AxaEjlaA1chHP2z4kU7d9pErJCEC9XSMfATB3G0l/KnhjcB7r7sXJcyYkWG9eYBEFH
 xZnd5LnV/fNPBw6Yny9bcvlcVlVmZKs5wQvrEr/+YR+PCAG6P4ciH0JlKoo45Mv9uQ
 K5vSUcndaz3yU8Ewoe75G+9cm4bKcaU1eq/WCqWLZGkyMnOGJ7Uw+6lcEUClYOE3o+
 3Z/k3oj/iC7tnOceilYRQucmt8wwzAIhlTkvRyMbA3D3CZMTfjzBwMX6R5Ww9qhFix
 NiIchs7pKGIbGZ/BSa1OuQcrvgg4fen5v6OKQERr55WkXjA7vcLIyCpvTDjzT3s97y
 RbZnGTNqF1imWbSc+DX5Knjf6IDvhN7V9SbdQPd+bXbafvJJH6gqyol5Zs8hdGVquI
 WL/hqJrSd66WqyrVDJCSMgtZ5TaD39iSnEzHwnkiNjuOADWd4uzMDHBhAiekFGMXi+
 FVTnzINLqqKiSagrd1hk3BKk=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=ZGd5peLd
Subject: [Intel-wired-lan] [PATCH iwl] ice: Restore Ordered MMIO Writes for
 Tx Doorbells
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
From: Bryan Fraschetti via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Bryan Fraschetti <bryan.fraschetti@canonical.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The DQL accounting state which tracks the number of bytes queued for the
NIC to transmit, namely dql->num_queued, is updated by the ICE driver
when it invokes __netdev_tx_sent_queue(). Subsequently the driver
updates the hardware queue tail allowing the NIC to begin processing the
work queue. The queue accounting update should be ordered before the NIC
begins transmitting descriptors.

The transmit path currently updates the hardware doorbell using
writel_relaxed(), which (on arm64) does not provide the same ordering
guarantees between writes to normal memory and writes to MMIO registers
that writel() does. This introduces a potential race where the NIC
begins transmitting descriptors before the dql->num_queued update is
globally visible. If the NIC finishes before the update is observed by
dql_completed(), it detects an invalid state where more bytes have been
completed than have been queued. When this happens the following BUG_ON
is triggered.

  BUG_ON(count > num_queued - dql->num_completed);

This has been observed and manifests as the following crash (note that
the trace has been trimmed) in an environment with sustained network
load that uses an Intel Corporation Ethernet Controller E810-XXV for SFP
(rev 02) on an arm64 machine. Replacing writel_relaxed() with writel()
in a test kernel eliminated the crash in the user's workload, which
previously reproduced the issue reliably.

  kernel BUG at lib/dynamic_queue_limits.c:99

Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
pc : dql_completed+0x268/0x2a0
lr : ice_clean_tx_irq+0x1d4/0x620 [ice]
Call trace:
dql_completed+0x268/0x2a0 (P)
ice_napi_poll+0x94/0x520 [ice]
__napi_poll+0x48/0x3f0
net_rx_action+0x194/0x420

This restores the behaviour prior to commit ccde82e90946 ("ice: add E830
Earliest TxTime First Offload support"), which changed the notification
mechanism from writel() to writel_relaxed().

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2161572
Fixes: ccde82e90946 ("ice: add E830 Earliest TxTime First Offload support")
Signed-off-by: Bryan Fraschetti <bryan.fraschetti@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index c04c5856dad6..4e26ace793ec 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1561,10 +1561,10 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
 			}
 		}
 		tstamp_ring->next_to_use = j;
-		writel_relaxed(j, tstamp_ring->tail);
+		writel(j, tstamp_ring->tail);
 	} else {
 ring_kick:
-		writel_relaxed(i, tx_ring->tail);
+		writel(i, tx_ring->tail);
 	}
 	return;
 
-- 
2.53.0

