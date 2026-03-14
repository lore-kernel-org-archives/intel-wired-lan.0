Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF064106ACF9
	for <intel-wired-lan@archiver.kernel.org>; Sat, 14 Mar 2026 20:06:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80E6F60F7B;
	Sat, 14 Mar 2026 20:06:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RIwJYoQudB3O; Sat, 14 Mar 2026 20:06:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 44AE960F7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773518767;
	bh=+eXLCQqb/ezSRIQFNIcLg0jzBBCSFotxZEZXkOyxLKs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bCm+h7TX6UmM2Ek5V4HdQJvTy5aDBUYO18oVgxaHqORIsBu2K+7DAfUUcCOWS/ELi
	 uqwnBG0QUbgRL59kGFRm55hfuZQBYaU6k9ti9g044nUVfje/FYFC6uXxGOTGPbYfU9
	 IQ5pFaPq0dLG17Lvv+i5dVtjlfJ/aRD4ugOSRxD//49XGJJYU+gZLgvxGtq99wgjqH
	 y9AendB3CXCRPhLyor38PgSFT+GRMs26b98EZ9xVysgNCRp15pIMoKkLlmBEE980MB
	 2rMiFqwi+aWT2CEybWItjZbUPF9nf3TOGwYaZ82ar8d0bqdpk0GZkU2mkJVNe56iUL
	 kuB/3cCyjiXig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44AE960F7C;
	Sat, 14 Mar 2026 20:06:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 28264118
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Mar 2026 20:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B3D94045D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Mar 2026 20:06:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JBmdkMtlgph9 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 14 Mar 2026 20:06:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AB4EF403C6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AB4EF403C6
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AB4EF403C6
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Mar 2026 20:06:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1439043E0B;
 Sat, 14 Mar 2026 20:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083B3C116C6;
 Sat, 14 Mar 2026 20:06:01 +0000 (UTC)
Date: Sat, 14 Mar 2026 13:06:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: stfomichev@gmail.com, horms@kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 eperezma@redhat.com, xuanzhuo@linux.alibaba.com, jasowang@redhat.com,
 mst@redhat.com, przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 jacob.e.keller@intel.com, ronak.doshi@broadcom.com, pcnet32@frontier.com,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Message-ID: <20260314130601.0ec7a534@kernel.org>
In-Reply-To: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
References: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1773518762;
 bh=Vedks8gdVTP9wSEvN7dGkLWh0D4RhYNYqCAWeATFhWc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=pTdtN5xIqR30KmjBfL2KVNQ1fJ3tNDtIqYf0GCDpV1TYBmDuvVkBMGOs1xffttMK/
 rOEr7rz960iJaHe/9QXE3nJa+ajDGXJmF3XUXdlUbOL2okafXfWZdmzYL7PFO1g09d
 Ez1wRArCWruFWBeoSaCEPbFOPm9zlt5lkJfJK/IbbXgpfP3pP1DxZfOHx6BsFD37aq
 LzB6E0tUoFeWcu5U/SkLXe/vKZowq0dG9UWgRWUxP3wjAZoihPMETtdKpvhIq2UOJv
 xq/jBiILKhz03EHljS//m30IMJdncPWeXxuSt+DIVqGCcW+ILnks6x0hUohjf5uhZd
 +mmtcOLhMVYhw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=pTdtN5xI
Subject: Re: [Intel-wired-lan] [PATCH net-next v9 0/7] Introduce async
 callback ndo_set_rx_mode_async
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

On Sat, 14 Mar 2026 23:58:02 +0530 I Viswanath wrote:
> This is an implementation of the idea provided by Jakub here
> 
> https://lore.kernel.org/netdev/20250923163727.5e97abdb@kernel.org/
> 
> The set_rx_mode callback is invoked under the addr_lock spinlock which
> makes it illegal to sleep. This means set_rx_mode is prone to
> sleep-in-atomic bugs as drivers have a tendency to do the I/O directly
> in the callback.

Stan is actively working on this:
https://lore.kernel.org/20260313145113.1424442-1-sdf@fomichev.me
I feel like I spent enough time reviewing your attempts and Stan
will not need as much maintainer attention to bring this to 
a closure so let him cook. Sorry.
