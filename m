Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF378C52D6F
	for <intel-wired-lan@archiver.kernel.org>; Sat, 24 Aug 2024 13:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64A2D605B0;
	Sat, 24 Aug 2024 13:58:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id An351OxkJHhK; Sat, 24 Aug 2024 13:58:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CAF5F605BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1724507926;
	bh=JnKIRIiU9r2SosFAqspAhIEIk2FtZj38NcUbYmHQymQ=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=K12r9ZV8iZBjkX/6b7deJP2vnhzr83jSrOcKJuViM2bzG5dw8LnivkTVA8vxZ6OTV
	 z4zJ8CyFDfuI5C54e0Yh/heLbgcknwQCjOZ0ah+FvnmFsWXpO4mw6OuxeSYegNruBV
	 oJevIixEprJwbAVBWtAUBMyHTiL+S4x6zJfkqwggCX8SYYpILyp5fkFTtQu4pIYd1r
	 LLDGm79gLnbUdeqCzNNIGqzuAGg50QhHBa0I/bJIW16WQO3EwVXRLyWTlhoL/Itz5t
	 wnYGOwewLW22/S2eqPi27oT99Zam3cUFLQ8QeoDqrbyBn2sH/B8+kDOSs7ddCw2x21
	 j4EHYXl6wmLqA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAF5F605BD;
	Sat, 24 Aug 2024 13:58:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 2E9881BF349
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Aug 2024 13:58:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2760481778
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Aug 2024 13:58:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0BXUEH-bvj6b for <intel-wired-lan@lists.osuosl.org>;
 Sat, 24 Aug 2024 13:58:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55;
 helo=sin.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5C4E681774
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C4E681774
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5C4E681774
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Aug 2024 13:58:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C375DCE09B8;
 Sat, 24 Aug 2024 13:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8FAC32781;
 Sat, 24 Aug 2024 13:58:38 +0000 (UTC)
Date: Sat, 24 Aug 2024 14:58:36 +0100
From: Simon Horman <horms@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Message-ID: <20240824135836.GL2164@kernel.org>
References: <20240805134350.132357-1-wojciech.drewek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805134350.132357-1-wojciech.drewek@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1724507920;
 bh=MyaHm4/jqfyXmm+qOcdwO0g5N2J//Qv06F//5xrumO0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a5irSxDkcoxY/xqZdBbkzHelgjOWZlhGRo8NmbxiXowskXHVx0NcdipvKimljPk19
 cB5Xo8XRzA30R4n4IioqXB3C8YpwBhusk7N7xPmAB0sTc4xbKkbsfPNEtjLSmm6QFc
 sb4L7n/iH/eqU8r7U6yeAHPB2ByT+mwbIcgvRPlerHm7fpdpTO90SP8FXOcsY450Jm
 Lkc7Rog9Ottwi0Q4RHjdk/hIWXonO0Ptux2qL7ZUT33mZyritQy0vzU5xMDKGdOHTt
 kLUKlVksR/g2jHN2qHyrmsJtFtTgsYlycTuzHazjcUv0i1VeG4v0e6CRYvZ5QWJuiQ
 x4JKb+7Sz/sgg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=a5irSxDk
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: Flush FDB entries before
 reset
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
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Aug 05, 2024 at 03:43:50PM +0200, Wojciech Drewek wrote:
> Triggering the reset while in switchdev mode causes
> errors[1]. Rules are already removed by this time
> because switch content is flushed in case of the reset.
> We can avoid these errors by clearing the rules
> early in the reset flow. Remove unnecessary
> ice_clear_sw_switch_recipes.

Hi Wojciech,

I think it would be helpful (at least to me) if the patch
description included some more detail on
1) How the current flow results in these warnings; and
2) The new flow ensures resources are released.

> 
> [1]
> ice 0000:01:00.0: Failed to delete FDB forward rule, err: -2
> ice 0000:01:00.0: Failed to delete FDB guard rule, err: -2
> 
> Fixes: 7c945a1a8e5f ("ice: Switchdev FDB events support")
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>

...
