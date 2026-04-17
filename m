Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F36F43695
	for <intel-wired-lan@archiver.kernel.org>; Fri, 17 Apr 2026 11:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 326EE40D68;
	Fri, 17 Apr 2026 11:47:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n-YFSbWKdQXI; Fri, 17 Apr 2026 11:47:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BED9B40C1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776426476;
	bh=PlxeVhhHv4T+PAqlEkquzO+Yov3VJyz1rqzZQ+l3VkA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A1R+EnU/v78gbmCG0RyCEfuara2G0SiilDKD3+rM9LISHZF12OMG3TtwTPiU1i+Iw
	 uNbY9HinV8vXsZt5P+f4nxOH0Kru/NVROpsoQq+RRjDhEgisjuAEsimkDckVG8qzEQ
	 oVZ+SZKSOAGzIKIYmKofixWgX+1WhSHFvfD0C5fTE7YyM601h+wajDGwXim+TyJ+mW
	 wVEBBSFVpznyZLvqJ3lsJk9ZEfjx70vegVgC0xV3KnY/bH8kaYMQFLQj/yQhJuCMNq
	 tH4OZhWktZEuFl80jGEPoGW4c3vkjg7P8OK0iO1ZEXri1Zke/csdKN5s8A1Vvq9lms
	 xdPGLo3EUFeOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BED9B40C1E;
	Fri, 17 Apr 2026 11:47:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 89223259
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 11:47:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F0F38133F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 11:47:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vlS-zI6HcKz3 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 17 Apr 2026 11:47:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 74C578133E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 74C578133E
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 74C578133E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 11:47:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 31C3D60128;
 Fri, 17 Apr 2026 11:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5955BC19425;
 Fri, 17 Apr 2026 11:47:49 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: jtornosm@redhat.com
Cc: 'Simon Horman' <horms@kernel.org>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, przemyslaw.kitszel@intel.com
Date: Fri, 17 Apr 2026 12:45:04 +0100
Message-ID: <20260417114503.95952-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414110006.124286-6-jtornosm@redhat.com>
References: <20260414110006.124286-6-jtornosm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776426471;
 bh=AtVtjGo9WOREHNaDjSoboeKkxL/Kp+QHhxeYdDR6xfI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CUiC5yRgmyP7P9p95Zt3Q+pWNdJX9HnmB+keAuM7rQElcJyXk3dXvH/n+mWl+iFkb
 Qg12aL0yWXxjBNd8fP/+PjgaLDHQrFoyjL7+dqRn7heCK/Ykwkqx668hACQ/kB1TEM
 plGrtNWcrq9lRMiKAz2Y8TF+EA2xWyg40xyLsgLyKtk8k+HILvJpatUlmp5qi8DGRS
 CX3vOT9uGkl9tQbg+7dbWIzV1mhrVMQBEydndmc+LiUTGwOC7i/pbHQ/Tz6TbiSLbF
 FYVmPt8aQgnkQhq5FBWoreBkrDHeMqZtQWxY4zcIF7+KCA0tJjvIe4uq/D8apdJ7K2
 xzpOqj9UYRwtQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=CUiC5yRg
Subject: Re: [Intel-wired-lan] [PATCH net v3 5/5] iavf: refactor virtchnl
 polling into single function
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
iavf: refactor virtchnl polling into single function

This commit consolidates the init-time and runtime virtchnl message polling
logic into a single enhanced iavf_poll_virtchnl_msg() function.

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
[ ... ]
> +int iavf_poll_virtchnl_msg(struct iavf_hw *hw, struct iavf_arq_event_info *event,
> +			   enum virtchnl_ops op_to_poll, unsigned int timeout_ms,
> +			   bool (*condition)(struct iavf_adapter *, const void *),
> +			   const void *cond_data)
>  {
[ ... ]
> +	do {
> +		if (timeout_ms && iavf_virtchnl_completion_done(adapter, condition,
> +								cond_data, op_to_poll))
> +			return 0;
>  
> +		status = iavf_clean_arq_element(hw, event, &pending);
> +		if (status == IAVF_SUCCESS) {
> +			received_op = (enum virtchnl_ops)le32_to_cpu(event->desc.cookie_high);
>  
> +			/* Handle reset events specially */
> +			if (received_op == VIRTCHNL_OP_EVENT) {
> +				struct virtchnl_pf_event *vpe =
> +					(struct virtchnl_pf_event *)event->msg_buf;
>  
> +				if (vpe->event != VIRTCHNL_EVENT_RESET_IMPENDING)
> +					continue;

If received_op is VIRTCHNL_OP_EVENT but not VIRTCHNL_EVENT_RESET_IMPENDING,
the loop executes continue. Does this mean that during runtime polling (when
timeout_ms > 0), other asynchronous events like VIRTCHNL_EVENT_LINK_CHANGE
bypass iavf_virtchnl_completion() entirely and get discarded?

> +
> +				dev_info(&adapter->pdev->dev,
> +					 "Reset indication received from the PF\n");
> +				if (!(adapter->flags & IAVF_FLAG_RESET_PENDING))
> +					iavf_schedule_reset(adapter,
> +							    IAVF_FLAG_RESET_PENDING);
> +
> +				return -EIO;
> +			}
> +
> +			v_retval = le32_to_cpu(event->desc.cookie_low);
> +
> +			if (!timeout_ms) {
> +				if (received_op == op_to_poll)
> +					return virtchnl_status_to_errno((enum virtchnl_status_code)
> +							v_retval);
> +			} else {
> +				iavf_virtchnl_completion(adapter, received_op,
> +							 (enum iavf_status)v_retval,
> +							 event->msg_buf, event->msg_len);
> +			}
> +
> +			if (pending)
> +				continue;

When pending is true, the loop proceeds to the next iteration before executing
the memset buffer clearing code below. Might this leave stale data in
event->msg_buf for the next iavf_clean_arq_element() call if the subsequent
message is smaller than the previous one? The original implementation zeroed
the buffer before checking pending.

> +		} else if (!timeout_ms) {
> +			return iavf_status_to_errno(status);
> +		}
>  
> +		if (timeout_ms) {
> +			memset(event->msg_buf, 0, IAVF_MAX_AQ_BUF_SIZE);

The size passed to memset is hardcoded to IAVF_MAX_AQ_BUF_SIZE. If a caller
ever provides a timeout but passes a smaller buffer in the event structure,
could this write out of bounds?

For example, other callers like iavf_get_vf_supported_rxdids() use an 8-byte
stack variable for event->msg_buf with event->buf_len set to 8. Would it be
safer to use event->buf_len here instead of the hardcoded macro?

> +			usleep_range(50, 75);
>  		}
>  
> +	} while (!timeout_ms || time_before(jiffies, timeout));
