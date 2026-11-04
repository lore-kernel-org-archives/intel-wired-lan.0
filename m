Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECCB606A326
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=hAkIMd3T;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c/2xBfda
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 597A140719;
	Wed,  4 Nov 2026 16:44:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WQrhcqMrgqQw; Wed,  4 Nov 2026 16:44:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6C61340629
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793810678;
	b=S9P0kYTl56oYqPXUPrls2ONDvoPLZnnKirLnKgBmLmocsjRm0wudpLW/vFYaYdotuoyB
	 B6E7sqYVSDzkmG5MMfGR+3cJ/GDP1EOeTgvkuVUxrqnrXl09T96OHjhIdC/bWI/NueG7I
	 j4OjYs1g8FMTYPFLap8LvYVRrZsKoniIDUoQPYlMyXtdkDQ4+SZz7riI46drpVJKoIspM
	 4/wFNB8owPwxyAnJgi8LQJVww7/1O94Bz7f8QWsqAOVDFlQPDMi+fK1Cj9vGv3wJ7QV06
	 S3vbwUxj92HCmN5NOfveGGkyUQma166/7iqT2WORgtusUIzVODrLlaeAaa0G03Jvadg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810678;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bQvIDegU+Ei70cEI3udJurYLW6e3mWqJ7u/8qcqyJE8=;
	b=FEkqaOzasIQ/EgY2pRbN5phHT0/3/d2oVZSM+0XZt3rqpVWy7f6cBWkJmV5p3A4c/zzC
	 k0hFJUr6pFF4diNeK0gZgZu5jHGkzE/82CQqdZroDb1fZeBZtpT3WSIGEKV1jBWdPYYvz
	 q53q3Iox5jlTnjXP4uYCuh+P9vKWc9UT91F29J+W9+Gx3OOoP7Zm1k03+wW4tZxxaLzAm
	 KY209DgBnxYEXcr0quYeb+yGAGVJLoxIepN4D5JmttHQqzKWUPzUIYq5ELJAwH811I+rh
	 bYtiUA+jLPFNXSvrONMX8ameYJbjIzU5d3dLmwEe5efVUE4fkn2hKylwQoatNKOKsvA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793810678;
	bh=bQvIDegU+Ei70cEI3udJurYLW6e3mWqJ7u/8qcqyJE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=hAkIMd3TuOyDUn+hHYMtcKWyvkGrO52n5XZTtJdTc0WUmCgcgMxp1AsyaUUKq6Vl8
	 PiMJO3vJVZttvyWqLTptFImH67merjN0PhfOUh3r6zw5XCo0nJDLaVGhxQlLhFnTB0
	 TGDssh8uXRcIo1+gyfkOLCoqyDAitBv3JH5eh/5wjhCAM2dpk2dVgH7ufm/kSqG+QB
	 pQIqimgl9vFZMkhW9QcGZCvrKvPXsqnRjk5m+Lu8QPsDgUu9vr79WRSUquo6TuzK+j
	 0OGHjrpNoIoDl6TpTSMcpR63r/zrpElkT+FEPqVaurtWH3BHujQBB82SeIoUFXonTp
	 t629nW7desh3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C61340629;
	Wed,  4 Nov 2026 16:44:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 66049165
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 16:44:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4C0B040068
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 16:44:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kyhtE6p9WkJI for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 16:44:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3869240062
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=c/2xBfda
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3869240062
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 16:44:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1649A41747;
 Wed,  4 Nov 2026 16:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9F31F000C1;
 Wed,  4 Nov 2026 16:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793810674;
 bh=bQvIDegU+Ei70cEI3udJurYLW6e3mWqJ7u/8qcqyJE8=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=c/2xBfdaGBLrIZLTzTRRV+621+fS6sxissQ6IyXDuqGkDZk1caF40hjAYoZ3zCPyD
 BtsWAWES2CqNm1d7eHkAiuIED17n6H1pQVEWXOu7kv2UgUrdccjeJ/znFm91rY93XW
 V6osZXhH6VaCR2iLA98bAROLgdaBlpv6ig2A6uo86jKWmKusvRLT4Eoo+9o5dPRdeP
 RxjkYpTUelw+0e9t/Dwh70EqG2l7IDNo30GqWNPZaFh4wDszLE8O2phq8ed4LQ7FeD
 ZfaDVdNmYY2N/GZRVwVuqCXvI5L/dksaztAnPbeTZSGfcyW1GjjozziGt5uhDWNcAb
 VPKtP4kaPB1Zg==
Date: Wed, 4 Nov 2026 10:44:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Li, Yifan2" <yifan2.li@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>,
 "Ruinskiy, Dima" <dima.ruinskiy@intel.com>,
 "Li, Lili" <lili.li@intel.com>, "Wang, Jie" <jie.wang@intel.com>
Subject: Re: [PATCH iwl-net] igc: Disable PTM after the last device reset on
 remove
Message-ID: <20261104164432.GA1216460@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN7PR11MB170846508FFD9A89461965524FAF682@MN7PR11MB170846.namprd11.prod.outlook.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 02:22:40PM +0000, Li, Yifan2 wrote:
> On Mon, Nov 02, 2026, Bjorn Helgaas wrote:
> > On Sat, Oct 31, 2026 at 10:19:28AM +0800, Li Yifan wrote:
> ...

> > > Reset the device while the upstream port still has PTM enabled,
> > > so that the PTM Request gets a response. Then disable PTM and
> > > bus mastering. With this order, a later reset sends no PTM
> > > Request (tested on I226-LM). igc_ptp_stop() has already cleared
> > > IGC_PTP_ENABLED, so no new PTM dialog starts after this reset.
> > 
> > IGC_PTP_ENABLED is just a software flag, and it appears to be
> > related to PTP, not directly related to PTM, so there are some
> > dots missing between it and hardware PTM messages.
> 
> Sorry, I skipped steps. In igc, PTM is used only for PTP cross
> timestamps. The driver starts PTM dialogs only from the PTP code, by
> setting the TRIG bit in PTM_CTRL:
> - igc_ptp_reset() sets PTM_CTRL.EN and triggers the first dialog.
> - igc_ptp_getcrosststamp() triggers dialogs for each cross timestamp
>   request.
> 
> igc_ptp_stop() runs before the reset and stops both:
> 1. igc_ptp_suspend() -> igc_ptm_stop() clears PTM_CTRL.EN.
> 2. ptp_clock_unregister() removes the PHC and waits for the
>    getcrosststamp() calls in progress, so no more calls come.
> 3. It clears IGC_PTP_ENABLED. igc_reset() calls igc_ptp_reset(),
>    which returns early when this flag is clear, so the reset path does
>    not set PTM_CTRL.EN again.
> 
> So IGC_PTP_ENABLED does not control the hardware directly. It only
> stops the driver from setting PTM_CTRL.EN again. v2 will describe
> these steps.

I don't think the PCIe spec includes any generic way to trigger PTM
dialogs, and in general, I think devices are permitted to initiate
them at any time, independent of driver or other events.  So I think
igc has device-specific knowledge that the NIC *only* initiates PTM
dialogs when a driver sets the TRIG bit.  If so, I think that's worth
a mention.

I haven't worked through the steps you outlined, but maybe they
explain why there's no PTM Request after the later reset.

> > > If the interface is down,
> > > unregister_netdev() does not reset the device, so reset it explicitly.
> > > PTM is still disabled before bus mastering, as the related fix above
> > > requires.
> > 
> > Which fix requires PTM disable before bus mastering disable?  And
> > why is that required?
> 
> c080fe262f9e. Its commit message says: "Avoid an i225/i226 hardware
> issue that PTM requests can be made even though PCI bus mastering is
> not enabled. These unexpected PTM requests can crash some systems."
> The order is a workaround for that I225/I226 hardware issue, not a
> PCIe spec requirement. The commit message does not say more about
> why the order matters, but when I checked with the hardware team, I
> found an internal erratum for that issue.
> 
> I found c080fe262f9e when I searched the igc history for this PTM
> problem. Our issue is different: after the device has done a PTM
> dialog, the next CTRL.RST can make it send a PTM Request, even when
> PTM Enable is clear.

I think that part of the c080fe262f9e commit log is just wrong.  The
fact that i225/i226 can make PTM requests when bus mastering is
disabled is perfectly fine; it's not a hardware issue.  I *suspect*
that only the pci_disable_ptm() in that commit is actually required.

> > > Skip the reset if the device cannot respond: error recovery is in
> > > progress or has failed (pci_channel_offline()), the device is gone
> > > (pci_device_is_present()), or igc_rd32() has already reported "PCIe
> > > link lost" (IGC_REMOVED()). Otherwise the reset accesses a device in
> > > error recovery, or polls all-ones register values for about two
> > > seconds until igc_disable_pcie_master() times out.
> > >
> > > Call pci_disable_ptm() only if PTM is enabled. pci_enable_ptm() can
> > > fail in probe, for example if the upstream port does not support PTM,
> > > and probe continues without PTM. The PCI/PTM change above also made
> > > pci_disable_ptm() use a reference count: it decrements
> > > dev->ptm_enable_cnt without a check, and then does the same for the
> > > upstream port. Before, it did nothing if PTM was not enabled. After a
> > > failed pci_enable_ptm(), the count of the device becomes negative and
> > > stays negative after the driver unbinds. pcie_ptm_enabled() returns
> > > true for a negative count, so after the next probe
> > > igc_is_crosststamp_supported() reports PTM support and igc_ptp_reset()
> > > starts PTM cycles on a device that does not have PTM enabled. Commit
> > > 650f197d8ea6 ("idpf: disable PTM on probe failure and on remove") adds
> > > the same check to idpf.
> > 
> > This sounds like a bug in the PCI core PTM support, i.e., maybe
> > pci_disable_ptm() should be checking for PTM being enabled?
> > Otherwise I'm afraid lots of drivers might trip over this.
> 
> Agree and thanks! I sent a PCI core fix:
> https://lore.kernel.org/r/20261104121457.2108515-1-yifan2.li@intel.com

Thanks for that!

Bjorn
