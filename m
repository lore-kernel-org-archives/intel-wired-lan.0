Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DA3FF8861
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Apr 2026 10:40:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE1EC851A2;
	Mon, 27 Apr 2026 10:40:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DqllQK9aWqKo; Mon, 27 Apr 2026 10:40:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AAB3D8519C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777286449;
	bh=1awmovS6Yf6Mv/ja8hVRXRLENoAVc+c5LE5Mx5uIPpE=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yHdWcHqre8xqzcl1Vnzbb0O62ssKf4RTWl+hzLdGH9fKMsjrBHIsu7UTmZN7yY5n5
	 b25QH8BhPsEbMIUJ0vooXolWJ08TmWMDcGorvTuyw5DrwpoMtwsr+geNELPBbcuyXI
	 /sfPerWdCRCOQgsccKIiEtwcxwS00hBMqdPLzxUZn1Va0s7aJxsNyzQ4Gl6HdJFF/m
	 t+UJOagZ8mAmK9KXq/dcBrHvtVuVtNw/ZqXFoZbyJtdum1Aw88zor8GPnVIAmEcNI0
	 o11nGlxNoTev1RDkc9exRfj5MTOMxlIgQ1Oq2TDUnVCx6mFYaFunlGLl/ubEdZ35Oq
	 iA8kG7+JDdZ5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AAB3D8519C;
	Mon, 27 Apr 2026 10:40:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 680B52DF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Apr 2026 10:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 58A566F66B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Apr 2026 10:40:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hXzqhNxA6XPq for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Apr 2026 10:40:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D173861725
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D173861725
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D173861725
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Apr 2026 10:40:45 +0000 (UTC)
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id EB4764C2C37D45;
 Mon, 27 Apr 2026 12:40:17 +0200 (CEST)
Message-ID: <2d8bd703-f368-4405-9266-d0d8824455aa@molgen.mpg.de>
Date: Mon, 27 Apr 2026 12:40:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Li <boolli@google.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Decotigny <decot@google.com>, Anjali Singhai
 <anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Brian Vazquez <brianvv@google.com>, emil.s.tantilov@intel.com
References: <20260424031545.3777023-1-boolli@google.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260424031545.3777023-1-boolli@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] libie: log more info when
 virtchnl fails
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

Dear Li,


Thank you for your patch.

Am 24.04.26 um 05:15 schrieb Li Li via Intel-wired-lan:
> Virtchnl failures can be hard to debug without logs. Logging the details
> of virtchnl transactions can be useful for debugging virtchnl-related
> issues.

Why is the first added one added as error, and the second as info?

Do you have a reproducer to get each of the new log messages?

> Tested: Built and booted on a test machine.

Please paste the new messages.

> Signed-off-by: Li Li <boolli@google.com>
> ---
>   drivers/net/ethernet/intel/libie/controlq.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
> index ebc05355e39d..7eaa77413621 100644
> --- a/drivers/net/ethernet/intel/libie/controlq.c
> +++ b/drivers/net/ethernet/intel/libie/controlq.c
> @@ -762,6 +762,16 @@ libie_ctlq_xn_process_recv(struct libie_ctlq_xn_recv_params *params,
>   	status = ctlq_msg->chnl_retval ? -EFAULT : 0;
>   
>   	xn = &xnm->ring[xn_index];
> +
> +	if (ctlq_msg->chnl_retval) {
> +		dev_err_ratelimited(
> +			params->ctlq->dev,
> +			"Non-zero virtchnl ret val (msg op: %u, ret val: %u, msg_cookie: %u, data_len: %u); xn op: %u, id: %u, cookie: %u\n",
> +			ctlq_msg->chnl_opcode, ctlq_msg->chnl_retval,
> +			msg_cookie, ctlq_msg->data_len, xn->virtchnl_opcode,
> +			xn->index, xn->cookie);
> +	}
> +
>   	if (ctlq_msg->chnl_opcode != xn->virtchnl_opcode ||
>   	    msg_cookie != xn->cookie)
>   		return false;
> @@ -1011,6 +1021,11 @@ int libie_ctlq_xn_send(struct libie_ctlq_xn_send_params *params)
>   		params->recv_mem = xn->recv_mem;
>   		break;
>   	default:
> +		dev_notice_ratelimited(
> +			params->ctlq->dev,
> +			"Transaction failed (op %u, xn state: %d, id: %u, cookie: %u, size: %zu)\n",
> +			params->chnl_opcode, xn->state, xn->index, xn->cookie,
> +			xn->recv_mem.iov_len);
>   		ret = -EBADMSG;
>   		break;
>   	}


Kind regards,

Paul
