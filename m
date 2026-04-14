Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CA9F9D0D3
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Apr 2026 15:22:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 670EA42ABC;
	Tue, 14 Apr 2026 15:22:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9RSdzOrzhtD2; Tue, 14 Apr 2026 15:22:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A298742ABB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776180168;
	bh=KS45GNRgOtw6kPaEsEXt8bD9u+4+IV8D7TszSgCsXP0=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o9LLBg77cWCYkxXt5+sUV2C/Sgy+UzJBlS7r7FY9+gB9mvEEH3QJA546nWBeHNxTM
	 h6vqV3IdzkWOOU3XUPbfFYFZsYehsJpe/fdjGcACdHa8S6ZSiCwpAMFJ/RUeaZFFt3
	 2BaDN7jogKYtJNYVaz/PxJh01bfWo/YLcKD6ZF1xLfj6AzXpMXyewxbtgCiuenx0Sm
	 u9oZqbmhPPmOaKPKILX9hc4yeWbxSEGJH/h0Eew4vYmTstSMZeCs0dDxWkIrBDIFM/
	 Z2ZKnaId8Y4Q6g5FHuVNi3vTy9ORjGScVMc0MVRqLrtr7uCNv+PZY84AlQC2USy0og
	 eyz6a122KGhug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A298742ABB;
	Tue, 14 Apr 2026 15:22:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AFF90375
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 15:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9BFB784420
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 15:22:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X6QLNp7aI8KP for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Apr 2026 15:22:46 +0000 (UTC)
X-Greylist: delayed 545 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 14 Apr 2026 15:22:45 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D684984406
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D684984406
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net;
 envelope-from=lukas@wunner.de; receiver=<UNKNOWN> 
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net
 [IPv6:2a01:37:3000::53df:4ee9:0])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D684984406
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 15:22:45 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net
 [IPv6:2a01:37:1000::53df:5f1c:0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
 client-signature ECDSA (secp384r1) client-digest SHA384)
 (Client CN "*.hostsharing.net",
 Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
 by mailout2.hostsharing.net (Postfix) with ESMTPS id 8EB0410586;
 Tue, 14 Apr 2026 17:13:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id 6E6506034192; Tue, 14 Apr 2026 17:13:36 +0200 (CEST)
Date: Tue, 14 Apr 2026 17:13:36 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com, jay.bhat@intel.com,
 ivan.d.barrera@intel.com, aleksandr.loktionov@intel.com,
 larysa.zaremba@intel.com, anthony.l.nguyen@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, aleksander.lobakin@intel.com,
 linux-pci@vger.kernel.org, madhu.chittim@intel.com,
 decot@google.com, willemb@google.com, sheenamo@google.com
Message-ID: <ad5ZoDCuSsPW0lKo@wunner.de>
References: <20260414031631.2107-1-emil.s.tantilov@intel.com>
 <20260414031631.2107-3-emil.s.tantilov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414031631.2107-3-emil.s.tantilov@intel.com>
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=wunner.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 2/2] idpf: implement pci
 error handlers
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

On Mon, Apr 13, 2026 at 08:16:31PM -0700, Emil Tantilov wrote:
> +static pci_ers_result_t
> +idpf_pci_err_slot_reset(struct pci_dev *pdev)
> +{
> +	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
> +
> +	pci_restore_state(pdev);
> +	pci_set_master(pdev);
> +	pci_wake_from_d3(pdev, false);
> +	if (readl(adapter->reset_reg.rstat) != 0xFFFFFFFF)
> +		return PCI_ERS_RESULT_RECOVERED;

FWIW, there's a PCI_POSSIBLE_ERROR() helper that you may find useful
to check for an "all ones" MMIO read.

Thanks,

Lukas
