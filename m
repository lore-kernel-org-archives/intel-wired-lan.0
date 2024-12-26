Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6906E77188
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Dec 2024 16:52:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 622E680A59;
	Thu, 26 Dec 2024 16:52:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dEJ10nsp8V1I; Thu, 26 Dec 2024 16:52:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D254380ACD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1735231951;
	bh=9jo07Tlrz15w/TzMuCB5HC/3DxkFQ4oE8Ex5RRlirs8=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jVnK/Ttcpzo6vkI5gHEALO0KVLklPokhYsJhesX8WUgAcKZLq79B8vgBpiosZ+eEu
	 fs/HGnZpu4ujk9fepZJ6bKAHYWPCDQP9gLawZQIrxGhIhfnVCCQQZNcjlTtWPI747U
	 i7/dVShRFfHe+zZxoczLPui+piR5WnsnkOt3u0TYQgwUgljXXMxIW0/flQ58ZjareK
	 0Im+o3XYbwuew/VxFEpiRkUk6Sg+MZd0WZt4teJu2CakfrkTwN/TwuszCJbrB4raQR
	 3/5gTD/SuEzZjCxPCfFPpRCazYL3ovgnSUyRRkifGzamVJD4l0tLxXu9yV90z5voxl
	 epsRxiJ9ADZ0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D254380ACD;
	Thu, 26 Dec 2024 16:52:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1ACF7757
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Dec 2024 16:52:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 165F180ACD
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Dec 2024 16:52:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rbl0hj3-4KR2 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Dec 2024 16:52:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1098:5b::1;
 helo=mx.treblig.org; envelope-from=linux@treblig.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1745080A59
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1745080A59
Received: from mx.treblig.org (mx.treblig.org [IPv6:2a00:1098:5b::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1745080A59
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Dec 2024 16:52:28 +0000 (UTC)
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <linux@treblig.org>) id 1tQr5s-007IaP-1J;
 Thu, 26 Dec 2024 16:52:16 +0000
From: linux@treblig.org
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Date: Thu, 26 Dec 2024 16:52:12 +0000
Message-ID: <20241226165215.105092-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=9jo07Tlrz15w/TzMuCB5HC/3DxkFQ4oE8Ex5RRlirs8=; b=UR/oysPAE8heoXk6
 9/DG9m7b+qm2z0mhSU4Rgd5g70V+0UyCkJxjkwBM6bE4xDZnGnaTfes9Ru/hVq2Xm42lCjjwAG8Gb
 LAimq3nAzMkzIDtwnXwweCs3GrBu5E9PIyF7NEMnM2vEl2IUUPSPBScepa5Dws5/BRmO1Npjl6+2h
 AZGWiNv1xBIFmb2WZaefueNoLzgmYfXHLqJM8PlvIEWvfNGdsPFNgixw+AgiOBHCQbI9PL4xn8LBb
 RyswABDZUQz1NR97o3nmyA12o/idSvsB2pVuE3JucIOnPgwAskQXJo/aSQfZMNS8WCY0/30Ul3m31
 SEt5EO3zNZKkD+qrfw==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=treblig.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=treblig.org header.i=@treblig.org header.a=rsa-sha256
 header.s=bytemarkmx header.b=UR/oysPA
Subject: [Intel-wired-lan] [RFC net-next 0/3] igc deadcoding
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

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  This set removes some functions that are entirely unused
and have been since ~2018.

Build tested.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (3):
  igc: Remove unused igc_acquire/release_nvm
  igc: Remove unused igc_read/write_pci_cfg wrappers
  igc: Remove unused igc_read/write_pcie_cap_reg

 drivers/net/ethernet/intel/igc/igc_hw.h   |  5 ---
 drivers/net/ethernet/intel/igc/igc_main.c | 39 ------------------
 drivers/net/ethernet/intel/igc/igc_nvm.c  | 50 -----------------------
 drivers/net/ethernet/intel/igc/igc_nvm.h  |  2 -
 4 files changed, 96 deletions(-)

-- 
2.47.1

