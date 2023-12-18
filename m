Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABE2C46CCD
	for <intel-wired-lan@archiver.kernel.org>; Mon, 18 Dec 2023 15:08:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D90A981E6E;
	Mon, 18 Dec 2023 15:08:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D90A981E6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702912117;
	bh=M4C1ZsD/dwjNqui+UwZy1ZuVNUVHF3mI1HH401pHulQ=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=dRAGnAtO4oVU0tEs6hGiaavA9tt47ZPhrvJbBT3Cgig6EjsFdxepxBmPSNvQWalz5
	 4TGFVEK7Vd82RkuDsmSHL0Ap/JdBVDUNikabJuO1/G1NvElhrkIbLAIPNYOe8jjFD6
	 rIQ4ox5Wy8cqblEdwk0z7dHxlCRmRtJo49eTI/Nzeo4mZunKpprGghQ3z/+bfSP0qh
	 ZmnG5CjW50wXk9RmZkpyXDnPfW5LhfqHOgEDY9fS3I/HrolYVZUEITWtjoCKgK8bZx
	 0UawZyXIoyXJwh9pbVA/p+4QzJZQh1Zq6xH2lA6ENUoRTiYesG6uYk7P/zVXU6yDPR
	 NqIqZX+Sxm15Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XiYUN1rATGKJ; Mon, 18 Dec 2023 15:08:37 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id D279281E6F;
	Mon, 18 Dec 2023 15:08:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D279281E6F
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id E99421BF345
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 Dec 2023 15:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B4F0840A4B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 Dec 2023 15:08:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B4F0840A4B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qepPsmVEbfCS for <intel-wired-lan@lists.osuosl.org>;
 Mon, 18 Dec 2023 15:08:32 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD47740A15
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 Dec 2023 15:08:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD47740A15
Received: from [141.14.220.40] (g40.guest.molgen.mpg.de [141.14.220.40])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id DFF1861E5FE04;
 Mon, 18 Dec 2023 16:07:03 +0100 (CET)
Message-ID: <de9b8611-98c2-48f4-b096-4bb07e133138@molgen.mpg.de>
Date: Mon, 18 Dec 2023 16:07:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
References: <20231218145855.3605898-1-arkadiusz.kubalewski@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20231218145855.3605898-1-arkadiusz.kubalewski@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: dpll: fix phase
 offset value
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
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear Arkadiusz,


Am 18.12.23 um 15:58 schrieb Arkadiusz Kubalewski:
> Stop dividing the phase_offset value received from firmware. This fault
> is present since the initial implementation.
> The phase_offset value received from firmware is in 0.01ps resolution.
> Dpll subsystem is using the value in 0.001ps, raw value is adjusted
> before providing it to the user.
> 
> The user can observe the value of phase offset with response to
> `pin-get` netlink message of dpll subsystem for an active pin:
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
> 	--do pin-get --json '{"id":2}'
> 
> Where example of correct response would be:
> {'board-label': 'C827_0-RCLKA',
>   'capabilities': 6,
>   'clock-id': 4658613174691613800,
>   'frequency': 1953125,
>   'id': 2,
>   'module-name': 'ice',
>   'parent-device': [{'direction': 'input',
>                      'parent-id': 6,
>                      'phase-offset': -216839550,
>                      'prio': 9,
>                      'state': 'connected'},
>                     {'direction': 'input',
>                      'parent-id': 7,
>                      'phase-offset': -42930,
>                      'prio': 8,
>                      'state': 'connected'}],
>   'phase-adjust': 0,
>   'phase-adjust-max': 16723,
>   'phase-adjust-min': -16723,
>   'type': 'mux'}
> 
> Provided phase-offset value (-42930) shall be divided by the user with
> DPLL_PHASE_OFFSET_DIVIDER to get actual value of -42.930 ps.
> 
> Before the fix, the response was not correct:
> {'board-label': 'C827_0-RCLKA',
>   'capabilities': 6,
>   'clock-id': 4658613174691613800,
>   'frequency': 1953125,
>   'id': 2,
>   'module-name': 'ice',
>   'parent-device': [{'direction': 'input',
>                      'parent-id': 6,
>                      'phase-offset': -216839,
>                      'prio': 9,
>                      'state': 'connected'},
>                     {'direction': 'input',
>                      'parent-id': 7,
>                      'phase-offset': -42,
>                      'prio': 8,
>                      'state': 'connected'}],
>   'phase-adjust': 0,
>   'phase-adjust-max': 16723,
>   'phase-adjust-min': -16723,
>   'type': 'mux'}
> 
> Where phase-offset value (-42), after division
> (DPLL_PHASE_OFFSET_DIVIDER) would be: -0.042 ps.

Thank you for the detailed description.

> Fixes: 8a3a565ff210 ("ice: add admin commands to access cgu configuration")
> Fixes: 90e1c90750d7 ("ice: dpll: implement phase related callbacks")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_common.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 9a6c25f98632..edac34c796ce 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -5332,7 +5332,6 @@ ice_aq_get_cgu_dpll_status(struct ice_hw *hw, u8 dpll_num, u8 *ref_state,
>   			   u8 *eec_mode)
>   {
>   	struct ice_aqc_get_cgu_dpll_status *cmd;
> -	const s64 nsec_per_psec = 1000LL;
>   	struct ice_aq_desc desc;
>   	int status;
>   
> @@ -5348,8 +5347,7 @@ ice_aq_get_cgu_dpll_status(struct ice_hw *hw, u8 dpll_num, u8 *ref_state,
>   		*phase_offset = le32_to_cpu(cmd->phase_offset_h);
>   		*phase_offset <<= 32;
>   		*phase_offset += le32_to_cpu(cmd->phase_offset_l);
> -		*phase_offset = div64_s64(sign_extend64(*phase_offset, 47),
> -					  nsec_per_psec);
> +		*phase_offset = sign_extend64(*phase_offset, 47);
>   		*eec_mode = cmd->eec_mode;
>   	}

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
