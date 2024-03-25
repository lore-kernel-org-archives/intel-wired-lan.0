Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E4BCD11BF
	for <intel-wired-lan@archiver.kernel.org>; Mon, 25 Mar 2024 22:30:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1CC2608E7;
	Mon, 25 Mar 2024 22:30:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uwbEu5bgaE32; Mon, 25 Mar 2024 22:30:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 355A9608DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1711405809;
	bh=tAQlwVWYFz0DCGZt++IXnhgr4sduoZGI7/seZp7kiBg=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=8frtD7dKIsmR7Lsrg953PA15Jf2pGPb6r2S19+KNCv4gd7mIU0LTUQbiBp3anJtME
	 lyDCEztkhxh2tH+ZhCqS6vaWDJ+bmdsoc0GlKPjP5nyiUiYcZWbZ5keSfoo9b/8ezZ
	 1QBWyQ1PGA2xEPhH2DujqR8f2YJ5sX5RY8JWFasS0utN6hfR98u3adZbZIUDZXE27a
	 SqwVcNnqZx+Ngdsj9WzYLmJCZa3mFfRdPSceQWehxUhaw2fzHR1vJuGsR7UmBU5jdm
	 gSqrf+gcEAgQgIaLNB0ypC0Qjgr7qHs7QmoGTS0DD5e0kAB59hpKKk5fMUalf4K976
	 S163vQ3wrACvA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 355A9608DE;
	Mon, 25 Mar 2024 22:30:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id A76041BF2A9
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 Mar 2024 22:30:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A0203608CE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 Mar 2024 22:30:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p8Gv8SKiMhuB for <intel-wired-lan@lists.osuosl.org>;
 Mon, 25 Mar 2024 22:30:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 601E46082F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 601E46082F
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 601E46082F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 Mar 2024 22:30:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id B3465CE1D50;
 Mon, 25 Mar 2024 22:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34CEC433F1;
 Mon, 25 Mar 2024 22:29:58 +0000 (UTC)
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Date: Mon, 25 Mar 2024 17:29:48 -0500
Message-Id: <20240325222951.1460656-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1711405799;
 bh=s6f0H6C9JKUP0UFu/98JgZPoNS9zucvQkAEttBGZoDY=;
 h=From:To:Cc:Subject:Date:From;
 b=atuGH1dkaJFc6beHU9/dXrtXnZVohJuLwacVykwe7JIcmAVH5e3J1KxmkEAbeugkF
 DgKyPy0nETCy+CO7aO3A0AJYTPlWC3KigEur69U9yJeAL+t+vFhmxLHGhpCwj6WVdG
 q//063yDQXIo1H1a/2ysO1wueZ5PFmVDV3eRSraUD4ixrraJ21iKzmL5chHT2dOVTB
 3v/JzlB5MHuurUelrCGzwIZ/ZkMIqHgwxqyh6Yg0LmZ7bn3p+uTSk92LBsrcCZouDn
 mlWOMaM3I0kyyM/qX2Bj68xJQfkAET8j8pwCSUGhVuORqd4t3lBwhksArarmov6ZRx
 vY2vpxxClIVqg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=atuGH1dk
Subject: [Intel-wired-lan] [PATCH 0/3] net/e1000e, igb,
 igc: Remove redundant runtime resume
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
Cc: Sasha Neftin <sasha.neftin@intel.com>, netdev@vger.kernel.org,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 intel-wired-lan@lists.osuosl.org, Zheng Yan <zheng.z.yan@intel.com>,
 Konstantin Khlebnikov <khlebnikov@openvz.org>,
 Heiner Kallweit <hkallweit1@gmail.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Bjorn Helgaas <bhelgaas@google.com>

e1000e, igb, and igc all have code to runtime resume the device during
ethtool operations.

Since f32a21376573 ("ethtool: runtime-resume netdev parent before ethtool
ioctl ops"), dev_ethtool() does this for us, so remove it from the
individual drivers.

Bjorn Helgaas (3):
  e1000e: Remove redundant runtime resume for ethtool_ops
  igb: Remove redundant runtime resume for ethtool_ops
  igc: Remove redundant runtime resume for ethtool ops

 drivers/net/ethernet/intel/e1000e/ethtool.c  | 62 ++------------------
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 15 -----
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 17 ------
 3 files changed, 6 insertions(+), 88 deletions(-)

-- 
2.34.1

