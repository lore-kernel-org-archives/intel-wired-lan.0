Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D65FD45FC
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Feb 2026 23:56:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33A0B6103D;
	Wed, 25 Feb 2026 23:56:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FaQBqdsuj4j6; Wed, 25 Feb 2026 23:56:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6EBA960D64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772063810;
	bh=Fze38fQh3jYeQvMp+laFGBIXCYEEb1EnfKKcalJI/qY=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AllU7NOwNJIUmfbTOGdZHMHDjsf5sK8x+loR18qLqD6zgtPykAlAvyN1dNio8DBgG
	 Fm9/H2OtpBbr5N4RjKtg4V6qvaBOMpplgx1CC1MWoVgqVSAuYKlxbTMPGNQ9+fqNR9
	 kfzzbkMfo64btfzNR+U4y0dK7omWdGqBuEYR1qlqJ//LGViuNtF3yTFTW5J/kXbJ+M
	 /ocJQHCecvOyJ4LkubFLwgs1Ii8IunfiOkIcdD1sJhiidEcOup7/kU4h5T3amILLVj
	 7g2GNUN+bPc8bpudu1LMIfTq0AbpLC1pr2Xl17M+H35Y0Jov97D/H/+WZx5TbHp5iT
	 BJJq0VhN5y7eA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EBA960D64;
	Wed, 25 Feb 2026 23:56:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 77380204
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Feb 2026 23:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 68FCC60D64
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Feb 2026 23:56:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NWXqf9ZQeP5p for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Feb 2026 23:56:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=vinicius.gomes@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B084760D5C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B084760D5C
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B084760D5C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Feb 2026 23:56:46 +0000 (UTC)
X-CSE-ConnectionGUID: 3WPK37XkT3CXwGFKgjk6zg==
X-CSE-MsgGUID: CzTplUYQQq+aNeSiCGTc8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73296037"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; d="scan'208";a="73296037"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 15:56:45 -0800
X-CSE-ConnectionGUID: OHcdCXSgQxiLJtblpsZj+A==
X-CSE-MsgGUID: w2L6W3WVTdeZm1ACxOS+Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; d="scan'208";a="254143884"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO vcostago-mobl3)
 ([10.125.111.103])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 15:56:45 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas
 <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, intel-wired-lan@lists.osuosl.org, Bjorn
 Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Richard Cochran
 <richardcochran@gmail.com>, Andy
 Shevchenko <andriy.shevchenko@intel.com>, Vitaly Lifshits
 <vitaly.lifshits@intel.com>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Dima Ruinskiy <dima.ruinskiy@intel.com>
In-Reply-To: <20260225122619.GA2275908@black.igk.intel.com>
References: <20260224111044.3487873-3-mika.westerberg@linux.intel.com>
 <20260224165837.GA3736201@bhelgaas>
 <20260225122619.GA2275908@black.igk.intel.com>
Date: Wed, 25 Feb 2026 15:56:44 -0800
Message-ID: <87jyw09y2r.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772063807; x=1803599807;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=PUDRRJUvwufwpdxAeV/prfHMJbc5bfvWNHyTsiVnrog=;
 b=mzC31bOnEt90syKyjEH5bRjnGFgxEwOeCYXzECNYNRB3XO03JOifscVs
 8dgQHr5zYH2mrAufs8Wkq1/P3LA+QCRPFwqWzrO19EwLB0fMdzXP6wEiS
 XavzuCVc3l9itYcTZcrMYTiiY1shcL+o89Xtn3Sa3DDcZ3g8B+pPvE82t
 Tle85MH1nPCv6WZzG8PoxfJhIGhOF8VpcnLQQD5juXP/syOooM1D/sv0Z
 VfmIf+nY6PN4g2B/HGLolIpjtm4sWFzDDswTfaBxxqHhZw357v+lDA/Ot
 cnXovvoWu7oiwkDiN8BdcGM+sYKYT7xn6WzHgooJScia0VwnvvCadUqZF
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mzC31bOn
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

Mika Westerberg <mika.westerberg@linux.intel.com> writes:

> On Tue, Feb 24, 2026 at 10:58:37AM -0600, Bjorn Helgaas wrote:
>> On Tue, Feb 24, 2026 at 12:10:41PM +0100, Mika Westerberg wrote:
>> > Currently igc driver calls pci_set_power_state() and pci_restore_state()
>> > and the like to bring the device back from low power states. However,
>> > PCI core handles all this on behalf of the driver. Furthermore with PTM
>> > enabled the PCI core re-enables it on resume but the driver calls
>> > pci_restore_state() which ends up disabling it again.
>> > 
>> > For this reason let the PCI core handle the common PM resume flow.
>> > 
>> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> 
>> I love it, thanks a lot for doing this!
>> 
>> Do we still need the pci_enable_device_mem() and pci_set_master()
>> in __igc_resume()?
>>
>> I suppose some of that is related to the pci_disable_device() in the
>> suspend path (__igc_shutdown()), but there are only a few dozen
>> drivers that do this, so I'm not sure it's essential.
>
> I think they are just as you describe due the fact there are explicit
> pci_disable_device() calls. Probably we can get rid of them as well but
> that requires careful testing that nothing accidentally breaks.
>

This series is solving real problems (thank you btw), I think the
pci_disable_device() one would be better as a separate series.


Cheers,
-- 
Vinicius
