Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506BEECD6D6
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Feb 2026 18:29:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09CF261115;
	Wed, 11 Feb 2026 18:29:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FHT9O56nJ10y; Wed, 11 Feb 2026 18:29:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 28672610FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770834554;
	bh=GIZwJCecyRkIlvIX6OKuTc6BX0FU+KsqchZqYOP3fBc=;
	h=Date:From:To:Cc:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=tspLZmnDgaziuvdg4vSNv4vdKWUW8q6Ra/ZehEPbgicT+TDexkwIRXwThD27yCuYp
	 Qfry+mfB/w/vmePAxMEOebsG7mU+/xwDIZ29F326iPZ/eXBFUcFzxe2747ObQ5+qD0
	 cI9INj5OrKj/GcT+7tMtCa2iE2z+ZJgFsrw+YqEAMMyOdY4Z+pp1CYojie0KaWaFZg
	 ziesil8b32QTRucLifg7QIWJYh75my24Xe/QohI/0cgudp5F42UzwW9SIR5H/NgPzE
	 yKop5fXEg3fJbr50hWfTIl0Z+0cXEQ7lXRWokC0ww+88loFLZbRuuQWPCarNHk0J2G
	 hkHSDA4QdMx4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28672610FF;
	Wed, 11 Feb 2026 18:29:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BA95023F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Feb 2026 18:29:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F01D40F66
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Feb 2026 18:29:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DUcSFpbrvJAx for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Feb 2026 18:29:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CE9A340073
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CE9A340073
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CE9A340073
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Feb 2026 18:29:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C475860018;
 Wed, 11 Feb 2026 18:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507CFC4CEF7;
 Wed, 11 Feb 2026 18:29:10 +0000 (UTC)
Date: Wed, 11 Feb 2026 12:29:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Harshank Matkar <harshankmatkar1304@outlook.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "tony.nguyen@intel.com" <tony.nguyen@intel.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20260211182909.GA117627@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260210203332.23200-1-harshankmatkar1304@outlook.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770834550;
 bh=FkTdMrzfnWOa65M7TOxVOTewRFDuBbrSyTDkM7TTM8w=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=ihi46+2ENQiAMifT2Lwhf/yFa/G83yY9BjSdarvUEs+XcVzxfI+w05QH04NLlMp0v
 44hlBE/eE0wfizEO2hpc3uOb9+MU2yNXFctF3UZ14tUxQhcQdGA9ImtLD+ewuTLLcA
 7Gms8XyrzbWAPve/KSNRv5/gHcsC/YWNMqzxlEAQrjNTP+Atlg3RmmhshTFiw+hwRY
 IGqizqdeHOJe4/B7D3oCPwH4+azvPI89LhaJmhtW97tIzFamykfTgd/rmPY/jw/SqF
 jWoxRbhpyre9gOys2dhtDuzF9RoTzddsb6XliZydSW2JA39prYpok2l+VRtNsIO3qE
 9TUrdcrz+HFkw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ihi46+2E
Subject: Re: [Intel-wired-lan] [PATCH] igc: Add PCIe link recovery for
 I225/I226
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

On Tue, Feb 10, 2026 at 08:34:02PM +0000, Harshank Matkar wrote:
> From: Harshank Matkar <harshankmatkar1304@outlook.com>
> 
> When ASPM L0s transitions occur on Intel I225/I226 controllers,
> transient PCIe link instability can cause register read failures
> (0xFFFFFFFF responses).

At the PCIe level, the failure is some uncorrectable PCIe error like a
Completion Timeout or Unsupported Request.  The 0xFFFFFFFF response is
implementation-specific behavior determined by the Root Complex
design.

> Implement a multi-layer recovery strategy:
> 1. Immediate retries: 3 attempts with 100-200μs delays
> 2. Link retraining: Trigger PCIe link retraining via capabilities
> 3. Device detachment: Only as last resort after max attempts
> 
> The recovery mechanism includes rate limiting, maximum attempt
> tracking, and device presence validation to prevent false detaches
> on transient ASPM glitches while maintaining safety through
> bounded retry limits.

I assume the glitch is a hardware erratum and should be documented as
such by Intel, although it's possible ASPM L0s isn't configured
correctly.

If it's a hardware erratum, I think you should use a quirk to disable
L0s on these devices, e.g., pci_disable_link_state(pdev,
PCIE_LINK_STATE_L0S).  Even if this patch allows recovery, the PCIe
errors will be logged and reported via AER, which will be confusing to
users.

Bjorn
