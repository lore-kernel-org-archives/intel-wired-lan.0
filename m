Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB49DC67861
	for <intel-wired-lan@archiver.kernel.org>; Mon,  8 Apr 2024 13:32:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49EB84082F;
	Mon,  8 Apr 2024 13:32:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LhaImZ1Fv_oA; Mon,  8 Apr 2024 13:32:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4A08E40834
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1712583149;
	bh=wV/+HNJUEq+C7SHXV5Dxwbl344n/fVqQt2upyhHrxo0=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=9IzvVY3atmCu08H9edja1iNnfb2XoSiX6FlyaIK6HQmIIAQNyErFQdLURBSX7yWJu
	 awm9EIthqEGjVC6N+VcYFlhCHPQ0UdbQIHdPY4kR0FKrD3sGa/URTu2iR4+AxNTtw8
	 bHX9ZG1sHUaT+6l1ON5r1pAJDTqrZ6BcdwOXYmownC69FxsmyqIrGu8hU17e8GVsZ9
	 8XNz83c3knphKQ/W4yju/ZUsu6CVyI9w1pcUVkWoIL01iEm6LRrJr2ffniFcsW9Erm
	 m2FbR7vmJl/fRDnH9x5LyT/DR/hE+63msLbsp6cnLETu+sLkOYNTinPBeHuqXRvMro
	 kdsYarJBCXG2g==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A08E40834;
	Mon,  8 Apr 2024 13:32:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id DB22F1BF344
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Apr 2024 13:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C508140834
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Apr 2024 13:32:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9LBHJlO-mz03 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  8 Apr 2024 13:32:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9BD8D4082F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9BD8D4082F
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9BD8D4082F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Apr 2024 13:32:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 18F7BCE1320;
 Mon,  8 Apr 2024 13:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB82C43390;
 Mon,  8 Apr 2024 13:32:20 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:32:17 +0100
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Message-ID: <20240408133217.GI26556@kernel.org>
References: <20240404140451.504359-1-marcin.szycik@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404140451.504359-1-marcin.szycik@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1712583143;
 bh=ZZ1j49kXRZioyRheEpLmhWE7M5mUvy3M3llmDuAPn30=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=swSSJ9SooD5M6Rix+XRmlpY++WFoyuTVfLVp7SRZzpP20Js2SpqLIP/Ya2bFaM3fV
 OK38CVwArYXsyCRocQMdQ2Xu5guDsmtYfgCjIz0psaC21v4wmaOh9NwsTr17MrNA8h
 jeoR8GZ4R2DTFecJLG5otcT6GTJsuNCFn9b/Ms55/WwSymzQlk7mhLoaXRpk7nlpb+
 pYeI0azsAjhhmnPG7uCiR90/FMDu20/q8V8f7ASMUkeiEmrV+GelJ08i5yrvwY3LnD
 EbRXud2hOmQniaQIjjFBkcWyv1eRert6hWdxIl0nB2E3ePcls4ezlFED9kuOkWE4c/
 M2SYWn5/VFlMg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=swSSJ9So
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5] ice: Add automatic VF
 reset on Tx MDD events
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
Cc: aleksandr.loktionov@intel.com, Wojciech Drewek <wojciech.drewek@intel.com>,
 netdev@vger.kernel.org, pawel.chmielewski@intel.com,
 anthony.l.nguyen@intel.com, Liang-Min Wang <liang-min.wang@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Apr 04, 2024 at 04:04:51PM +0200, Marcin Szycik wrote:
> In cases when VF sends malformed packets that are classified as malicious,
> it can cause Tx queue to freeze as a result of Malicious Driver Detection
> event. Such malformed packets can appear as a result of a faulty userspace
> app running on VF. This frozen queue can be stuck for several minutes being
> unusable.
> 
> User might prefer to immediately bring the VF back to operational state
> after such event, which can be done by automatically resetting the VF which
> caused MDD. This is already implemented for Rx events (mdd-auto-reset-vf
> flag private flag needs to be set).
> 
> Extend the VF auto reset to also cover Tx MDD events. When any MDD event
> occurs on VF (Tx or Rx) and the mdd-auto-reset-vf private flag is set,
> perform a graceful VF reset to quickly bring it back to operational state.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Co-developed-by: Liang-Min Wang <liang-min.wang@intel.com>
> Signed-off-by: Liang-Min Wang <liang-min.wang@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

