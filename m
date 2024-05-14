Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA83C04FFE
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 May 2024 09:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F093641700;
	Tue, 14 May 2024 09:56:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TjF2RbcnirpQ; Tue, 14 May 2024 09:56:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 90C53409C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1715680609;
	bh=GNYtR+q9uE63aRtdLnD1UVSymR0PLwTXMoj0zVEWqqA=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Gt3uRW31+wz6YjcuCVX7dF71VKD9Sy9W1Fzi965tibf+uljOIX7Wj+RMfRj5ppN8w
	 Ls+LmwswNYq8y6WQaRJPZ6etC4Q/nMCpze0biL++7B2mjL826QAs0cDwJ8Gq6weTcn
	 5M4h4RZYkvPsVB0AsEpIEFK0hEhxlJmKSHiYweH+fT7r1hHra+DQwHq3YHV1t80WyJ
	 Y7PhMF2oJkNtUJHmcbFmrejvKm7igyUwmmgC2jf8n6n3dPs0SkabgDaZ4D99IG3nP/
	 sNzuj6mnehmOIuKD6d3MqAZrzKCDy807uXQ1C3eSOMXj0ZGCldvqI84vVSf8SNvYvv
	 ho8GZ5ACZLgrQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 90C53409C8;
	Tue, 14 May 2024 09:56:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 5B5A11BF293
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 May 2024 09:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 46E0D6060C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 May 2024 09:56:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I_OjLAqWX6Jh for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 May 2024 09:56:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6C44D605C2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C44D605C2
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C44D605C2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 May 2024 09:56:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A4C2FCE11DF;
 Tue, 14 May 2024 09:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD32C2BD10;
 Tue, 14 May 2024 09:55:54 +0000 (UTC)
Date: Tue, 14 May 2024 10:55:05 +0100
From: Simon Horman <horms@kernel.org>
To: Thinh Tran <thinhtr@linux.ibm.com>
Message-ID: <20240514095505.GZ2787@kernel.org>
References: <20240513175549.609-1-thinhtr@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513175549.609-1-thinhtr@linux.ibm.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1715680602;
 bh=gZrU37Bnrk2g/V7MyPmOEN+NfkYpCEkrj9K5YIMfcxc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QiC7SazMf72R5Ui1qCY3ZLZ6O0jD6kv9YD5T30415oP2P5Ti1wh6PHAh8jf50wXIg
 Z1Podplr0v5ollmJ+NGZYEYApS+l25VfuKmTFvEoSuF3Q/MHq6ZegK+gzG5VWgQhE5
 hnBH1fViJ8pHHTB6V8iT1pLyTNR8GPnvyQennhrHzNDIDC4Qgxxlcf9o7B1Tc8XSyo
 CumnP4fe6RLeZAYHAcK+g6Ka73ssGBKiDonZkka6yP3papouIVHz7auawGWKN7xH3w
 I+udsNmC74ndX3ymphtodX9PoIuQWkcHsgmlGD8wiw9OMLDy3IBFD0PxuTpfbmHRNC
 BZFaHGGcHiPSA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QiC7SazM
Subject: Re: [Intel-wired-lan] [PATCH iwl-net V2,
 0/2] Fix repeated EEH reports in MSI domain
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
Cc: netdev@vger.kernel.org, rob.thomas@ibm.com, aleksandr.loktionov@intel.com,
 edumazet@google.com, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, May 13, 2024 at 12:55:47PM -0500, Thinh Tran wrote:
> The patch fixes an issue where repeated EEH reports with a single error
> on the bus of Intel X710 4-port 10G Base-T adapter in the MSI domain
> causes the device to be permanently disabled.  It fully resets and
> restarts the device when handling the PCI EEH error.
> 
> Two new functions, i40e_io_suspend() and i40e_io_resume(), have been
> introduced.  These functions were factored out from the existing
> i40e_suspend() and i40e_resume() respectively.  This factoring was
> done due to concerns about the logic of the I40E_SUSPENSED state, which
> caused the device not able to recover.  The functions are now used in the
> EEH handling for device suspend/resume callbacks.
> 
> - In the PCI error detected callback, replaced i40e_prep_for_reset()
>   with i40e_io_suspend(). The change is to fully suspend all I/O
>   operations
> - In the PCI error slot reset callback, replaced pci_enable_device_mem()
>   with pci_enable_device(). This change enables both I/O and memory of 
>   the device.
> - In the PCI error resume callback, replaced i40e_handle_reset_warning()
>   with i40e_io_resume(). This change allows the system to resume I/O 
>   operations
> 
> v2: fixed typos and split into two commits

Hi,

These patches look good to me, but I think it would be worth adding parts
of the text above to the commit messages of each patch. This will make the
information easier to find in git logs in future.

> 
> Thinh Tran (2):
>   i40e: fractoring out i40e_suspend/i40e_resume
>   i40e: Fully suspend and resume IO operations in EEH case
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 257 +++++++++++---------
>  1 file changed, 140 insertions(+), 117 deletions(-)
> 
> -- 
> 2.25.1
> 
> 
