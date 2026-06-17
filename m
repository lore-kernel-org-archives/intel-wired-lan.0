Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D139ACD98E2
	for <intel-wired-lan@archiver.kernel.org>; Wed, 17 Jun 2026 09:44:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7177440910;
	Wed, 17 Jun 2026 09:44:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QbX2AshDwNwH; Wed, 17 Jun 2026 09:44:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C97324093F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781689448;
	bh=k74zDYNsIHMKvFenq5Y945axJ1MFbmkTfoPjO5NmnpI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UQGBp+Rlq8azQFVxoqnx55otkoP2QDtMuW8dYgl2/MNU0kSE1D3SU+cPfIuXCj+fU
	 BNA7xO0HTcMObVNzQJH/tVoy+kYWh0yeIg5Bu1nPHW5DzQG2BCfQ86Wct5CXHISNl5
	 dIwuW2fCWIl1larrsVmAfv3CW1kuCdhw6ljhJ7IK1YQke0DH/kUKCXQHOT1gatiMjH
	 P25hl3SsDhIbDq4+f+qs2GxtRVnf0mtn7KJY+iQtRJFTz/KHMMhNkvVaHCCiFbLeWC
	 2mwGBTjLSjlzaIvVizc3R/6DlBAoBuzYqlYRyYjb1qNnN29Opt4hfbqjBrdr89HMWB
	 ZizA81/94T02g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C97324093F;
	Wed, 17 Jun 2026 09:44:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 55A69347
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 Jun 2026 09:44:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 38D1D40910
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 Jun 2026 09:44:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ug8gdoRv_rfU for <intel-wired-lan@lists.osuosl.org>;
 Wed, 17 Jun 2026 09:44:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101;
 helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4DBB44091E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4DBB44091E
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4DBB44091E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 Jun 2026 09:44:06 +0000 (UTC)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1wZmoT-0089tB-LK; Wed, 17 Jun 2026 11:44:01 +0200
Date: Wed, 17 Jun 2026 11:44:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Message-ID: <9befcf6b-a20b-4e2a-8d22-1bcf1a7460d8@lunn.ch>
References: <20260617084329.199110-1-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617084329.199110-1-sergey.temerkhanov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=k74zDYNsIHMKvFenq5Y945axJ1MFbmkTfoPjO5NmnpI=; b=ZMUC71+bhO8Z0xj37TQV8CRqMC
 iKR5RMZTw3EPnHkgzm42OxSq9vInMJX6kUHZjldFGEV6qu4M8TrasdodNuanotzZ63Mj3YuzcngtL
 dCVD5L8DLDGK7QOqDZM+DgD2Tyww8Ke3mHE0fldiu63qPZKu53xOB2BgI+nx0DRFGGhA=;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=lunn.ch
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=ZMUC71+b
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: Implement PCI
 reset handler
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

> +static void ixgbe_reset_prep(struct pci_dev *pdev)
> +{
> +	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
> +	unsigned int timeout = IXGBE_PCIE_RESET_RETRIES;
> +
> +	if (!adapter)
> +		return;
> +
> +	/* Prevent the service task from being requeued in the timer callback
> +	 * while we're resetting.
> +	 */
> +	if (test_bit(__IXGBE_SERVICE_INITED, &adapter->state)) {
> +		timer_delete_sync(&adapter->service_timer);
> +		/* Prevent the service task from running while we're resetting. */
> +		cancel_work_sync(&adapter->service_task);
> +	}
> +
> +	pci_clear_master(pdev);
> +
> +	while (test_and_set_bit(__IXGBE_RESETTING, &adapter->state) && --timeout)
> +		usleep_range(1000, 2000);

Please consider using something from iopoll.h

> +
> +	if (!timeout) {
> +		e_err(drv, "Timed out waiting for __IXGBE_RESETTING to be released. Reset is needed\n");
> +		pci_set_master(pdev);
> +		return;
> +	}

because this is broken. You need to retest the condition before
declaring ETIMEDOUT.

	Andrew
