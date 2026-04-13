Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB3CEBFD3A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 13 Apr 2026 10:52:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1BD860DE8;
	Mon, 13 Apr 2026 10:52:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rPGY4MU2ILxN; Mon, 13 Apr 2026 10:52:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6E4160DE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776077554;
	bh=wlOWhH6bDXD2Okn0TrVB7zMDgRC0F+Y7IGtZfsT0zvA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fL/7mW2S+L2q5xdDsEGCahkBdjoocb+Uf75RFBiqaOdxL6df2MeY+NNcUdCLS0GJv
	 3IyHykn9DUmt2eUwKnREbFGGp2DcR6f+FtDCBVd+I61qZluqx41STl6UOQBStCqBx3
	 7UXYazVhfjWuCFkdzlhk3xNjjKZ8tFGfEaaJpWX9J92ufxiSmsP80OPei3kWjjDWXM
	 a8V6+lsAHxpOucXGcZvZzW2xNKuZ6JXw2oJHjnWZYsjAhXzLlWGd2HXrpBGEZMrLVd
	 ZWoT689kizGyESf0ih9RnGvsK/kfTefIf3w7QHdGnPuQWc2CXk6c0NKh3dNn8vWfsj
	 TXmR+DSRjOcwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6E4160DE3;
	Mon, 13 Apr 2026 10:52:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F427237
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 10:52:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 70FA842183
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 10:52:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TWRBAGpITBLe for <intel-wired-lan@lists.osuosl.org>;
 Mon, 13 Apr 2026 10:52:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C819242112
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C819242112
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C819242112
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 10:52:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CE03360172;
 Mon, 13 Apr 2026 10:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3A7C116C6;
 Mon, 13 Apr 2026 10:52:30 +0000 (UTC)
Date: Mon, 13 Apr 2026 11:52:28 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
Message-ID: <20260413105228.GM469338@kernel.org>
References: <20260408131154.2661818-1-aleksandr.loktionov@intel.com>
 <20260408131154.2661818-2-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408131154.2661818-2-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776077551;
 bh=/59Z2nIxca4BWCGm41Q6Vv1qVELMXteJ1TzzUL0CZBs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Aa9qG/FtFR8PilwlAVTGc2cfRcP/xOxcrUt8dNlp7948fgaf/zaAqfG5vsj5x6EVf
 keI7k+eYVk6wSRpo/Bj7K4sqjh36TCDmdfoFg2nKtOChlfUzXxt9LEH7AneAM6FKsJ
 uV6ywKoThT00sSA6HZ8G65p9xRm++NQQI1aGCzP5N+gF8UwnUYsiJ1BHeWgXXV6RLO
 S0TosDCcHNT/0T/xf/D7x8Cm7aFKHW53Ucde4CW7pQnzeOqa8JicFVZxOq2eG8dB0z
 y992Opoqf8AYFdS177QYXhKHmseDoUXE0eAsA9IOAbway64CDdOczMjrP2OL2mu+ag
 lZAG68Czz7Irg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Aa9qG/Ft
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 1/6] ixgbe: fix SWFW
 semaphore timeout for X550 family
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

On Wed, Apr 08, 2026 at 03:11:49PM +0200, Aleksandr Loktionov wrote:
> According to FW documentation, the most time-consuming FW operation is
> Shadow RAM (SR) dump which takes up to 3.2 seconds.  For X550 family
> devices the module-update FW command can take over 4.5 s.  The default
> semaphore loop runs 200 iterations with a 5 ms sleep each, giving a
> maximum wait of 1 s -- not "200 ms" as previously stated in error.
> This is insufficient for X550 family FW update operations and causes
> spurious EBUSY failures.
> 
> Extend the SW/FW semaphore timeout from 1 s to 5 s (1000 iterations x
> 5 ms) for all three X550 variants: ixgbe_mac_X550, ixgbe_mac_X550EM_x,
> and ixgbe_mac_x550em_a.  All three share the same FW and exhibit the
> same worst-case latency.  Use three explicit mac.type comparisons rather
> than a range check so future MAC additions are not inadvertently
> captured.
> 
> The timeout variable is set immediately before the loop so the intent
> is clear, with an inline comment stating the resulting maximum delay.
> 
> Suggested-by: Soumen Karmakar <soumen.karmakar@intel.com>
> Cc: stable@vger.kernel.org
> Suggested-by: Marta Plantykow <marta.a.plantykow@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1 -> v2:
>  - Squash with 0015 (X550EM extension); fix commit message ("200ms" was
>    wrong, actual default is 1 s); replace >= / <= range check with three
>    explicit mac.type == comparisons per Tony Nguyen.

Reviewed-by: Simon Horman <horms@kernel.org>

