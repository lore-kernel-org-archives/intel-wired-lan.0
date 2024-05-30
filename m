Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94921C25B74
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 May 2024 05:01:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 29A4F402E7;
	Thu, 30 May 2024 05:01:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fs_7V6EUV7JM; Thu, 30 May 2024 05:01:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6FEF840342
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1717045315;
	bh=1gf+zepPW83keDSf8aSkFin4GVSv27YfDUwEsCKcjAA=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=d9b/ssAq3CRjZDZFG1scbKhXKDLJ13CCkSPypFUgIcPDYFwI9ExHVVA2bzbQi8pam
	 eMYjPABmqBvqaaiT9YOlpMg/LAnVJC4ab66bmM2Vlin1O6CD0IbFqYZ5DcJXivuAic
	 M8/ZoSrh0I+UWXpFD7eLkbloyjmF0qOlP7ypDBfus6b01SNknyNQbCrTGXqouSQkZA
	 7rCnPleWf0zHMB8fWUFSDZz/2l7vlm2BjyroSADqv/V8Iwu3Kp4BsyxpU5uw0OHkFy
	 2ifI3VpkdXSPfxOFnBYv0v6KjHD06Oi9q8y11VuJFGoaIaM6E/epTI7Pg1kU+mWCSx
	 Y+oHTMFiWYY7w==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6FEF840342;
	Thu, 30 May 2024 05:01:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 5808E1D41E6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 May 2024 05:01:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4701683774
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 May 2024 05:01:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rRbkt7-goLJF for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 May 2024 05:01:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D612C83641
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D612C83641
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D612C83641
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 May 2024 05:01:50 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5af172.dynamic.kabel-deutschland.de
 [95.90.241.114])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id D219D61E646E6;
 Thu, 30 May 2024 07:01:30 +0200 (CEST)
Message-ID: <ee16afbe-83a0-4149-a987-6895968e3720@molgen.mpg.de>
Date: Thu, 30 May 2024 07:01:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Karen Ostrowska <karen.ostrowska@intel.com>
References: <20240529071736.224973-1-karen.ostrowska@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240529071736.224973-1-karen.ostrowska@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ice: Rebuild TC queues on
 VSI queue reconfiguration
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
Cc: Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org,
 Jan Sokolowski <jan.sokolowski@intel.com>, intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear Karen, dear Jan,


Thank you for the patch.

Am 29.05.24 um 09:17 schrieb Karen Ostrowska:
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> TC queues needs to be correctly updated when the number of queues on

need

> a VSI is reconfigured, so netdev's queue and TC settings will be
> dynamically adjusted and could accurately represent the underlying
> hardware state after changes to the VSI queue counts.

Please document the test configuration, and how to test/verify your change.

> Fixes: 0754d65bd4be ("ice: Add infrastructure for mqprio support via ndo_setup_tc")
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Signed-off-by: Karen Ostrowska <karen.ostrowska@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_main.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 1b61ca3a6eb6..a1798ec4d904 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -4136,7 +4136,7 @@ bool ice_is_wol_supported(struct ice_hw *hw)
>   int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
>   {
>   	struct ice_pf *pf = vsi->back;
> -	int err = 0, timeout = 50;
> +	int i, err = 0, timeout = 50;

unsigned int

>   	if (!new_rx && !new_tx)
>   		return -EINVAL;
> @@ -4162,6 +4162,14 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
>   
>   	ice_vsi_close(vsi);
>   	ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> +
> +	ice_for_each_traffic_class(i) {
> +		if (vsi->tc_cfg.ena_tc & BIT(i))
> +			netdev_set_tc_queue(vsi->netdev,
> +					    vsi->tc_cfg.tc_info[i].netdev_tc,
> +					    vsi->tc_cfg.tc_info[i].qcount_tx,
> +					    vsi->tc_cfg.tc_info[i].qoffset);
> +	}
>   	ice_pf_dcb_recfg(pf, locked);
>   	ice_vsi_open(vsi);
>   done:


Kind regards,

Paul
