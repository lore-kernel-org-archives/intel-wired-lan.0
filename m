Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4E0C3ABC9
	for <intel-wired-lan@archiver.kernel.org>; Fri, 16 May 2025 15:16:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6592F612AE;
	Fri, 16 May 2025 15:16:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3GXUu5ehLPlo; Fri, 16 May 2025 15:16:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5885612C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1747408588;
	bh=kFPRL8SAWScBT6kLbV86B4iD3vcMap0aoyMMGOJWcjA=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FrCb8iYqIUHR1i84O2uZmwi9qYiZDWr+DrnexnShMARx2GF6nFyiNAVWgl6EeBoCk
	 dlwu5IVu8cRmFWaWiUJxyDpc2ARZPbNrtF4otopnY5jav4Zrn1L5aNKhLs5v1xQKj5
	 gxkkSPB3q/sHTGxqmFdTINxHMypx86RR0R5c21dZ6w0zXPbmOGEGeZdaNcofujY0j6
	 V6xXCg2B1vnlOuZRJWpUXb8pBWdx0iBDc+RZTB0Aw9mTcFTd+4lciZclipcHJP2/n0
	 XUDpnZSeQ9rSBf1Bj9k0ZbbUm2A+sGkVYB3ePW3GYUweUMcyhy4w8dSY8yso2bB95r
	 V988/bOHEIrTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5885612C1;
	Fri, 16 May 2025 15:16:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DB407185
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 May 2025 15:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D7EA8612C1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 May 2025 15:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k590iy3QuZxO for <intel-wired-lan@lists.osuosl.org>;
 Fri, 16 May 2025 15:16:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 64A84612AE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 64A84612AE
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 64A84612AE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 May 2025 15:16:24 +0000 (UTC)
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id EE38161EA1BF8;
 Fri, 16 May 2025 17:15:54 +0200 (CEST)
Message-ID: <be6f3fd0-e45b-460b-89df-7b3e846eefd9@molgen.mpg.de>
Date: Fri, 16 May 2025 17:15:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Simon Horman <horms@kernel.org>
References: <20250516144214.1405797-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250516144214.1405797-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] ice: add 40G speed to
 Admin Command GET PORT OPTION
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

Dear Aleksandr,


Thank you for your patch.

Am 16.05.25 um 16:42 schrieb Aleksandr Loktionov:
> Introduce the ICE_AQC_PORT_OPT_MAX_LANE_40G constant and update the code
> to process this new option in both the devlink and the Admin Queue Command
> GET PORT OPTION (opcode 0x06EA) message, similar to existing constants like
> ICE_AQC_PORT_OPT_MAX_LANE_50G, ICE_AQC_PORT_OPT_MAX_LANE_100G, and so on.
> 
> This feature allows the driver to correctly report configuration options
> for 2x40G on ICX-D LCC and other cards in the future via devlink.
> 
> Example command:
>   devlink port split pci/0000:01:00.0/0 count 2
> 
> Example dmesg:
>   ice 0000:01:00.0: Available port split options and max port speeds (Gbps):
>   ice 0000:01:00.0: Status  Split      Quad 0          Quad 1
>   ice 0000:01:00.0:         count  L0  L1  L2  L3  L4  L5  L6  L7
>   ice 0000:01:00.0:         2      40   -   -   -  40   -   -   -
>   ice 0000:01:00.0:         2      50   -  50   -   -   -   -   -
>   ice 0000:01:00.0:         4      25  25  25  25   -   -   -   -
>   ice 0000:01:00.0:         4      25  25   -   -  25  25   -   -
>   ice 0000:01:00.0: Active  8      10  10  10  10  10  10  10  10
>   ice 0000:01:00.0:         1     100   -   -   -   -   -   -   -
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> v2->v3 - fix indent
> v1->v2 - fix typo in commit message
> ---
>   drivers/net/ethernet/intel/ice/devlink/port.c   | 2 ++
>   drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 1 +
>   drivers/net/ethernet/intel/ice/ice_common.c     | 2 +-
>   drivers/net/ethernet/intel/ice/ice_ethtool.c    | 3 ++-
>   4 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/port.c b/drivers/net/ethernet/intel/ice/devlink/port.c
> index 767419a..63fb36f 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/port.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/port.c
> @@ -30,6 +30,8 @@ static const char *ice_devlink_port_opt_speed_str(u8 speed)
>   		return "10";
>   	case ICE_AQC_PORT_OPT_MAX_LANE_25G:
>   		return "25";
> +	case ICE_AQC_PORT_OPT_MAX_LANE_40G:
> +		return "40";
>   	case ICE_AQC_PORT_OPT_MAX_LANE_50G:
>   		return "50";
>   	case ICE_AQC_PORT_OPT_MAX_LANE_100G:
> diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> index bdee499..2ff141a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> @@ -1672,6 +1672,7 @@ struct ice_aqc_get_port_options_elem {
>   #define ICE_AQC_PORT_OPT_MAX_LANE_50G	6
>   #define ICE_AQC_PORT_OPT_MAX_LANE_100G	7
>   #define ICE_AQC_PORT_OPT_MAX_LANE_200G	8
> +#define ICE_AQC_PORT_OPT_MAX_LANE_40G	9
>   
>   	u8 global_scid[2];
>   	u8 phy_scid[2];
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 4fedf01..2519ad6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -4080,7 +4080,7 @@ int ice_get_phy_lane_number(struct ice_hw *hw)
>   
>   		speed = options[active_idx].max_lane_speed;
>   		/* If we don't get speed for this lane, it's unoccupied */
> -		if (speed > ICE_AQC_PORT_OPT_MAX_LANE_200G)
> +		if (speed > ICE_AQC_PORT_OPT_MAX_LANE_40G)
>   			continue;
>   
>   		if (hw->pf_id == lport) {
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 6488151..f2c0b28 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -667,7 +667,8 @@ static int ice_get_port_topology(struct ice_hw *hw, u8 lport,
>   
>   		if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_100G)
>   			port_topology->serdes_lane_count = 4;
> -		else if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_50G)
> +		else if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_50G ||
> +			 max_speed == ICE_AQC_PORT_OPT_MAX_LANE_40G)
>   			port_topology->serdes_lane_count = 2;
>   		else
>   			port_topology->serdes_lane_count = 1;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
