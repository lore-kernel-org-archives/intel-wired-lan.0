Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5407C44524
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Jul 2026 08:27:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A78860635;
	Thu, 23 Jul 2026 08:27:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VGlfkbia2vTW; Thu, 23 Jul 2026 08:27:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CBB360646
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784795225;
	bh=dctZDlC2XJVQXTcTGVVfbpBQOnBh4QfJjhWU5Wge13Y=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HiIur9B33MEOu+HHuBjQHxyWP7k3hfu6lflZBvKY9UOiWomDJaj656zNDJJoNc05Q
	 /IDpMSMSFN1XlDPaYy3QCuZXAkgWtpEjJeuy7mm8rQSLcURRckxmeeeL9PBVCAmaZV
	 PFUQgHRNQ0gt5FoAqnD3nozZp75qbvUAON4xOZpErMcDJ8Ge0hPh8IYnjWCrRWwfHw
	 42vHwQFQ7kwI2PFbw414Eiy9M32135fuJrnK5N77FYw1EysXr3MiutMxKR2spgP5+U
	 avGgfmKhWO4vsF3MI05NGx2oHDfKq0Gw97eX47mQlxN5phbmOUSLDk6773N2GNVVFs
	 dWWby9ckhWL3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CBB360646;
	Thu, 23 Jul 2026 08:27:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 08EAB429
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 08:27:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EECCB60646
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 08:27:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r-9XxDl4dh8k for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Jul 2026 08:27:02 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7541360635
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7541360635
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7541360635
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 08:27:01 +0000 (UTC)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-IVK4FyoLPRWjQH5WMrJ3Pw-1; Thu, 23 Jul 2026 04:26:58 -0400
X-MC-Unique: IVK4FyoLPRWjQH5WMrJ3Pw-1
X-Mimecast-MFC-AGG-ID: IVK4FyoLPRWjQH5WMrJ3Pw_1784795217
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4956b4cfe19so3081265e9.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 01:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784795217; x=1785400017;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dctZDlC2XJVQXTcTGVVfbpBQOnBh4QfJjhWU5Wge13Y=;
 b=ab3A9DUf0SDK0WgllHr1D4uoreZY/1ii3H5lUM9dolg1ydF+Vj4j8palxV1nR9ndba
 Q/0JYnz1P0Jgp9Xv3msuBGj5xwlBY1IDuHAt1JWxHWyg2+BCjSiBxelMkt1rtLWE7zK9
 mJJUabJIa+nVKvu0bNiS74K64r7IuHI08nrDlY1VsdIzze7/ckW3QScjeWXWmtQMCGLg
 /SPrUtStRwrYAcK9q3VMnbTqrFDUkKDdF35L9/IVUo3w7SbDtVrDPVz3Lt5t09NQA508
 UnJecWWfKgbnka6ojWHzE1WMfpQ98o0DNRI3udMQwVFyxKbn5CE22YbhCsgslbETBMFm
 qlGw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7WHgTbXlr/6wPQzbw9G83ZlPcG/zRLEh5EK/o6JUaft9JKpushndmcQ/9Y1NYTMKbiAqz0rck6jJJzofq2io=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyLqx6WAMGw1uZ9lTZSeweHXG1FGlEPlq2SWCFX5fHyPXRbZ2FY
 xPNPBLem7IxO3HiZv+0UuzrrJtbyW+TkpVjswA7O4QaRyX2Qd3Vaey6sDjhlO+mOlDI9U5qOh6I
 PIZvz/O26rJpAiRqKJtJnglQ1fYw51jBWk71CKYcRcJhU4T3zIdN6RZreeqf9iuEM158J0kY=
X-Gm-Gg: AR+sD11d9QtTtzGaMknAsrr65/GocwX9oyjdt8F+cTZsRvI1/0VIOVY2PxHj/vAxFLw
 gzPCwIo0z2F9RPft7oClmeLkT3PQAd8QvKSkjnYqzlaMvetavPBIOWouvlEhmY5OF6bVzJlHJmN
 Q+/ZQAyGhQVa5VwuouWsTZfkFCvMAlunMDx0nwPVHMBofB1BHx37Etlvw0brpdaBvNtQr6Byixa
 WmTbtAPCDomNnohvdh3ona3t3w8TIdByFYLCjELfIXXn7n9jRR6XfPoTfoZp+Dg9Aqs1Kc/UH5Q
 iiHY4+MpatPyTMj1+bK6+Dlo6O4hPoGLevcJbrxe295efqT0QPJpyykUP4cqheopSUaHF97vEZ0
 =
X-Received: by 2002:a05:600c:1395:b0:495:4487:61af with SMTP id
 5b1f17b1804b1-49573d36fddmr21981465e9.36.1784795216760; 
 Thu, 23 Jul 2026 01:26:56 -0700 (PDT)
X-Received: by 2002:a05:600c:1395:b0:495:4487:61af with SMTP id
 5b1f17b1804b1-49573d36fddmr21980795e9.36.1784795216029; 
 Thu, 23 Jul 2026 01:26:56 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b72fac1sm105603625e9.1.2026.07.23.01.26.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 01:26:55 -0700 (PDT)
Message-ID: <eea8692e-f8e9-4bae-beb8-e33f7508aa9b@redhat.com>
Date: Thu, 23 Jul 2026 10:26:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Przemyslaw Korba <przemyslaw.korba@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, arkadiusz.kubalewski@intel.com,
 aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, konstantin.ilichev@intel.com
References: <20260720120151.2675206-1-przemyslaw.korba@intel.com>
 <20260720120151.2675206-3-przemyslaw.korba@intel.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260720120151.2675206-3-przemyslaw.korba@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2-hbQhxrbKNwqabots6iZl5dDApt_0rVk46ocWJdYKE_1784795217
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1784795220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dctZDlC2XJVQXTcTGVVfbpBQOnBh4QfJjhWU5Wge13Y=;
 b=XPF0QAgcv8HQFa6nRTS75ztvMqpv0HXuK57eLUVAmKMEAUdoavDX5SB9sgeuFC4njNza/x
 Ar05BJEov+DrEcMOaDmwonSdE89LfF0M0zFPdgyCoiW4jUnV1qPaAv/TZhg1GWXlFsCqTG
 /okgIxWX2S2WFHIwwreai6OKQNJFPS4=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=XPF0QAgc
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 2/4] ice: clear unexpected Tx
 timestamp ready bits to prevent stuck PHY
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


On 7/20/26 14:01, Przemyslaw Korba wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
>
> Clear orphaned timestamp ready bits left in the PHY when a packet is
> timestamped just as the link goes down. The driver clears its software
> in_use bits during link-down cleanup, but the PHY has already latched
> the timestamp, so on the next link-up a stale ready bit from the
> previous link cycle remains set with no matching in_use entry.
>
> The PHY timestamp interrupt logic will not generate a new interrupt
> until ALL outstanding ready bits have been read. ice_ptp_process_tx_
> tstamp() only iterates slots set in the software in_use bitmap, so it
> never reads these orphaned slots. The result is a permanent interrupt
> deadlock:
>
> 1. The PHY has ready bits set for slots with no in_use tracker entry
> 2. The driver never reads those slots because in_use is clear
> 3. The PHY refuses to generate new timestamp interrupts
> 4. All future Tx timestamps permanently fail
> 5. Only a power-on reset can recover the device
>
> Clear these stale ready bits on link-up, in ice_ptp_link_change(),
> before any new timestamp requests arrive, scoped to the affected port
> only so timestamps still pending on other ports are left untouched. For
> every affected MAC the clearing iterates the not-in_use slots with
> for_each_clear_bit(), so a pending software request is never discarded
> and tx->lock need not be held across the PHY access:
>
>    - E810 is skipped (guarded by tx->has_ready_bitmap) because
>      ice_get_phy_tx_tstamp_ready_e810() returns an all-ones bitmap rather
>      than a real ready status.
>    - E830 and E825/eth56g read the real Tx timestamp ready bitmap and
>      clear only the slots the PHY actually latched, via
>      ice_clear_phy_tstamp(). If the ready bitmap cannot be read, the
>      clear is skipped and a rate-limited warning is logged.
>
> On every MAC the ready bit is cleared by reading the slot's timestamp
> memory; the orphaned bits linger only because the normal processing path
> never reads those not-in_use slots. The link-up recovery clears them by
> reading the timestamp memory via ice_clear_phy_tstamp():
>
>    - E830: add ice_clear_phy_tstamp_e830(), which reads the
>      PRTTSYN_TXTIME_H/L registers to clear the entry, and add an
>      ICE_MAC_E830 case to the ice_clear_phy_tstamp() dispatch.
>    - eth56g: ice_clear_ptp_tstamp_eth56g() reads the timestamp memory
>      location, which per the PHY spec is the operation that clears the
>      entry's valid bit and its corresponding (read-only) ts_memory_status
>      bit. The ts_memory_status registers cannot be written to clear a
>      bit, so only reading the timestamp memory has any effect.
>
> The new for_each_clear_bit() loop runs from the service task via link
> events. During device removal, tx->in_use is freed before the service
> task is stopped. Fix by stopping the service task at the start of
> ice_unload(), before ice_ptp_release() frees tx->in_use.
>
> Reviewed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_main.c   |  1 +
>   drivers/net/ethernet/intel/ice/ice_ptp.c    | 72 +++++++++++++++--
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 89 +++++++++++++++++----
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  1 +
>   drivers/net/ethernet/intel/ice/ice_type.h   |  7 ++
>   5 files changed, 149 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index e3d3810c791f..231d533309cb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5169,6 +5169,7 @@ void ice_unload(struct ice_pf *pf)
>   
>   	devl_assert_locked(priv_to_devlink(pf));
>   
> +	ice_service_task_stop(pf);
>   	ice_unplug_aux_dev(pf);
>   	ice_deinit_rdma(pf);
>   	ice_deinit_features(pf);
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 1aa440b0639f..9d9d9958fe5c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1372,15 +1372,73 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>   	switch (hw->mac_type) {
>   	case ICE_MAC_E810:
>   	case ICE_MAC_E830:
> -		/* Do not reconfigure E810 or E830 PHY */
> +	case ICE_MAC_GENERIC_3K_E825:
> +		/* Do not reconfigure E810 or E830 PHY, but on link-up clear
> +		 * any stale timestamp ready bits left over from a previous
> +		 * link cycle. The PHY may have latched timestamps for packets
> +		 * in flight when the link went down; these must be cleared
> +		 * before new timestamp requests arrive.
> +		 *
> +		 * E810 does not have a real ready bitmap
> +		 * (ice_get_phy_tx_tstamp_ready_e810 returns all-ones), so
> +		 * skip clearing on E810 to avoid unnecessary sideband queue
> +		 * operations for every not-in-use slot on each link-up.
> +		 */
> +		if (linkup && ptp_port->tx.has_ready_bitmap) {
> +			struct ice_ptp_tx *tx = &ptp_port->tx;
> +			u64 tstamp_ready;
> +			int i;
> +
> +			if (ice_get_phy_tx_tstamp_ready(hw, tx->block,
> +							&tstamp_ready)) {
> +				dev_warn_ratelimited(ice_pf_to_dev(pf),
> +						     "PTP failed to read Tx timestamp ready bitmap on link-up; stale PHY timestamps may remain and stall Tx timestamping\n");
> +			} else {
> +				/* Only clear stale ready bits for slots that
> +				 * have no in-flight software request. Iterating
> +				 * the not-in-use slots skips any concurrent
> +				 * ice_ptp_request_ts() allocation without
> +				 * holding tx->lock across the PHY access. E830
> +				 * and E825 reach this clear; E810 is filtered
> +				 * out above by has_ready_bitmap.
> +				 */
> +				for_each_clear_bit(i, tx->in_use, tx->len) {
> +					u8 phy_idx = i + tx->offset;
> +
> +					if (tstamp_ready & BIT_ULL(phy_idx))
> +						ice_clear_phy_tstamp(hw,
> +								     tx->block,
> +								     phy_idx);
> +				}
> +			}
> +		}
> +
> +		/* E810 and E830 need no further PHY reconfiguration */
> +		if (hw->mac_type != ICE_MAC_GENERIC_3K_E825)
> +			return;
> +
> +		/* E825 recovers its Tx path by soft resetting the PHY
> +		 * timestamp block and restarting the port, but only on
> +		 * link-up. The reset is a three-step register toggle; if it
> +		 * fails partway through, the port can be left held in reset,
> +		 * and programming a PHY that is stuck in reset via
> +		 * ice_ptp_port_phy_restart() would leave Tx timestamping
> +		 * permanently broken. So warn and skip the restart on
> +		 * failure; the sequence is retried on the next link-up event.
> +		 */
> +		if (!linkup)
> +			return;
> +
> +		if (ice_ptp_phy_soft_reset_eth56g(hw, ptp_port->port_num))
> +			dev_warn(ice_pf_to_dev(pf),
> +				 "PTP failed to soft reset PHY port %u on link-up; skipping restart, Tx timestamping may be stuck, try toggle a link to recover\n",
> +				 ptp_port->port_num);
> +		else
> +			ice_ptp_port_phy_restart(ptp_port);

We hit a regression from this hunk while testing the series on an
E825 T-BC system: after the soft reset the port no longer signals
latched Tx timestamps. Nothing re-enables the port interrupt
configuration (PHY_REG_TS_INT_CONFIG) afterwards, the only writers
are the clock owner init and rebuild paths via
ice_ptp_cfg_phy_interrupt(), and ice_ptp_port_phy_restart() does not
touch it. So the first link-up that takes this path leaves the port
without Tx timestamp interrupts until the next reset of the clock
owner PF or a driver reload.

Regards,

Petr

>   		return;
>   	case ICE_MAC_GENERIC:
>   		ice_ptp_port_phy_restart(ptp_port);
>   		return;
> -	case ICE_MAC_GENERIC_3K_E825:
> -		if (linkup)
> -			ice_ptp_port_phy_restart(ptp_port);
> -		return;
>   	default:
>   		dev_warn(ice_pf_to_dev(pf), "%s: Unknown PHY type\n", __func__);
>   	}
> @@ -3380,6 +3438,7 @@ void ice_ptp_init(struct ice_pf *pf)
>   
>   	ptp->state = ICE_PTP_INITIALIZING;
>   
> +	mutex_init(&hw->ptp.tx_tstamp_lock);
>   	if (hw->lane_num < 0) {
>   		err = hw->lane_num;
>   		goto err_exit;
> @@ -3443,6 +3502,7 @@ void ice_ptp_init(struct ice_pf *pf)
>   
>   	ice_ptp_cleanup_adapter(pf);
>   err_exit:
> +	mutex_destroy(&hw->ptp.tx_tstamp_lock);
>   	/* If we registered a PTP clock, release it */
>   	if (pf->ptp.clock) {
>   		ptp_clock_unregister(ptp->clock);
> @@ -3469,6 +3529,7 @@ void ice_ptp_release(struct ice_pf *pf)
>   
>   	if (pf->ptp.state != ICE_PTP_READY) {
>   		mutex_destroy(&pf->ptp.port.ps_lock);
> +		mutex_destroy(&pf->hw.ptp.tx_tstamp_lock);
>   		ice_ptp_cleanup_pf(pf);
>   		ice_ptp_cleanup_adapter(pf);
>   		if (pf->ptp.clock) {
> @@ -3495,6 +3556,7 @@ void ice_ptp_release(struct ice_pf *pf)
>   
>   	ice_ptp_port_phy_stop(&pf->ptp.port);
>   	mutex_destroy(&pf->ptp.port.ps_lock);
> +	mutex_destroy(&pf->hw.ptp.tx_tstamp_lock);
>   	if (pf->ptp.kworker) {
>   		kthread_destroy_worker(pf->ptp.kworker);
>   		pf->ptp.kworker = NULL;
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index a1970a887c38..b23b68cd18ee 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -1160,11 +1160,15 @@ static int ice_read_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx,
>    *
>    * To directly clear the contents of the timestamp block entirely, discarding
>    * all timestamp data at once, software should instead use
> - * ice_ptp_reset_ts_memory_quad_eth56g().
> + * ice_ptp_reset_ts_memory_eth56g().
>    *
>    * This function should only be called on an idx whose bit is set according to
>    * ice_get_phy_tx_tstamp_ready().
>    *
> + * Serialized against ice_ptp_clear_tx_memory_status_eth56g() via
> + * tx_tstamp_lock so the two paths do not interleave their reads of the same
> + * port's Tx timestamp memory.
> + *
>    * Return:
>    * * %0     - success
>    * * %other - failed to write to PHY
> @@ -1175,25 +1179,62 @@ static int ice_clear_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx)
>   	u16 lo_addr;
>   	int err;
>   
> -	/* Read the timestamp register to ensure the timestamp status bit is
> -	 * cleared.
> +	lo_addr = (u16)PHY_TSTAMP_L(idx);
> +
> +	mutex_lock(&hw->ptp.tx_tstamp_lock);
> +
> +	/* Per the PHY spec, reading the timestamp memory location is what
> +	 * clears the entry's valid bit and its corresponding (read-only)
> +	 * ts_memory_status bit. This clears only this index, leaving any
> +	 * other in-flight timestamps on the port untouched.
>   	 */
>   	err = ice_read_ptp_tstamp_eth56g(hw, port, idx, &unused_tstamp);
> -	if (err) {
> +	if (err)
>   		ice_debug(hw, ICE_DBG_PTP, "Failed to read the PHY timestamp register for port %u, idx %u, err %d\n",
>   			  port, idx, err);
> -	}
> -
> -	lo_addr = (u16)PHY_TSTAMP_L(idx);
>   
>   	err = ice_write_port_mem_eth56g(hw, port, lo_addr, 0);
> -	if (err) {
> +	if (err)
>   		ice_debug(hw, ICE_DBG_PTP, "Failed to clear low PTP timestamp register for port %u, idx %u, err %d\n",
>   			  port, idx, err);
> -		return err;
> +
> +	mutex_unlock(&hw->ptp.tx_tstamp_lock);
> +
> +	return err;
> +}
> +
> +/**
> + * ice_ptp_clear_tx_memory_status_eth56g - Reset one port's Tx timestamp memory
> + * @hw: pointer to the HW struct
> + * @port: port number to clear
> + *
> + * Fully reset a single PHY port's Tx timestamp memory. Per the PHY spec, the
> + * only way to clear a timestamp valid bit (and its read-only ts_memory_status
> + * bit) is to read the timestamp memory location, so read every entry for the
> + * port (two 32-bit reads each). This discards all timestamp data on the port,
> + * so it must only be used for a full reset; callers that must preserve
> + * in-flight timestamps clear individual indices via ice_clear_phy_tstamp().
> + *
> + * Holds tx_tstamp_lock so this full-port sweep does not interleave with the
> + * per-index reads in ice_clear_ptp_tstamp_eth56g() on the same port.
> + *
> + * Return: 0 on success, negative error code on failure to read the PHY.
> + */
> +int ice_ptp_clear_tx_memory_status_eth56g(struct ice_hw *hw, u8 port)
> +{
> +	u64 unused_tstamp;
> +	int err = 0;
> +	u8 idx;
> +
> +	mutex_lock(&hw->ptp.tx_tstamp_lock);
> +	for (idx = 0; idx < INDEX_PER_PORT; idx++) {
> +		err = ice_read_ptp_tstamp_eth56g(hw, port, idx, &unused_tstamp);
> +		if (err)
> +			break;
>   	}
> +	mutex_unlock(&hw->ptp.tx_tstamp_lock);
>   
> -	return 0;
> +	return err;
>   }
>   
>   /**
> @@ -1204,12 +1245,8 @@ static void ice_ptp_reset_ts_memory_eth56g(struct ice_hw *hw)
>   {
>   	unsigned int port;
>   
> -	for (port = 0; port < hw->ptp.num_lports; port++) {
> -		ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_MEMORY_STATUS_L,
> -					 0);
> -		ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_MEMORY_STATUS_U,
> -					 0);
> -	}
> +	for (port = 0; port < hw->ptp.num_lports; port++)
> +		ice_ptp_clear_tx_memory_status_eth56g(hw, port);
>   }
>   
>   /**
> @@ -5277,6 +5314,23 @@ static void ice_read_phy_tstamp_e830(const struct ice_hw *hw, u8 idx,
>   		  FIELD_PREP(PHY_EXT_40B_LOW_M, lo);
>   }
>   
> +/**
> + * ice_clear_phy_tstamp_e830 - Clear a timestamp from the E830 PHY
> + * @hw: pointer to the HW struct
> + * @idx: the timestamp index to clear
> + *
> + * Clear the valid bit for the given timestamp index in the Tx memory (TS_MEM).
> + * On E830 devices the PRTMAC_TS_TX_MEM_VALID_L/H registers are read-only
> + * mirrors of the per-entry TX_VALID bits and cannot be written. The actual
> + * TS_MEM entry's TX_VALID bit is cleared by reading the corresponding
> + * PRTTSYN_TXTIME_L/H registers (read-to-clear).
> + */
> +static void ice_clear_phy_tstamp_e830(const struct ice_hw *hw, u8 idx)
> +{
> +	rd32(hw, E830_PRTTSYN_TXTIME_H(idx));
> +	rd32(hw, E830_PRTTSYN_TXTIME_L(idx));
> +}
> +
>   /**
>    * ice_get_phy_tx_tstamp_ready_e830 - Read Tx memory status register
>    * @hw: pointer to the HW struct
> @@ -5772,6 +5826,9 @@ int ice_clear_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx)
>   	switch (hw->mac_type) {
>   	case ICE_MAC_E810:
>   		return ice_clear_phy_tstamp_e810(hw, block, idx);
> +	case ICE_MAC_E830:
> +		ice_clear_phy_tstamp_e830(hw, idx);
> +		return 0;
>   	case ICE_MAC_GENERIC:
>   		return ice_clear_phy_tstamp_e82x(hw, block, idx);
>   	case ICE_MAC_GENERIC_3K_E825:
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> index 16b1988e993d..b003e0aae8b1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> @@ -304,6 +304,7 @@ int ice_ptp_clear_phy_offset_ready_e82x(struct ice_hw *hw);
>   int ice_read_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx, u64 *tstamp);
>   int ice_clear_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx);
>   void ice_ptp_reset_ts_memory(struct ice_hw *hw);
> +int ice_ptp_clear_tx_memory_status_eth56g(struct ice_hw *hw, u8 port);
>   int ice_ptp_init_phc(struct ice_hw *hw);
>   void ice_ptp_init_hw(struct ice_hw *hw);
>   int ice_get_phy_tx_tstamp_ready(struct ice_hw *hw, u8 block, u64 *tstamp_ready);
> diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
> index 710c519d670d..d8c73fcafc25 100644
> --- a/drivers/net/ethernet/intel/ice/ice_type.h
> +++ b/drivers/net/ethernet/intel/ice/ice_type.h
> @@ -888,6 +888,13 @@ enum ice_global_link_topo {
>   
>   struct ice_ptp_hw {
>   	union ice_phy_params phy;
> +	/* Serializes eth56g Tx timestamp-memory reads (the per-index
> +	 * timestamp entries, not the TX_MEMORY_STATUS registers). Reading an
> +	 * entry auto-clears its ts_memory_status bit as a side effect, so the
> +	 * per-index and full-port clear paths must not interleave on the same
> +	 * port or a bit could re-latch the interrupt.
> +	 */
> +	struct mutex tx_tstamp_lock;
>   	u8 num_lports;
>   	u8 ports_per_phy;
>   };

