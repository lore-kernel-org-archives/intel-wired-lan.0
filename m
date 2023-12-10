Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BCBC4167B
	for <intel-wired-lan@archiver.kernel.org>; Sun, 10 Dec 2023 11:50:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 847F76104C;
	Sun, 10 Dec 2023 11:50:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 847F76104C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702209018;
	bh=zccENANq/fnZ8bgPb6JScKLR13WH5n9TlOFrgukxBg4=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=OODZTn4ogmH0mL757tj4Bp7hbh7ijz2zY9cpdPBJThOoDyjvVkV62yHNWVxaiF1/y
	 zhcNjD4RATPBpmBUIpg/YfNG2Iw0wqe09bMiBjx/mk6UaF36/8WWqp26dQbaBsM7G6
	 YBYYL0ZsnXpHE0b7QDJl94wL3DR4iybRqrmH0tIJbb/4xLkCeF7kMi0Ve4Mf3i6INT
	 /JLVXjS9cUq9MKnh6aedywknjfen/kv4gwWF/rzwnHbZt8/hrOXSy+1LpueSd7a9bZ
	 sR0aWc4wLzKSF66YBabzAbzcufIAuafNtai8EetSGSUT7XYhe5/Kzug1FImL15GEmU
	 K76Z1eoGd3uIw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kImOWqetuGXS; Sun, 10 Dec 2023 11:50:17 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87CAB6104E;
	Sun, 10 Dec 2023 11:50:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 87CAB6104E
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 89EAE1BF593
 for <intel-wired-lan@lists.osuosl.org>; Sun, 10 Dec 2023 11:50:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F28341527
 for <intel-wired-lan@lists.osuosl.org>; Sun, 10 Dec 2023 11:50:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F28341527
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Irn5f9k2L-hf for <intel-wired-lan@lists.osuosl.org>;
 Sun, 10 Dec 2023 11:50:15 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BBBB0408BD
 for <intel-wired-lan@lists.osuosl.org>; Sun, 10 Dec 2023 11:50:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BBBB0408BD
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id D8EEEB80A48;
 Sun, 10 Dec 2023 11:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5138C433C7;
 Sun, 10 Dec 2023 11:50:10 +0000 (UTC)
Date: Sun, 10 Dec 2023 11:50:07 +0000
From: Simon Horman <horms@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Message-ID: <20231210115007.GH5817@kernel.org>
References: <20231206140718.57433-1-kurt@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231206140718.57433-1-kurt@linutronix.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1702209013;
 bh=nQSIKETL4cIFCIbVW5Lsz+1L3/MB2QWHSDc0NxIJQEM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MOxVeJgHOOMRna/HW4cFKZIIYcRQqETPNwvF0zXDgqFI4dn5tqk2147+EmWvmlrXd
 BC+uXMXZ++0JryrqSN6UURjhctB9bjEdTl2fGWg3y8C2vaGWHaxeUu0hyDgrOjj9Qj
 HlxcwYAlJgdjgYtuTAaADFDOp97yM7/UvQ/Y74W+K0tWh0fkg4NCw5cgJgGY4fo9Lh
 4TNrR+hDMQktsBtbO6aEAcEmL4m5m5JT5k9/cBQMPXlie4jQa7L0JYYGpaniHQ6xWv
 M+XGKG29AMwq7oufZgeodGnYWy6SZhUtxJ+HzRHY9QjhTfo54ItvdCFuxqmx3ZAceV
 HasXGRxeMLMjw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=MOxVeJgH
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] igc: Check VLAN EtherType mask
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
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Suman Ghosh <sumang@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Dec 06, 2023 at 03:07:18PM +0100, Kurt Kanzenbach wrote:
> Currently the driver accepts VLAN EtherType steering rules regardless of
> the configured mask. And things might fail silently or with confusing error
> messages to the user. The VLAN EtherType can only be matched by full
> mask. Therefore, add a check for that.
> 
> For instance the following rule is invalid, but the driver accepts it and
> ignores the user specified mask:
> |root@host:~# ethtool -N enp3s0 flow-type ether vlan-etype 0x8100 \
> |             m 0x00ff action 0
> |Added rule with ID 63
> |root@host:~# ethtool --show-ntuple enp3s0
> |4 RX rings available
> |Total 1 rules
> |
> |Filter: 63
> |        Flow Type: Raw Ethernet
> |        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> |        Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> |        Ethertype: 0x0 mask: 0xFFFF
> |        VLAN EtherType: 0x8100 mask: 0x0
> |        VLAN: 0x0 mask: 0xffff
> |        User-defined: 0x0 mask: 0xffffffffffffffff
> |        Action: Direct to queue 0
> 
> After:
> |root@host:~# ethtool -N enp3s0 flow-type ether vlan-etype 0x8100 \
> |             m 0x00ff action 0
> |rmgr: Cannot insert RX class rule: Operation not supported
> 
> Fixes: 2b477d057e33 ("igc: Integrate flex filter into ethtool ops")
> Suggested-by: Suman Ghosh <sumang@marvell.com>
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
