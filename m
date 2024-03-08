Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA72C54E41
	for <intel-wired-lan@archiver.kernel.org>; Fri,  8 Mar 2024 21:31:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C17283592;
	Fri,  8 Mar 2024 21:31:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0nEivHqB55_P; Fri,  8 Mar 2024 21:31:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E0C8835A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1709933476;
	bh=528tIhuueY4a9H6PuqwCbvU7Hl31xzaYWJK9s9WX8po=;
	h=Date:From:To:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Cc:From;
	b=2kiAy96bAJyR4CvZz4QdeTEyakQfOZIU9NdzL6R3pSGCtGc/MwYvrjusWThJ5pZca
	 V9M/J1H16xQJcoEf4RHgwhAkyVovsLAahZEePYlhs49A40B9bR/5DLoYQd/4f4i3a8
	 bkvqpL+UMmyy+V0y3Q4RmdsRMuKdIDifz4hQiIxM81kvG5NLM5iIvKHRP5AuNO9CNZ
	 nzjIYWAC13oteHQZ5+zSyUKgxI1OTwAdKNPGAasWY8RX4b+tLq9HoFHZ7uM1WT4dQM
	 YVCt/gz+00FfJdCBtn2PrMbcO6Wo4mzGFSA8NhhsRYLlJMmpDThTpNglJs9EIMgHG8
	 kgwKj/EnQUikQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E0C8835A9;
	Fri,  8 Mar 2024 21:31:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id CFBC21BF48D
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 Mar 2024 21:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C873C40B07
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 Mar 2024 21:31:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1BeimiVT9xr1 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  8 Mar 2024 21:31:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55;
 helo=sin.source.kernel.org; envelope-from=helgaas@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D1B01400EF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D1B01400EF
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D1B01400EF
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 Mar 2024 21:31:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 97936CE29B1;
 Fri,  8 Mar 2024 21:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97843C43394;
 Fri,  8 Mar 2024 21:31:08 +0000 (UTC)
Date: Fri, 8 Mar 2024 15:31:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Message-ID: <20240308213107.GA700934@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240206135717.8565-1-ilpo.jarvinen@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1709933468;
 bh=BIrlIu35U2rimElEMkh+0WBDV89ooLPXuL5UGm7857c=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=TW7YYjfkc2/7XCq1OsOk4JnkQ2Z4roe/55Aod6b+odn0SZoI1mh5iU4avPdsBAWNJ
 vKBopD5GVzT90xHrQM+caKjUTuYrTM7tQ+t8f8Rtpg0do1sXZN4uug2ChAwfwUt8oD
 FYO5MDsYtY3VOSDjGJM9RCJyjHti1KtmK4BjwP7C+HHelSf9pmB/FblcRkwN1JJygS
 8cvT2c6sCebDAogOn97OZTUAmx5lOItuq5MiswxsqBTwwpFBq4sChVbLa+1RPGMnYF
 PnJky00JFyo6T5VFhhxyakNMX6h7kcYchNcS/Xl5ww125XNcuXJ7pVUOeybv5tcaQm
 78wmQeAI82sxA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=TW7YYjfk
Subject: Re: [Intel-wired-lan] [PATCH 0/4] PCI: Consolidate TLP Log reading
 and printing
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
Cc: Oliver O'Halloran <oohall@gmail.com>, linux-efi@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-pci@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 intel-wired-lan@lists.osuosl.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Feb 06, 2024 at 03:57:13PM +0200, Ilpo Järvinen wrote:
> This series consolidates AER & DPC TLP Log handling code. Helpers are
> added for reading and printing the TLP Log and the format is made to
> include E-E Prefixes in both cases (previously only one DPC RP PIO
> displayed the E-E Prefixes).
> 
> I'd appreciate if people familiar with ixgbe could check the error
> handling conversion within the driver is correct.
> 
> Ilpo Järvinen (4):
>   PCI/AER: Cleanup register variable
>   PCI: Generalize TLP Header Log reading

I applied these first two to pci/aer for v6.9, thanks, these are all
nice improvements!

I postponed the ixgbe part for now because I think we should get an
ack from those maintainers or just send it to them since it subtly
changes the error and device removal checking there.

>   PCI: Add TLP Prefix reading into pcie_read_tlp_log()
>   PCI: Create helper to print TLP Header and Prefix Log

I'll respond to these with some minor comments.

>  drivers/firmware/efi/cper.c                   |  4 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 39 +++------
>  drivers/pci/ats.c                             |  2 +-
>  drivers/pci/pci.c                             | 79 +++++++++++++++++++
>  drivers/pci/pci.h                             |  2 +-
>  drivers/pci/pcie/aer.c                        | 28 ++-----
>  drivers/pci/pcie/dpc.c                        | 31 ++++----
>  drivers/pci/probe.c                           | 14 ++--
>  include/linux/aer.h                           | 16 ++--
>  include/linux/pci.h                           |  2 +-
>  include/ras/ras_event.h                       | 10 +--
>  include/uapi/linux/pci_regs.h                 |  2 +
>  12 files changed, 145 insertions(+), 84 deletions(-)
> 
> -- 
> 2.39.2
> 
