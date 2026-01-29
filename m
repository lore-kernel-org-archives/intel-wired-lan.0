Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0536FD73E87
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Jan 2026 23:45:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9791260C14;
	Thu, 29 Jan 2026 23:45:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lKLzcz48OTDG; Thu, 29 Jan 2026 23:45:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E61BC60C17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769730355;
	bh=PIdQSlVndi3bUxGTAiBqEFVJx+Ds7txopB4BLfeZ+GQ=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yF9/edGLOLywtmQFr/p4oGCslLwyPhE7NofF8Vx6lBe9d7jwFJ/dr0a6noyeXIpIg
	 lDPItLjr/K5tbamVRDU9v0BaqQZ/ABoKFWWV6+Q07vPlTJKZEjll1pB4Jv0zFgLDiJ
	 J8Zg0REKBacRKDgrOTLpcYjHmnDHfBhcgJCnGGdlql9ac6c9NoU2JW9bhgj8XFqJIN
	 VyK+6mK6b0FlnlJMNylm422bCrS2Ym3cZbU5u2vFDYkvL5Mz3uLVUOfwH7ngG/TdRj
	 jtcHq7Ep9+Cl96Vxuei2eJniom8/03qU8jDGkLuYAAXrQGtQpTlpjFrf6LD40rg/iB
	 h57YbDQU5M2SA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E61BC60C17;
	Thu, 29 Jan 2026 23:45:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5334C1A6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 23:45:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 334F8405D8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 23:45:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LrFowg7WssSj for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Jan 2026 23:45:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4BC2C405C8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4BC2C405C8
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4BC2C405C8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 23:45:51 +0000 (UTC)
Received: from [192.168.0.192] (ip5f5af758.dynamic.kabel-deutschland.de
 [95.90.247.88])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5E8D14C442FB42;
 Fri, 30 Jan 2026 00:45:34 +0100 (CET)
Message-ID: <e5751b33-4650-4b9f-8b9d-7f9297b1e67d@molgen.mpg.de>
Date: Fri, 30 Jan 2026 00:45:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 przemyslaw.korba@intel.com,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260129-jk-i40e-limit-timestamping-v1-1-0495e6e7d318@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260129-jk-i40e-limit-timestamping-v1-1-0495e6e7d318@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] i40e: only timestamp PTP
 event packets
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

Dear Jacob,


Thank you for the patch.

Am 29.01.26 um 22:52 schrieb Jacob Keller:
> The i40e_ptp_set_timestamp_mode() function is responsible for configuring
> hardware timestamping. When programming receive timestamping, the logic
> must determine how to configure the PRTTSYN_CTL1 register for receive
> timestamping.
> 
> The i40e hardware does not support timestamping all frames. Instead,
> timestamps are captured into one of the four PRTTSYN_RXTIME registers.
> 
> Currently, the driver configures hardware to timestamp all V2 packets on
> ports 319 and 320, including all message types. This timestamps
> significantly more packets than is actually requested by the
> HWTSTAMP_FILTER_PTP_V2_EVENT filter type.
> 
> The documentation for HWTSTAMP_FILTER_PTP_V2_EVENT indicates that it should
> timestamp PTP v2 messages on any layer, including any kind of event
> packets.
> 
> Timestamping other packets is acceptable, but not required by the filter.
> Doing so wastes valuable slots in the Rx timestamp registers. For most
> applications this doesn't cause a problem. However, for extremely high
> rates of messages, it becomes possible that one of the critical event
> packets is not timestamped.
> 
> The PTP protocol only requires timestamps for event messages on port 319,
> but hardware is timestamping on both 319 and 320, and timestamping message
> types which do not need a timestamp value.
> 
> The i40e hardware actually has a more strict filtering option. First, only
> timestamp layer 4 messages on port 319 instead of both 319 and 320. Second,
> note that hardware has a specific mode to timestamp only event packets
> (those with message type < 8).
> 
> Update the configuration to use this mode, so that timestamps are captured
> for only event messages. This replaces the use of the 'wildcard' option of
> the V2MESSTYPE field which caused timestamping of all message types
> regardless of whether it was an event message.
> 
> This avoids wasting the valuable Rx timestamp register slots on non-event
> frames, and may reduce faults when operating under high event rates.

Do you have a test case to reproduce this?

Can the other mode be enabled somehow for people needing port 320 and 
timestamps on every message?

> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_register.h | 10 ++++++++++
>   drivers/net/ethernet/intel/i40e/i40e_ptp.c      |  9 +++------
>   2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
> index c4051dbcc297..2560c47910d4 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_register.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
> @@ -797,8 +797,18 @@
>   #define I40E_PRTTSYN_CTL1_V2MESSTYPE0_SHIFT 16
>   #define I40E_PRTTSYN_CTL1_V2MESSTYPE0_MASK I40E_MASK(0xF, I40E_PRTTSYN_CTL1_V2MESSTYPE0_SHIFT)
>   #define I40E_PRTTSYN_CTL1_TSYNTYPE_SHIFT 24
> +#define I40E_PRTTSYN_CTL1_TSYNTYPE_MASK I40E_MASK(0x3, I40E_PRTTSYN_CTL1_TSYNTYPE_SHIFT)
> +/* Timestamp UDP v1 packets */
> +#define I40E_PRTTSYN_CTL1_TSYNTYPE_V1 \
> +	FIELD_PREP(I40E_PRTTSYN_CTL1_TSYNTYPE_MASK, 1)
> +/* Timestamp L2 and UDP v2 packets with message type < 8 */
> +#define I40E_PRTTSYN_CTL1_TSYNTYPE_V2_EVENT \
> +	FIELD_PREP(I40E_PRTTSYN_CTL1_TSYNTYPE_MASK, 3)
>   #define I40E_PRTTSYN_CTL1_UDP_ENA_SHIFT 26
>   #define I40E_PRTTSYN_CTL1_UDP_ENA_MASK I40E_MASK(0x3, I40E_PRTTSYN_CTL1_UDP_ENA_SHIFT)
> +/* Timestamp UDP packets on port 319 */
> +#define I40E_PRTTSYN_CTL1_UDP_ENA_319 \
> +	FIELD_PREP(I40E_PRTTSYN_CTL1_UDP_ENA_MASK, 1)
>   #define I40E_PRTTSYN_CTL1_TSYNENA_SHIFT 31
>   #define I40E_PRTTSYN_CTL1_TSYNENA_MASK I40E_MASK(0x1, I40E_PRTTSYN_CTL1_TSYNENA_SHIFT)
>   #define I40E_PRTTSYN_INC_H 0x001E4060 /* Reset: GLOBR */
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index 89abe2f22216..d70adf2e5a1c 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -24,9 +24,6 @@
>   #define I40E_PTP_1GB_INCVAL_MULT	20
>   #define I40E_ISGN			0x80000000
>   
> -#define I40E_PRTTSYN_CTL1_TSYNTYPE_V1  BIT(I40E_PRTTSYN_CTL1_TSYNTYPE_SHIFT)
> -#define I40E_PRTTSYN_CTL1_TSYNTYPE_V2  (2 << \
> -					I40E_PRTTSYN_CTL1_TSYNTYPE_SHIFT)
>   #define I40E_SUBDEV_ID_25G_PTP_PIN	0xB
>   
>   enum i40e_ptp_pin {
> @@ -1278,7 +1275,7 @@ static int i40e_ptp_set_timestamp_mode(struct i40e_pf *pf,
>   		pf->ptp_rx = true;
>   		tsyntype = I40E_PRTTSYN_CTL1_V1MESSTYPE0_MASK |
>   			   I40E_PRTTSYN_CTL1_TSYNTYPE_V1 |
> -			   I40E_PRTTSYN_CTL1_UDP_ENA_MASK;
> +			   I40E_PRTTSYN_CTL1_UDP_ENA_319;
>   		config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
>   		break;
>   	case HWTSTAMP_FILTER_PTP_V2_EVENT:
> @@ -1295,9 +1292,9 @@ static int i40e_ptp_set_timestamp_mode(struct i40e_pf *pf,
>   	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
>   		pf->ptp_rx = true;
>   		tsyntype = I40E_PRTTSYN_CTL1_V2MESSTYPE0_MASK |
> -			   I40E_PRTTSYN_CTL1_TSYNTYPE_V2;
> +			   I40E_PRTTSYN_CTL1_TSYNTYPE_V2_EVENT;
>   		if (test_bit(I40E_HW_CAP_PTP_L4, pf->hw.caps)) {
> -			tsyntype |= I40E_PRTTSYN_CTL1_UDP_ENA_MASK;
> +			tsyntype |= I40E_PRTTSYN_CTL1_UDP_ENA_319;
>   			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
>   		} else {
>   			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;


Kind regards,

Paul
