Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DEEE9B253
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Feb 2026 11:10:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B409E41BED;
	Tue, 24 Feb 2026 11:10:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hpZXoC7u8kNb; Tue, 24 Feb 2026 11:10:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB79A41C7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771931457;
	bh=KYgFDr/0UqtWoFqAzRl3JD3YYRBxkTo9PHzeUewzRcE=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=L50kXqwqTpfl0WyHzc+pT8NRGaIiQ/yoOwfzso0V0yDVMSIqqu9DvQ1/5RvWkjnS3
	 PpLZSRdWzUZcOsSU0aqG0c4I0vn9P2I7EL5/KWezLy6DossKjj6iDLtvfX4GJC4B+2
	 0DTJGXg0X/bonpL0CR1M79Dt+rMImrECTuhAfMr86GowJphARyao65KT3GQMnQy48L
	 XsAOL9bhGcsiA8eaoT1phbPw/QCNvEAtsnpANo0j52P0HiR9SzFfu1zkrTF1YG6osO
	 8sX6Gmc1V+8DanzeZ1dRM82fVhx7LdDOc7Rg41joMD0ATHXd4LXj4V6Kma730Kvl1S
	 BWsVb2doPrzEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB79A41C7B;
	Tue, 24 Feb 2026 11:10:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B7C5237
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 11:10:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0257F41BF3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 11:10:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A7BaSjFBya5N for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Feb 2026 11:10:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=mika.westerberg@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4C4FF41BF5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C4FF41BF5
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C4FF41BF5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 11:10:52 +0000 (UTC)
X-CSE-ConnectionGUID: 1DmqUi9eTviPZ1JuklwiNw==
X-CSE-MsgGUID: 3CTyvTdAQQSl5B0GDQ3Dqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="98405017"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="98405017"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 03:10:50 -0800
X-CSE-ConnectionGUID: 0E2qZSbRQzmW17znr/jcSA==
X-CSE-MsgGUID: l37B6SpOSwWEV/47tJ08Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="215892057"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa008.jf.intel.com with ESMTP; 24 Feb 2026 03:10:45 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
 id 182A098; Tue, 24 Feb 2026 12:10:44 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, Bjorn Helgaas <bhelgaas@google.com>,
 Lukas Wunner <lukas@wunner.de>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Dima Ruinskiy <dima.ruinskiy@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Date: Tue, 24 Feb 2026 12:10:39 +0100
Message-ID: <20260224111044.3487873-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771931452; x=1803467452;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/yCQtpg7l1ZDCjOdUuFIA9/TuYYY4m2dg5A5Iqb7IMc=;
 b=aAzUGdOkmnBU1SL5CePlEyGPjBPxhGztQo+G3rdk7TgvuZlB18n6paga
 BVlDItrcVPtTOyoDGMBvP5eMswY6/wpRplDWAFpgl61lgy41cZjOzPKa3
 qr+xb1SlO01ONl6KOH7DxgUHOOsIXBXh+lEu12EMULVkfy3Zuv3W4cxHW
 PtzbMRwsNgP0q3wDNDdYSmG+tVJCqhfntHSSXG6QH3PTtewPt/WSq/4/K
 8u/RsoUYL89aJRK76kkG7jUBuGqXfbGtUZ1U1PeLjijLuaUXGeMYMzwyg
 DspVitE1YtfJCw3auE7pcQVqT9J3jl77JDfNm9Ep/Z1bEKtcx6qlHdnBX
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=aAzUGdOk
Subject: [Intel-wired-lan] [PATCH 0/5] PCI / igc: Improvements related to
 PTM enabling
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

Hi all,

There is (still) an issue with Linux PCIe PTM enabling that happens because
Linux automatically enables PTM if certain capabilities are set. However,
turns out this is not enough because once we enumerate PCIe Switch Upstream
port we also enable PTM but the Downstream Ports are not yet enumerated.
This triggers floods of AER errors like this:

      pcieport 0000:00:07.1: AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:00:07.1
      pcieport 0000:00:07.1: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Receiver ID)
      pcieport 0000:00:07.1:   device [8086:d44f] error status/mask=00200000/00000000
      pcieport 0000:00:07.1:    [21] ACSViol                (First)
      pcieport 0000:00:07.1: AER:   TLP Header: 0x34000000 0x00000052 0x00000000 0x00000000
      pcieport 0000:00:07.1: AER: device recovery successful
      pcieport 0000:00:07.1: AER: Uncorrectable (Non-Fatal) error message received from 0000:00:07.1

We have ACS Source Validation enabled so Requester ID 0 which is sent by
the not-enumerated Downstream Port triggers the ACS violation AER.

This can be prevented by enabling PTM when the whole topology has been
enumerated and doing it like that seems to be reasonable anyway because we
only have a couple of drivers enabling it now so it does not make sense to
enable otherwise as it consumes bandwidth.

I did that fix and the problem went away but wanted to test with a device
and driver that actually enables PTM. I have a couple of igc NICs here that
has this support. However, when testing I noticed that during power state
transitions we still get errors like this from igc:

  igc 0000:03:00.0 enp3s0: Timeout reading IGC_PTM_STAT register

and after this PTM for the device stays disabled.

This series includes fixes for igc that deal with the issues I found and
now PTM gets succesfully enabled and works accross suspend and runtime
suspend of igc, and there are no flood of AER errors as above. While there
there is one cleanup patch in the middle that drops unused parameter.

Mika Westerberg (5):
  igc: Call netif_queue_set_napi() with rntl locked
  igc: Let the PCI core deal with the PM resume flow
  igc: Don't reset the hardware on suspend path
  PCI/PTM: Drop granularity parameter from pci_enable_ptm()
  PCI/PTM: Do not enable PTM automatically for Root and Switch Upstream Ports

 drivers/net/ethernet/intel/ice/ice_main.c     |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  2 +-
 drivers/net/ethernet/intel/igc/igc.h          |  2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c  |  6 +-
 drivers/net/ethernet/intel/igc/igc_main.c     | 33 ++++----
 .../net/ethernet/mellanox/mlx5/core/main.c    |  2 +-
 drivers/pci/pcie/ptm.c                        | 77 ++++++++++---------
 include/linux/pci.h                           |  6 +-
 8 files changed, 64 insertions(+), 66 deletions(-)

-- 
2.50.1

