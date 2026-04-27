Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699A2FF8868
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Apr 2026 16:44:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3211040A56;
	Mon, 27 Apr 2026 16:44:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MMdYl5HiV7tQ; Mon, 27 Apr 2026 16:44:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E27F440A53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777308248;
	bh=JH3JRmQBpCnWHw3wvFh/nbnoikGnOZuwUHsK0VbEm68=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TUPXGKkhUJI3BPZWkAdHdoW1OWXkwJmn+1rG5d/Gu8DemYyHYIOK0br6tigPrVugM
	 Qiq2nP+oZ5uwRGOgrfVCXJn5AWgLghQkLTJlx4XiMChZCawjWHOOY/QHi1bhs+sar5
	 J0jR3ijgDImn/+cv3fDPMaq2fg6aI//Wor0wXn24ThnfhRLaB9qsxKEj0AImz2b6WL
	 I2IJsoI8zJhCrox0bMlC8VfOlFq8fO3wPB6O54xMtK9BQK4cFpwR2K3dwyxDTo1PCi
	 iU+j/eH+/xttefU6uDvg9TN5g5FqbQxx62MWxGM8g7v6hffdYwdqE0lWN1z+MgMbl2
	 Ai9/9brjr30Sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E27F440A53;
	Mon, 27 Apr 2026 16:44:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 94BE21B8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Apr 2026 16:44:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 92C834008A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Apr 2026 16:44:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kTX4kBp7lOT5 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Apr 2026 16:44:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9947740086
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9947740086
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9947740086
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Apr 2026 16:44:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DAD6160126;
 Mon, 27 Apr 2026 16:44:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0CEC19425;
 Mon, 27 Apr 2026 16:44:01 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: jtornosm@redhat.com
Cc: 'Simon Horman' <horms@kernel.org>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com,
 aleksandr.loktionov@intel.com, jacob.e.keller@intel.com,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Mon, 27 Apr 2026 17:43:57 +0100
Message-ID: <20260427164357.1227583-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423130405.139568-4-jtornosm@redhat.com>
References: <20260423130405.139568-4-jtornosm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1777308244;
 bh=wKIY3PMnej7pArpikhLOSs8krStKOs1qix0SOQmNecA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tGSOJSFZK7W2BeZeFd0/3P9QJ0274sr8/HSIOVmOy4Li3fTQhVIiJ39Dq/nNoXPNL
 gZz98ZPZaIqvddoAANT3I1/qEfDO379sOVfmvXQ5vJZc1a0FghNpEDmPTAtM3x4Gf8
 ghiAtIgaCwlnEv0aSoZCLl9G7tM4/5mvKe3tqnE5Bp4w3Pa+ZhPWHyJRtECbqVkcfU
 PccYEqgWhdzcqDTzlhGFBhqbPrW7Rwg/MGf4zF/mRwbRU/ytZSKhDqw8unENe6IRYM
 /b4BkMVAAWMjx5+J9bJrpxEZicfhfiM1bWX1YfGxZar1xKrr2zSVevEqohjgUa5ldM
 UGFfh1BoeN+kg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=tGSOJSFZ
Subject: Re: [Intel-wired-lan] [PATCH net v4 3/4] iavf: send MAC change
 request synchronously
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

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
iavf: send MAC change request synchronously

This commit updates the MAC address setting in the iavf driver to be
synchronous. It sends the virtchnl message directly and polls the admin
queue for the response, rather than relying on the watchdog task, to avoid
deadlocks when holding the netdev instance lock.

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 67aa14350b1b01..bc5994bf2cd99d 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c

[ ... ]

> @@ -1067,25 +1109,20 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
>  		return -EADDRNOTAVAIL;
>  
>  	ret = iavf_replace_primary_mac(adapter, addr->sa_data);
> -
>  	if (ret)
>  		return ret;
>  
> -	ret = wait_event_interruptible_timeout(adapter->vc_waitqueue,
> -					       iavf_is_mac_set_handled(netdev, addr->sa_data),
> -					       msecs_to_jiffies(2500));
> -
> -	/* If ret < 0 then it means wait was interrupted.
> -	 * If ret == 0 then it means we got a timeout.
> -	 * else it means we got response for set MAC from PF,
> -	 * check if netdev MAC was updated to requested MAC,
> -	 * if yes then set MAC succeeded otherwise it failed return -EACCES
> -	 */
> -	if (ret < 0)
> +	ret = iavf_set_mac_sync(adapter, addr->sa_data);
> +	if (ret) {
> +		/* Rollback for local failures (timeout, send error, -EBUSY).
> +		 * Note: If PF rejects the request (sends error response),
> +		 * iavf_virtchnl_completion() automatically calls
> +		 * iavf_mac_add_reject(), ret=0, and this is not executed.
> +		 * Only local failures (no PF response received) need manual rollback.
> +		 */
> +		iavf_mac_add_reject(adapter);
>  		return ret;
> -
> -	if (!ret)
> -		return -EAGAIN;
> +	}

Does the manual rollback in iavf_set_mac() need to restore adapter->hw.mac.addr?

Before calling iavf_set_mac_sync(), iavf_replace_primary_mac() optimistically
updates adapter->hw.mac.addr to the new MAC address and unsets the is_primary
flag on the old MAC filter. If iavf_set_mac_sync() fails locally,
iavf_mac_add_reject() deletes the pending new MAC filter but doesn't restore
adapter->hw.mac.addr back to netdev->dev_addr.

By contrast, the PF-rejection path in iavf_virtchnl_completion() explicitly
restores it:

	iavf_mac_add_reject(adapter);
	/* restore administratively set MAC address */
	ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);

If the local failure was a timeout and a delayed success response arrives from
the PF later, could iavf_virtchnl_completion() blindly copy the corrupted
adapter->hw.mac.addr into netdev->dev_addr? This seems like it would silently
change the interface MAC to an address already deleted from the internal list.

Additionally, on subsequent MAC change attempts, wouldn't
iavf_replace_primary_mac() search for the old filter using the corrupted
adapter->hw.mac.addr, fail to find it, and permanently leak the old filter in
the PF's hardware tables?

[ ... ]

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index a52c100dcbc56d..d1afb8261c2412 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c

[ ... ]

> @@ -2956,3 +2966,76 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
>  	} /* switch v_opcode */
>  	adapter->current_op = VIRTCHNL_OP_UNKNOWN;
>  }
> +
> +/**
> + * iavf_poll_virtchnl_response - Poll admin queue for virtchnl response
> + * @adapter: adapter structure
> + * @condition: callback to check if desired response received
> + * @cond_data: context data passed to condition callback
> + * @timeout_ms: maximum time to wait in milliseconds
> + *
> + * Polls the admin queue and processes all incoming virtchnl messages.
> + * After processing each valid message, calls the condition callback to check
> + * if the expected response has been received. The callback receives the opcode
> + * of the processed message to identify which response was received. Continues
> + * polling until the callback returns true or timeout expires.
> + * Clear current_op on timeout to prevent permanent -EBUSY state.
> + * Caller must hold netdev_lock. This can sleep for up to timeout_ms while
> + * polling hardware.
> + *
> + * Return: 0 on success (condition met), -EAGAIN on timeout, or error code
> + **/
> +int iavf_poll_virtchnl_response(struct iavf_adapter *adapter,
> +				bool (*condition)(struct iavf_adapter *adapter,
> +						  const void *data,
> +						  enum virtchnl_ops v_op),
> +				const void *cond_data,
> +				unsigned int timeout_ms)
> +{

[ ... ]

> +		if (iavf_clean_arq_element(hw, &event, &pending) == IAVF_SUCCESS) {
> +			received_op = (enum virtchnl_ops)le32_to_cpu(event.desc.cookie_high);
> +			if (received_op != VIRTCHNL_OP_UNKNOWN) {
> +				v_retval = le32_to_cpu(event.desc.cookie_low);
> +
> +				iavf_virtchnl_completion(adapter, received_op,
> +							 (enum iavf_status)v_retval,
> +							 event.msg_buf, event.msg_len);
> +
> +				if (condition(adapter, cond_data, received_op)) {
> +					ret = 0;
> +					break;
> +				}
> +			}
> +
> +			memset(event.msg_buf, 0, IAVF_MAX_AQ_BUF_SIZE);
> +
> +			if (pending)
> +				continue;
> +		}
> +
> +		usleep_range(50, 75);
> +	} while (time_before(jiffies, timeout));
> +
> +	if (ret == -EAGAIN && adapter->current_op != VIRTCHNL_OP_UNKNOWN)
> +		adapter->current_op = VIRTCHNL_OP_UNKNOWN;

Could clearing adapter->current_op on timeout cause overlapping virtchnl
commands and state corruption?

If the timeout expires and adapter->current_op is forced to
VIRTCHNL_OP_UNKNOWN, the VF watchdog might consider the admin queue free
and send a new command while the PF is still actively processing the
timed-out request.

If the PF eventually completes the timed-out request and sends a late response,
iavf_virtchnl_completion() will process it. At the end of
iavf_virtchnl_completion(), the driver unconditionally clears the state:

	adapter->current_op = VIRTCHNL_OP_UNKNOWN;

Would this prematurely clear the tracking state for the newly in-flight
overlapping command, compounding the state machine corruption and allowing
even more commands to be sent concurrently?

> +
> +	kfree(event.msg_buf);
> +	return ret;
> +}
