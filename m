Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B19CC43458
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Jul 2026 17:02:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28AA160DDC;
	Wed,  8 Jul 2026 17:02:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z8FKCxbjDYlb; Wed,  8 Jul 2026 17:02:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A48960D9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1783530164;
	bh=nzA7oP4dBhbWOn+fQw3xQ+2T7d/x7OIJEku8W4h5UBE=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dSE2bFwQtZuCBkirL7qfA/wLChee++i0xP9YhrvnOZxUsxu9Mmmru97foPqc7gnn0
	 9O1mHoic9hygNfh4KnCf2bUVTqnyL+293YeG+K5mTb3bB0z9qWeGD8YqJkjMQM+gAj
	 I/l5ZEdBsD6U5UvHJG7p30mlZ/row0KZer3mjMN8EgtM+GsDXI7XbmdCGMD7qv/lZk
	 VUFGqhwGjuHPmwOQ3shDUcut0KnspZx627HUFMeNptT0L3WYkw89ueTXqiUO2hfF3x
	 EXo2gGqLGxsTfrCngpnD4JVOp5XY+NvJTyj67Jtn7ZwtLzHnlDBiwDU/XDZNt4IkfK
	 4MoTh1xGyM3ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A48960D9F;
	Wed,  8 Jul 2026 17:02:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 66B0630D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Jul 2026 17:02:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 58D1D4030E
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Jul 2026 17:02:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2jPK79lStc8O for <intel-wired-lan@lists.osuosl.org>;
 Wed,  8 Jul 2026 17:02:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 55EF5400AD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 55EF5400AD
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 55EF5400AD
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Jul 2026 17:02:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EEA9940114;
 Wed,  8 Jul 2026 17:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02EC1F000E9;
 Wed,  8 Jul 2026 17:02:39 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: jedrzej.jagielski@intel.com
Cc: Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org
Date: Wed,  8 Jul 2026 18:02:35 +0100
Message-ID: <20260708170235.1514479-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702091553.57112-7-jedrzej.jagielski@intel.com>
References: <20260702091553.57112-7-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1783530160;
 bh=nzA7oP4dBhbWOn+fQw3xQ+2T7d/x7OIJEku8W4h5UBE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ch+RHaQYkCe4qNb6Wq0QOHNmTaJ+Y9DWdDjNtKj/BFVWAZsjWecsq7YvQR79BFfS2
 EPf0tY2UpdoQXigoM/6do3LyGtem6kRIgQgTqeNPMTHgzmytOrSOxcym/InUQObCM5
 Fxx6k7ipOrcvyF+PkIGp71EXYt45N6hO1KQun60ltxC0i/rh9BIXtzb7NSQ2N/3Z5c
 0h6dAO0RpQTxkRA0glBguO93QvbSU/OYQqZYE7zfOs/ZGCT+GG26PjaiSdlv4bC4Tz
 Ls4vbM1dyEpE2oCun1us+U5EwFXknSEzTmTrGVJdEx//SlxgFe0+B4GA3zoahNBAXJ
 av/b2ATrr/iFQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ch+RHaQY
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 6/6] ixgbe: take rtnl lock
 before ixgbe_reset() is called
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

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ixgbe: take rtnl lock before ixgbe_reset() is called

Previous commit introduced ixgbe_mac_addr_refresh which touches netdev
struct by updating mac addr. It should operate after taking rtnl lock.
One of the callers is ixgbe_reset(). Most of scenarios when ixgbe_reset()
is called met taking lock requirement, but there is a ixgbe_resume() path
which calls ixgbe_reset() -> ixgbe_mac_addr_refresh() without taking
the lock. So there is a risk of race.

Move rtnl_lock() before ixgbe_reset() is called.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index eb05c2f982e8e..aa5a61f95d883 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -7535,11 +7535,11 @@ static int ixgbe_resume(struct device *dev_d)
>  
>  	device_wakeup_disable(dev_d);
>  
> +	rtnl_lock();
>  	ixgbe_reset(adapter);

[Severity: High]
This patch fixes the missing rtnl_lock() in ixgbe_resume(), but is this fix 
incomplete? 

It looks like there are still other paths that call ixgbe_reset() without 
acquiring rtnl_lock(), which would trigger the same race condition and 
ASSERT_RTNL() warning on the MAC address update. 

For example, the PCI error recovery handler calls it directly:

ixgbe_io_slot_reset() {
	...
	ixgbe_reset(adapter);
	...
}

And the service task can also call it without rtnl_lock():

ixgbe_handle_fw_event() {
	...
	ixgbe_down(adapter); /* calls ixgbe_reset() */
	...
}

[Severity: High]
This isn't a bug introduced by this patch, but does ixgbe_reset() also modify 
the unicast address list without the required lock?

ixgbe_reset() directly calls __dev_uc_unsync(netdev, NULL) which iterates 
over and modifies the dev->uc address list. However, __dev_uc_unsync() is a 
lockless helper that expects the caller to hold netif_addr_lock_bh(netdev). 

Since the callers of ixgbe_reset() only hold rtnl_lock() (or no lock), 
could this cause list corruption or use-after-free if the device resets 
concurrently with unicast address modifications?

[Severity: High]
This is a pre-existing issue, but does ixgbe_reset() use an ad-hoc 
synchronization mechanism instead of standard primitives?

Inside ixgbe_reset():

	/* lock SFP init bit to prevent race conditions with the watchdog */
	while (test_and_set_bit(__IXGBE_IN_SFP_INIT, &adapter->state))
		usleep_range(1000, 2000);

Reimplementing a lock with test_and_set_bit() and usleep_range() lacks 
deadlock detection (lockdep visibility), priority inheritance, and fairness. 

Should this use a proper mutex or spinlock instead of spinning on a bit flag?

>  
>  	IXGBE_WRITE_REG(&adapter->hw, IXGBE_WUS, ~0);
>  
> -	rtnl_lock();
>  	err = ixgbe_init_interrupt_scheme(adapter);
