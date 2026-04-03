Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93B8D730BD
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Apr 2026 08:09:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66084606A3;
	Fri,  3 Apr 2026 08:09:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jKpqUjpbxd0T; Fri,  3 Apr 2026 08:09:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 16E9560681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775203797;
	bh=MbjhZi2bJN9+5VnBpc6vE+kn+nwe3T1CIFQtDNtzAsc=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=plpYnigP8Dso7hKRUmxjBGjtTLlQP57XJcDBbH1uHRphvP6K6AByHWVDAQqC3Uqki
	 NK+AvKLJJCvK3WtXrXwnmwXbRglXGgvj6cJOSHXkQ3RA5kGUkzXntMYSHkRqW+Lm5b
	 WqZWcsrJ/c42TXkUiebDZuXInhTDYdRtTVqVced86i+Tqs+vZW6OoilTLU4YxtY1Dr
	 cfvx+mlHA7h4xSnIaS1RY89HlPJVNQFMobE1cQeaB+2O64lBbFx147xaxvbsABjz53
	 1ltakIxt5XYNOAYyIXCM91LGngk8Xtm97F0cdmS89oNPYbzpooTO4T6lGBiK6lUaN9
	 G7P2EGhO3eJSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16E9560681;
	Fri,  3 Apr 2026 08:09:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DCF11A9
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 08:09:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8F0F160639
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 08:09:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NlR60oMSXfnN for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Apr 2026 08:09:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E5E7F606A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E5E7F606A3
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E5E7F606A3
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 08:09:52 +0000 (UTC)
Received: from [192.168.2.229] (p57bd9728.dip0.t-ipconnect.de [87.189.151.40])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 169814C2C37D58;
 Fri, 03 Apr 2026 10:09:36 +0200 (CEST)
Message-ID: <3013fbbd-74ef-4636-9a18-5c35c4e8dd04@molgen.mpg.de>
Date: Fri, 3 Apr 2026 10:09:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Leszek Pepiak <leszek.pepiak@intel.com>
References: <20260403054321.3791392-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260403054321.3791392-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH net-next] iavf: fix kernel-doc comment
 style in ethtool ops
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

Dear Leszek, dear Aleksandr,


Thank you for the patch.

Am 03.04.26 um 07:43 schrieb Aleksandr Loktionov:
> From: Leszek Pepiak <leszek.pepiak@intel.com>
> 
> iavf_get_channels() and iavf_set_channels() use the legacy `**/`
> comment terminator and embed the return description in the body text.
> Convert to proper kernel-doc style: single `*/` terminator and an
> explicit `Return:` section.
> 
> Signed-off-by: Leszek Pepiak <leszek.pepiak@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> ---
>   drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> index 8188dd4..425acbb 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> @@ -1846,13 +1846,13 @@ static int iavf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
>   	return ret;
>   }
>   /**
> - * iavf_get_channels: get the number of channels supported by the device
> + * iavf_get_channels - get the number of channels supported by the device
>    * @netdev: network interface device structure
>    * @ch: channel information structure
>    *
>    * For the purposes of our device, we only use combined channels, i.e. a tx/rx
>    * queue pair. Report one extra channel to match our "other" MSI-X vector.
> - **/
> + */
>   static void iavf_get_channels(struct net_device *netdev,
>   			      struct ethtool_channels *ch)
>   {
> @@ -1873,14 +1873,15 @@ static void iavf_get_channels(struct net_device *netdev,
>   }
>   
>   /**
> - * iavf_set_channels: set the new channel count
> + * iavf_set_channels - set the new channel count
>    * @netdev: network interface device structure
>    * @ch: channel information structure
>    *
>    * Negotiate a new number of channels with the PF then do a reset.  During
> - * reset we'll realloc queues and fix the RSS table.  Returns 0 on success,
> - * negative on failure.
> - **/
> + * reset we'll realloc queues and fix the RSS table.
> + *
> + * Return: 0 on success, negative on failure.
> + */
>   static int iavf_set_channels(struct net_device *netdev,
>   			     struct ethtool_channels *ch)
>   {

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
