Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE8DFF886F
	for <intel-wired-lan@archiver.kernel.org>; Mon,  4 May 2026 12:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDE65844FB;
	Mon,  4 May 2026 12:22:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vLp6gbdD_yjp; Mon,  4 May 2026 12:22:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EAD4384494
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777897343;
	bh=z7lxL1SpJEYwiYwqOd7zK4lrZy0nQlcOa3WKLgXrSxA=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9DDwh1XJTvNM6wWlr5qamqrInCTwj6zmKqeTS+GFw/30pAD39GzUGwKQL1jMxkCxv
	 fQM/VlMNlWSd1nifP70vsjB6O0MM110MvF/7C8J64+YCGDQcmRV0/2NRRsL+QBsPs3
	 3D9IC7EmRCYhIcKEwFVs2ReUWbAD/ogyCRYpgLP1TtH9FCsFcQAjwJTSnqoNsnX2qp
	 wUfNPY/HN42wPMSzPfUs5B8gCg8EOkaGyROhtPA8yy2LDTtIywRGHHQ18WvkNW5REK
	 ZvUDeeOPVoNrYyUIOZMw9Mz4VdKr3/JitJXE4prF0ytdZkHLXgigKY9qnB1j4hktTA
	 QSsq+Ti17jJ4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EAD4384494;
	Mon,  4 May 2026 12:22:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C2CC9190
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 May 2026 12:22:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F5FF41A7D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 May 2026 12:22:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kKrqU_Sz0d1J for <intel-wired-lan@lists.osuosl.org>;
 Mon,  4 May 2026 12:22:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1124641A65
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1124641A65
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1124641A65
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 May 2026 12:22:19 +0000 (UTC)
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id C14AD4C443115E;
 Mon, 04 May 2026 14:21:37 +0200 (CEST)
Message-ID: <f55d1782-a416-4746-8a76-67cab063ecd3@molgen.mpg.de>
Date: Mon, 4 May 2026 14:21:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Eric Dumazet <edumazet@google.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
References: <20260504121603.1702674-1-poros@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260504121603.1702674-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: fix missing priority
 callbacks for U.FL DPLL pins
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

Dear Petr,


Thank you for your patch.

Am 04.05.26 um 14:16 schrieb Petr Oros:
> The U.FL2 input pin advertises DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE
> in its capability mask, but ice_dpll_pin_ufl_ops does not provide
> .prio_get and .prio_set callbacks. As a result the DPLL subsystem
> cannot report or accept priority for U.FL pins: pin-get omits the prio
> field on U.FL2 and pin-set with prio is rejected as invalid, even
> though the capability is present. This prevents user space from using
> priority to select or disable U.FL2 as a DPLL input source.
> 
> Add the missing .prio_get and .prio_set callbacks to
> ice_dpll_pin_ufl_ops, reusing ice_dpll_sw_input_prio_{get,set}. The
> same ops struct is shared by U.FL1 and U.FL2: U.FL2 (input) delegates
> to the backing hardware input pin, while U.FL1 (output) does not
> advertise DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE so the dpll core
> capability gate never invokes the callback for it. The reused helpers
> also guard on p->direction != DPLL_PIN_DIRECTION_INPUT and !p->input
> as defense in depth.

Should you resend, it’d be great if you listed the user space commands 
to reproduce this.

> Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_dpll.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 27b460926baced..be72a076f7a15c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -2628,6 +2628,8 @@ static const struct dpll_pin_ops ice_dpll_pin_ufl_ops = {
>   	.state_on_dpll_set = ice_dpll_ufl_pin_state_set,
>   	.state_on_dpll_get = ice_dpll_sw_pin_state_get,
>   	.direction_get = ice_dpll_pin_sw_direction_get,
> +	.prio_get = ice_dpll_sw_input_prio_get,
> +	.prio_set = ice_dpll_sw_input_prio_set,
>   	.frequency_get = ice_dpll_sw_pin_frequency_get,
>   	.frequency_set = ice_dpll_sw_pin_frequency_set,
>   	.esync_set = ice_dpll_sw_esync_set,

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
