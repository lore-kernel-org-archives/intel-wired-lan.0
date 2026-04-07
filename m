Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A0CFF5125
	for <intel-wired-lan@archiver.kernel.org>; Tue,  7 Apr 2026 16:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22A2360DA0;
	Tue,  7 Apr 2026 16:39:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ySJn25ARIZqu; Tue,  7 Apr 2026 16:39:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF25160D9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775579967;
	bh=NbTBixRqYDlQeL95GG9hAoNz+4WwubnNaEGA+7z76QI=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZIntxKn4DB6jMDNVZ9A0Mm/fAz91IMfJaTOmz1Ee1WTT/pBsXpCOhBGXsfwWFym8Z
	 WAiko9wONpqtkKMEgSzyxoeRbms3urJU8tUmxd+2RUDMVGwkrq8XN5XELsy+Nl6lIX
	 PezXNM47IJhf26u9d1SBUYwciaJ6C1s2xLwT75V9mRciziAdHn5dbsEjvAOQpjRsWD
	 dYtL3yf2UdGwf1ruDS1XrFzyIWd2F6eyEGT8KsdtPQ4vUoZJ1WIziztPEbFH42hxTo
	 WcPE/P3l2hCmwexm8J2ssjDFPvYjaKeIVcjQKngV+z0V/MYcuqSncRE0LGpsUjXEhw
	 GL1rm4XgQFRvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF25160D9B;
	Tue,  7 Apr 2026 16:39:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E95EB1F6
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Apr 2026 16:39:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DAC5F40550
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Apr 2026 16:39:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FdWsQdvW7hIm for <intel-wired-lan@lists.osuosl.org>;
 Tue,  7 Apr 2026 16:39:24 +0000 (UTC)
X-Greylist: delayed 473 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 07 Apr 2026 16:39:23 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E4DC240195
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E4DC240195
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E4DC240195
 for <intel-wired-lan@osuosl.org>; Tue,  7 Apr 2026 16:39:23 +0000 (UTC)
Received: from [192.168.2.229] (p5dc55707.dip0.t-ipconnect.de [93.197.87.7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 15C5C4C2C37D56;
 Tue, 07 Apr 2026 18:31:17 +0200 (CEST)
Message-ID: <c6763568-7773-43af-a43f-dcf6fc4ab0eb@molgen.mpg.de>
Date: Tue, 7 Apr 2026 18:31:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Matt Vollrath <tactii@gmail.com>
Cc: Kohei Enju <kohei@enjuk.jp>, intel-wired-lan@osuosl.org,
 stable@vger.kernel.org
References: <20260407161447.43645-1-tactii@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260407161447.43645-1-tactii@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] i40e: Cleanup PTP pins on
 probe failure
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

Dear Matt,


Thank you for the patch. Should you resend you could spell the verb 
*clean up* with a space:

 > i40e: Clean PTP pins up on probe failure

or

 > i40e: Clean up PTP pins on probe failure

But it’s not important.

Am 07.04.26 um 18:14 schrieb Matt Vollrath:
> PTP pin structs are allocated early in probe, but never cleaned up.
> 
> Fix this by calling i40e_ptp_free_pins in the error path.
> 
> To support this, i40e_ptp_free_pins is added to the header and
> pin_config is correctly nullified after being freed.
> 
> This has been an issue since i40e_ptp_alloc_pins was introduced.
> 
> Fixes: 1050713026a08 ("i40e: add support for PTP external synchronization clock")
> Reported-by: Kohei Enju <kohei@enjuk.jp>
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
>   drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 3 ++-
>   3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index dcb50c2e1aa2..83e780919ac9 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -1318,6 +1318,7 @@ void i40e_ptp_restore_hw_time(struct i40e_pf *pf);
>   void i40e_ptp_init(struct i40e_pf *pf);
>   void i40e_ptp_stop(struct i40e_pf *pf);
>   int i40e_ptp_alloc_pins(struct i40e_pf *pf);
> +void i40e_ptp_free_pins(struct i40e_pf *pf);
>   int i40e_update_adq_vsi_queues(struct i40e_vsi *vsi, int vsi_offset);
>   int i40e_is_vsi_uplink_mode_veb(struct i40e_vsi *vsi);
>   int i40e_get_partition_bw_setting(struct i40e_pf *pf);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 926d001b2150..c7062aa476dd 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -16112,6 +16112,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	i40e_clear_interrupt_scheme(pf);
>   	kfree(pf->vsi);
>   err_switch_setup:
> +	i40e_ptp_free_pins(pf);
>   	i40e_reset_interrupt_capability(pf);
>   	timer_shutdown_sync(&pf->service_timer);
>   err_mac_addr:
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index 404a716db8da..7d07c389bb23 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -940,12 +940,13 @@ int i40e_ptp_hwtstamp_get(struct net_device *netdev,
>    *
>    * Release memory allocated for PTP pins.
>    **/
> -static void i40e_ptp_free_pins(struct i40e_pf *pf)
> +void i40e_ptp_free_pins(struct i40e_pf *pf)
>   {
>   	if (i40e_is_ptp_pin_dev(&pf->hw)) {
>   		kfree(pf->ptp_pins);
>   		kfree(pf->ptp_caps.pin_config);
>   		pf->ptp_pins = NULL;
> +		pf->ptp_caps.pin_config = NULL;
>   	}
>   }

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
