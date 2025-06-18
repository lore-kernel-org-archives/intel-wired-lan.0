Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEA1C7115B
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Jun 2025 07:08:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 910C0406B8;
	Wed, 18 Jun 2025 07:08:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L0LK3uyX_Les; Wed, 18 Jun 2025 07:08:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E21CE40665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1750230501;
	bh=AthrdE03eMT6iyFsW/vA3bdClID4lHYN+YmePk1prAg=;
	h=From:Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=n/nrDshwkb5lUSLedR6gjmL7iSVh9qwBiVaYro+kFvOeXSRuLCTjl/Mbl98bUELII
	 p3blEZq3NwKReiCySPkEWZJ2lgFcPprMllyHiZappeSGD6qjL2LyVpHMjIV2PSSwRP
	 uErlF2jhd1kjvbpNnFCIV/RfJPw1nrblkRoaSXmh3Mlsm2J51fDclGqSDQHbpaLh5e
	 Ir4wuhUsNbNCl5KRjQKk49ZkB5BSKD0F1T8ZSJgFLHGwV55s7hj4q1k5pSvjjR49fr
	 Y+cyvaT19QoOHUxqIlgrEhb8eBrzQnsXVtDLmtYCBZqtaCdXtKXGY6EjuJowq9C4Vc
	 +X8Tmca3yWG6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E21CE40665;
	Wed, 18 Jun 2025 07:08:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 79176D94
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Jun 2025 07:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 5F9AC40655
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Jun 2025 07:08:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id SQmi5DajRBvU for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Jun 2025 07:08:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=t-8ch@linutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8320240665
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8320240665
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 8320240665
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Jun 2025 07:08:19 +0000 (UTC)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Date: Wed, 18 Jun 2025 09:08:05 +0200
Message-Id: <20250618-restricted-pointers-net-v3-0-3b7a531e58bb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANVlUmgC/3XNTQ7CIBAF4Ks0rMUApT+68h7GBYHBTmKgASQ1T
 e8u4saYdPnyZr63kggBIZJzs5IAGSN6V0J7aIielLsDRVMyEUx0TDJJA8QUUCcwdPboEoRIHSS
 qRm2MYS10hpPyPQewuFT5Sj4HDpZEbqWZMCYfXnUy89p/db6vZ04Z5UJZpkH2ZenyQPdMwTtcj
 gaqm8WvNexbolgnqe0AdoRewb+1bdsbHhNJuxgBAAA=
X-Change-ID: 20250404-restricted-pointers-net-a8cddd03e5d1
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750230493; l=1640;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=HQUhUUMz1hwkIw0H+WnoEWZYfkvGVKwDKzojTFzI74U=;
 b=QlTPnkpsoB7IxMXFtb6EQuaKpoYFy/ecQsJwnFfe1wgZEQyKZKKJ6NznpDduSF+m9engtl6GI
 i8njRl6iDk7CynbKVDiatPcDnpR0+yna592iCmay7YDBYaG/O14khee
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1750230496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AthrdE03eMT6iyFsW/vA3bdClID4lHYN+YmePk1prAg=;
 b=I2EZxJXsMG2CTO7g5gZZf1qltdHNLqFjmsBKmGggS50/UZiRsCFPdz5DhOb9RGxWls8eHc
 bYP7KbbfUGQmtJ+Ee8tXBgYXe1lQVNuX15Uf2dX3uS+JM41tqXajUfALR7RqZvU689ESES
 sma/nVhg/68/CO3nsc42B36La6pHvxaHub9NC5pkh/nwRcUhvxnuZFRwECywBr0I2pCYb6
 Em7GDPpRqTjKla2tOiCnr1m3gzHky/MkqTz6qqck8DKGjyEffqZvt6pNnhzAIOYKM4MbKy
 icNyrZ3X8jBpzLnamNQ3388eI438j5sNT0JP7DL31r166XhFFWFTGy4iKB3x7Q==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1750230496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AthrdE03eMT6iyFsW/vA3bdClID4lHYN+YmePk1prAg=;
 b=BbgFDKDY3M2uyykrupOKp2zK1iwQwdxSS5saBGNgSDiVEZPEd+V2WAEzhndjPyjbxNOD1t
 ipt47VuIseiY7GDA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de
 header.a=rsa-sha256 header.s=2020 header.b=I2EZxJXs; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=BbgFDKDY
Subject: [Intel-wired-lan] [PATCH net-next v3 0/2] net: Don't use %pK
 through printk
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

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping locks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.
There are still a few users of %pK left, but these use it through seq_file,
for which its usage is safe.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v3:
- Fix typo in commit messages
- Link to v2: https://lore.kernel.org/r/20250417-restricted-pointers-net-v2-0-94cf7ef8e6ae@linutronix.de

Changes in v2:
- Drop wifi/ath patches, they are submitted on their own now
- Link to v1: https://lore.kernel.org/r/20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de

---
Thomas Weißschuh (2):
      ice: Don't use %pK through printk or tracepoints
      net/mlx5: Don't use %pK through printk or tracepoints

 drivers/net/ethernet/intel/ice/ice_main.c                      |  2 +-
 drivers/net/ethernet/intel/ice/ice_trace.h                     | 10 +++++-----
 .../ethernet/mellanox/mlx5/core/sf/dev/diag/dev_tracepoint.h   |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)
---
base-commit: 52da431bf03b5506203bca27fe14a97895c80faf
change-id: 20250404-restricted-pointers-net-a8cddd03e5d1

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

