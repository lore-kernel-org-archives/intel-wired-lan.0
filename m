Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC38C021B8
	for <intel-wired-lan@archiver.kernel.org>; Wed, 26 Feb 2025 22:52:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C0CC8222D;
	Wed, 26 Feb 2025 22:52:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id olToBEBv_Wq8; Wed, 26 Feb 2025 22:52:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AC3538230A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1740610340;
	bh=MkQ8uUHQ+uezvHICBEfyNTjs8v7ihKU40F0pUzTSAuA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D04vwTiMbHc0u/TT6Bxr4YhgD1FtKU9/nlrvrbzwtVYE47NKUJ38RCPVLIYdZCoXE
	 XYTQLONe4FECoMaUHsa9QXAcxxrgwhVtPt7rQYziUFYAed635j8AjcyKe8lq7M81ID
	 QC2iLxC/K2fnwP84Pf16uktAFxO6r6L3m+iAQwktMbYzVW9f7Sq1NB6Cxk0i1GefiE
	 2u+H36Bm4SB3WuYCFIu0ozBCVwjzW3NgHiZ1gK8RpixFk+TNQR4NOMT37grSm7tNKa
	 2AKKMKFtdBnhKVjWpOn9L2vYb5EHRDxCC9DwHfENpyEZYuEQ8AsnSdwn/Wvk0qHull
	 DcCwlAIWafSow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC3538230A;
	Wed, 26 Feb 2025 22:52:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CF4B768
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Feb 2025 22:52:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC4FE41336
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Feb 2025 22:52:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aICu_Xhf-Qzv for <intel-wired-lan@lists.osuosl.org>;
 Wed, 26 Feb 2025 22:52:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101;
 helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 692BD4136D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 692BD4136D
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 692BD4136D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Feb 2025 22:52:17 +0000 (UTC)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1tnQG1-000PBp-Ql; Wed, 26 Feb 2025 23:52:01 +0100
Date: Wed, 26 Feb 2025 23:52:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <36ae9886-8696-4f8a-a1e4-b93a9bd47b2f@lunn.ch>
References: <mpearson-lenovo@squebb.ca>
 <20250226194422.1030419-1-mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226194422.1030419-1-mpearson-lenovo@squebb.ca>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=MkQ8uUHQ+uezvHICBEfyNTjs8v7ihKU40F0pUzTSAuA=; b=lI1al3X5MiKMt2ao5EstWg5YTb
 fKd0BT5389tq2N7O8iD/8kGfBWC52DX/SDEOWObN/PSVuJn+jy/ysmwFj9tD/ax8cXw+v5H+c3+p3
 S+oH2uTzJde1ele0RY2yUiqNjdf6OWqAl6yFLrIJtjGVuuso/9hgBw9xTKMaHZcQLKtI=;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=lunn.ch
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256
 header.s=20171124 header.b=lI1al3X5
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: Link flap workaround option
 for false IRP events
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

On Wed, Feb 26, 2025 at 02:44:12PM -0500, Mark Pearson wrote:
> Issue is seen on some Lenovo desktop workstations where there
> is a false IRP event which triggers a link flap.
> Condition is rare and only seen on networks where link speed
> may differ along the path between nodes (e.g 10M/100M)
> 
> Intel are not able to determine root cause but provided a
> workaround that does fix the issue. Tested extensively at Lenovo.
> 
> Adding a module option to enable this workaround for users
> who are impacted by this issue.

Why is a module option needed? Does the workaround itself introduce
issues? Please describe those issues?

In general, module options are not liked. So please include in the
commit message why a module option is the only option.
 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 286155efcedf..06774fb4b2dd 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -37,6 +37,10 @@ static int debug = -1;
>  module_param(debug, int, 0);
>  MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
>  
> +static int false_irp_workaround;
> +module_param(false_irp_workaround, int, 0);
> +MODULE_PARM_DESC(false_irp_workaround, "Enable workaround for rare false IRP event causing link flap");
> +
>  static const struct e1000_info *e1000_info_tbl[] = {
>  	[board_82571]		= &e1000_82571_info,
>  	[board_82572]		= &e1000_82572_info,
> @@ -1757,6 +1761,21 @@ static irqreturn_t e1000_intr_msi(int __always_unused irq, void *data)
>  	/* read ICR disables interrupts using IAM */
>  	if (icr & E1000_ICR_LSC) {
>  		hw->mac.get_link_status = true;
> +
> +		/*
> +		 * False IRP workaround
> +		 * Issue seen on Lenovo P5 and P7 workstations where if there
> +		 * are different link speeds in the network a false IRP event
> +		 * is received, leading to a link flap.
> +		 * Intel unable to determine root cause. This read prevents
> +		 * the issue occurring
> +		 */
> +		if (false_irp_workaround) {
> +			u16 phy_data;
> +
> +			e1e_rphy(hw, PHY_REG(772, 26), &phy_data);

Please add some #define for these magic numbers, so we have some idea
what PHY register you are actually reading. That in itself might help
explain how the workaround actually works.

    Andrew

---
pw-bot: cr
