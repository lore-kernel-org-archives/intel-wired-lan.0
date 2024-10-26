Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5CBD0C604
	for <intel-wired-lan@archiver.kernel.org>; Sat, 26 Oct 2024 15:37:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCC8B605DB;
	Sat, 26 Oct 2024 15:37:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TqUL0U-wJgt9; Sat, 26 Oct 2024 15:37:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1989605DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1729957071;
	bh=SdbQ0xbfbEzjwTQExWjTC0vstleoygaRbUr3K6VyXqM=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=bsktnaF43U7zAmT5uPIsgJ+x4Cfj0jbxG+wNT6HqC6crwde3AofWZWoRLrI27tw+5
	 m7Ft8xRPRmTCzAMs49VEoFIzZo4RU5c82seozWomaTqR7TmtvPKPG4gxo1y6xeFSQr
	 Zyy1PdZohAUO6K+8nK47sl+JAxxrEgRbpkKG6KMaU4KRQBu/prBCUxMvnBIdW/8GnQ
	 PmIuXMX1WpUMs+O1FR8SJOt2JSn0c1QKMUMRuv5ZQewUw3ZzxaHp/DEBnRw7zpbuNr
	 d3QHrJXm1b2f1nySDe2qLvbg8uuWToxD/caTMcED3HigY6UmOH2lv0lTcs4mYaWZ0i
	 MmTPO+EsOOnqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1989605DD;
	Sat, 26 Oct 2024 15:37:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B495C5C1E
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Oct 2024 15:37:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 95AB781238
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Oct 2024 15:37:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SL8L1nB9yoMU for <intel-wired-lan@lists.osuosl.org>;
 Sat, 26 Oct 2024 15:37:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=147.75.193.91;
 helo=nyc.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EAF1180DCF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EAF1180DCF
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EAF1180DCF
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Oct 2024 15:37:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 25BCBA401E6;
 Sat, 26 Oct 2024 15:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB03C4CEE5;
 Sat, 26 Oct 2024 15:37:43 +0000 (UTC)
Date: Sat, 26 Oct 2024 16:37:41 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Message-ID: <20241026153741.GL1507976@kernel.org>
References: <20241026041249.1267664-1-yuehaibing@huawei.com>
 <20241026041249.1267664-3-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026041249.1267664-3-yuehaibing@huawei.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1729957068;
 bh=J/pySOqdQbC0PUYIJrkvno4pdFRrrM8O/AMC9oqFvOc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lK9W7vPAwGUPtwc42qru4fapuGmElf2Mfl5Az5wkZZocNeNFVhic7Ix/GUJ3xrqtr
 Gokwrg/cN5sNA/HrVGBGvS/okrGF4DPdrmGVRE+zTtB4gHfUEjSTXa8fAG6fQlQZEI
 3mFdyBwznc2kenqyjrMxwyAi2ZIG0y4tNWt76BElluIZZ+LGovHmbMf6D67b+4W2FA
 3r+PFPGRe5AB3UaWZC+583UqarYFbXT1b3RpM+x7gGuOhXd6sRfXRJyyqHu1/7+0+V
 mtGReDo288JQDQlQ+7y+u2DOVvnH5ORL370Bs5jSdieuNyY4YdXPQsMh+hJExq8Nrs
 u3NNeoxEARuDA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=lK9W7vPA
Subject: Re: [Intel-wired-lan] [PATCH v4 net-next 2/4] igb: Fix passing 0 to
 ERR_PTR in igb_run_xdp()
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
Cc: alexander.h.duyck@intel.com, andre.guedes@intel.com,
 maciej.fijalkowski@intel.com, hawk@kernel.org, daniel@iogearbox.net,
 jithu.joseph@intel.com, przemyslaw.kitszel@intel.com, john.fastabend@gmail.com,
 ast@kernel.org, linux-kernel@vger.kernel.org, edumazet@google.com,
 netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, jacob.e.keller@intel.com, kuba@kernel.org,
 bpf@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 vedang.patel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sat, Oct 26, 2024 at 12:12:47PM +0800, Yue Haibing wrote:
> igb_run_xdp() converts customed xdp action to a negative error code
> with the sk_buff pointer type which be checked with IS_ERR in
> igb_clean_rx_irq(). Remove this error pointer handing instead use plain
> int return value.
> 
> Fixes: 9cbc948b5a20 ("igb: add XDP support")
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

