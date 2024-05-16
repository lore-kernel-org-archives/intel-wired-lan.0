Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2887EC25B74
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 May 2024 08:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D966540BC2;
	Thu, 16 May 2024 08:51:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EuyeyUymn0bA; Thu, 16 May 2024 08:51:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9032540B75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1715849462;
	bh=3J//RKz1bIxa3EImvXN7PDkT+JW6x8a5p7puZ7Z2ybY=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=tEdgLBqhRniH5L5RP/Vj8GqdWLliZKbLMg2flYqDU6+jSsFAMmwp+QJ86LPMZ+o3O
	 QjlF3SB6v5tTjhs0mEgkCWgz9r8RfBRc5lAXR8VxArP9ttUY2XCfN2pIKjVYMCmfll
	 0bASjY9qVRzAmj3ReCwCKGPmOSJN5sCKOZGxcydx8JQnw5bCNa55EpGv0joORfz2WT
	 jDBBMjq419vfLQAcHIzJEFSed6UU5BKzKTIJ7bsgU5/APlGErCkrKvAyVUyiDJhMox
	 xdCMC+iTpEWhq2f+YyiRa8FpFnT54/QAtDTBV03ocwbocvZ79ETKLmu5sAaP2is1C5
	 uHSsdUf0t9w8A==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9032540B75;
	Thu, 16 May 2024 08:51:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id C051A1BF855
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 May 2024 08:51:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B7B0B60E21
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 May 2024 08:51:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yBjrJFweN3UR for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 May 2024 08:50:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7E9A960E02
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E9A960E02
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7E9A960E02
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 May 2024 08:50:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B54B361684;
 Thu, 16 May 2024 08:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD46C113CC;
 Thu, 16 May 2024 08:50:54 +0000 (UTC)
Date: Thu, 16 May 2024 09:50:52 +0100
From: Simon Horman <horms@kernel.org>
To: Thinh Tran <thinhtr@linux.ibm.com>
Message-ID: <20240516085052.GG179178@kernel.org>
References: <20240515210705.620-1-thinhtr@linux.ibm.com>
 <20240515210705.620-2-thinhtr@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515210705.620-2-thinhtr@linux.ibm.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1715849457;
 bh=0o141OsbQBSWlhcqmL6WnzLb6HnjbT/RtgVx14YaTw4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=P4tRZmgo0ifCRZ0sgKBMyhEudpMasEKTxrUlzebbBviVwrEeIXXl5TNvdH2m7CLdL
 31ISu/5cFsTCMfEiXX68qqOzsZhhg7RskOu1r+izVqknr+PDOXOsTKurrzL61n9l/Y
 wP2HGYLOAZISLLKoZMs5HfVnscmghhI9Z8FQ3nmQYzaCSCtMFVbaJg37qE72MbZDDg
 jEpDKKns+Rty9Qs7Ws1Y3TbF4Whhmqy5iSnz1xRcPAk3FR3fryc/xzpKqTKwS+dENq
 Y/eJo7V9EPH0btu2YRaT5JGH2AF8+WPpbOvIqGl7Rwn+K5DyrZ1IU58re0z2vdHzn7
 vrlWT0Z1M1SSw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=P4tRZmgo
Subject: Re: [Intel-wired-lan] [PATCH iwl-net V4,
 1/2] i40e: factoring out i40e_suspend/i40e_resume
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
Cc: pmenzel@molgen.mpg.de, netdev@vger.kernel.org, rob.thomas@ibm.com,
 aleksandr.loktionov@intel.com, edumazet@google.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, May 15, 2024 at 04:07:04PM -0500, Thinh Tran wrote:
> Two new functions, i40e_io_suspend() and i40e_io_resume(), have been
> introduced.  These functions were factored out from the existing
> i40e_suspend() and i40e_resume() respectively.  This factoring was
> done due to concerns about the logic of the I40E_SUSPENSED state, which
> caused the device to be unable to recover.  The functions are now used
> in the EEH handling for device suspend/resume callbacks.
> 
> The function i40e_enable_mc_magic_wake() has been moved ahead of
> i40e_io_suspend() to ensure it is declared before being used.
> 
> Tested-by: Robert Thomas <rob.thomas@ibm.com>
> Signed-off-by: Thinh Tran <thinhtr@linux.ibm.com>

Hi Thrinh,

Sorry to nit-pick, but the request from Paul in his review of v3
was to use imperative mood in the title.

	Factor out i40e_suspend/i40e_resume

In any case, this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
