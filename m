Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C90E7BDB8
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Feb 2026 12:59:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 496BC60B6A;
	Mon, 16 Feb 2026 12:59:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XbEFHt81tPkX; Mon, 16 Feb 2026 12:59:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF2CE60B67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771246797;
	bh=Y+LjRxJG+nPwohI4v+Vkwgq5DWcFOVd+OD8kV0wBODg=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rjOqqSeWb1mCsI5at2U3kSLtaV8nBa+HvWrzwW8Fmz7GjB7Afc1avfXADJaNUvIp4
	 lP0/jwAsVlQlC3IDcKzVES4b8Xh8x2cwsl3f9iDw7jdz+0u7KjRTKpKV7FXyvX5Vu9
	 NVFEKK96tL6/socjrRNUx9glQZiJhvtX24iNYmqALaD1X09hXGkkSfs8gQbkr2ja0M
	 AGy1k2Xf9P0/11aTpJelFI8yR9jycwUkKgv+FjIaygw8XteU2CMNi0CC34q3G5KVc8
	 v71HYw0T0g/U4NtcONx+Kpils5dTNu5R79vv5cK5oVnx9AVOak0b4QsNQXfXMpmiUq
	 rMNtF7ryyu+8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF2CE60B67;
	Mon, 16 Feb 2026 12:59:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 595191EB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Feb 2026 12:59:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56F2F60B67
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Feb 2026 12:59:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7FHVxQ_isKGe for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Feb 2026 12:59:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A332660B61
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A332660B61
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A332660B61
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Feb 2026 12:59:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 11044600B0;
 Mon, 16 Feb 2026 12:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685C3C116C6;
 Mon, 16 Feb 2026 12:59:51 +0000 (UTC)
Date: Mon, 16 Feb 2026 12:59:49 +0000
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sasha Neftin <sasha.neftin@intel.com>, kohei.enju@gmail.com
Message-ID: <aZMUxeIqb2wxVLdL@horms.kernel.org>
References: <20260214194636.295647-1-kohei@enjuk.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214194636.295647-1-kohei@enjuk.jp>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771246793;
 bh=XTSXpUaNT8kV0Iio9lfnvsZxSIMODYj1r/F/mFweMmk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VdBAn+GZoY86y/uvjobTk+xIte0YerJYNxBIMWj72xs+aSzxuuXURECuDRCtlCLIj
 +/4g9xBt5+BvrMy3TT8naaCfuObta6L936pWT4Y4yaXJFJ0m5oNuJpj4Ms7ggUJpZZ
 T6w67EjQSPpEUJhypwVqYBXTNd0ubjUCw0zw5lofFhU08G5repaePND1ywypweHLQF
 SBnmY0YKArO9BzbzWG9XZ8xzXUmd4SUDKIODhHqT0ovp1m8OB9RBu8rfJEr8KQRD3P
 cfehWdg0m+U3iMIXO6AMlL0xxHFn0RWgmJAS0ma929oXCVbVTgyo0+HLeFJf1I+L7e
 nsTLOEXTSRUnQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VdBAn+GZ
Subject: Re: [Intel-wired-lan] [PATCH v1 iwl-net] igc: fix missing update of
 skb->tail in igc_xmit_frame()
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

On Sat, Feb 14, 2026 at 07:46:32PM +0000, Kohei Enju wrote:
> igc_xmit_frame() misses updating skb->tail when the packet size is
> shorter than the minimum one.
> Use skb_put_padto() in alignment with other Intel Ethernet drivers.
> 
> Fixes: 0507ef8a0372 ("igc: Add transmit and receive fastpath and interrupt handlers")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>

Reviewed-by: Simon Horman <horms@kernel.org>

