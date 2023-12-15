Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C744C4332F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 15 Dec 2023 16:29:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EA2A4179A;
	Fri, 15 Dec 2023 16:29:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0EA2A4179A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702657749;
	bh=Qi931pzx6MkpCuJBD7E4HQ/4rGSurhd5kkZdFtstSLM=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=xJAZ9TMvsUpsaynYOvJb4bgb0uIenRrxXfJU0z+SYrAmmx+7iu96FQGkW3qGNCS7g
	 FJP9Pa3uI/Z3jS1MZbrOoHHQz6zPwCE3+0yDbl9ARb03U3bZhbzHzRD/8y+Lzttv7g
	 q4lFqL3Bl69kTPWsfmvRihasyeANYQ59Lhz8aMMHwpfALvT0rXano/Pd48yl9OF7Jf
	 2LN+ceEBg6lAzWKxN/tJ7pqPg0T9AF1lU/s5Kjh/K6IgNoP3UyY9ZILvFye6X80Bii
	 aUMfj+QHUaRM1wCG/Gi0xXsa5KOvGfbeJ7OkWHCycyXbrAP5bupStOVa/O9wyHiloX
	 6SJMngwGy5zuw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vnp7ez33_WPJ; Fri, 15 Dec 2023 16:29:08 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE9DC417D5;
	Fri, 15 Dec 2023 16:29:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE9DC417D5
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 491361BF31F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Dec 2023 16:29:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 20E45417FA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Dec 2023 16:29:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 20E45417FA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MsUBTlgxPXvb for <intel-wired-lan@lists.osuosl.org>;
 Fri, 15 Dec 2023 16:29:05 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A7C84175B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Dec 2023 16:29:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6A7C84175B
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 66D88CE3068;
 Fri, 15 Dec 2023 16:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E3EC433C7;
 Fri, 15 Dec 2023 16:28:55 +0000 (UTC)
Date: Fri, 15 Dec 2023 16:28:53 +0000
From: Simon Horman <horms@kernel.org>
To: Ke Xiao <xiaoke@sangfor.com.cn>
Message-ID: <20231215162853.GK6288@kernel.org>
References: <20231213104912.16153-1-xiaoke@sangfor.com.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231213104912.16153-1-xiaoke@sangfor.com.cn>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1702657738;
 bh=PvK4lHEsSy91ob3n505rV6h36iVUZdMcZREAFz8vIoM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Bw58GekOTv1fN132V0rPxC3mTpZ2rfRnVJx2/4yuT1hGdR6+XjVDo8al2PNmMMkss
 5N4as3dszFFI8BfXD9Nl565+F+tYn7tDe5/V7JTNAZiUBwl7XKsJuPcWEakTcMyJoV
 ThInph7/v/oMJNek5nFo4on8mmRPLJYHuNDTtyJ9abgXtXfYAufE3ZiSr+BhVnZ51c
 /38Mcf5MKn8zkBBMBWZgys+/TBc2oY18mlziMnAX2AtQ2m1pw9iriJoYiWZIvD4h7a
 +0FGQMMRH8Q9tqpOAG/X2EonSojEwjnFLRhBnAWIcNJDQJLsLjzMbWUWwlzf59mYUp
 DfFpdK6xWX+UA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Bw58GekO
Subject: Re: [Intel-wired-lan] [net PATCH] i40e: fix use-after-free in
 i40e_aqc_add_filters()
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
Cc: zhudi2@huawei.com, intel-wired-lan@lists.osuosl.org, dinghui@sangfor.com.cn,
 jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org, edumazet@google.com,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Dec 13, 2023 at 06:49:11PM +0800, Ke Xiao wrote:
> Commit 3116f59c12bd ("i40e: fix use-after-free in
> i40e_sync_filters_subtask()") avoided use-after-free issues,
> by increasing refcount during update the VSI filter list to
> the HW. However, it missed the unicast situation.
> 
> When deleting an unicast FDB entry, the i40e driver will release
> the mac_filter, and i40e_service_task will concurrently request
> firmware to add the mac_filter, which will lead to the following
> use-after-free issue.
> 
> Fix again for both netdev->uc and netdev->mc.
> 
> BUG: KASAN: use-after-free in i40e_aqc_add_filters+0x55c/0x5b0 [i40e]
> Read of size 2 at addr ffff888eb3452d60 by task kworker/8:7/6379
> 
> CPU: 8 PID: 6379 Comm: kworker/8:7 Kdump: loaded Tainted: G
> Workqueue: i40e i40e_service_task [i40e]
> Call Trace:
>  dump_stack+0x71/0xab
>  print_address_description+0x6b/0x290
>  kasan_report+0x14a/0x2b0
>  i40e_aqc_add_filters+0x55c/0x5b0 [i40e]
>  i40e_sync_vsi_filters+0x1676/0x39c0 [i40e]
>  i40e_service_task+0x1397/0x2bb0 [i40e]
>  process_one_work+0x56a/0x11f0
>  worker_thread+0x8f/0xf40
>  kthread+0x2a0/0x390
>  ret_from_fork+0x1f/0x40
> 
> Allocated by task 21948:
>  kasan_kmalloc+0xa6/0xd0
>  kmem_cache_alloc_trace+0xdb/0x1c0
>  i40e_add_filter+0x11e/0x520 [i40e]
>  i40e_addr_sync+0x37/0x60 [i40e]
>  __hw_addr_sync_dev+0x1f5/0x2f0
>  i40e_set_rx_mode+0x61/0x1e0 [i40e]
>  dev_uc_add_excl+0x137/0x190
>  i40e_ndo_fdb_add+0x161/0x260 [i40e]
>  rtnl_fdb_add+0x567/0x950
>  rtnetlink_rcv_msg+0x5db/0x880
>  netlink_rcv_skb+0x254/0x380
>  netlink_unicast+0x454/0x610
>  netlink_sendmsg+0x747/0xb00
>  sock_sendmsg+0xe2/0x120
>  __sys_sendto+0x1ae/0x290
>  __x64_sys_sendto+0xdd/0x1b0
>  do_syscall_64+0xa0/0x370
>  entry_SYSCALL_64_after_hwframe+0x65/0xca
> 
> Freed by task 21948:
>  __kasan_slab_free+0x137/0x190
>  kfree+0x8b/0x1b0
>  __i40e_del_filter+0x116/0x1e0 [i40e]
>  i40e_del_mac_filter+0x16c/0x300 [i40e]
>  i40e_addr_unsync+0x134/0x1b0 [i40e]
>  __hw_addr_sync_dev+0xff/0x2f0
>  i40e_set_rx_mode+0x61/0x1e0 [i40e]
>  dev_uc_del+0x77/0x90
>  rtnl_fdb_del+0x6a5/0x860
>  rtnetlink_rcv_msg+0x5db/0x880
>  netlink_rcv_skb+0x254/0x380
>  netlink_unicast+0x454/0x610
>  netlink_sendmsg+0x747/0xb00
>  sock_sendmsg+0xe2/0x120
>  __sys_sendto+0x1ae/0x290
>  __x64_sys_sendto+0xdd/0x1b0
>  do_syscall_64+0xa0/0x370
>  entry_SYSCALL_64_after_hwframe+0x65/0xca
> 
> Fixes: 3116f59c12bd ("i40e: fix use-after-free in i40e_sync_filters_subtask()")
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Signed-off-by: Ke Xiao <xiaoke@sangfor.com.cn>
> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> Cc: Di Zhu <zhudi2@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
