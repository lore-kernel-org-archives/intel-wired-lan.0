Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90D7606A329
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=8i6dFBLL;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0xbMNSR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1B22809E7;
	Mon,  2 Nov 2026 22:28:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WOMVXFMp3dKK; Mon,  2 Nov 2026 22:28:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F30B080C6E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793658503;
	b=siW6QFthn3JHQ6Hyyq63UN/zYlZ9JlSplOw2jg94wWsQzLgt1HnpG1MUXqxhWpTSq+HQ
	 8muu40AgI3pgPqWDCRuAdvS35jAk8JkSWCqKyuPE2bg/KvcYkFeYXNP/S71NhQTpoY891
	 hwarezGgcdWbneH5yPWdaizj2DnvFT6z7mzLjB0pGeAVAFCPrECye+DTbVfvtqV77HDby
	 gE6Wymggm8iB7PLfs/18FL6nqMxHq+5Ezj6QoON5rxbsT40HbsPy4z+ZPVK/77aqRQbBO
	 NSrhUQiVsJUki14dMCfcZae3ZpNU1MpIrzVhuadxecRrvgQtNHo0kjVImNgxPMUdsBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793658503;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pLrc6IvsxvZox2frClEyQ8V7DfzXsEUEs896JOGYWfk=;
	b=J5XUCUPleCAXs1EZVmILBpLMljLFOja7JfVVec/EtdkHwzMfz4hXDGPOlCKwAE383pkL
	 NFEmR2oRnaBG0tMe0a0d46DJsFFE1dy4MTYtRDPmHDvNoXsOUIPXaKD0juPUmSchdLUjn
	 nBrFn6Nulu5vB7INfwU0w11s3GgMCteoea+ygI9dPYZGZh5nyH8GIAUYmlYPAgb7BjH0b
	 cYySN+Q34WMcATn/0DJ2HKw4MtRWajboOOXRZHe/HJhEgSw5+8jytQGvzZBORSvWvE87k
	 qUG8Gxj6lmvnf9uB5II+71F4Efh1hpDhr9uezSMPnAyj0rmGEmlm6V+CURcQmATQh6w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0xbMNSR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793658503;
	bh=pLrc6IvsxvZox2frClEyQ8V7DfzXsEUEs896JOGYWfk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=8i6dFBLLP1TlapIAnewgaBQj2aSwP4/seAHppKRHPa0LBQg7dmvWxLhO5Cmuu+HHM
	 RXA9uQDFVgXOO8A3NsmAdUXuVwRK66oSC5D681ZpDUR8am56u3n/bAu4CauHMlYoyi
	 gR7mIFmkwOGqr8HyH9ccroyYFedVC3y5o8WGzUJfaStx3Knjz0E/IhSHBtB+nNyctN
	 IvUzQMeSLqgPN6Jnt1UWfeBG+ULhHpq/poiwVyfOP2KWE47zGuXB/DLEosh+5o+Frv
	 I4o2BCo1tZpJhS+8wOX1srIL+YOuMOaD5dQLnKsOPzUcaac9Vlrw1IzjlqdF4RYS/r
	 BPsGIHwKeTzDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F30B080C6E;
	Mon,  2 Nov 2026 22:28:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F3DFD356
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 22:28:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E548A80C6E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 22:28:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6MtTNiSnfUIh for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 22:28:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ED657809E7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793658501;
 b=XAzMJ1uemaf7py4bbp8vwtoM2wsebAL0vyAJC0w6aj5yuCoga+1RscT0PdUfO0j9LK/0
 fOAj8AYTgWxnAuL+PFZn2+vLUcuqmCROd1M/LjRm89g79ylr4pxuj5YROpvxfngqgZiu4
 Su0NqBtqb4JjT11rBrb82heSn+BsvCRM3xZowka80F2zlfbhrrYOHfl6dvRz4V3HmIsdF
 6PdSAUqM8t6F/DFNPeKCF6hcjN7EBKwNo1FhvmHYf8XpV5qzMAg/RJ9zys4QvSyS1S+yE
 aC8BI1XST6S3hr+xfn8Yu59ncg7yHkzrOcixFE/o/7uUSyaCJyeC6p6xOZaHFjUlZrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793658501;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=pLrc6IvsxvZox2frClEyQ8V7DfzXsEUEs896JOGYWfk=;
 b=kG3yhJktiaPvdHcjKeKo2pPtf6kzcw8CoTy889j9UaGiu+P6MWq8EARNqJqpxFlLCjPJ
 b6J+xcl/cOiZgeyuANtAgo1UuyQN9Pw5M/r1/fhJlTTjCGnYyixq+ZSih17hfXztCweLy
 rlOSkyLmjYP/CvHfpAk0QB79NbdL+ZhisC7naIXptmWbDOJNwXCvIGpw+TWbM44GsKE8x
 6f72ge3z/SVviDuwOP/858WWTN3ek39UV1tArNDZr8o3Ye53PRDr/Yg87Om4KQfRVQH+Y
 /QQ9t9+OD/Ge2U5oI0pPs1kSIJl6sby5qaMPf8JFUCrxpfgPSzz8PRYUuN9haVvGaGA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=o0xbMNSR; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=o0xbMNSR
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED657809E7
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 22:28:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 446D8600D1;
 Mon,  2 Nov 2026 22:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBCB1F00A16;
 Mon,  2 Nov 2026 22:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793658499;
 bh=pLrc6IvsxvZox2frClEyQ8V7DfzXsEUEs896JOGYWfk=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=o0xbMNSROg9/PhI4EqQSPzRQ+s8Ia33KoO6eIdPfjUOpHDY59v0XgycrL12PCpw1X
 kj+d3U4x/Tm4TBNzOh6yWQeWS/Pwy2uxoAuAU/5Q6msUXdc4M3B1lTsCSZLn3WuLrp
 /orWGlt8Am0+awWt1D/AbkHLrjI/lq7t/c2QTnKXIQc1Ueykunl7fiamNrNif2r0WS
 INkafWu1EGLsu43RccLnzsr9iFcwtrxx8giZgrraYSJuBCBjLMMrnMPsQ/qhyRpJ2N
 BVnXmFWnFuSWmPrtMreyM9huw6xem2KMTsQl5+4009y3i4PZxlgsT23WyBdc+8Mky8
 iBlvbGMZXo7eg==
Date: Mon, 2 Nov 2026 16:28:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Li Yifan <yifan2.li@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Dima Ruinskiy <dima.ruinskiy@intel.com>,
 Li Lili <lili.li@intel.com>, Wang Jie <jie.wang@intel.com>
Subject: Re: [PATCH iwl-net] igc: Disable PTM after the last device reset on
 remove
Message-ID: <20261102222817.GA983941@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031021928.1714612-1-yifan2.li@intel.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 31, 2026 at 10:19:28AM +0800, Li Yifan wrote:
> I225/I226 have a hardware issue: after a PTM dialog, the next device
> reset through the RST bit of the Device Control register (CTRL.RST)

I assume this Device Control is a device-specific register, not the
Device Control in the PCIe Capability, right?

> can make the device send a PTM Request. The device sends it even if
> PTM is disabled in its PTM Control register (PCI config space), the EN
> bit of its PTM_CTRL register (MMIO) is clear

And I guess PTM_CTRL is another device-specific register.  The
architected PTM Enable bit in the PTM Capability in config space is
supposed to be enough to prevent the device from issuing PTM Requests,
so I guess the device-specific control is only relevant because it's
not enough to work around this hardware defect.

> and Bus Master Enable is
> clear, so the driver cannot stop it. Commit c080fe262f9e ("igc: Fix
> possible system crash when loading module") disables PTM before bus
> mastering because of a related issue (PTM Requests with bus mastering
> disabled), but that does not stop the request at CTRL.RST.

c080fe262f9e and this both mention Bus Master Enable, but I don't
think it's relevant to either change.  Bus Master Enable controls
ability to issue Memory and I/O Read/Write Requests.  PTM Requests are
PCIe Messages (not Read/Write Requests) so Bus Master Enable should
not affect them.

If this is a documented erratum, can we include an identifier or a
pointer to it?

> The request is harmless while the upstream port has PTM enabled. Since
> commit e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root
> and Switch Upstream Ports"), pci_disable_ptm() also disables PTM on the
> upstream port when the last user goes away. igc_remove() calls
> pci_disable_ptm() before unregister_netdev(). If the interface is up,
> unregister_netdev() then resets the device through igc_close() ->
> igc_down() -> igc_reset(). The upstream port now handles the PTM
> Request as an Unsupported Request. On an Intel Nova Lake-S system with
> an I226-LM, this triggers DPC on "modprobe -r igc". Recovery fails
> because the driver is unbinding, and the next probe fails:
> 
>   pcieport 0000:80:1d.0: DPC: containment event, status:0x1f01: unmasked uncorrectable error detected
>   pcieport 0000:80:1d.0:    [20] UnsupReq               (First)
>   pcieport 0000:80:1d.0: AER:   TLP Header: 0x34000000 0x81000052 0x00000000 0x00000000
> 
> Message code 0x52 in the TLP header is a PTM Request from 81:00.0.
> 
> Reset the device while the upstream port still has PTM enabled, so
> that the PTM Request gets a response. Then disable PTM and bus
> mastering. With this order, a later reset sends no PTM Request (tested
> on I226-LM). igc_ptp_stop() has already cleared IGC_PTP_ENABLED, so no
> new PTM dialog starts after this reset.

IGC_PTP_ENABLED is just a software flag, and it appears to be related
to PTP, not directly related to PTM, so there are some dots missing
between it and hardware PTM messages.

> If the interface is down,
> unregister_netdev() does not reset the device, so reset it explicitly.
> PTM is still disabled before bus mastering, as the related fix above
> requires.

Which fix requires PTM disable before bus mastering disable?  And why
is that required?

> Skip the reset if the device cannot respond: error recovery is in
> progress or has failed (pci_channel_offline()), the device is gone
> (pci_device_is_present()), or igc_rd32() has already reported "PCIe
> link lost" (IGC_REMOVED()). Otherwise the reset accesses a device in
> error recovery, or polls all-ones register values for about two
> seconds until igc_disable_pcie_master() times out.
> 
> Call pci_disable_ptm() only if PTM is enabled. pci_enable_ptm() can
> fail in probe, for example if the upstream port does not support
> PTM, and probe continues without PTM. The PCI/PTM change above
> also made pci_disable_ptm() use a reference count: it decrements
> dev->ptm_enable_cnt without a check, and then does the same for the
> upstream port. Before, it did nothing if PTM was not enabled. After
> a failed pci_enable_ptm(), the count of the device becomes negative
> and stays negative after the driver unbinds. pcie_ptm_enabled()
> returns true for a negative count, so after the next probe
> igc_is_crosststamp_supported() reports PTM support and igc_ptp_reset()
> starts PTM cycles on a device that does not have PTM enabled. Commit
> 650f197d8ea6 ("idpf: disable PTM on probe failure and on remove")
> adds the same check to idpf.

This sounds like a bug in the PCI core PTM support, i.e., maybe
pci_disable_ptm() should be checking for PTM being enabled?
Otherwise I'm afraid lots of drivers might trip over this.

> Fixes: e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root and Switch Upstream Ports")
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Co-developed-by: Li Lili <lili.li@intel.com>
> Signed-off-by: Li Lili <lili.li@intel.com>
> Signed-off-by: Li Yifan <yifan2.li@intel.com>
> Tested-by: Wang Jie <jie.wang@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index b8ac2f4fea5a..3ee8b05f0515 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -7406,9 +7406,6 @@ static void igc_remove(struct pci_dev *pdev)
>  
>  	igc_ptp_stop(adapter);
>  
> -	pci_disable_ptm(pdev);
> -	pci_clear_master(pdev);
> -
>  	set_bit(__IGC_DOWN, &adapter->state);
>  
>  	timer_delete_sync(&adapter->watchdog_timer);
> @@ -7427,6 +7424,22 @@ static void igc_remove(struct pci_dev *pdev)
>  	igc_release_hw_control(adapter);
>  	unregister_netdev(netdev);
>  
> +	/* After a PTM dialog, I225/I226 can send a PTM Request at the next
> +	 * CTRL.RST, even with PTM and bus mastering disabled on the device.
> +	 * Reset the device while PTM is still enabled on the upstream port,
> +	 * so that the request gets a response. unregister_netdev() resets the
> +	 * device only if the interface was up. Skip the reset if the device
> +	 * cannot respond (error recovery, surprise removal or an earlier
> +	 * "PCIe link lost"). Then disable PTM before bus mastering.
> +	 */
> +	if (!pci_channel_offline(pdev) && pci_device_is_present(pdev) &&
> +	    !IGC_REMOVED(adapter->hw.hw_addr))

All these tests look racy.  .reset_hw() really should be able to
detect and deal with any errors that happen if it tries to access a
device that is no longer responding.

> +		adapter->hw.mac.ops.reset_hw(&adapter->hw);
> +
> +	if (pcie_ptm_enabled(pdev))
> +		pci_disable_ptm(pdev);
> +	pci_clear_master(pdev);

I don't think bus mastering has any connection to PTM, so why are we
moving pci_clear_master()?

>  	igc_clear_interrupt_scheme(adapter);
>  	pci_iounmap(pdev, adapter->io_addr);
>  	pci_release_mem_regions(pdev);
> 
> base-commit: c550c1c9727726dcae121221c252013153fa5945
> -- 
> 2.43.0
> 
