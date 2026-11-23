Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A27606A33B
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=a0TuamVC;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=cfSQ1o9c
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBF9880DC5;
	Mon, 23 Nov 2026 16:24:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ET92dBABaXlu; Mon, 23 Nov 2026 16:24:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EF3E180DCB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795451072;
	b=Q4lcTMNBHsaf86eIQkPqAjXMWbWlh6FqEM4G1Zfh3WbMOkOtUT5zXjhgMMGQA4qYGUDm
	 4ozUAoK52y9S2QqiP/6UR1CUSounRhuElFnetR2Xr4Z51zM0azEmkdQaI7UQI9jt9eGEn
	 gVHu7nJz3+C2HuifMGoy2vTBS89HEAM3snwvS5OV8oYDY1YWZviDc3PfTVpmyPVPNq6ph
	 5Kq5JgOW4TMop5hGUaOmuPXKHVOeU4FKWhOjyu3v+QV2JL6KWjbnBfTiOC8GcV4Hkun6P
	 xyt3pE91d43/rAvVuB8JNjd634GU96RoWgrynJCKGEj7HUD41zMCuwKmVW8Os07VBJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795451072;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Rspamd-Queue-Id:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NFDq/dfBCfoa/KiAjzRfVOpUv5cnY5UK5YhJ5mmMku0=;
	b=MBv9GP3BxGTMl4dsjflwEUAJgJbsu2UEDvN8P5mrxtbsjQeIc6kYbwpzyxLhEZPgWsCW
	 5yhZr0IXIY8gxvQ/wGuTRsKGHx1dA0BU93m//l+DMo6/3/3ctIn/cMbeeuKKxvBUC+GSP
	 30w7A5FVnZZElFxqbSequIm8Ed+Huw1ckjX6AH5eeQRAtlaoprXe2512O1yvPHKenzlig
	 ACHdG11SiGIOJonYbJbHePsSEw1L2z+pBxXSDRyPD72eRIU0qC4t78ULgKWi+dvmjABVG
	 t5In+ruxMRt+KZ6M4dBBMYlpprWQocVETqRvZ/4CwDGa97h9eXoiUEIV0uNzexp/ksg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=steffen.cc;
	dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=cfSQ1o9c;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795451072;
	bh=NFDq/dfBCfoa/KiAjzRfVOpUv5cnY5UK5YhJ5mmMku0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=a0TuamVCR2lyu5uobwF4uZmbpnPzVHeOngrp8AAIsTlFlFYMEx+0ss5s7pdbiV8WO
	 DTnz7i6FgZiewCX+L3djAxTbGqSXkko6xBXtBvkFXH9Q7hljyxTJZjxamG22B4ZSFX
	 kBgDN5fm4pTBZBVSGZcKCJbX7qeWOPIs7g+VmWcwX0KjgC7/bGZ8dB5t4pNIe88KQ8
	 Uf76hx0zlH7wyDD3fP+/1FONrAp2ukmayBpWHFL30pn/GG3U03vfoaAlgwlApGvDEU
	 hjwszAqUGyMpblndT+wngQMYTXNxP0A3rHUFKV7t1Ex+dR1xrKGxy9e4ycbcBA9d7N
	 GMDYUiTWCWV+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF3E180DCB;
	Mon, 23 Nov 2026 16:24:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 12B2022B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 10:04:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1034280D7B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 10:04:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eVI_qqUZHT6E for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 10:04:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1E5C880CE0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=lists@steffen.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=cfSQ1o9c
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E5C880CE0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 10:04:14 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jY1Xj4cVzzMks0;
 Mon, 23 Nov 2026 10:55:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1795427749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NFDq/dfBCfoa/KiAjzRfVOpUv5cnY5UK5YhJ5mmMku0=;
 b=cfSQ1o9cRMD08SVPSlNEhqcISoiYnXtkWfa9m9B545BBBgBcuKfKio8BqvYr8PzSk6kzcJ
 IsB3M5CJ27BrHBu0/oJ0oRS/tg2kIoZblS46Z7kv/oPWvvtG6lGM/0pns8OlBiTb5gphYD
 zmGLj8vOMbb4fOmpb9rgR1ddHMykypquBnxF1cXs1XsnJp+dg/VnGjn40WmykCL8fowGRV
 R3AF+fkgSvYDPsz1R6K1JuFXJa6woC/JqFpf1eDaX+nAlI9wX3qNsTJU4/jhg5Qd41zIUK
 QiKw7D/gy4BJEy/v4eWkk5sbU+1DCvpEOdQpXhZ/PYpDcB3a3pOmGktTAnmigQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Subject: [PATCH iwl-net 0/5] intel: fix a Tx hang at boot on I219 and Tx
 hang recovery
Date: Mon, 23 Nov 2026 10:55:14 +0100
Message-Id: <20261123-e1000e-tx-hang-v1-0-ecb4309942f1@beckhoff.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBQFr1Le2g8/ESJ6FXGh6at+kShJqoXSu
 5vqchhmZhRmY8Ghm5H5tmLP1MBtOsTbOV0p1jeGVx+cUy90qkqpk6xaenIfom7jbgho0StzsOk
 3PMI+D0msOP1FGS93xrrusCxfI3bFvHsAAAA=
X-Change-ID: 20261102-e1000e-tx-hang-dee96c03c7f6
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Ertman <david.m.ertman@intel.com>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Helge Deller <deller@kernel.org>, 
 Kurt Kanzenbach <kurt@linutronix.de>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795427747; l=2406;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=DMwtg/bvCNLG7STyovCaXcE1wSYyWoZi/jHKr4ndvW8=;
 b=9OXIEyff4Wml5k0fiH+RpSyL7CxYDRnii0TPmWDGg0Cd07OQ4VEDt+nZiAlRGUFCI96BWKIKw
 /BWghHkuN3/CYhng266ajQ77CqZRcRZeXyTd519f2LzT4q59dgcQzDb
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jY1Xj4cVzzMks0
X-Mailman-Approved-At: Mon, 23 Nov 2026 16:24:27 +0000
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We've been seeing some rare hangs of the I219-LM nics in some of our
boards after boot. We ran some longer investigation on many test devices
and found fixes for both the hang on boot and the recovery not working.

Patch 1 fixes I219 occasionally ignoring the global MAC reset.

Patch 2 fixes why such a hang, or any other e1000e Tx hang, never
recovers: since v6.12 every hang report refreshes trans_start, so
dev_watchdog() never calls ndo_tx_timeout.

Patches 3 to 5 make the same change in igb, igc and e1000, which stop
the queue on every hang report too. e1000 is affected like e1000e. igb
and igc currently recover in most cases, because their watchdog no
longer forces an interrupt every two seconds (a22ed15c99a0 and
8dcf2c212078, "Get rid of spurious interrupts"), but stable trees
without those commits never recover, and with them recovery still
depends on a stopped queue seeing no interrupt for 5 s.

Drivers that never recover from a Tx hang, per supported kernel:

  mainline, 6.18:  e1000e, e1000
  6.12:            e1000e, e1000, igb
  6.6, 6.1:        e1000e, e1000, igb, igc

The lost reset fixed by patch 1 is in all of them.

Patches 1 and 2 were tested on hardware with a kernel based on v7.2.13
and with net at 5e9b2ad9b838 (v7.4-rc2), both with PREEMPT_RT=y.
Patches 3 and 4 were tested on hardware with the same net kernel,
patch 5 only in QEMU.

I used an llm to both run the test series on our testracks and draft fix
commits.

---
Steffen Dirkwinkel (5):
      e1000e: retry a global reset the I219 didn't apply
      e1000e: let dev_watchdog reset the adapter after a Tx hang
      igb: let dev_watchdog reset the adapter after a Tx hang
      igc: let dev_watchdog reset the adapter after a Tx hang
      e1000: let dev_watchdog reset the adapter after a Tx hang

 drivers/net/ethernet/intel/e1000/e1000_main.c |  9 ++++++++-
 drivers/net/ethernet/intel/e1000e/ich8lan.c   | 27 +++++++++++++++++++++++----
 drivers/net/ethernet/intel/e1000e/netdev.c    |  8 ++++++--
 drivers/net/ethernet/intel/igb/igb_main.c     | 11 +++++++++--
 drivers/net/ethernet/intel/igc/igc_main.c     | 11 +++++++++--
 5 files changed, 55 insertions(+), 11 deletions(-)
---
base-commit: af6737b9066832a2017c281159950ba92385ce00
change-id: 20261102-e1000e-tx-hang-dee96c03c7f6

Best regards,
--  
Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

