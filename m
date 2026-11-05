Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40477606A31B
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Nov 2026 23:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=BPwfJQCW;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oGPJce4f
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D03160890;
	Thu,  5 Nov 2026 23:46:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JxN-zaKKkal4; Thu,  5 Nov 2026 23:46:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A8F066085B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793922377;
	b=cBqHrCPFWo3tiKffpDdEgtpAUHQxzxqVSxEzvbgbquX42qMu3/A6JJjwgZlVB4TbbXPu
	 mkSugSevhVRD2HUi8197iNkDX0GxLxEjEX64/nUEJule1Z5TXXmaUoR+QRL14KV1jT2L5
	 IYtBrbSqtXUClEx1k6TOc95OuuLMHlpcFQ+aHYTFX238XjjpHlVysvdCg8KLcqKwEgtNH
	 5CU1F4HNpHodIkhGIysu6dmjcO9dVFBS1Z7CDPV1GJ4LuUDJue5Tf4Wbwjtf9ZsPDFU4J
	 GgpyyIuR1uPIF1j90Ill1+7by+PqtlDlQ+D0/FJCIFlhum6nT4AqRJTI7Zzph3LtIPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793922377;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:MIME-Version:Content-Type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=W+uNQUyXcc+ekvFYQ9xIE0qfkbp7ilJ7NXxuLfb006w=;
	b=cXkit/wAroHELkc8ZnU8qgtjQt/OIRb7ZzLAnbUywIc08b5KgkSmGfhmHuhK2eoyJEst
	 /YXB0r2SX/WoYxv1RqgHEW2+oyittedP9in1ULlr+0nTPvKmB/6mUkcO/jQA7LgctQ6Fe
	 EibBZU/PmMm3+kjUXIWocPYDA6/HDFwT6JvTBuOtVAJ/tL9F0df0HWGrcJa9a1i7Hk8YO
	 cRXhpQdNPwbP3FYPgt9o1F3TQTOIwI0RN6mVtmhZD5Ztrb5CoedWGPapmn+CWMR6JYYvk
	 ACEEpSUFLJiQ3qVP++dr2Zo8lFzsz8MrzbwuCCEBBglkHaGwmq/sAP7MUyq70Ob9e6Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793922377;
	bh=W+uNQUyXcc+ekvFYQ9xIE0qfkbp7ilJ7NXxuLfb006w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BPwfJQCWOmPS/JL44E7I+2jMl+cjT42Qgbt/k4aYze0DasBUvIZTM8MW7wuCcuzKA
	 4VlcK3eMYeendl0g1eiB7iE3GAR5cHdhM42w+SUm7pIABho4MxjTNrdoPM+1L0p7In
	 Kjd3sGMtHnDW6JpOjk1xRF9H2az4T+Z1qHief761hfvbl0ydJMpoyJsmPwqMuMteBC
	 XtcsF16GRIwuPT67cjVe/KKv26i2D7D+uSLRTvIzsbKcAGhNGRdwSHRdGZo0XFLzIN
	 GzDUXzPH8FvuwVPfT+w4GXwADS18w+X4iqM65moWyB6vDCHu6xU728EOfXUzlbAfF0
	 GTX+KZuNdCrLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8F066085B;
	Thu,  5 Nov 2026 23:46:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C78C795F
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 23:46:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AD21140815
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 23:46:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QOJpPqvTekVZ for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Nov 2026 23:46:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8A46B4050E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=vinicius.gomes@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=oGPJce4f
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A46B4050E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 23:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793922369; x=1825458369;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=snKNR2nl9AaDmkl2ulsSGrGAiVn+mGHWQlK5yFxTaMg=;
 b=oGPJce4fokySe6p30VvpCyyIUZIXSVVWHyPR+QEFUbb2dgtBXAjp34bv
 W8AugmacMv0GtMvczbxB984WjWxR7i2uUIQw8FT3BFIiVP/7XUI8HQnxQ
 cdUgfmaWVnwE2zBp4iWa5NW2ZEf28XpnvH7kWnr71ECOtFCi5d3CT7nrA
 4c+y8K8tgVDQ9z1C91LeSInMF5vQbmoXcJj32frEKKmtVSxQtaLBmmBVb
 pAkO6m/lLQuJbNVPmyjjLxLXuU/6zsXqVdHblSDuN6C3+keBdsPevboFr
 N7oJJnG4TZyULxG1KDE8NEX6hldtJ8P8ZFL8KA/nU4GuMHTG8vo5xv90i Q==;
X-CSE-ConnectionGUID: WQFHn6s9SbquxSa9SElvSA==
X-CSE-MsgGUID: ER3/A5hiTOCMM8ZtQ5i/CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2726083"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2726083"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 15:44:20 -0800
X-CSE-ConnectionGUID: nV4uMikZTyWvN89HWVbJnQ==
X-CSE-MsgGUID: hpgmX9uHSOe07DdJQLUnzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7458260"
Received: from vcostago-desk.jf.intel.com (HELO vcostago-desk) ([10.98.24.84])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 15:44:21 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "Li, Yifan2" <yifan2.li@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, "Ruinskiy, Dima"
 <dima.ruinskiy@intel.com>, "Li, Lili" <lili.li@intel.com>, "Wang, Jie"
 <jie.wang@intel.com>
Subject: Re: [PATCH iwl-net] igc: Disable PTM after the last device reset on
 remove
In-Reply-To: <20261104164432.GA1216460@bhelgaas>
References: <20261104164432.GA1216460@bhelgaas>
Date: Thu, 05 Nov 2026 15:44:20 -0800
Message-ID: <87ik2avo6j.fsf@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Wed, Nov 04, 2026 at 02:22:40PM +0000, Li, Yifan2 wrote:
>> On Mon, Nov 02, 2026, Bjorn Helgaas wrote:
>> > On Sat, Oct 31, 2026 at 10:19:28AM +0800, Li Yifan wrote:
>> ...
>
>> > > Reset the device while the upstream port still has PTM enabled,
>> > > so that the PTM Request gets a response. Then disable PTM and
>> > > bus mastering. With this order, a later reset sends no PTM
>> > > Request (tested on I226-LM). igc_ptp_stop() has already cleared
>> > > IGC_PTP_ENABLED, so no new PTM dialog starts after this reset.
>> > 
>> > IGC_PTP_ENABLED is just a software flag, and it appears to be
>> > related to PTP, not directly related to PTM, so there are some
>> > dots missing between it and hardware PTM messages.
>> 
>> Sorry, I skipped steps. In igc, PTM is used only for PTP cross
>> timestamps. The driver starts PTM dialogs only from the PTP code, by
>> setting the TRIG bit in PTM_CTRL:
>> - igc_ptp_reset() sets PTM_CTRL.EN and triggers the first dialog.
>> - igc_ptp_getcrosststamp() triggers dialogs for each cross timestamp
>>   request.
>> 
>> igc_ptp_stop() runs before the reset and stops both:
>> 1. igc_ptp_suspend() -> igc_ptm_stop() clears PTM_CTRL.EN.
>> 2. ptp_clock_unregister() removes the PHC and waits for the
>>    getcrosststamp() calls in progress, so no more calls come.
>> 3. It clears IGC_PTP_ENABLED. igc_reset() calls igc_ptp_reset(),
>>    which returns early when this flag is clear, so the reset path does
>>    not set PTM_CTRL.EN again.
>> 
>> So IGC_PTP_ENABLED does not control the hardware directly. It only
>> stops the driver from setting PTM_CTRL.EN again. v2 will describe
>> these steps.
>
> I don't think the PCIe spec includes any generic way to trigger PTM
> dialogs, and in general, I think devices are permitted to initiate
> them at any time, independent of driver or other events.  So I think
> igc has device-specific knowledge that the NIC *only* initiates PTM
> dialogs when a driver sets the TRIG bit.  If so, I think that's worth
> a mention.
>
> I haven't worked through the steps you outlined, but maybe they
> explain why there's no PTM Request after the later reset.
>
>> > > If the interface is down,
>> > > unregister_netdev() does not reset the device, so reset it explicitly.
>> > > PTM is still disabled before bus mastering, as the related fix above
>> > > requires.
>> > 
>> > Which fix requires PTM disable before bus mastering disable?  And
>> > why is that required?
>> 
>> c080fe262f9e. Its commit message says: "Avoid an i225/i226 hardware
>> issue that PTM requests can be made even though PCI bus mastering is
>> not enabled. These unexpected PTM requests can crash some systems."
>> The order is a workaround for that I225/I226 hardware issue, not a
>> PCIe spec requirement. The commit message does not say more about
>> why the order matters, but when I checked with the hardware team, I
>> found an internal erratum for that issue.
>> 
>> I found c080fe262f9e when I searched the igc history for this PTM
>> problem. Our issue is different: after the device has done a PTM
>> dialog, the next CTRL.RST can make it send a PTM Request, even when
>> PTM Enable is clear.
>
> I think that part of the c080fe262f9e commit log is just wrong.  The
> fact that i225/i226 can make PTM requests when bus mastering is
> disabled is perfectly fine; it's not a hardware issue.  I *suspect*
> that only the pci_disable_ptm() in that commit is actually required.
>

Yeah, most probably I should have written that commit message better :-)

From what I remember, the issue was on the other side, even if i225/i226
sending PTM requests when bus mastering is disabled is fine, the side
receiving those requests weren't fine with that. And that caused some
stuck systems. (perhaps I should have focused on this when writing the
commit message)

>> > > Skip the reset if the device cannot respond: error recovery is in
>> > > progress or has failed (pci_channel_offline()), the device is gone
>> > > (pci_device_is_present()), or igc_rd32() has already reported "PCIe
>> > > link lost" (IGC_REMOVED()). Otherwise the reset accesses a device in
>> > > error recovery, or polls all-ones register values for about two
>> > > seconds until igc_disable_pcie_master() times out.
>> > >
>> > > Call pci_disable_ptm() only if PTM is enabled. pci_enable_ptm() can
>> > > fail in probe, for example if the upstream port does not support PTM,
>> > > and probe continues without PTM. The PCI/PTM change above also made
>> > > pci_disable_ptm() use a reference count: it decrements
>> > > dev->ptm_enable_cnt without a check, and then does the same for the
>> > > upstream port. Before, it did nothing if PTM was not enabled. After a
>> > > failed pci_enable_ptm(), the count of the device becomes negative and
>> > > stays negative after the driver unbinds. pcie_ptm_enabled() returns
>> > > true for a negative count, so after the next probe
>> > > igc_is_crosststamp_supported() reports PTM support and igc_ptp_reset()
>> > > starts PTM cycles on a device that does not have PTM enabled. Commit
>> > > 650f197d8ea6 ("idpf: disable PTM on probe failure and on remove") adds
>> > > the same check to idpf.
>> > 
>> > This sounds like a bug in the PCI core PTM support, i.e., maybe
>> > pci_disable_ptm() should be checking for PTM being enabled?
>> > Otherwise I'm afraid lots of drivers might trip over this.
>> 
>> Agree and thanks! I sent a PCI core fix:
>> https://lore.kernel.org/r/20261104121457.2108515-1-yifan2.li@intel.com
>
> Thanks for that!
>
> Bjorn


Cheers,
-- 
Vinicius
