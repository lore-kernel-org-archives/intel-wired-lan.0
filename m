Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BA0EA3F3A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Feb 2026 11:12:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CE85610F0;
	Tue, 10 Feb 2026 11:12:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6whhRPkUVCSJ; Tue, 10 Feb 2026 11:12:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E007361105
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770721929;
	bh=lb6xVqeWhfFobngLJakxEWMs+Af5xacOPJXzXdDJ9+A=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jNRfziUzpLVDRiSG6eW6u3VjglDrCUbD2NZ7Lz31yYdbmjm8Cczp08sTHojP7/JVE
	 rJI4tRxYOBJ/b90IIs9+D3KMT8Yj4s+xyfRkoPNHc3satAEa/mg1c1orBJeO1BwJ/t
	 LDhXHfeZfuoFnAXiaca54WX0/5FCWh3T+tvNUbr8GJY52vyoGLo9rn53xmzo5KAgFK
	 C4cA9WpavH7bhC1GAFEPGml/9noanIaLdmNwYo3Xx2nsz+NwpWz0pE/3cAxn//CE4e
	 iIeApHTookoJdub70ovrX/wa75cD2/09h2WE9VZ8xAh7Auty6S4MfUqtJmngPkTrhK
	 rRb8EMfdxo9Dg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E007361105;
	Tue, 10 Feb 2026 11:12:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BD17BF2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Feb 2026 11:12:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BAE4740CAC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Feb 2026 11:12:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NU-gjcIHnK38 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Feb 2026 11:12:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.167.43;
 helo=mail-lf1-f43.google.com; envelope-from=timo.teras@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3490741185
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3490741185
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3490741185
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Feb 2026 11:12:05 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-59e4a04f054so835155e87.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Feb 2026 03:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770721923; x=1771326723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lb6xVqeWhfFobngLJakxEWMs+Af5xacOPJXzXdDJ9+A=;
 b=qnw+wMx8Aup3vkd0K2cdmIOjRaPwJqcZKd/9JYU7VWMVUjD0fmIS6ROSG5/0yS4xBg
 LCKurMx9tIPSqASZY3M6yOo9aXuoC+QuptraWFEHygx3TXczCI1jE/wmmKSdF+qugjJq
 KUOv7mutSx7OiNQ0F+CTfhu4fTEliGKuhy7VxMxLNYTNWNMmjZ0euJR0MXMkGnwJbiRW
 eS459IM/nFWhf6gu38ckiwABfQ3bYr+FV6TKaDcTYcldNALW4ta81HU2GG2UyEHXfENI
 7Myqyo7AYmiaYIHGIPKQ8/qqofuKn4O64HuxGUiWC6mDUiuWMg42m+523j/353QH65kQ
 kxmA==
X-Gm-Message-State: AOJu0YzG7NsnOiMhHHqeWr5j4g1A/KfdG3AvKvK5GXqKMFfxtBiL8Nme
 kGDN0Pv11NYWCvRtmQ73YE6iujQysLFFTrdRZQ1D79fEGXDIttCN9vAB
X-Gm-Gg: AZuq6aL5py1sa1dTP0yhCYcDJnP5HN+wkP+yUs4EEfZhQr0hCMUXEdEKCKY82S6wjQf
 up5B1J5QUFNMPi0ZN3gTdh0CDkd/hEHCfyHFGdKl/wJNV16K6QXTLUEiqfCq6UxeghkShSpQS5y
 O31SuOqr7Yedvn0Iqr43KzBTI2IcnDZIiAaCSeu6b421KdjGdxMd89hVjZJqltrnQFU4mQdARiG
 JB7UF+NrTL0F1RSHrA8ahGprbcd4mo8PjZ/PMJlv4G97F4HOkEPLtDeTRAi+lmGOAryPjDRfAV5
 08LnpYpCp8KLvlI3Ofpb83II3ke4WXiaNEq10BbagmI6rpyYxMF1/L5Llu0Uyr2kBAlQTQbU3Eo
 mvJn/K5TR8uTJUXqqv3ydrQnuUHP8y+nLL51JRFSQ88+lvTp/a6VUgJyDfYAcT6ZfRAJW3mNEln
 vQvpfO+laQYIJCOXpvKgIcWtofLU5vp4pAykt69ifc0XtxBHKb1HttTB7E
X-Received: by 2002:a05:6512:3c86:b0:59e:3910:f2d4 with SMTP id
 2adb3069b0e04-59e451641admr4616216e87.50.1770721922405; 
 Tue, 10 Feb 2026 03:12:02 -0800 (PST)
Received: from onyx.my.domain (85-76-115-16-nat.elisa-mobile.fi.
 [85.76.115.16]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e44cf6f7dsm3172698e87.12.2026.02.10.03.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 03:12:02 -0800 (PST)
Date: Tue, 10 Feb 2026 13:11:58 +0200
From: Timo Teras <timo.teras@iki.fi>
To: Vitaly Lifshits <vitaly.lifshits@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, marmarek@invisiblethingslab.com,
 jeremie.wenger@edu.ge.ch
Message-ID: <20260210131158.1055ad48@onyx.my.domain>
In-Reply-To: <20260202103257.1972097-1-vitaly.lifshits@intel.com>
References: <20260202103257.1972097-1-vitaly.lifshits@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-alpine-linux-musl)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=iki.fi
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 1/1] e1000e: reconfigure
 PLL clock gate value and re-enable K1 on Meteor Lake
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

Hi

This seems to retrigger the malfunction on a Dell Pro 16 Plus PB16250 laptop.

CPU Interl Core Ultra 5 235U
CPU family 6 model 181 stepping 0

Please advise if you can reproduce or suggest alternative fix?

Thanks,
Timo

On Mon,  2 Feb 2026 12:32:57 +0200
Vitaly Lifshits <vitaly.lifshits@intel.com> wrote:

> Commit 3c7bf5af21960 ("e1000e: Introduce private flag to disable K1")
> disabled K1 by default on Meteor Lake and newer systems due to packet
> loss observed on various platforms. However, disabling K1 caused an
> increase in power consumption due to blocking PC10 state.
> 
> To mitigate this, reconfigure the PLL clock gate value so that K1 can
> remain enabled without incurring the additional power consumption.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220954
> Fixes: 3c7bf5af21960 ("e1000e: Introduce private flag to disable K1")
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> ---
> v2: add comment for the PLL timeout value and revisit the commit message
> v1: initial version
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 6 ++++++
>  drivers/net/ethernet/intel/e1000e/netdev.c  | 3 ---
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index 13841daba399..8e88aa9048da 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -1594,6 +1594,12 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
>  			phy_reg &= ~I217_PLL_CLOCK_GATE_MASK;
>  			if (speed == SPEED_100 || speed == SPEED_10)
>  				phy_reg |= 0x3E8;
> +			else if (hw->mac.type == e1000_pch_mtp ||
> +				 hw->mac.type == e1000_pch_ptp)
> +				/* Increase PLL clock gate timeout to avoid
> +				 * packet loss
> +				 */
> +				phy_reg |= 0x1D5;
>  			else
>  				phy_reg |= 0xFA;
>  			e1e_wphy_locked(hw, I217_PLL_CLOCK_GATE_REG, phy_reg);
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 82d1d5fe51d5..8f0eb822610b 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -7755,9 +7755,6 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	/* init PTP hardware clock */
>  	e1000e_ptp_init(adapter);
>  
> -	if (hw->mac.type >= e1000_pch_mtp)
> -		adapter->flags2 |= FLAG2_DISABLE_K1;
> -
>  	/* reset the hardware with the new settings */
>  	e1000e_reset(adapter);
>  

