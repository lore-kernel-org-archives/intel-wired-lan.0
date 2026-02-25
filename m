Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13812F55434
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Feb 2026 00:11:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D207E60E17;
	Wed, 25 Feb 2026 00:11:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PKt2jGdWJprk; Wed, 25 Feb 2026 00:11:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5473960F40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771978290;
	bh=LI0Vauyjm/WJVa11JM6KDXC/Wmorzdglu6DvCKsqx3s=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=q5spx5M+K0Mv39ao7IW7PSPREfO2WhbuDS6ATLpU/+uYjkItrnfkrHCuYUp+M3681
	 JlzfUuahbkr8mZKtbgYLZuq73FLxps1Nhl8pWjUtaSkYYrfcqM2GhozfWzWMV6gdj/
	 if4gL3ChjEbsLsg0uoHpjDtxYqceo9EfehAg7+yrpAVsnDcsKOYU+kpjf48P4Yn8PE
	 RrgJnYGHB8lTvEeUsAR6c5NQg9QolXz3xCymxy1WZXMGDGJy8S7fMK6ZODjaJw+JaM
	 O4GlYdcqWA6irp/YoP1PDSo02h3gCmghCLhUvDMuN92SgkRtTPxnDqERvH+K0x7luL
	 RJGyQ8Qjkzi+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5473960F40;
	Wed, 25 Feb 2026 00:11:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 339F323D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Feb 2026 00:11:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1971A40279
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Feb 2026 00:11:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gc03ZUvDvZEM for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Feb 2026 00:11:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6DE8C4007B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6DE8C4007B
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6DE8C4007B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Feb 2026 00:11:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 68D8A43E4E;
 Wed, 25 Feb 2026 00:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3C0C116D0;
 Wed, 25 Feb 2026 00:11:25 +0000 (UTC)
Date: Tue, 24 Feb 2026 16:11:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Message-ID: <20260224161125.4dc744eb@kernel.org>
In-Reply-To: <842bb101-d73c-4470-a01e-f49f96847370@intel.com>
References: <20260220004027.729384-14-anthony.l.nguyen@intel.com>
 <20260222162835.23954-1-horms@kernel.org>
 <842bb101-d73c-4470-a01e-f49f96847370@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771978287;
 bh=Eu/+E6Fe9CTf+32ncOdkyu0tZxs9mpbn4gaiq8dFxqQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=lbi/yUtoqADzlCBITKE11CFaiT9gHa2IQJaQhHBj1QC+6Wt2Qjk5Geuw94XAswPnu
 VkNTgQaQoYnKdsGeCm3WEwDZDkTq5zeElAauS5dhoIMmHiyF5JHWUdTfM80fYjEClV
 DHnsPzaCHBM8HBh5yXL6LcVO+DfE9r33ZR54RDBEOAsDN08T8Il9U8SpkaANG8oZZN
 pJe6Mf4+tnK+oQyqMbMs1wFexYT97Et3D98VX/C4iOkLhGnjnA6gt0OsXa+RytVUus
 CZzyyxuSi2c1rYLqn2/47SjD+KzY0LLWR5xujimd1Sx1k8X0gj/qHI9ZED9J2VuA++
 slqj/wVFasEVw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=lbi/yUto
Subject: Re: [Intel-wired-lan] [net,
 13/13] e1000e: correct TIMINCA on ADP/TGP systems with wrong XTAL
 frequency
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
Cc: piotr.kwapulinski@intel.com, brett.creeley@amd.com,
 emil.s.tantilov@intel.com, sx.rinitha@intel.com, brianvv@google.com,
 jedrzej.jagielski@intel.com, edumazet@google.com, boolli@google.com,
 decot@google.com, avigailx.dahan@intel.com, joe@dama.to,
 przemyslaw.kitszel@intel.com, Samuel.salin@intel.com, en-wei.wu@canonical.com,
 aleksandr.loktionov@intel.com, michal.kubiak@intel.com,
 intel-wired-lan@lists.osuosl.org, jacob.e.keller@intel.com,
 david.m.ertman@intel.com, pabeni@redhat.com, pmenzel@molgen.mpg.de,
 richardcochran@gmail.com, aaron.ma@canonical.com, sreedevi.joshi@intel.com,
 willemb@google.com, netdev@vger.kernel.org, joshua.a.hay@intel.com,
 stable@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 tglx@kernel.org, Simon Horman <horms@kernel.org>, sridhar.samudrala@intel.com,
 vitaly.lifshits@intel.com, dima.ruinskiy@intel.com, rafal.romanowski@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 24 Feb 2026 14:59:36 -0800 Tony Nguyen wrote:
> Yea, looks like we need to do some adjustments here. Also, the AI review 
> I just ran on this is reporting another issue that we'll need to look 
> into. I'm going to drop this one from the series to not hold the others 
> up on this.

I'd sometimes apply series partially for y'all but FWIW the idpf
"defensive programming instead of proper rollback" patches really
don't make me want to interact with this series more than I have to.
You don't have to rework them. Just expect some delays, I guess.
