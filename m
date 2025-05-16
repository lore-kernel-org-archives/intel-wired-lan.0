Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595F0C3ABC9
	for <intel-wired-lan@archiver.kernel.org>; Fri, 16 May 2025 09:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2963C41588;
	Fri, 16 May 2025 09:45:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aUnfL4AkmB1P; Fri, 16 May 2025 09:45:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F18641575
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1747388731;
	bh=e7yeGEXq5WaeIQNIW/XccMU2VpxH4/y2FhBYeVBRQOE=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N14AKGNHNn0Q8hW9SY5S9169mCUemBjialNiNeHYaD20mV9AiceIdQ9sgJ9HBnVqP
	 prABfDYyMcHKdgUYQJm8/Fg3Z4hiHP0EBl18ZuGegpt1ZK/ZbP8no/nl7/lDJJQJSU
	 4qxdLz68odQNccpFPSnrqQE4IxiWQ4/bDg+PsON3vXpK/nh5kesBzrJoRuMEzHcCs8
	 hNIWwaDCXcyGR39jcrm4kXsZYpEjfj+xY7DpPTmfMlDE9PNr/g/e1vx5Q6M9+OCcT6
	 SgCidMlBijyqtyyEd8Bc6kaXjxfbmtjIB0T07KgNlOVjeH46s7MoYdBcDwMh2MU8HF
	 sgrEY7LAu6Y+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F18641575;
	Fri, 16 May 2025 09:45:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E18FB1AB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 May 2025 09:45:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D2F9740415
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 May 2025 09:45:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5blbB1eUyPc9 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 16 May 2025 09:45:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=147.75.193.91;
 helo=nyc.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 19F80405B7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 19F80405B7
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19F80405B7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 May 2025 09:45:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 30E00A4E679;
 Fri, 16 May 2025 09:45:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F82C4CEE4;
 Fri, 16 May 2025 09:45:25 +0000 (UTC)
Date: Fri, 16 May 2025 10:45:23 +0100
From: Simon Horman <horms@kernel.org>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Chwee-Lin Choong <chwee.lin.choong@intel.com>
Message-ID: <20250516094523.GM1898636@horms.kernel.org>
References: <20250514042945.2685273-1-faizal.abdul.rahim@linux.intel.com>
 <20250514042945.2685273-6-faizal.abdul.rahim@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514042945.2685273-6-faizal.abdul.rahim@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1747388727;
 bh=e7yeGEXq5WaeIQNIW/XccMU2VpxH4/y2FhBYeVBRQOE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jhboFUdoo1SKe0onXbXMqjUq/0n3vJPyHaXVBFWy/EXuNA6OA4D4i1g9SUe8vuBU6
 3um4des1zzGAkv3wZBrhBIZ45Xz8OqQoEfBBs0iMEq/YV+bzanYe9sOhStjD23D7yi
 mFHbiORuReuH3VtgTV6WakEvr7YFBXzQR/l+5VwJ+oeuZXJhyBy808H0AY9YxnBftF
 eeKadRTRcKa3tRxRo7PAQ6R6olrpYlb1KYy9OREmCu5hHwVdNL3cf4CLfcAqlRI46L
 ePg3NzhqatwTVveecTU0aeeT9blYsP+ZI+EjUqNAYP2QoD5wdCyULuXJ+pG2v/Pe4C
 J1LaHCLQYzlFQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=jhboFUdo
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 5/8] igc: add private flag
 to reverse TX queue priority in TSN mode
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

On Wed, May 14, 2025 at 12:29:42AM -0400, Faizal Rahim wrote:
> By default, igc assigns TX hw queue 0 the highest priority and queue 3
> the lowest. This is opposite of most NICs, where TX hw queue 3 has the
> highest priority and queue 0 the lowest.

...

> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

