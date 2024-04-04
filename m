Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF2ACD128A
	for <intel-wired-lan@archiver.kernel.org>; Thu,  4 Apr 2024 00:18:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EEAC04192B;
	Thu,  4 Apr 2024 00:18:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2pj4_6lnmFvF; Thu,  4 Apr 2024 00:18:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 50C6741943
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1712189911;
	bh=oFgDkqDFbBuI5mDUBruGWOiy5gGd2s0+giOp4E1Jyns=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=1juVN+LSapbjB1O6evQrxwwnuCFd+Cj3fXHYjTa3Imsb0/CR+9lXoBUySOXoBMsWc
	 upukrx81WFbr1mRCnRyMxT30IjNsyeAchUenvDsa7OTadfiDLmsOOtoteUnYB9cbHg
	 RoVVQoNERBNadyPsSlI9xAfRkbFrzdgSDAilwUT9BT7ob/2J/50UQPxOhkiCt5gGXF
	 qVFisKV8ZqKPhVm5bB12VhR+I5YRncwpGoZyMxQ6vPFukJMx+muvokPbSll9HsaAG6
	 xe6Ye8Hl7aEnPxhIwIUz2B0y8AMqpmvn8BHHmodlSKrt0NWlWt/TprRvqPGRC9RHCW
	 4t9jjUyLqX5Yg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 50C6741943;
	Thu,  4 Apr 2024 00:18:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 664C81BF983
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Apr 2024 00:18:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 513A1606BE
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Apr 2024 00:18:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dji-GZh-gjQh for <intel-wired-lan@lists.osuosl.org>;
 Thu,  4 Apr 2024 00:18:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B02BD6066D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B02BD6066D
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B02BD6066D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Apr 2024 00:18:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8A99A614D4;
 Thu,  4 Apr 2024 00:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D97C433F1;
 Thu,  4 Apr 2024 00:18:26 +0000 (UTC)
Date: Wed, 3 Apr 2024 17:18:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Message-ID: <20240403171825.31d6867a@kernel.org>
In-Reply-To: <348ead57-cdb8-4db7-a3d7-e8053a5f00c1@intel.com>
References: <20240329092321.16843-1-wojciech.drewek@intel.com>
 <20240329092321.16843-3-wojciech.drewek@intel.com>
 <20240329152954.26a7ce75@kernel.org>
 <f7c6264e-9a16-4232-aba2-fde91eb51fb7@intel.com>
 <20240402073421.2528ce4f@kernel.org>
 <348ead57-cdb8-4db7-a3d7-e8053a5f00c1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1712189907;
 bh=oFgDkqDFbBuI5mDUBruGWOiy5gGd2s0+giOp4E1Jyns=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=TAjSWw8k6GmTkmAsyvPKWdQQnLmKDQwQ6/GdVjEfA4fUOBlEMsu1bYBpR8TGEzmS5
 egDBIRgsS48gXmeM5Dfa6KrHuxb5ULq5KpQpsff9CqvLL6jWsPXnCM+8QibOwhcNld
 9G+CVa9fo38kl2oKz0JwzHuBu9r1nL2j1Z11gisc4NVDfuFciarNPCIfC1lYAIjotF
 wSgWQDfe4GyZF7eUvGShkbdl2DNZ88dPtRsoZMfzIxAxyJ+epayQY3s185jeq+8Uoi
 Tpt/JyN0DD8ZasNMIZVLSki6p2hAym+0kll6p3s6ShUgtLYW2njT3FHLECweSsnIFb
 nBssSYPTnPORA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=TAjSWw8k
Subject: Re: [Intel-wired-lan] [PATCH net-next 2/3] ethtool: Introduce max
 power support
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
Cc: netdev@vger.kernel.org, edumazet@google.com, marcin.szycik@linux.intel.com,
 anthony.l.nguyen@intel.com, idosch@nvidia.com,
 intel-wired-lan@lists.osuosl.org, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, 3 Apr 2024 12:19:57 +0200 Wojciech Drewek wrote:
> You're saying that if min_pwr_allowed or max_pwr_allowed taken from get op
> are 0 than we should not allow to set max_pwr_reset and max_pwr_set?

Yes, return -EOPNOTSUPP and point extack at whatever max_pwr attr user
sent. If driver doesn't return any bounds from get() it must not support
the configuration.

> And similarly if policy was 0 than we should not allow to set it?

You mean the limit? I'm not as sure about this one. We can either
treat 0 as "unset" or as unsupported. Not sure what makes more sense
for this case.
