Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D39ED7B96
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Apr 2026 09:39:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF78F428C4;
	Tue, 14 Apr 2026 09:39:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id phxUTpHRpqUF; Tue, 14 Apr 2026 09:39:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E3B40428C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776159553;
	bh=1l4dH2drHoukG4zkJIWtzgRKTUAWEajAv4whB9gIY+I=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9J3LD0GS1qdqInVKnAiWLk6zrbnSDoE2lB0Vg7SZKnhhU8Z/mKoSpITNUO2THRrry
	 1+pPoLoxelNOBaR+nB/uNpbwyR8jiDowYu5m9BAJGHj0yF8vQ/ZBBTBhloUISEvQ+J
	 EzjQ13JpVUbFylEGVkrllJNrDwwJCBEb4Zr4OaD30/lEVObcEUpFynWLi+8T/EhEGM
	 h5BbcBosr4k1p+qIAW5eesVotnYuAfAYkPj6f64aS9COS4qf1qpvXSZWdfsJ9ns8Rp
	 qwN58JTA1XNg2fG9kUzagezWMzqwRCCiVStT/FSe1gk3V4cisHlUAL2f26kOscdjoj
	 NxhwaisJPgR7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3B40428C7;
	Tue, 14 Apr 2026 09:39:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 783CF237
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 09:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E16784B85
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 09:39:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0mHQDOr7S5QU for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Apr 2026 09:39:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5BACF84B26
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5BACF84B26
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5BACF84B26
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 09:39:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5CFEB60018;
 Tue, 14 Apr 2026 09:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E917CC19425;
 Tue, 14 Apr 2026 09:39:08 +0000 (UTC)
Date: Tue, 14 Apr 2026 10:39:06 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Larysa Zaremba <larysa.zaremba@intel.com>
Message-ID: <20260414093906.GB469338@kernel.org>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
 <20260410074921.1254213-10-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410074921.1254213-10-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776159550;
 bh=9CjN8QKJaZS37XrLND/7+2tyRPuh4F/grHoUHubMTT0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RwjmaZ8DHe0zIwVGglFq9cxfKVCEwO20jDRuv964bAglwYo6CXg9lLqIVLWUmR8uF
 A4/QKiHBuIZf/p1Q2FVSlzmucksuTz8UBvnhMF1+0eydGxWQia78Pa2UxRg3BUcG7r
 urFTXrtrrsbdpgHp5Hh8uHA/IUx/s9RySuc9v7TWODBIJF+nT6uqQnmqoO++ImIAFe
 J8RhnUHnmPx7OoBzPhy8c87Ubv3UnH2v/bGhsWs0XrCOzJSMOZVlZrmhwufFZ6pJ2x
 /f1Ph0SkaNCxTFVWeiOAiqSfCnCiY53MGuXTK/s8GJBpFNhoK/MN4ElIxbu2TgWhJm
 k7uklo0bwxVmg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=RwjmaZ8D
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 9/10] ice: use inline helpers
 instead of memcmp() for IPv6 mask checks in ice_ethtool_fdir
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

On Fri, Apr 10, 2026 at 09:49:20AM +0200, Aleksandr Loktionov wrote:
> Replace static full_ipv6_addr_mask / zero_ipv6_addr_mask structs
> and the associated memcmp() calls in ice_ethtool_fdir.c with the
> kernel-provided ipv6_addr_any() helper and a new ice_ipv6_mask_full()
> inline, reducing boilerplate and making intent clearer.
> 
> Suggested-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

