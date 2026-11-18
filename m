Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6E1606A31C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=xUqbMnvs;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pnkwsk7U
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C078280D0F;
	Wed, 18 Nov 2026 14:01:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G2CSGbKH9h-c; Wed, 18 Nov 2026 14:01:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C3D8781253
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795010515;
	b=fFRVoIiCmpM1xFK7137HVWG5t9fkAij6mju7Xmf7mrSBMFEnIBvC5KhZaEd91enR5/W8
	 FUkWGkWBFRiAOPoMs4D3YucMePeJ0EHjNMZC5ijeCP/XMRYTPa1QSg3h691Mw/NW5V1m0
	 H8RD405G1xoXCcwImUD1+ovZ7u6NI87iN5QlgMDKcCtrRwo281rrl6/EYyNM8bQp4ImID
	 UIhLrt8rQfLVC2hCHcqlT5yukjj3q5WeVmE15OHoXQBomDEhDX5TCxjgwwS5Icb/HLWE1
	 E7GWnvMgidV6HOPzJPMJoYQGCcEVEV+pYiZgpOP116yDlfSnirgh0P8ABwGAjpzFEtQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795010515;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KIdqIlj6kC8jVLpZrDN3iLbh4+p+XYCBL44LZcUbDfM=;
	b=PMWObKEBGwDjorS+mpptW2d11hku++u5N/AvhdYPHjtolFr6MY//7NLC5qku2VbiUsLJ
	 2uqx+Tmqq8rtEGRQHSqF+w3DVc0KsaHUhy7eMlc+DfNW4+1Xbm/ZapqaXpF6j4AJnu/vp
	 2OnsrM5tKHoPPC1Q2CTuAkJa8wS/bFOQLrRdT5u8QKFO452USpbwygJQ5DsXZ7xYn2vWN
	 C/R1h3CifdbFpCMgqbnNUN875ycsfJ893sD5fxZgq0mOGGfDSA3iQwonpVpYiKafY/Jl8
	 oyzMMj5m8SDIBO/c0PyBiNwusLQZYPj6qIECetpbuO8wQO3DkWx4D2qWlEPj+7qkMUQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pnkwsk7U;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795010515;
	bh=KIdqIlj6kC8jVLpZrDN3iLbh4+p+XYCBL44LZcUbDfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xUqbMnvsKRl0pn4tDptktxPSmMTYxx/ePD9qsa17uzvCKzrWF6s9NDUx+QpGW2cpo
	 SfRgmjbxIAgP+BsaEpv5d6RgYeclIU/loC0TilL0r5v+xqCJb3PkJokFSFlrVQVIY3
	 JLrD5IcBMJRzvRYRm1VAKRPdGJblp1NV1gERkhk+qQVKD4SVWfS/dD/acQqXeBOCcp
	 OvyijEu5Ck0/7edWEgoJSK6mSVH9d7FfBporTbCfFPnJzpW1INh53FF70agkQBv6gH
	 0jN+/8j4e+UHlpBFITOwpPvuZldac3VFwvz8Fo9p+6w3ba/qBOzN/Ha46/mmkGmYZe
	 vcFFcwK/Ql5Kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3D8781253;
	Wed, 18 Nov 2026 14:01:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 86E1D70B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 14:01:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6CC1A81253
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 14:01:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fsyyELjLY2xO for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 14:01:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C39F380D0F
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Pnkwsk7U
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C39F380D0F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 14:01:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BA31943391;
 Wed, 18 Nov 2026 14:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7611F000C4;
 Wed, 18 Nov 2026 14:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795010511;
 bh=KIdqIlj6kC8jVLpZrDN3iLbh4+p+XYCBL44LZcUbDfM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Pnkwsk7UoGBWjjE2fd8d2R7QRtAmeQRGgwRrPDe3Pi3eJSHnlzVj/A3JeYavucVSG
 6Tjytuhoq3N156tPQ0Oe6XF78LM1c6yCcVdHA0SxF4GdzKssQWwG+dSCNRiKWkbywL
 uDwcQXgMZQq/zhW7SVKB5Aj++5wTECre1k7evRxEEaJRyQLe/pAUOx6H9biDo8j/Qx
 KRN1v9zlB7L3o5oz9lX53YCcYfizrne+cfCbRuk5z5HlUP2qHeZ+YpEGKrXnSOOPWC
 XZAb6bpXT0G53QqSAfNYgv7RH4aPrVQ25UuWgxtk3KfngXAK6AatZHzHfp2BlIGuo0
 P0VXSohs03Rig==
Date: Wed, 18 Nov 2026 14:01:46 +0000
From: Simon Horman <horms@kernel.org>
To: Li Yifan <yifan2.li@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Dima Ruinskiy <dima.ruinskiy@intel.com>,
 Li Lili <lili.li@intel.com>, Wang Jie <jie.wang@intel.com>
Subject: Re: [PATCH iwl-net v2] igc: Disable PTM after the last device reset
 on remove
Message-ID: <20261118140146.GD860048@horms.kernel.org>
References: <20261110062051.2730678-1-yifan2.li@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110062051.2730678-1-yifan2.li@intel.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 02:20:51PM +0800, Li Yifan wrote:
> After a PTM dialog, I225/I226 can send a PTM Request at the next device
> reset through the RST bit of the device-specific CTRL register
> (CTRL.RST). The device sends it even when the PTM Enable bit in its PTM
> Capability is clear. This is a hardware defect: a PTM Requester is
> permitted to request PTM Master Time only when PTM is enabled (PCIe
> r7.1 sec 6.21.3.1). The EN bit of the device-specific PTM_CTRL register
> is also clear at that time, so the driver has no control that stops
> the request.
> 
> The request is harmless while the upstream port has PTM enabled. Since
> commit e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root
> and Switch Upstream Ports"), pci_disable_ptm() also disables PTM on the
> upstream port when the last user goes away. igc_remove() calls
> pci_disable_ptm() before unregister_netdev(). If the interface is up,
> unregister_netdev() then resets the device through igc_close() ->
> igc_down() -> igc_reset(). The upstream port now handles the PTM
> Request as an Unsupported Request, as the spec requires (sec 6.21.3).
> On an Intel Nova Lake-S system with an I226-LM, this triggers DPC on
> "modprobe -r igc". Recovery fails because the driver is unbinding, and
> the next probe fails:
> 
>   pcieport 0000:80:1d.0: DPC: containment event, status:0x1f01: unmasked uncorrectable error detected
>   pcieport 0000:80:1d.0:    [20] UnsupReq               (First)
>   pcieport 0000:80:1d.0: AER:   TLP Header: 0x34000000 0x81000052 0x00000000 0x00000000
> 
> Message code 0x52 in the TLP header is a PTM Request from 81:00.0.
> 
> Call pci_disable_ptm() after the last reset of the device, so that the
> upstream port still has PTM enabled and responds to the request. If the
> interface is down, unregister_netdev() does not reset the device, so
> reset it explicitly. Skip this reset if error recovery is in progress
> or has failed, as igc_down() does before igc_reset().
> 
> Tests on an I226-LM show that this reset also clears the state: the
> device sends the request only at the first CTRL.RST after a PTM dialog,
> so a later reset sends nothing unless a new dialog runs.
> 
> No new dialog runs after this reset. The PCIe spec makes the mechanism
> that starts a PTM dialog implementation specific (sec 6.21.3.1), so a
> device can start dialogs at any time while PTM is enabled. I225/I226
> start a dialog only when PTM_CTRL.EN is set and the driver sets the
> TRIG bit in PTM_CTRL (the "PTM trigger mode" in commit 8e404ad95d2c
> ("igc: fix PTM cycle trigger logic")), or in an automatic cycle mode
> that igc does not use. The request at CTRL.RST is the only exception
> that we know of. igc sets EN and TRIG only in the PTP code, and
> igc_ptp_stop() runs before the reset:
> 
>   - igc_ptp_suspend() -> igc_ptm_stop() clears PTM_CTRL.EN.
>   - ptp_clock_unregister() removes the PHC and waits for the
>     igc_ptp_getcrosststamp() calls in progress, so no new TRIG comes.
>   - IGC_PTP_ENABLED is cleared, so igc_ptp_reset() returns early in the
>     reset path and does not set EN or TRIG again.
> 
> pci_clear_master() stays where it is, so PTM Enable is now cleared
> after bus mastering is disabled. This keeps what commit c080fe262f9e
> ("igc: Fix possible system crash when loading module") needs: the
> device starts no PTM dialog while bus mastering is disabled, because
> PTM_CTRL.EN is already clear.
> 
> Fixes: e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root and Switch Upstream Ports")
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Co-developed-by: Li Lili <lili.li@intel.com>
> Signed-off-by: Li Lili <lili.li@intel.com>
> Signed-off-by: Li Yifan <yifan2.li@intel.com>
> Tested-by: Wang Jie <jie.wang@intel.com>
> ---
> v2:
> - Call CTRL the device-specific CTRL register. Describe the defect as a
>   PTM Request with PTM Enable clear, and remove Bus Master Enable from
>   the description of the defect (Bjorn).
> - Leave pci_clear_master() where it is and move only pci_disable_ptm()
>   (Bjorn). Retested this order on the I226-LM (v7.2.7 with the same
>   change): reload x20 with the
>   interface up; unload with the interface down or never up, then a
>   manual CTRL.RST (no PTM Request); S3 and s2idle; unbind/bind;
>   remove/rescan; runtime suspend; reload in parallel with S3 for 10
>   minutes. No DPC.
> - Explain why no new PTM dialog starts after the reset, and that
>   starting dialogs only on TRIG is device-specific (Bjorn).
> - Add PCIe r7.1 references for the defect, the Unsupported Request at
>   the upstream port, and the dialog trigger.
> - Keep only the pci_channel_offline() check before the reset (Bjorn).
> - Drop the pcie_ptm_enabled() check before pci_disable_ptm(). The PCI
>   core fix [1] (applied to pci/ptm for v7.5) handles a failed
>   pci_enable_ptm() for all drivers. Without [1], this is the same as
>   the current code, which also calls pci_disable_ptm() without a check.
> - No erratum covers the PTM Request at CTRL.RST yet. I reported it to
>   the I225/I226 hardware team and waiting update now. I
> 
> [1] https://lore.kernel.org/r/20261104121457.2108515-1-yifan2.li@intel.com
> 
> v1: https://lore.kernel.org/r/20261031021928.1714612-1-yifan2.li@intel.com

Reviewed-by: Simon Horman <horms@kernel.org>

