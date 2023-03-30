Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EB7C761AF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Mar 2023 07:29:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 95B4241DF0;
	Thu, 30 Mar 2023 07:29:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 95B4241DF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1680161359;
	bh=Ew1GtuoF9FHBsWzjomHwmLp+sfDU6R4SBL97gTMF/kg=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=tp5LzWp4Fd3FiTMg0bbS6SRLs29RLPhlZkFptVxf674HSUljIMO59jISOPa2t9D/I
	 19szHixkk+0ZDxP6sWkRUXp/eeLDpX/0EeWizGJrzYgKHXZ2qmHtP3U389iCXytvKj
	 bLc3APLItC61y+owzkzaBkFTJrpiU+IdG1da5/Bm8sP7LQhi4LUUDSP0vYPNRUZf9B
	 YQPOcGD3e/ybMp26u58LLP1+779H8eeOfFOwnThkPtJvCS8Jx1pKPsl0X6HS6Im7P4
	 v2nNRMBs9koRA7295tFSQ7XI8doCvPd3LLWQSkN3cl/YpdnvRvgOU2b3FOsF/cfT4Z
	 K6tSoJbWePhfw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LBfDAZRE6u9N; Thu, 30 Mar 2023 07:29:18 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 956CD41DF2;
	Thu, 30 Mar 2023 07:29:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 956CD41DF2
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 877051BF343
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Mar 2023 07:29:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D47D82065
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Mar 2023 07:29:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D47D82065
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id keg6kympKmkh for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Mar 2023 07:29:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7FBB18204C
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7FBB18204C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Mar 2023 07:29:15 +0000 (UTC)
Received: from [141.14.13.126] (g381.RadioFreeInternet.molgen.mpg.de
 [141.14.13.126])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6BD1A61CC457B;
 Thu, 30 Mar 2023 09:29:12 +0200 (CEST)
Message-ID: <973187a9-6fdf-cdb7-f203-271d28e1543e@molgen.mpg.de>
Date: Thu, 30 Mar 2023 09:29:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To: Andrii Staikov <andrii.staikov@intel.com>
References: <20230330071759.3405263-1-andrii.staikov@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230330071759.3405263-1-andrii.staikov@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net v1] i40e: fix PTP pins verification
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: intel-wired-lan@lists.osuosl.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear Andrii,


Am 30.03.23 um 09:17 schrieb Andrii Staikov:
> Fix PTP pins verification not to contain tainted arguments.
> As a new PTP pins configuration is provided by a user, it
> may contain tainted arguments that are out of bounds for the
> list of possible values that can lead to a potential security threat.
> Change pin's state name from 'invalid' to 'empty' for more
> clarification.

Please use the full line width of 75 characters per line.

Also, how did you test this?

> Fixes: 1050713026a0 ("i40e: add support for PTP external synchronization clock")
> Signed-off-by: Andrii Staikov <andrii.staikov@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_ptp.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index c37abbb3cd06..78e7c705cd89 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -49,7 +49,7 @@ static struct ptp_pin_desc sdp_desc[] = {
>   
>   enum i40e_ptp_gpio_pin_state {
>   	end = -2,
> -	invalid,
> +	empty,
>   	off,
>   	in_A,
>   	in_B,
> @@ -1078,11 +1078,19 @@ static int i40e_ptp_set_pins(struct i40e_pf *pf,
>   	else if (pin_caps == CAN_DO_PINS)
>   		return 0;
>   
> -	if (pins->sdp3_2 == invalid)
> +	if ((pins->sdp3_2 < empty || pins->sdp3_2 > out_B) ||
> +	    (pins->sdp3_3 < empty || pins->sdp3_3 > out_B) ||
> +	    (pins->gpio_4 < empty || pins->gpio_4 > out_B)) {
> +		dev_warn(&pf->pdev->dev,
> +			 "The provided PTP configuration set contains meaningless values that may potentially pose a safety threat.\n");

Would it be better to tell the user the wrong argument?

> +		return -EPERM;
> +	}
> +
> +	if (pins->sdp3_2 == empty)
>   		pins->sdp3_2 = pf->ptp_pins->sdp3_2;
> -	if (pins->sdp3_3 == invalid)
> +	if (pins->sdp3_3 == empty)
>   		pins->sdp3_3 = pf->ptp_pins->sdp3_3;
> -	if (pins->gpio_4 == invalid)
> +	if (pins->gpio_4 == empty)
>   		pins->gpio_4 = pf->ptp_pins->gpio_4;
>   	while (i40e_ptp_pin_led_allowed_states[i].sdp3_2 != end) {
>   		if (pins->sdp3_2 == i40e_ptp_pin_led_allowed_states[i].sdp3_2 &&


Kind regards,

Paul
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
