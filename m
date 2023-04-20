Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA1EC77B76
	for <intel-wired-lan@archiver.kernel.org>; Thu, 20 Apr 2023 14:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D2E5608A6;
	Thu, 20 Apr 2023 14:36:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D2E5608A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1682001385;
	bh=/d7CpL1ATMcbRFrP2thhFUUxqyIuhg6o/BQOd/j3jz0=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=L9LtL18cyzwRYx0DpPjPGUjp6+TFt9YcI6Zbi82xheSg2aPpX9dmOrRIye4SR5nD4
	 OTWS8j1Ybj1o1XR/aEvmfKQWOLBJ3dnrfFgIjeQoz3XKHorAxyUIMsLXTvRPYNjsyz
	 +3sfFaZYN+Faecid759AehKjRHP5eQfCAfuBL17sdkVNLD7xXBj2zGqgszfJAfBVlC
	 UiEAZEQ09Fj8nBDKzyMC9lBUcX8aq8PAUVssntecBKnJ5aTDorLaaPn9xG3R9QlgvN
	 cMHNuLmiwmtxpFXwlpmp2DzwBwhiXo1aCHw3dX3/k86YPIwJpKll8q45ob0CqYpu2o
	 8if5Xi13OANMw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZxGAsdnNp82d; Thu, 20 Apr 2023 14:36:24 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A7B660AAD;
	Thu, 20 Apr 2023 14:36:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2A7B660AAD
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 268401BF836
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Apr 2023 14:36:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0C0A683B12
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Apr 2023 14:36:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0C0A683B12
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id St-UvteZViwR for <intel-wired-lan@lists.osuosl.org>;
 Thu, 20 Apr 2023 14:36:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 606DF8214F
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 606DF8214F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Apr 2023 14:36:22 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A501A64A05;
 Thu, 20 Apr 2023 14:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FC7C433D2;
 Thu, 20 Apr 2023 14:36:20 +0000 (UTC)
Date: Thu, 20 Apr 2023 07:36:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Duoming Zhou <duoming@zju.edu.cn>
Message-ID: <20230420073619.6001cb27@kernel.org>
In-Reply-To: <20230420140157.22416-1-duoming@zju.edu.cn>
References: <20230420140157.22416-1-duoming@zju.edu.cn>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1682001381;
 bh=CiPDXZ/3Ibo+b4cOGX7CAnSBNa4vesz4gA9rJfwtNJY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=SqLfS3bEgPPg/oItrzysDOaivBXR/CmHP8N6K/BAYMHYjVAb2po9WtA+GuneI/OnQ
 65w16wfhnNGEjJ+utePwRCfEEvHwPfS03ECUjyPhs890Rx7SbrNP/HP/j16nkjK2iS
 CbB6hOpYlPxaII7vHl1UA6nud8xDuUtiZWoea0L6FmMhdJwH8cYJMgf1ZC3/IwK7Xn
 mDZeGqQzoCSq2INHZBO4JsMW+QnVLFdAKhLK+aHtvKg+Xu46CnCK5za8UsTeoAKPh0
 kZJyjhs+kKYPyD9GmbkLz4pXmXoLsynfLj2YOTDBgb3Kvv+R7HiapmrGwVsJAbEDZy
 3O+lDja0Wzb7Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=SqLfS3bE
Subject: Re: [Intel-wired-lan] [PATCH net] ethernet: ixgb: fix use after
 free bugs caused by circular dependency problem
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jesse.brandeburg@intel.com, edumazet@google.com, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 20 Apr 2023 22:01:57 +0800 Duoming Zhou wrote:
> The watchdog_timer can schedule tx_timeout_task and tx_timeout_task
> can also arm watchdog_timer. The process is shown below:
> 
> ----------- timer schedules work ------------
> ixgb_watchdog() //timer handler
>   schedule_work(&adapter->tx_timeout_task)
> 
> ----------- work arms timer ------------
> ixgb_tx_timeout_task() //workqueue callback function
>   ixgb_up()
>     mod_timer(&adapter->watchdog_timer,...)
> 
> When ixgb device is detaching, the timer and workqueue
> could still be rearmed. The process is shown below:
> 
>   (cleanup routine)           |  (timer and workqueue routine)
> ixgb_remove()                 |
>                               | ixgb_tx_timeout_task() //workqueue
>                               |   ixgb_up()
>                               |     mod_timer()
>   cancel_work_sync()          |
>   free_netdev(netdev) //FREE  | ixgb_watchdog() //timer
>                               |   netif_carrier_ok(netdev) //USE
> 
> This patch adds timer_shutdown_sync() in ixgb_remove(), which
> could prevent rearming of the timer from the workqueue.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

The driver has been removed. No point.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
