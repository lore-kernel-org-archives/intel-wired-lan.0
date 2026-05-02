Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9A8CD3427
	for <intel-wired-lan@archiver.kernel.org>; Sat,  2 May 2026 17:32:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 219F783DC5;
	Sat,  2 May 2026 17:32:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c23Opa1COF9b; Sat,  2 May 2026 17:32:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5046B83DC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777743149;
	bh=FO6nMcMn/OGU6uVS1myEZJa/Wri94sywk/kufi7znt0=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=YznrV/xE0+vOO2NbY3hAfSvfjobP7wyzfCxwvVxvr1k5vU163+5sFR81yN/3UaJNR
	 BBqHrCsm/1ygEPnzBpPite1Y/iE5t6+J949FJBes2DTEt3VlRI833QGwEzQW9g7UgE
	 ASvtPahY6W2hifF4xT3RfS2qOlnQybYuIb1JwHo0tZnjEcTJamMi9hz+1PwP0Nmzvf
	 iwmNmMlZ6jJ9ndxVU01CE6FM1nW0dDA34FDXevdg3+BMXAaSxeTfN5TSfr130dW7c1
	 Fc+R/7A0gz779wFmgGnYUY+OW/Q7wge7wmxtjGF/Y/YvDD48ye8+1u04sf2yDRvzbi
	 crS+ETkiAFelg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5046B83DC3;
	Sat,  2 May 2026 17:32:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E8B1190
 for <intel-wired-lan@lists.osuosl.org>; Sat,  2 May 2026 17:32:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 148106062D
 for <intel-wired-lan@lists.osuosl.org>; Sat,  2 May 2026 17:32:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2rP2qnm6Bgtz for <intel-wired-lan@lists.osuosl.org>;
 Sat,  2 May 2026 17:32:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6FAF96109A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6FAF96109A
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6FAF96109A
 for <intel-wired-lan@lists.osuosl.org>; Sat,  2 May 2026 17:32:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5890960120;
 Sat,  2 May 2026 17:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406F3C19425;
 Sat,  2 May 2026 17:31:55 +0000 (UTC)
Date: Sat, 2 May 2026 10:31:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Message-ID: <20260502103154.71b4b5de@kernel.org>
In-Reply-To: <20260430094238.987976-4-grzegorz.nitka@intel.com>
References: <20260430094238.987976-1-grzegorz.nitka@intel.com>
 <20260430094238.987976-4-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1777743116;
 bh=FO6nMcMn/OGU6uVS1myEZJa/Wri94sywk/kufi7znt0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=gGyfBsqb83MA8IoSJM0udPhNHy69AFryi5X9Dy1SpE2tZSuT/RBvrQY5Jn8npArWI
 QP/NC9fNm24xkYgn8Bc05tSVeeZtoUka8ZdRvW18FspJFWxkn3seyZT4U0kYaR8CMJ
 +gwG8EoHsCXuoxKx0lpsT5HE00uMHmF8H8RaJvBZBJC3tyXPNQ/d8PrXnWlwqyqNR8
 DrSB6NndZGdyyaIZ5XhkoV5z9qHxyO3C3UNF63S9CkRQtWLcyYM6+rIFH1Bc7AFbV6
 A5driE33UrVCc19Qicg/o0+tgPvcOtOV4Xg15JBzeO65GG693lGKrq+ayDHXa3uOjh
 DxIDhfFia9WPg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=gGyfBsqb
Subject: Re: [Intel-wired-lan] [PATCH v7 net-next 3/8] dpll: extend pin
 notifier and netlink events with notification source ID
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
Cc: ivecera@redhat.com, vadim.fedorenko@linux.dev, jiri@resnulli.us,
 edumazet@google.com, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 netdev@vger.kernel.org, richardcochran@gmail.com, donald.hunter@gmail.com,
 linux-kernel@vger.kernel.org, arkadiusz.kubalewski@intel.com,
 Prathosh.Satish@microchip.com, andrew+netdev@lunn.ch,
 intel-wired-lan@lists.osuosl.org, horms@kernel.org,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, pabeni@redhat.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 30 Apr 2026 11:42:33 +0200 Grzegorz Nitka wrote:
> Subject: [PATCH v7 net-next 3/8] dpll: extend pin notifier and netlink events with notification source ID

As AI points out you're only adding this for the internal notification,
but the commit title mentions netlink too. If we don't need it in
netlink we can just drop the references in the commit msg?
