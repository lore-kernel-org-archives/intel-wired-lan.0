Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A7FF483F8
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Mar 2026 21:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72DEA81DA3;
	Mon, 23 Mar 2026 21:19:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dDDlzpwMHFmH; Mon, 23 Mar 2026 21:19:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 67ADE81D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774300766;
	bh=++5w7WAFq1NpP/9k0jG7HJmewsr67dfHeMWia/coHjI=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=2UeqIKsSGsgn1sPXT2sVNNopp9me/3dmDrdy5YIyOJOZ7eixQ3zMFVxD4DV+ohzPM
	 gytIItd4oudzRcLG/6hWdRwL6FlfQ+hnM+emzZn7MN5NS5WycBJVCg8ZmxRz8TFnM8
	 UIucT0Uk7083TlixB9Ph5b9ki8VInXhRnp801Bm7VUrmbNdSFy6Mccui9oqCJ4zL8I
	 YmHVoNuOj72PBhFWe2LkA5mYE+/Mr4njoKkXnpt5cPnFJxhVvRATav/rfhzT7PZViN
	 2brFUV55YSEeY7zbF436fJTo750O3kMmW5QTEdPsEqBdRwoJ7Kiu35hqhUp8hpZDzq
	 LwMXXfNKrahlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67ADE81D21;
	Mon, 23 Mar 2026 21:19:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DDEEE1D3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 21:19:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C37E981D21
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 21:19:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A_9J4dCKi9AY for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Mar 2026 21:19:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 070CA81D18
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 070CA81D18
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 070CA81D18
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 21:19:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6ECAB600AC;
 Mon, 23 Mar 2026 21:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C976C2BC87;
 Mon, 23 Mar 2026 21:19:19 +0000 (UTC)
Date: Mon, 23 Mar 2026 14:19:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Message-ID: <20260323141918.7863c85e@kernel.org>
In-Reply-To: <20260321222627.1193603-1-grzegorz.nitka@intel.com>
References: <20260321222627.1193603-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1774300763;
 bh=++5w7WAFq1NpP/9k0jG7HJmewsr67dfHeMWia/coHjI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=pIF/XgrCFEpz3gQexV4ogxaRJvAKWvvDVh2ROnptetq7JfJscqKb22M4uYfdLZwKV
 fN13P3ojwW20IrFpdF+pFPAo56oWnmIzUOWx/O6oLJvSftMnJDFMoUlotADXJR3a/q
 Yh6YKeWgeq9kaX8o/lWqlTvVQ6r5pi+PXyuTO85yaJnIHm8ILGp3utnMvnHZg+yFwe
 UKdF9U+bGTNPm6b9oN5qKvnrvlicSuFTKDeAd/W4q0vsW8ja47fi8djO5d+6ytrRxw
 LfkjZAjWYjhgnnhmpyZ8YOCSiDpIT4XhCum2y4U3djBdh66OXLCHo2uuJJKr//2veV
 kcvnfz30BXaHA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=pIF/XgrC
Subject: Re: [Intel-wired-lan] [PATCH v2 net-next 0/8] dpll/ice: Add TXC
 DPLL type and full TX reference clock control for E825
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
 edumazet@google.com, netdev@vger.kernel.org, richardcochran@gmail.com,
 donald.hunter@gmail.com, linux-kernel@vger.kernel.org,
 arkadiusz.kubalewski@intel.com, Prathosh.Satish@microchip.com,
 andrew+netdev@lunn.ch, intel-wired-lan@lists.osuosl.org, horms@kernel.org,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, pabeni@redhat.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sat, 21 Mar 2026 23:26:19 +0100 Grzegorz Nitka wrote:
> NOTE: This series is intentionally submitted on net-next (not
> intel-wired-lan) as early feedback of DPLL subsystem changes is
> welcomed. In the past possible approaches were discussed in [1].

drivers/net/ethernet/intel/ice/ice_cpi.c:178:2-3: Unneeded semicolon
