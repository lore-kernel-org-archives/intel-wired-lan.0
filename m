Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B9BCD5BAC
	for <intel-wired-lan@archiver.kernel.org>; Thu, 21 May 2026 15:46:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9BE7A61AD7;
	Thu, 21 May 2026 15:46:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V3-utVj1P6Ko; Thu, 21 May 2026 15:46:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C142261AD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779378400;
	bh=ssft/NzfZRZcfj5PrYHp1lVFl4VZcEXN3GWhU7p5eT0=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rcDv8qXRjOQ6wUcO12NzD7lGHY6Nn1eYPyuF8aDE3vM54yP7MboKFqYmH6GhL/H2o
	 Kku3oRJUSjHuEPtgKC3PfR8Gc++074YGfQhmfbfsMMxKSdzgoODG3AX2vvsMgrlfkB
	 bf5NOYctTYoEEkANIRqFqr0UjO4SjVykPgfKNwcamCQC3aXh9pIpjxFX9OIZJi5XGZ
	 NDkcd3yNE2Uiicu8RS53XjFgIrpQo8vVJHXLTx0SAE8H21HVOEEHOn9B0bcLlE1BXU
	 gjRqVRuHuJSVau2m1pwWODckoI8s4im+1imPmGwpLXKCIWnVEuUgrYJN6Sxd94JvcB
	 SQ4ozlAzy3Gwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C142261AD1;
	Thu, 21 May 2026 15:46:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 74757D3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 May 2026 12:28:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65B43844BB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 May 2026 12:28:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4CF9ce1Nn3I7 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 21 May 2026 12:28:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=maxime.chevallier@bootlin.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 717C684499
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 717C684499
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 717C684499
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 May 2026 12:28:22 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id D4B364E42D0D;
 Thu, 21 May 2026 12:28:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A82E960495;
 Thu, 21 May 2026 12:28:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5E2FF107E8B67; 
 Thu, 21 May 2026 14:28:13 +0200 (CEST)
Message-ID: <45efcb6b-a439-4b38-8214-1c2f4f6808e9@bootlin.com>
Date: Thu, 21 May 2026 14:28:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ashwin Gundarapu <linuxuser509@zohomail.in>,
 "anthony.l.nguyen@intel.com" <przemyslaw.kitszel@intel.com>,
 andrewnetdev <andrew+netdev@lunn.ch>, davem <davem@davemloft.net>,
 edumazet <edumazet@google.com>, kuba <kuba@kernel.org>,
 pabeni <pabeni@redhat.com>
Cc: intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <19e49280392.4757403170773.5767589851918809405@zohomail.in>
Content-Language: en-US
In-Reply-To: <19e49280392.4757403170773.5767589851918809405@zohomail.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 21 May 2026 15:46:39 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bootlin.com; s=dkim; 
 t=1779366498; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=ssft/NzfZRZcfj5PrYHp1lVFl4VZcEXN3GWhU7p5eT0=;
 b=XMAaPR8sLQ6fkvdLebTrLGWSJ0Nx34Ps+wEUDK4b1XlIUkwwL6VucJXFMXfRGHhv3aktkf
 BGYq5Ox4jW/JY4wwc7BTCLBOsK3n6l/6j7FEaeolQznYC/z2ujWjCtK+edYWA1pE4WDh3G
 pFepQjhbczEuZBF2kQcz+ZmoQwdW7By0MZY/xwoEVZY2M3ESYBgwzY4xS/YkRqbTinpVMM
 Ped1YehsGbA0SLIHjSGgcrGTUc8ZqOLPzvdjoldIuAQlUJ2V5/Z6natwwnYhpEZ2LGcemq
 QYB9Yoxs3lWeCIZsIFGLFssocsiNB4x6rvqfD3dQchNly7NCf+nq3/ITgCK62g==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=bootlin.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=XMAaPR8s
Subject: Re: [Intel-wired-lan] [PATCH net-next] net: e100: replace silent
 'hope for the best' with debug message
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
From: Maxime Chevallier via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi,

On 5/21/26 08:10, Ashwin Gundarapu wrote:
> From: Ashwin Gundarapu <linuxuser509@zohomail.in>
> Date: Sun, 10 May 2026 15:09:12 +0530
> Subject: [PATCH] net: e100: replace silent 'hope for the best' with debug
>   message
> 
> Replace a silent return with a debug message when no MII PHY is
> detected on known variants. This gives users visibility into the
> failure instead of silently hoping for the best.

It's not silent actually, e100_phy_check_without_mii() already prints a 
message when returning 1.

Not sure this patch achieves anything meaningful...

Maxime

> 
> Found by checkpatch.pl inspection.
> 
> Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
> ---
>   drivers/net/ethernet/intel/e100.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
> index 9074b558de35..bfacf877ca40 100644
> --- a/drivers/net/ethernet/intel/e100.c
> +++ b/drivers/net/ethernet/intel/e100.c
> @@ -1450,7 +1450,9 @@ static int e100_phy_init(struct nic *nic)
>   		 * But do this AFTER MII checking only, since this does
>   		 * lookup of EEPROM values which may easily be unreliable. */
>   		if (e100_phy_check_without_mii(nic))
> -			return 0; /* simply return and hope for the best */
> +                        netif_dbg(nic, probe, nic->netdev,
> +                                  "No MII PHY detected, continuing anyway\n");
> +                        return 0;
>   		else {
>   			/* for unknown cases log a fatal error */
>   			netif_err(nic, hw, nic->netdev,

