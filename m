Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AB1EF4EDC
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Apr 2026 12:30:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 616596066C;
	Mon,  6 Apr 2026 12:30:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g-mdOgo5eBtI; Mon,  6 Apr 2026 12:30:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 921A960641
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775478613;
	bh=3OLGYuWueXpAxw4Xwkb7rNrd6HvEWShajiH3l89z4JE=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TD6Bg4G2I49ocptK6Le/HvPnz/1gTG2qAbiH8JqHqMVLXygJlQ68gNd2hJrJvry8A
	 sJcEQt1nz7Sm/7SVdKWhSaEqAcrbxpzQS9MIeGKjtaJFz8DaQj3259dE4AzQRDP/Zy
	 RVcaoOZxo63BMlWPLdcV6z32TL/zqEnKOjTsh4KC8255WLCudu69llCiLIMpZWvASh
	 NDVYHTzegYc+uX3SKTtO2r+zrScIi7OWdigz7WKS6B44Q64uKH/DSjD5J7/TiZts1Z
	 5m8g81wUiRLV5oWTZNOqT4cZKgD6vZJ6ZtvEhTf1wnuKpTdWFq+YWzzFz/+4rp5Be8
	 Pd5AWmWNRj1xQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 921A960641;
	Mon,  6 Apr 2026 12:30:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D5AA9219
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Apr 2026 12:30:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C633B8078F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Apr 2026 12:30:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VnEeJSEVYZhF for <intel-wired-lan@lists.osuosl.org>;
 Mon,  6 Apr 2026 12:30:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B7DBA80785
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7DBA80785
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B7DBA80785
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Apr 2026 12:30:10 +0000 (UTC)
Received: from x1 (13.3.31.150.dy.iij4u.or.jp [150.31.3.13])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 636CTo3j080947
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 6 Apr 2026 21:29:52 +0900 (JST) (envelope-from kohei@enjuk.jp)
Date: Mon, 6 Apr 2026 21:29:50 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, stable@vger.kernel.org
Message-ID: <adOjGCms-5PBuNte@x1>
References: <20260406112057.906685-1-jtornosm@redhat.com>
 <20260406112057.906685-4-jtornosm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260406112057.906685-4-jtornosm@redhat.com>
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=3OLGYuWueXpAxw4Xwkb7rNrd6HvEWShajiH3l89z4JE=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20251215; t=1775478592; v=1;
 b=exUuEimwu+3LRSzYhW/E37U5h2mO6GNiVvGmtd5dpgX/MBhWFIRJCLhZbiiqOJDa
 0qTY6LkjTmVPE4ycnrw8xHlErDa4Lvy/wPiI9NPbZmm7QLuh53Ji8h9boEEkZZrY
 +8bgVkBfITYXHXECH6t6DfGXldKysJhXceZOAdcFCR5B3sNyXYkf2vTTYTwZZXKg
 yhR6XtxA81mCXQqIQ1iN0W6C9XTvQhqs14dxL4cnl8XI13cHGjwWN0Jk954uLN7L
 TjoH7yRrykcjXmbrOW1BOFKavYCawN7taZrMrAR7Siup5IhIzBBQWWOwHAPTl3e8
 CvTnHpqFoo5nVy8PO9RyUA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=exUuEimw
Subject: Re: [Intel-wired-lan] [PATCH net 3/3] iavf: drop netdev lock while
 waiting for MAC change completion
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

On 04/06 13:20, Jose Ignacio Tornos Martinez wrote:
> After commit ad7c7b2172c3 ("net: hold netdev instance lock during sysfs
> operations"), iavf_set_mac() is called with the netdev instance lock
> already held.
> 
> The function queues a MAC address change request and then waits for
> completion while holding this lock. However, the watchdog task that
> processes admin queue commands (including MAC changes) also needs to
> acquire the netdev lock to run.
> 
> This creates a lock contention scenario:
> 1. iavf_set_mac() holds netdev lock and waits for MAC change
> 2. Watchdog needs netdev lock to process the MAC change request
> 3. Watchdog blocks waiting for lock
> 4. MAC change times out after 2.5 seconds
> 5. iavf_set_mac() returns -EAGAIN
> 
> This particularly affects VFs during initialization when enslaved to a
> bond. The first VF typically succeeds as it's already fully initialized,
> but subsequent VFs fail as they're still progressing through their state
> machine and need the watchdog to advance.
> 
> Fix by temporarily dropping the netdev lock before waiting for MAC change
> completion, allowing the watchdog to run and process the request, then
> re-acquiring the lock before returning.
> 
> This is safe because:
> - The MAC change request is already queued before we drop the lock
> - iavf_is_mac_set_handled() just checks filter state, doesn't modify it
> - We re-acquire the lock before checking results and returning
> 
> Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
> cc: stable@vger.kernel.org
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index dad001abc908..6281858e6f3c 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -1068,10 +1068,14 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
>  	if (ret)
>  		return ret;
>  
> +	netdev_unlock(netdev);
> +
>  	ret = wait_event_interruptible_timeout(adapter->vc_waitqueue,
>  					       iavf_is_mac_set_handled(netdev, addr->sa_data),
>  					       msecs_to_jiffies(2500));
>  
> +	netdev_lock(netdev);
> +

Hi Jose, thank you for the fix and detailed explanation.

I don't have a great solution for this issue, but dropping the netdev
lock taken by the networking core in the driver callback might not look
acceptable.

FYI, Petr reported the same type of locking issue in
ndo_change_mtu(), and the v1 approach was really similar to this one.
https://lore.kernel.org/intel-wired-lan/20260202155813.3f8fbc27@kernel.org/

IIUC, the issue was eventually fixed by completing the reset
synchronously in the same context as ndo_change_mtu(), instead of
dropping the netdev lock and waiting for reset_task.
https://lore.kernel.org/intel-wired-lan/20260211191855.1532226-1-poros@redhat.com/

If that applies here as well, maybe iavf_set_mac() needs a similar
approach, e.g. progressing the relevant virtchnl request/completion
synchronously with the netdev lock held, rather than dropping the lock
here?

>  	/* If ret < 0 then it means wait was interrupted.
>  	 * If ret == 0 then it means we got a timeout.
>  	 * else it means we got response for set MAC from PF,
> -- 
> 2.53.0
> 
