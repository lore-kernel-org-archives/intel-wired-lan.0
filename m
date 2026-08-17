Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D632C5DF66
	for <intel-wired-lan@archiver.kernel.org>; Mon, 17 Aug 2026 10:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2A10406EE;
	Mon, 17 Aug 2026 10:17:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dy2JUf9mz1q9; Mon, 17 Aug 2026 10:17:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E1D19406E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786961850;
	bh=vBwO+o8/g3c8E5g41SDi1C7yT6nUsCVbHkSVCJNe+7M=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dPbWbOmBYOu3VUmPBk3J54lWEw6no5rq9SEvE0v2mQPIYAz72ES7qBZeLoQQI2NTR
	 zax4k2fZZWlOnE1BTVljvZKp/TUCeipyyzMhqvdBU8/Fkw2zRMWoXQNm8aRQ0/gSKm
	 CWM49rUvO6BdDqXy6ZkjPGzuYd+KCSHuceWM5jyUzXjCvSPee2r2QljVCrJfCR4LkG
	 0KjCgQZNyKhA0d0VUQbKOBRNig5I5Kng3kUtWyvk/UyzT3dkeXBX62VdL6gbjxgyBf
	 JCuJw0R4vd62rrhxixh2cTXB2f82WnzASkPrds2ZJs/yEiJVBoqAY4m2Pa1IIWVflN
	 8lzk3KpGXK2+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1D19406E3;
	Mon, 17 Aug 2026 10:17:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E25BF25B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 10:17:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D3E14406DB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 10:17:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CXbqH1lOtKAQ for <intel-wired-lan@lists.osuosl.org>;
 Mon, 17 Aug 2026 10:17:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1D81E40680
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D81E40680
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iCLqWUDd
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D81E40680
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 10:17:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 69997418F3;
 Mon, 17 Aug 2026 10:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3EE1F000E9;
 Mon, 17 Aug 2026 10:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786961848;
 bh=vBwO+o8/g3c8E5g41SDi1C7yT6nUsCVbHkSVCJNe+7M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=iCLqWUDdgR60lfTw8qDSfaik+jq0gVVQ2pIQ9nR9Fzve0F46IqthNlpYXx6i20W9J
 V16oGiX5xkxkdMzLCSfTOsdvHXsT9SBAZhaV30aC8Z/eOBonZNfNWYbjFGXdfGVlBn
 /FxYZRJpb8y1sL2eubbgEaQFBs+RG8chBlTgzsj4WGqiKHohZ+3vl9aoXEhoDFu3TX
 c1ohb5moXp31CqhGHvH1+y3iYIbS/Oes9dt5cr4dYrmsmvUyK7RjovsJ0y+fG3JeHb
 FfQOSrNjf+NZ7Ivob3epw0MJSctcl2VDgBOxUd8V0UDQWYQX2Bv1Qbstx4oyl+0zJS
 N1te37kfU44Nw==
Date: Mon, 17 Aug 2026 11:17:20 +0100
From: Simon Horman <horms@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, aleksander.lobakin@intel.com,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, witu@nvidia.com,
 martin.lau@kernel.org, yoong.siang.song@intel.com,
 rohan.g.thomas@intel.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, leon@kernel.org
Message-ID: <20260817101720.GX265046@horms.kernel.org>
References: <20260813190800.222527-1-sdf@fomichev.me>
 <20260813190800.222527-2-sdf@fomichev.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813190800.222527-2-sdf@fomichev.me>
Subject: Re: [Intel-wired-lan] [PATCH net v2 1/3] xsk: align TX metadata
 layout across ABIs
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

On Thu, Aug 13, 2026 at 12:07:58PM -0700, Stanislav Fomichev wrote:
> Add explicit padding before launch_time so xsk_tx_metadata has the same
> layout on 32-bit and 64-bit systems.
> 
> On i386 and m68k, the old native 32-bit layout put launch_time at offset 12
> and had a natural size of 20 bytes. Using sizeof(struct xsk_tx_metadata) as
> tx_metadata_len was already rejected because the length must be a multiple
> of eight, so the straightforward use of the interface was broken on those
> ABIs. Userspace could still register a padded length of 24 bytes, though;
> mixing the old and new layouts then silently reads launch_time from the
> wrong offset and misprograms packet launch times. This intentionally
> replaces that incompatible layout while the interface is still new.
> 
> Fixes: ca4419f15abd ("xsk: Add launch time hardware offload support to XDP Tx metadata")
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Simon Horman <horms@kernel.org>

