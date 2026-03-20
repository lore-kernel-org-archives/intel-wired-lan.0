Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA22B1099B3B
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 19:28:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7699561BE0;
	Fri, 20 Mar 2026 19:28:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4QL27q1C-IOA; Fri, 20 Mar 2026 19:28:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C928D60B78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774034893;
	bh=fL1jMIsCkYMM4m7gVy5CMk3G12QhHFU1IqZLlQZCToY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P+JjNPo5cbo3NAM+MDm4pSXUMLLMQhBd0sMRV4tIOeAKJ5evvmyUPRihwAdRvFv9Y
	 s+RsIxbSajO5NBr6ipFcS/mTz3oQxnUwdw8bi2deLuB5xjAYK91/e4tV3+DkVa+0Hq
	 iDtGsYmpafH015EqkFOY5ziQW/aWstS0WaLzwVB1UNT35iGiHYvmlCtXw91otPSTce
	 SgdVDXt6PhpSPOfHb0wsX8ptKpaIceu1zEPoCxo2Bz2SxLoPSIQumSBNR4ISKrcVzd
	 J0m7LXwfVvZaNkGq+nE1WO3cNM7rHz2T9tP9XUo13um+GDpB7vOIG0dakk4/qkM7UP
	 ToI7LegsJlUsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C928D60B78;
	Fri, 20 Mar 2026 19:28:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 18B9C25C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 19:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F113A842A0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 19:28:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0n-IXzgXZUCB for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 19:28:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6297A8429D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6297A8429D
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6297A8429D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 19:28:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 23D8A44238;
 Fri, 20 Mar 2026 19:28:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C283AC2BCC6;
 Fri, 20 Mar 2026 19:28:08 +0000 (UTC)
Date: Fri, 20 Mar 2026 19:28:06 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@intel.com>
Message-ID: <20260320192806.GA167844@horms.kernel.org>
References: <20260320050529.422444-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320050529.422444-1-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1774034890;
 bh=hRCyxeO+q0UWavMXDa0++bIl1kG/fqO+nKzwc907+eo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f7E0ALlxYyOyPYGw7aZp0bTZ1fpK6livtLn3GPHRL2jNvow0C/lU+5onFW94aYrSR
 rvI7nJkwF9PNs3ursmjCZ8X58o5wWth5vYg6RmRK2riQ9WofOtx/IA1LYLoojrGVNq
 bjrw4K33mGSXnpCtFczZEfjgKWulwgUCHcP1dEKwGJoDLP6mPP5z+9XOVZ1Mdv4c2i
 jR5A0FqqtwGBSTnxPO89QtG4ISN72idMT5PkfrrBwu0kMz22s09Bz3kqIfFY/ldfc9
 M/TZaP50oJ7WS0hd5KQze81bGMdlL8h1S8MdErmf6UCFDxvq2SsCh7GsfyMU6XiDKZ
 o22EauwjlkIig==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=f7E0ALlx
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: fix allocating
 excessive memory in ice_create_lag_recipe()
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

On Fri, Mar 20, 2026 at 06:05:29AM +0100, Aleksandr Loktionov wrote:
> From: Marcin Szycik <marcin.szycik@intel.com>
> 
> For some reason ice_create_lag_recipe() allocates an array of 64
> struct ice_aqc_recipe_data_elem elements, while it only needs one (1).
> Fix it, while also using kzalloc_obj().
> 
> Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on bonded interface")
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

This doesn't seem to be a bug.

So think we can drop the fixes tag.  And, it might be best to drop the
"fix" language from the subject and commit message.
