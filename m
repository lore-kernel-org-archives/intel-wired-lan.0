Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A51E8536F
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Apr 2026 13:39:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DB4960A43;
	Fri,  3 Apr 2026 13:39:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QPnCXpIC70UT; Fri,  3 Apr 2026 13:39:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9DA3360A38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775223540;
	bh=Q9Uh+oO9LIJMEEOhSdY5kkN7VXeuWN5736sJFQRFp5s=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ef9m612uuXSjhkbS5vUW5UirGBjrH+SXwoymy/z2nrWvWxEDhvjmjY2ykrjQmbeRL
	 rpzNU63ZYwl3NsL38te5thHMZ2xjJOve6bcDi6smEv299ZEsD55XFPffnzhSMZNm8/
	 OPA4o+WSmQFG+JOfnEagMLg0y58w82eyNlOLN41cCxpHF/OZEPwxZ6wYS0Jq1Tyqpl
	 7iT9YMlrXIVSmT9YDR2KdQBOXxS3zADmnHwzYxQDdU+4y+mJHbxqNj6DJt6Tjop0r1
	 f8YMUWXl34oe08PsWC2BCD7dbimDlJgQiI5krlj0KGVrlZqMQCFUE5G/uTBKdKvYwJ
	 F6MiI6ynBJmHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DA3360A38;
	Fri,  3 Apr 2026 13:39:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2679D2CC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 13:39:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0BFAF81D24
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 13:39:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Np-1LUggm_ok for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Apr 2026 13:38:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6975E81D02
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6975E81D02
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6975E81D02
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 13:38:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6711060008;
 Fri,  3 Apr 2026 13:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26ADFC4CEF7;
 Fri,  3 Apr 2026 13:38:56 +0000 (UTC)
Date: Fri, 3 Apr 2026 14:38:54 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
Message-ID: <20260403133854.GE113102@horms.kernel.org>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
 <20260327073046.134085-6-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327073046.134085-6-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1775223538;
 bh=ON/nNOqI/OkiuXpJNKeSHyA+bBRHeRwSkEFs+cCTYWY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=len1WXHU9M1UIQTj5jzzxQ3gZLAvL9TzQU0+Z2peuAmauY94FrLx09aCQDeptmN+D
 VjjSK+y1h/jmipcNVHbd9Xrr88NmqYWgjRNZcWg7jopv0Qt3T4sIFqQDYVKCkvJaoA
 vAbxrjGKUQFqYGAh/6H3G66wQqtFCtAlEqHKa+24ksv/ZTgXibjWUwYOLE0V981SLD
 LPlJhT+4TQ/0LpcMnylbUDOr11yIebnPnyLEA1TVUrZvl1MAvtWNm6y+AwZ5yJ4UJ9
 4AE7nZw5f6iJyKQrq0lNZQJSlhP4a1TryDwjzLcYuNg+pMUNzQwIrdtY0ocACanoLN
 ev+1aq89tMdEA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=len1WXHU
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ixgbe: call ixgbe_setup_fc()
 before fc_enable() after NVM update
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

On Fri, Mar 27, 2026 at 08:30:40AM +0100, Aleksandr Loktionov wrote:
> From: Radoslaw Tyl <radoslawx.tyl@intel.com>
> 
> During an NVM update the PHY reset clears the Technology Ability Field
> (IEEE 802.3 clause 37 register 7.10) back to hardware defaults.  When
> the driver subsequently calls only hw->mac.ops.fc_enable() the SRRCTL
> register is recalculated from the stale autonegotiated capability bits,
> which the MDD (Malicious Driver Detect) logic treats as an invalid
> change and halts traffic on the PF.
> 
> Fix by calling ixgbe_setup_fc() immediately before fc_enable() in
> ixgbe_watchdog_update_link() so that flow-control autoneg and the
> PHY registers are re-programmed in the correct order after any reset.
> 
> Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

This feels like a fix that should have a Fixes tag and be routed
via iwl-net. And some explanation of what effect this has on the user.

Otherwise, please reword the commit message to make it clear this
is not a bug fix.

...
