Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129ABFD374E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Feb 2026 12:29:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C755B41DA2;
	Wed, 25 Feb 2026 12:29:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4LgLEMkH-v7Q; Wed, 25 Feb 2026 12:29:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 807F541D74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772022544;
	bh=lrtXcSJjIcH/1xtfxmcGmDUXdssO0zveh5SmAoLyswU=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zgJYFgr2l5AqjiYYm/6lqQMRB7Wl7qpopIEQNbHFAXR+ltYh9bAlmd8Vuu1ZBdZJn
	 OpjHMmCiB3wmBXW1B3IzgdLpqk85PyfnakKtdH3LtliEWDTsoGINR1+LBr6LY1xrY3
	 TdTMwHksndRBaXalwehW8dfbliBEb5VrPnBhyFWgC25WfTegymBKYPrkpFTIvxXF3c
	 j3LHgYa6Ws6mnSK1Y82uwBdivlysq2fIph4sDL5yBtS6gFCLMt6dH7svYyrTjMDPLZ
	 +ox6B5LTKJLjreBIYoJJnUkNfkukMIoXMu3g+Fc3Uye0sNE0T7ia225LdAnhLH6nhk
	 pKXx09OxdzWhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 807F541D74;
	Wed, 25 Feb 2026 12:29:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CA1223D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Feb 2026 12:29:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6DC0260FB4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Feb 2026 12:29:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sEfxBX7sERCt for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Feb 2026 12:29:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=mika.westerberg@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 67B3260BB8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 67B3260BB8
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 67B3260BB8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Feb 2026 12:29:01 +0000 (UTC)
X-CSE-ConnectionGUID: rqskPyYwRp6eYPwtJo8Wpg==
X-CSE-MsgGUID: zDwWkAuCQJiXoTjHBLW/8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72960809"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="72960809"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 04:29:00 -0800
X-CSE-ConnectionGUID: I3xwHY4JTKidB9QAeTmyOA==
X-CSE-MsgGUID: z3uDptVlQUyHrQZjyUOZwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="215323366"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa006.jf.intel.com with ESMTP; 25 Feb 2026 04:28:56 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
 id 238D198; Wed, 25 Feb 2026 13:28:55 +0100 (CET)
Date: Wed, 25 Feb 2026 13:28:55 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Richard Cochran <richardcochran@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Dima Ruinskiy <dima.ruinskiy@intel.com>
Message-ID: <20260225122855.GC2275908@black.igk.intel.com>
References: <20260224111044.3487873-3-mika.westerberg@linux.intel.com>
 <20260224165837.GA3736201@bhelgaas>
 <20260225122619.GA2275908@black.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260225122619.GA2275908@black.igk.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772022541; x=1803558541;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7g+d2bSnzpz2QCpHfxO/sRHUP6mOIul7BC/cDoNCzrY=;
 b=lZXFjEoPK96dDscrqOFSgvv3XGcCtXIwBiX62Plx3wc3I7o6XKR/D1x2
 72E79JIufkQKte7wmRWPa/D5vLXgqeypLlXPN0BquD+79MWJEokUvsrWr
 Y9nXv9R6fTML1xyRF+jD+OIWjbw5UStpdF62+0aPSR/m04LuZrRxDHd0b
 88x0O+7WkpY07Iq8sq4sGUIp5tMMr0V0Cvb5y95rumyBOIjxcfi1vH6kF
 /ZyO5Y2vAfw4hjSrr20zRHMrqkHHG22+FcFxvdpHh/qAAQ6Jo+Bd3wxFd
 tyP+ruoZp0ldDGKe5bGYD3PXOTPJ8YcHTBUSaAH7zY5inK23vSejQJY6E
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lZXFjEoP
Subject: Re: [Intel-wired-lan] [PATCH 2/5] igc: Let the PCI core deal with
 the PM resume flow
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

On Wed, Feb 25, 2026 at 01:26:19PM +0100, Mika Westerberg wrote:
> On Tue, Feb 24, 2026 at 10:58:37AM -0600, Bjorn Helgaas wrote:
> > On Tue, Feb 24, 2026 at 12:10:41PM +0100, Mika Westerberg wrote:
> > > Currently igc driver calls pci_set_power_state() and pci_restore_state()
> > > and the like to bring the device back from low power states. However,
> > > PCI core handles all this on behalf of the driver. Furthermore with PTM
> > > enabled the PCI core re-enables it on resume but the driver calls
> > > pci_restore_state() which ends up disabling it again.
> > > 
> > > For this reason let the PCI core handle the common PM resume flow.
> > > 
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > 
> > I love it, thanks a lot for doing this!
> > 
> > Do we still need the pci_enable_device_mem() and pci_set_master()
> > in __igc_resume()?
> >
> > I suppose some of that is related to the pci_disable_device() in the
> > suspend path (__igc_shutdown()), but there are only a few dozen
> > drivers that do this, so I'm not sure it's essential.
> 
> I think they are just as you describe due the fact there are explicit
> pci_disable_device() calls. Probably we can get rid of them as well but
> that requires careful testing that nothing accidentally breaks.
> 
> @Vitaly, what do you think? I can take a look.

Sorry @Vitaly and @Vinicius I meant :)
