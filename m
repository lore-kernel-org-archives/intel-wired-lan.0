Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE6FE7FDE0
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Feb 2026 23:58:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C052C606D3;
	Mon,  2 Feb 2026 23:58:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tt_zhPFSVGSB; Mon,  2 Feb 2026 23:58:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB71C6067E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770076697;
	bh=kxVFHLHk1GFXyxSOxpB/S03QfZtGcTHjBT1hQPIQylU=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Y4xklZq0D+lPZ8OHwyG4BMirZkreQuc23tntA9LgIbMFHzW0eDGcFuEocwaQcvWVp
	 OD5mnPGd2INPkDRhrG0k2dGDX4tuYMeGSlKE6PjZpz+BxPFqIWwamRSoxdJnfu19m7
	 eBDv1S9HO24AjbBDrpkEwIS7GXmCkThUjaS+KWg8/Ix2dwb55XkyerGMabJve4xVYx
	 w4w+6Kxq95iheOaFFBSH6OnOOPa43lp/w3eeKMA6XIPnH+oIV96l11DL7oTpUmPrzc
	 SW7B5q5BQ+54rIxGuXSnR++AeVp/eQzZLeAraWcH0/FB8l5kbda+PuUh9ei4Dm6Ghp
	 HEQZQQW++TY0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB71C6067E;
	Mon,  2 Feb 2026 23:58:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 945D4F4
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Feb 2026 23:58:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 824D8403AB
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Feb 2026 23:58:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9dPP0k6AfOKa for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Feb 2026 23:58:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CA86040137
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA86040137
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CA86040137
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Feb 2026 23:58:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D974E42B63;
 Mon,  2 Feb 2026 23:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15747C116C6;
 Mon,  2 Feb 2026 23:58:14 +0000 (UTC)
Date: Mon, 2 Feb 2026 15:58:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Oros <poros@redhat.com>
Message-ID: <20260202155813.3f8fbc27@kernel.org>
In-Reply-To: <20260202084820.260033-1-poros@redhat.com>
References: <20260202084820.260033-1-poros@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770076694;
 bh=BRzLYgVhduJBkOdpDGMvQh4aM+Uyxm2O3nUvq4ILHMo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=XIR2hMpkUMbhV1MpUhritR1FLGXUgquvWgO+cNXu5uIv3h6mT47Es8QhNileswiVR
 BZWZgFSxGoU5G8yrZQDufhvQ3Mj0Wqb1knY1oX+J3pPveV1n6c0u9DuUdnmPeSLa9g
 /rrIDZHPlJwzvMEpL3e8OlvzExblqQrdLksg/Ll0WWbgSiLO0MxudHUM3+kiQn1BTU
 xiY5lHWFewarOGX+MX7o12YOYAQTiLQR3Z521BySibAmGmXjDIYmUPKNKOhBYslXTU
 MIw71MZsNU8LpfTMksiQbcSIrzo8r0cdHnu08MkYFHwIRYSuWW4pzY7lu4VxkQRsWu
 tYf+Rr9Yi3V5A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=XIR2hMpk
Subject: Re: [Intel-wired-lan] [PATCH net] iavf: fix deadlock in reset
 handling
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
Cc: ivecera@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, Paolo Abeni <pabeni@redhat.com>, "David
 S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon,  2 Feb 2026 09:48:20 +0100 Petr Oros wrote:
> +	netdev_unlock(netdev);
> +	ret = wait_event_interruptible_timeout(adapter->reset_waitqueue,
> +					       !iavf_is_reset_in_progress(adapter),
> +					       msecs_to_jiffies(5000));
> +	netdev_lock(netdev);

Dropping locks taken by the core around the driver callback
is obviously unacceptable. SMH.
