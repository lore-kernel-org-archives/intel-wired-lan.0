Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFAFC27C6E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 14 Jun 2024 10:41:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67464843EF;
	Fri, 14 Jun 2024 10:41:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q9qhuclcebzd; Fri, 14 Jun 2024 10:41:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C54FF843EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1718361663;
	bh=bwTaErv9yVSvF168de0fXLn7xQk6ggebkczIfbK8OjI=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=03KDsajdk6VoIbzZhTcCHbKWITOQ36J1KjyRAd5FjTeV492Semlcci/1L86LeAsY8
	 ZA+VZ3wj4gkUekFlRN1iDF4rAexnG2IunzjwXFEg3+S337h1LZNgLs2YcMoZAr4IBz
	 YsjTNbLDBlDHzMJfGeJqXnQZhPGlgXQ4c5Y83npe5tFbX7ufpqDt08hDIBfF9gi/Gg
	 mepMRA1ycIn/GveZuW8TqOB2ofB7ZM+6Bmq2BOSx+8DAmUSbRF9xjyPB8AmLJqtnvx
	 Wsue2J7YXq4Pa0SKL/941r1vVr62YxiWpnIIiVe89RnV/8y4FUBSiBzeJKEQxXmGTI
	 AxqyfXwR6Rg8A==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id C54FF843EA;
	Fri, 14 Jun 2024 10:41:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 171771BF33E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Jun 2024 10:41:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 11DDB6060A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Jun 2024 10:41:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m5lNJFrkYTKX for <intel-wired-lan@lists.osuosl.org>;
 Fri, 14 Jun 2024 10:41:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 404BC60593
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 404BC60593
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 404BC60593
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Jun 2024 10:41:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id ADCEFCE2AFB;
 Fri, 14 Jun 2024 10:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A076C4AF1A;
 Fri, 14 Jun 2024 10:40:57 +0000 (UTC)
Date: Fri, 14 Jun 2024 11:40:54 +0100
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Message-ID: <20240614104054.GF8447@kernel.org>
References: <20240606224701.359706-1-jesse.brandeburg@intel.com>
 <20240606224701.359706-5-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606224701.359706-5-jesse.brandeburg@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1718361658;
 bh=B/VMUNEG6+XrQ+4IvPLk13QyRGjVOos0niB7ez3rRes=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ff1ZMpkGwiDfAwnVgXFT17lPCrGYC47rrh8oJk7068Q7Bbpyp9HEbUL+D24RkKSOX
 CAbOxQXsf5OKi/Xbb+r6qe2nL0ytQgbqxM6gxzT3UTG+FHwEeTT8vm1E+pj6BmniM7
 Kpbeih0K0y9EDylXpKgbBQeAtlQiYrnGJG8WZQV5uYidXUfQ48X+dDAe7avNwgsC6X
 GZKWk223E+0DQ8yT0qYSMFvGNOnYtLlcoFBao3eWmkhubVblR+3VjMjoxg9pu6STPb
 nDIs7Ss8x7ZwRXd1B3NLGKagvDrymK65Yb6/Ef9i6l04Q0rGDxs0KptiCwKFb57Kf7
 t8TKwT0EBbzxA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Ff1ZMpkG
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 4/5] ice: implement
 transmit hardware timestamp statistics
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
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org, corbet@lwn.net,
 Hariprasad Kelam <hkelam@marvell.com>, intel-wired-lan@lists.osuosl.org,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Jun 06, 2024 at 03:46:58PM -0700, Jesse Brandeburg wrote:
> The kernel now has common statistics for transmit timestamps, so
> implement them in the ice driver.
> 
> use via
> ethtool -I -T eth0
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

