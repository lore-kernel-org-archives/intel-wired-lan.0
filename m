Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C56EF5862
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Feb 2026 16:51:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60027613E6;
	Tue, 24 Feb 2026 16:51:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y_1ILm9cUn6a; Tue, 24 Feb 2026 16:51:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5E0F60726
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771951912;
	bh=P1y4bP+5R77sG3n+hg3sIZ8so3DA4XftpNuy6lZ2+Wk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OtuzG+nh8dFQwaIMEqY/syAcTrRCsxvm9KnUxIA7up4sBEJlcWj1Z9BZIYWs0KFIW
	 cYi7ZSGEEraS1LfJdao2wjwUQXwD+TaiEHS+glk0Dv/kQE0CWTXfeSIcrxN0VRQ//l
	 qldQ3m4FMbnv88d3frUNFvGdGOzUlC5tDe6Cgt2P9b0SSR9+g+jkRXcDZ2u5lMALSr
	 K9nNyOZpW6VPbxkXmj/Db7FwZUmEabYhDp86RXjwdrn4roFjOiPUCpTvyUciJuBDip
	 9BMQwXHbZpROfLJ/Qgm0EWSPZjSrZPRabEEZBQLdErwx/lWgPSqbjwDeTH30VteOjs
	 wlKLAgh3FvZ7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5E0F60726;
	Tue, 24 Feb 2026 16:51:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 067AE249
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 16:51:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E520E84535
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 16:51:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kkXbUcf-3AAO for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Feb 2026 16:51:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4C4FD84534
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4C4FD84534
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C4FD84534
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 16:51:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8015B600AE;
 Tue, 24 Feb 2026 16:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D678DC116D0;
 Tue, 24 Feb 2026 16:51:47 +0000 (UTC)
Date: Tue, 24 Feb 2026 16:51:45 +0000
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
 Anthony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Message-ID: <aZ3XIa2a1XiI4cQY@horms.kernel.org>
References: <20260223-jk-improve-fw-update-activate-message-v1-1-ce2b4abcf79f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-jk-improve-fw-update-activate-message-v1-1-ce2b4abcf79f@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771951909;
 bh=NbJZkDphPUQpxbHFYoF66qaDcKzRN4oeXu/r0CVUxhM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g8t3n5vrKeBclrgxx/DXcZSaeTJtDIoC7NTnka3pudEyN12jLjzMCfPzRFSwmHvNH
 cqNjdRGYSj7GqfLEBxbf9rJQH5cnnfXas96W3UUPPGXphKQ6iQgihcCsSxGukNim0x
 m8o78nbhwzW6h6cgkh5w6DQZRMLyTLfi7MV0cf/lGTiGje8PBMLn6AbdPog3y6hBIo
 ubbZUxJAh9htnvRPy3iGNi99CBY4Va4P3DJJIfv+sfy8CWDila94nOt8kezpt8Q2ru
 bPoGQpQD4ujLJZownHPzSU326ehGEEIL0aa2LI/c5z55KnZmBUMKDYU8Y2wEyWXpDb
 3orzodgnHpCjw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=g8t3n5vr
Subject: Re: [Intel-wired-lan] [PATCH] ice: mention fw_activate action along
 with devlink reload
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

On Mon, Feb 23, 2026 at 04:12:17PM -0800, Jacob Keller wrote:
> The ice driver reports a helpful status message when updating firmware
> indicating what action is necessary to enable the new firmware. This is
> done because some updates require power cycling or rebooting the machine
> but some can be activated via devlink.
> 
> The ice driver only supports activating firmware with the specific action
> of "fw_activate" a bare "devlink dev reload" will *not* update the
> firmware, and will only perform driver reinitialization.
> 
> Update the status message to explicitly reflect that the reload must use
> the fw_activate action.
> 
> I considered modifying the text to spell out the full command, but felt
> that was both overkill and something that would belong better as part of
> the user space program and not hard coded into the kernel driver output.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Thanks Jacob, all,

I agree that this text strikes a good balance.

Reviewed-by: Simon Horman <horms@kernel.org>
