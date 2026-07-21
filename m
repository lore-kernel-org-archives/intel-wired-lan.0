Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8122EC4452D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 21 Jul 2026 20:53:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3727A6089A;
	Tue, 21 Jul 2026 20:53:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uNg5FZ6ZI8Ro; Tue, 21 Jul 2026 20:53:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B7FA560692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784667201;
	bh=M+vbEhNomgWsvX0xx1+0wzbB/AAojB8yVvZ1w8lBpQ4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zvRU1n8sIIxTwj7XQdzSTwRpjIn/Qq/5QgwBb//uIYXRLmzSwUwh4vY28L9jv4THF
	 CZFyQmtIUr0jLqbSQn96K5m47GA4obetvZLnClpaoVuJyRTbeVwwPl+h+EIOVJlTSQ
	 W8j+s/7SA/FUAoixOOG6jf44EEsSAhKq+fvFhLezITxBH/CkhpZLfXcj0JAWa9BeF9
	 NlFS/HxzhXcnCx4/KRfYzk4iKXmWY7VWjtt/e514EzU8dnHgL2U5TmxLOoAUAcYpLl
	 Nzz5xyfHd8P4X+j5a0WxSRxRQKICiQeivFvdvClwL03xGh31GsovXLvepW7F0mhJVB
	 bZ2W3uErxwQ2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7FA560692;
	Tue, 21 Jul 2026 20:53:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A7FD0109C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 20:53:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9970140788
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 20:53:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iCv5ENwf-jx0 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 21 Jul 2026 20:53:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E7D7F40785
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E7D7F40785
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E7D7F40785
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 20:53:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0D550601EC;
 Tue, 21 Jul 2026 20:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0CD1F00A3D;
 Tue, 21 Jul 2026 20:53:16 +0000 (UTC)
Date: Tue, 21 Jul 2026 13:53:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Pielech, Adrian" <adrian.pielech@intel.com>
Cc: <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, <pabeni@redhat.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
 <andrew+netdev@lunn.ch>
Message-ID: <20260721135315.11db9f24@kernel.org>
In-Reply-To: <2c5c3c03-7a4d-4020-84eb-825bd6ed1e78@intel.com>
References: <2c5c3c03-7a4d-4020-84eb-825bd6ed1e78@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784667196;
 bh=M+vbEhNomgWsvX0xx1+0wzbB/AAojB8yVvZ1w8lBpQ4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=JQav6trhgHNVki2mO5Vf2X9yZjD80kRPiR66itCbIBBpWqrHB+kg79HuqG/IqZxSh
 4Tr99CDV3Ji9oQLmMpamhHN5FdZNu15cR/YTsnvtBQUDfbKY+mgS6dx6fs2yj2qd38
 B+PKD47pabBU6+4f/cAoFQNzj/Qx8afSbi3N9vFwOwW1NCk2NMBaIFZqtj/GD2W7bk
 cz7nmx/y+fkHCEcZ+9aOZJ/4TZhyRpwGJih6lqg+qZe77Xr65PzfqZsqfJ1PnxQsss
 54bBW1J85Pf99L6HHja7Hpv4nm54LU+FSaVjuZ2tFmg8rVcmoDvWvVCwvib9AuKN3i
 wInH+yJyNN3ig==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JQav6trh
Subject: Re: [Intel-wired-lan] [ANN] E830 NIC join intel's netdev-ci
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

On Fri, 10 Jul 2026 13:20:40 +0200 Pielech, Adrian wrote:
> I'm pleased to announce that E830-XXVDA2 NIC from Intel Ethernet E830 
> product line joins the suite that tests ice driver against net-next-hw 
> branch.

Great to see! Any plans to split the MAINTAINERS entry for Intel
drivers to claim the "Supported" status?

I think the coverage for i40e and ice is good enough, but the entry
covers a ton of other drivers.
