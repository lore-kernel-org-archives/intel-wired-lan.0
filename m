Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E47CD4F21
	for <intel-wired-lan@archiver.kernel.org>; Sun, 17 May 2026 10:25:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2D3542798;
	Sun, 17 May 2026 10:25:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ocXLqRGkT2E1; Sun, 17 May 2026 10:25:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D38E642797
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779013522;
	bh=VFbxUw4K1OptBGSFfyetzoI7FxA1zN8MHHDwAdJ+k1M=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UA3dSYH5AnOIJexZP0VFeRtgXJ/92e0MLJ1d8hcabK8xq+r5hchh1XhUtl3bU/fcb
	 XOm3ATPX8aOmP0+HCyY+WlUFUAcCCzQRxYtZFcKuJsqw2giAAYgPU7jU2gMRgnBTDI
	 r9N2+gaLFPtBIu9Pyo51eo8hW0MK1f9XUwTW2renWyh8CH9qDlCQTD+OfYq1UlKJ4C
	 atZuNqAwyJPhvWO9x7HG24zwEk7GcT4SqI9UGi2qzMB0mJFIU75VxdOKzCrpIfyow+
	 badb3Vla3DgXPAWMv/PBaMpySJB967r+LJyFuBto2YJ46ckGTzZ4PwgVt/6AfsyWe3
	 MJXXabba2qiDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D38E642797;
	Sun, 17 May 2026 10:25:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 84FAD282
 for <intel-wired-lan@lists.osuosl.org>; Sun, 17 May 2026 10:25:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7566B85495
 for <intel-wired-lan@lists.osuosl.org>; Sun, 17 May 2026 10:25:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vIeSTI0k2JiX for <intel-wired-lan@lists.osuosl.org>;
 Sun, 17 May 2026 10:25:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DA2A485494
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA2A485494
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA2A485494
 for <intel-wired-lan@lists.osuosl.org>; Sun, 17 May 2026 10:25:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6258A440C0;
 Sun, 17 May 2026 10:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2BBC2BCB0;
 Sun, 17 May 2026 10:25:18 +0000 (UTC)
Date: Sun, 17 May 2026 11:25:15 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Piotr Skajewski <piotrx.skajewski@intel.com>
Message-ID: <20260517102515.GA98116@horms.kernel.org>
References: <20260512140904.4105236-1-aleksandr.loktionov@intel.com>
 <20260512140904.4105236-4-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512140904.4105236-4-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1779013519;
 bh=8D9fs/PRk1JXXmpJR1ypWxBztd3OCrUpyzGGXF4Cqfw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rj+SMoP1rgaa2ACXValosTDUUUhc+/XLyeQmxx1aqcFbMH17as72kjO9MZ4OOwRhv
 NwP3E+jJQnD3nmKarRVk9guZ46EGjavEDR5abug7ALbsVJ9LfMBqXW77yr1HJfPr1R
 IadiPsXmf1PAblH0IP5KsWTYkNJEaXytDbspFZLzega2meiTtJRXr84a7P17/gSqax
 IhkGUYk3RQmXpdZDReCq1UHTRUlI7KP0rfmK/wP2Wv8BZVNSLzAt6QJxexvL5HT0pN
 zHKScZ2DA/3s6z862BmmjMO/B4F5oHwmPjsktY+sIl1fbVHV9sFAHa9tBpB1wMu0WX
 4AukxFBvWql3A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=rj+SMoP1
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 3/8] ixgbe: prevent adding
 duplicate FDIR perfect filter rules
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

On Tue, May 12, 2026 at 04:08:59PM +0200, Aleksandr Loktionov wrote:
> From: Piotr Skajewski <piotrx.skajewski@intel.com>
> 
> When the same flow specification is added twice (same 5-tuple with
> different sw_idx values), ixgbe_add_ethtool_fdir_entry() silently
> programs the duplicate into hardware using a second FDIR table slot.
> This wastes a scarce FDIR entry and can cause confusing behaviour
> when deleting rules.
> 
> Add a helper ixgbe_match_ethtool_fdir_entry() that walks the in-kernel
> filter list before programming hardware.  If an entry with an
> identical filter (excluding the sw_idx) already exists, the new add
> request is rejected with -EEXIST.
> 
> Signed-off-by: Piotr Skajewski <piotrx.skajewski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

