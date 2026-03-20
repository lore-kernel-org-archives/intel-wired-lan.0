Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD621099B3B
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 19:53:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01DD261BE5;
	Fri, 20 Mar 2026 19:53:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lgfzd8co_4tH; Fri, 20 Mar 2026 19:53:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43DE660BB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774036397;
	bh=6uekhhH1gD5oWdAiMDbUp85rMOTFq6Bf63bsQMFUkoE=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bqhjpo7t/kUNCAGe8WU/2Nw6kKrcEVoe9u4krFbvq9b1Mo2bQG2p1jY2m/8E7fzNS
	 5/Pjp+dmx5SAjVbXkTcTv3yo/DeAWHqMiIyL/BrV/B3RWAQ2Ul75I5qWauEYzHqrSU
	 +uEX0cVm9ympYD8Jho1A/Gilvns5sVguV2syHkmvTssqfU0qE+jLNR5F/ErldurOuU
	 dBGrg689tps2O+SOTVGCVVuNVI7Fg6UUwqaqwstMWfYWN/9UPGq9x7KaGULkUF0QSR
	 9fCzq9adGz56nhHNAe20ABDoqIMktKNFTt00u255oCakP7EU5monvX53fBFwo8l00k
	 7ES5a6EiM0W+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43DE660BB9;
	Fri, 20 Mar 2026 19:53:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 28A4C25C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 19:53:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E0638478B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 19:53:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NKCE1v5buwTY for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 19:53:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6E68D84771
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E68D84771
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E68D84771
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 19:53:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D8C4F408DB;
 Fri, 20 Mar 2026 19:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9506BC19425;
 Fri, 20 Mar 2026 19:53:13 +0000 (UTC)
Date: Fri, 20 Mar 2026 19:53:11 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Jakub Staniszewski <jakub.staniszewski@intel.com>
Message-ID: <20260320195311.GK74886@horms.kernel.org>
References: <20260320050533.422475-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260320050533.422475-1-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1774036394;
 bh=yOlwrnfApgSr2V+5A7pE8Ew2hiOEjPzACHrqChYg0ng=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ojiZCEL4DYXNLde91ANXhlXkvVIodJ9nQVyh0mL6mvlhYb++J1Dx2Jb+v/LwSu3c0
 i9XTCgoc4/7q06a0yIwC8LWoqowP9qsDN27ib/VOj7w49P6RG31wv01p5TW05oa1h2
 cIfz+hOxDFiuqx5cWQiESIfq2TVrB+q14vK0MM6cjQsRHR9io/o/K73C384TC7L9Sk
 Zfk7QdhNZXPBlMx9ngO6as3bPtNUvd0Nqu9uahQ9VnA9ztGC0Zr4C5iMlwApLtzLt5
 uF+Y4r1hfkV7HoAu0LvofsAZANRWQR7kNyJF7vwTAbevewN1DvmBJN2a/+utzZHSKE
 vH5Pb6ztbJHPg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=ojiZCEL4
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: fix FDB deletion
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

On Fri, Mar 20, 2026 at 06:05:33AM +0100, Aleksandr Loktionov wrote:
> From: Jakub Staniszewski <jakub.staniszewski@intel.com>
> 
> Correct the logic in ndo_fdb_del() to align with other drivers in 
> upstream. The condition was inverted — it was rejecting permanent
> (NUD_PERMANENT) MAC addresses while allowing non-permanent ones to be
> deleted, which is the opposite of the intended behavior.
> 
> The correct logic is to reject deletion of non-permanent entries,
> mirroring the fix applied to ndo_dflt_fdb_del() in commit 645359930231
> ("rtnetlink: Fix inverted check in ndo_dflt_fdb_del()").
> 
> Fixes: e94d4478669357cd ("ice: Implement filter sync, NDO operations and bump version")
> Signed-off-by: Jakub Staniszewski <jakub.staniszewski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

