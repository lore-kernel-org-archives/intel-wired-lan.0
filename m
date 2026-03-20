Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FC71099B30
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 19:57:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF6B26123C;
	Fri, 20 Mar 2026 19:57:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QvkeOsCgMx_S; Fri, 20 Mar 2026 19:57:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CDB116123B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774036672;
	bh=Jk5qqr2tdqgySy720KQi+pqP8yQdikH9WG+p8Q5OJ7c=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=8ceuTlWLTnhjrrjXmLQ95akUggZHcIq32n4P9PqJVTDDXFTeZzvssWfoLIQti0HX0
	 c8beyPerazm+FBbq6mKbIX0iQ3wYTx3fGxTelpL75MXNq1gRjbo2RQXVvCqPhtuUR7
	 2ew9SPM3/r5j7ivoBVWribln5sM1+/F+vn6e7Kr1YTYjCgjMrDx3kpDPVlKkVNaG5o
	 GJ555xUIV54JTMWMKQu1C4VK8srOvBeSCthx23dkvJJxHNpCnqB6J0zM8uJWx6aaAI
	 GBkR1nlK1iR50gj/3VCWRsJQspqN0SNL8y3l+kWawqdiGkngzMaBufv4mF0fvNsRp6
	 Var6NK2mQFVZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDB116123B;
	Fri, 20 Mar 2026 19:57:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A9FC25C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 19:57:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0FFD56123A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 19:57:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J_TgkPZ6g_pj for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 19:57:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5FBC86122A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5FBC86122A
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5FBC86122A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 19:57:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 84F0D60130;
 Fri, 20 Mar 2026 19:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A875C4CEF7;
 Fri, 20 Mar 2026 19:57:47 +0000 (UTC)
Date: Fri, 20 Mar 2026 19:57:45 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <20260320195745.GL74886@horms.kernel.org>
References: <20260320050548.422684-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320050548.422684-1-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1774036669;
 bh=t9B5H/VMcIfqiAeXQ2rk4ql7kLQyXGHI4PB6+emckco=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IZQD51Wq0om2Wvtrzk6MVzOo4jz7mM6ilPx3AstsPy1bfXYeHSw0XvXIztMkJFbW8
 ywbvKNcdjW8vuk5QNVPFHPk1pFF2RxQ8cYVuN4wOOM+/6b/YI5ReVQFENCJYSqfMDo
 lyH22JGkMzpQl1FQ6pkuJ9o29cmlncy2ozQBIDagco0XQtvdJ/598Y3cyyxW6kFnAV
 b1CGMcIWI7rxdzA+8k7kiJRjSaX7YhlzLajB/M9VcuI/Ddeup6xm7WF2TGm+d0c4mI
 wc0K4XWUcMGtKGzd8LY7Wvvrej+bAugXgPp5Vu+9mEBv9m9byNWQadyLEKdHuBWImC
 bAlQWePinaYzQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=IZQD51Wq
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: reduce loglevel to
 debug for 'Can't delete DSCP' message
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
Cc: anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Mar 20, 2026 at 06:05:48AM +0100, Aleksandr Loktionov wrote:
> From: Grzegorz Nitka <grzegorz.nitka@intel.com>
> 
> Reduce netdev message "Can't delete DSCP netlink app ..." from error
> to debug level when in FW (firmware) DCB mode.
> This is not a real error and a kind of expected behavior. The device
> is fully operational and error message might be wrongly interpreted by
> the user.
> 
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

