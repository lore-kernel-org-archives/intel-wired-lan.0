Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FB1C2BD09
	for <intel-wired-lan@archiver.kernel.org>; Mon,  1 Jul 2024 07:15:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E09B81443;
	Mon,  1 Jul 2024 07:15:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qCdsj4sn1WO7; Mon,  1 Jul 2024 07:15:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9128E81441
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1719818120;
	bh=uz1LHNdAZQvN/WkvQor+490npLlzanlb8YHYFe/d8V8=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=aq7REoLCkKsGOVaRYO6S9Omx2BxVGnj2OX5AfVYLNoJwRJ4PpjciIccjloj4jPVDG
	 zeeuV5Oc9V5HvejlQGGYRlR7iPX9V6fDJBMoJOh+eYlKSDqQ00bMaLSOhBbbohwWuQ
	 WKbG6yFqArQ6PvF+8MbS83JoV6yns8sRtOrudsV8YQhEB/xsu46ICFKtfKywGIBzzu
	 EcHyjplPjn0UnalTjxF4NbYfSv0dIvdx/+NeoyxCKo6gKf1FGvFallHHuxQEpxN6kS
	 g9hTNlwO+I36U8hK+TUUlCgaH113Jf0msenY0MMvDF9/eknmqih7G3twk96JlpFXxz
	 qnY68gWsv7ZmA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9128E81441;
	Mon,  1 Jul 2024 07:15:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id A62631BF340
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 Jul 2024 07:15:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F50D6069B
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 Jul 2024 07:15:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ywSdvVvt9oUe for <intel-wired-lan@lists.osuosl.org>;
 Mon,  1 Jul 2024 07:15:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B8175600C9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B8175600C9
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B8175600C9
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 Jul 2024 07:15:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 806FDCE0B66;
 Mon,  1 Jul 2024 07:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF12C116B1;
 Mon,  1 Jul 2024 07:15:10 +0000 (UTC)
Date: Mon, 1 Jul 2024 08:15:08 +0100
From: Simon Horman <horms@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Message-ID: <20240701071508.GD17134@kernel.org>
References: <20240212-igc_mqprio-v3-1-261f5bb99a2a@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212-igc_mqprio-v3-1-261f5bb99a2a@linutronix.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1719818112;
 bh=nkdyaCnnE2lxXci6pm9KjxbTWn7tU+ZcXRARm8bOYW8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dhaqeEKqq98NgKUAseyC8r5cT5SaAHirG2AnMafzn9m3y5vUpmYva/erfeptRLkvj
 v+ES4xXCF/N8KYTgjCI2O9qEWVd8DlnvZ0kSZUKlk1T09E/mfvn916mBwzI3mxdTU6
 2ks1Ha8WxNTwNavwwxF+6gvvrcQkKPgbNxvOK4APXkVID4Qg0zUFOI3JOWv/eIWOuN
 pe8Wea+DAhpjus0vT2X01hc9GAaLflnh7owm19ltFLw45EKlJRnzqOkMhEkHw5jsPu
 BkKX3ZUnU+m3R7nmX4X+UvzsBzUTkdKHeAi6B/O8bOuLWmV6ARtRaAOEO2fUmVQ4fB
 Lp+0/xHqhpn5w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=dhaqeEKq
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igc: Add MQPRIO offload
 support
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
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "shenjian \(K\)" <shenjian15@huawei.com>, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Jun 21, 2024 at 09:25:55AM +0200, Kurt Kanzenbach wrote:
> Add support for offloading MQPRIO. The hardware has four priorities as well
> as four queues. Each queue must be a assigned with a unique priority.
> 
> However, the priorities are only considered in TSN Tx mode. There are two
> TSN Tx modes. In case of MQPRIO the Qbv capability is not required.
> Therefore, use the legacy TSN Tx mode, which performs strict priority
> arbitration.
> 
> Example for mqprio with hardware offload:
> 
> |tc qdisc replace dev ${INTERFACE} handle 100 parent root mqprio num_tc 4 \
> |   map 0 0 0 0 0 1 2 3 0 0 0 0 0 0 0 0 \
> |   queues 1@0 1@1 1@2 1@3 \
> |   hw 1
> 
> The mqprio Qdisc also allows to configure the `preemptible_tcs'. However,
> frame preemption is not supported yet.
> 
> Tested on Intel i225 and implemented by following data sheet section 7.5.2,
> Transmit Scheduling.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>

