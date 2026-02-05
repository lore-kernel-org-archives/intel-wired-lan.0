Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192B2EA7951
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Feb 2026 01:40:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D474340D99;
	Thu,  5 Feb 2026 01:40:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Su718J-hraOd; Thu,  5 Feb 2026 01:40:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF56440D4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770255638;
	bh=h1UBGrphvuFc5G/sA0sqMy8WyNHolGCRX3eg/NB0Lsg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pPCsgNYn0CQ/01JEb2Sq22Pn8IVOyIDnE+XyUDcZUQ/D08JthnC4WmbhwTwwLIcV6
	 MbNYMOPJdo1pwwUO8SSKZzwSfjmGsgsJz47rgW0/efV/+REeBc7iL62Z4M8fqR4epz
	 SE1kOjXZX+uGxJfY4ef5i9bQk77hcQnk07+Jpj6kA6b4dMScGxjOYKaj0XUqc4Qm+J
	 K+9E5iECqVxgs8rPzAzZ6NBUWqWah8QwKxPGWLs95gy833QW8oLOEisVcEjVH8KEUF
	 M3fcDsP4CAEVheIxoRpcnWMg+RNaJLtTyGCPdiVLz8Zty/5eJ21Q6Oz6QG7V8CNhdj
	 Fzukhr5YRWSEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF56440D4E;
	Thu,  5 Feb 2026 01:40:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4090EF5
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 01:40:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 20B1083F7B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 01:40:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xCfKtLS9sTkO for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Feb 2026 01:40:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2E21F82F92
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E21F82F92
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2E21F82F92
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 01:40:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 37CBB60097;
 Thu,  5 Feb 2026 01:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D23AC4CEF7;
 Thu,  5 Feb 2026 01:40:34 +0000 (UTC)
Date: Wed, 4 Feb 2026 17:40:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Pielech, Adrian" <adrian.pielech@intel.com>
Cc: <netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <anthony.l.nguyen@intel.com>,
 <pabeni@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <horms@kernel.org>, <andrew+netdev@lunn.ch>, <krzysztof.galazka@intel.com>
Message-ID: <20260204174033.5aa7dc6a@kernel.org>
In-Reply-To: <a29bc22b-a1e3-4a9e-a63c-5d1c71a6f08b@intel.com>
References: <b5446385-1f51-4359-b484-6dfccb50dad0@intel.com>
 <20260203190811.1f9e7530@kernel.org>
 <a29bc22b-a1e3-4a9e-a63c-5d1c71a6f08b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770255634;
 bh=uTrsxGdHfJzR7evoyQV4W3EjM818czShb7pzEfoHKM0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=YYFxS/IjDvToGeQ/zY0WFvhW5OjotxHVMWKPlhXCltHJtf0BVtyVmDmSDyu3jkvVY
 BMF2PJs0vwRiNS8eabvdPWR2drkwJCRWDxL32O09L2+MPzqcTiahVkxlUzw40ky6ZZ
 K+QJGePYXoIfqPw0CGidNKBDEmJ5IoyYYkmOJJpQg1LomrKqguff8SxbeA4EbpG853
 q3FZM4pZzEA1dzMTl4USaCGGO8roZhxfdBz1nNNqomQhly9RECWQrtd388ej8k1KzO
 5lfmyJaITEf0MQndrT/zrT/4BId+SGIUwT+os9pMpe9Y8F0ZM8wneOUeqh5fSgjMCp
 YQrLs81vshZFQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=YYFxS/Ij
Subject: Re: [Intel-wired-lan] [ANN] intel's netdev-ci for i40e
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

On Wed, 4 Feb 2026 13:15:03 +0100 Pielech, Adrian wrote:
> On 2/4/2026 4:08 AM, Jakub Kicinski wrote:
> > Looks like the GRO test result parsing is off, the test cases are
> > reported as for example:
> > 
> > 	gro-test-lro-ipv6-ip-tos # XFAIL Device does not support...
> > 
> > Looks like this affects all your runners, I haven't noticed earlier.  
> 
> I have fixed that, XFAIL should be reported as fail even if further
> message suggests that the test should report SKIP due to "device does
> not support...".
> 
> Historical results were parsed again to remove test cases:
> "[...] # XFAIL [...]".

Looks good now, thanks!

One more note, the "driver metadata" is currently reported as:

{"devlink":{"driver":"i40e", ...

looks like you have some extra nests there. That's perfectly fine,
but we need there to be a "driver" key in the outmost object.
Right now our UIs show "undefined" for the drivers here:
https://netdev.bots.linux.dev/devices.html
