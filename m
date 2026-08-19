Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2D0C5DF81
	for <intel-wired-lan@archiver.kernel.org>; Wed, 19 Aug 2026 15:51:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B55C44059C;
	Wed, 19 Aug 2026 15:51:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bym9LRauqVGI; Wed, 19 Aug 2026 15:51:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787154691;
	bh=TMLxF/IB0sC5lGiI6MnZO8aVMsnVp3pHfBnlMppNdQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AVRuLASZAJukoW9y7+DH3SBkwvzOalO/xQRhs2GJNqMdeqWKILjIy3T2EhwZdExxC
	 rGzU1xXfVM8DYDk5fI3j+HOMXMNtFAHbGbu5CqpDURTu45F3xT3vyJ6luEq6G9pbdC
	 KX+AVUGf0iyMSZnDf/PF1fvEiOLRw6ooy5q43+Z/SKDqhzLB52LwF+Pl6bRlQhnJbG
	 wykG58RLS9NcKVHoRhMMl/8ugsrmQO71yHitxAUfZJ7XYh5nKtd0SxRY7qTd9j/lDr
	 n86weHDecSnfmIVRAIA3NEkPLJWhnYUORg2eLrFIjs0Yfet8Eq7Hi8rDpS4Lu+XZ7n
	 3xiq7Ra5Jor1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F951405A3;
	Wed, 19 Aug 2026 15:51:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DD1061395
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 15:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C21EA4057E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 15:51:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d32JGCQi6V7l for <intel-wired-lan@lists.osuosl.org>;
 Wed, 19 Aug 2026 15:51:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Cx8kqnQa
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 19BA34057B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 15:51:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 22CFD404E7;
 Wed, 19 Aug 2026 15:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400C11F000E9;
 Wed, 19 Aug 2026 15:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787154688;
 bh=TMLxF/IB0sC5lGiI6MnZO8aVMsnVp3pHfBnlMppNdQ4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Cx8kqnQaQtVafLngJRVs2qDCdx2l5LVgMj8+8qd54/vFyGVPbZ+TkrIxle8Qxn7uV
 RdcyBCUnY1q996smaHB9r4k3p6wSqfylVsYQiVVY5aLIg8pheSTIAY7vTnVaFdVxQc
 iUMbqR7kuba6QDAzUPHlFjAxiQdqhqxlu8mkutVpQNU6JGz3GAOkDhWJ705FlAvxo9
 j/oPZxKvlLce7ESBvYwBHq/Oj0kCUcUEKB0Gcs9hMCiof8X6zuP09J15CV1hfNAeEc
 Lbaia/O9yl3Tv4jZ19MH/Cwaoml5kJXU+3Gx7pmxkKOKsoejtayV9aKgFHxxHG7Png
 ORBKVQhIMwMFQ==
Date: Wed, 19 Aug 2026 16:51:22 +0100
From: Simon Horman <horms@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH net] ice: fix metadata_dst refcount handling on
 representor teardown
Message-ID: <20260819155122.GU265046@horms.kernel.org>
References: <20260816135510.1015041-1-tristmd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816135510.1015041-1-tristmd@gmail.com>
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

On Sun, Aug 16, 2026 at 01:55:10PM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> ice_eswitch_release_repr() uses metadata_dst_free() to release the
> representor's metadata_dst.  metadata_dst_free() directly frees the
> underlying memory without checking the dst_entry refcount.
> 
> When ice_eswitch_port_start_xmit() processes a packet, it takes a
> reference via dst_hold() and attaches the metadata_dst to the skb.
> If the representor is torn down while packets are still queued on
> the lower device (e.g. in a qdisc), the metadata_dst is freed while
> references are still held.
> 
> Use dst_release() instead, which correctly decrements the refcount
> and only frees the object when all references are dropped.  The dst
> subsystem already handles metadata_dst cleanup in dst_destroy() when
> DST_METADATA is set.
> 
> Other drivers sharing this pattern (nfp, airoha, bnxt) already use
> dst_release() for their metadata_dst lifecycle.
> 
> Fixes: f5396b8a663f7 ("ice: switchdev slow path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

Reviewed-by: Simon Horman <horms@kernel.org>

