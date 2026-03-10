Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42BDFD2D63
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Mar 2026 12:00:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84D4B41F66;
	Tue, 10 Mar 2026 12:00:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rQ4icWbl3WlG; Tue, 10 Mar 2026 12:00:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 41BA341EC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773144056;
	bh=L9hRDnDmBV4Oj9bEKMLXjPzsJ5AxOneSjtJ/nzdb/TA=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cr24Yi03fizXbY/4sIlZkWgEcShFTjogYTlXERuh/ADdBqJG1DN95gE+C7WXYBSYN
	 JyJNYQRSmHFuO9eW3G4BPBSpS7FofCcxJs+gUYxTKtrECdC940qM7P4+yr6pb5uGJg
	 Es43d1IcJCsG+Kfonw4bAZoLIW882wSbAf9kwIkWJ0XxKEktN7FnA7On+MqHaeShAg
	 x7ZaBAjoZ8kfltWKBKhAotYt+JjpKteH0flmgqtRxwsPtvfkMUNgD1CXDAtp9+hKIc
	 OBId6Mjeeqhn+Jx9JfPXBJ0z3seyL/ba3p2s3BjvKDugTsBhMhHKwiL6etD7IErqsZ
	 OljJXfmlchFJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41BA341EC0;
	Tue, 10 Mar 2026 12:00:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C63DC201
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:00:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B851960B75
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:00:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FPo5l5mrMPUm for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Mar 2026 12:00:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A5AA260B3C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A5AA260B3C
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A5AA260B3C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:00:47 +0000 (UTC)
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6DA9E4C4431ED8;
 Tue, 10 Mar 2026 13:00:11 +0100 (CET)
Message-ID: <3ce98bb7-273e-4b90-ab28-8679c53d5c90@molgen.mpg.de>
Date: Tue, 10 Mar 2026 13:00:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jakub Ramaseuski <jramaseu@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 przemyslaw.korba@intel.com
References: <20260310115556.1004263-1-jramaseu@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260310115556.1004263-1-jramaseu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: enable NETIF_F_HW_CSUM
 for GSO packets
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

Dear Jakub,


Thank you for your patch.

Am 10.03.26 um 12:55 schrieb Jakub Ramaseuski:
> IPv4 over IPv6 GRE currently fails on E810 with skb_warn_bad_offload,
> while IPv6 over IPv6 GRE falls back to software segmentation.
> This happens because the kernel's GSO engine requires the generic HW_CSUM
> flag to trust the hardware with complex encapsulation offloads.
> 
> Add NETIF_F_HW_CSUM to the device's csumo_features to satisfy the network
> stack and unlock full hardware segmentation for GRE tunnels.
> To prevent checksum corruption on standard traffic, evaluate the packet
> in ice_features_check() and dynamically clear the NETIF_F_HW_CSUM bit
> if it is not a GSO frame. This forces the driver to fall back to safe,
> protocol-specific checksum features for non-GSO packets
> while preserving the generic offload for tunnels.

Do you have a test case, you could document in the commit message?

> Signed-off-by: Jakub Ramaseuski <jramaseu@redhat.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_main.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index e7308e381e2f..9b4ad03e1a32 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3565,6 +3565,7 @@ void ice_set_netdev_features(struct net_device *netdev)
>   
>   	csumo_features = NETIF_F_RXCSUM	  |
>   			 NETIF_F_IP_CSUM  |
> +			 NETIF_F_HW_CSUM  |

Should this be sorted?

>   			 NETIF_F_SCTP_CRC |
>   			 NETIF_F_IPV6_CSUM;
>   
> @@ -9789,6 +9790,14 @@ ice_features_check(struct sk_buff *skb,
>   	if (skb->ip_summed != CHECKSUM_PARTIAL)
>   		return features;
>   
> +	/* Hardware requires strictly-typed Tx descriptors for non-GSO frames.
> +	 * Leaving generic NETIF_F_HW_CSUM enabled corrupts checksums,
> +	 * causing TCP drops. We strip it here to force safe,
> +	 * protocol-specific IPv4/IPv6 offloads instead.
> +	 */
> +	if (!gso)
> +		features &= ~NETIF_F_HW_CSUM;
> +
>   	/* We cannot support GSO if the MSS is going to be less than
>   	 * 64 bytes. If it is then we need to drop support for GSO.
>   	 */

The diff looks good.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
