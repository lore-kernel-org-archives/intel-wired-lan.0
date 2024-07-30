Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F024BC3DA49
	for <intel-wired-lan@archiver.kernel.org>; Tue, 30 Jul 2024 10:23:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B748A81140;
	Tue, 30 Jul 2024 10:23:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7XA1mZ3vvlI3; Tue, 30 Jul 2024 10:23:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 28FA881120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1722334983;
	bh=t6SB2DuCGrmvQWDsFGVnjfOvYNMWJ6+S4FIDl5AFpqM=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=QhdZiSmccdbcwr2y2i6mMgjDW0Ab+Q5GyHZLRe0kCi8T0o2UtxCZe69EQCKk5vXVd
	 MRs+iraV3pex6/+s3Tgh70nB737Awy9GAKz9loLKlPLfnE/Pa6yX6YUVqkH1ULDHzQ
	 zYGp7EfjVulGUqhysluVSfvOJcLww/iS6E3bU+elUi5G/BMgZYuAJTVZvO725/TLgl
	 B7TuLfHnjOjPsdFiB6vm18vQCVuyWOwJwwA8KOeYth6kVb8IQYsh2za/qaGqN4twym
	 4trZmwF73Bi9TnCcafPAxMtYQh9j5NCjeuTgyH3zARJnZwVYWtoi2+ORxu6ccGLOJu
	 Oy3NbngCp28XQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28FA881120;
	Tue, 30 Jul 2024 10:23:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id B41821BF5DA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jul 2024 10:23:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A071D4057F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jul 2024 10:23:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rlyfmCJf3PX1 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 30 Jul 2024 10:23:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CA2074023F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA2074023F
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CA2074023F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jul 2024 10:23:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A65A061C41;
 Tue, 30 Jul 2024 10:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90980C32782;
 Tue, 30 Jul 2024 10:22:57 +0000 (UTC)
Date: Tue, 30 Jul 2024 11:22:55 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Message-ID: <20240730102255.GT97837@kernel.org>
References: <20240725220810.12748-1-ahmed.zaki@intel.com>
 <20240725220810.12748-6-ahmed.zaki@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725220810.12748-6-ahmed.zaki@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1722334979;
 bh=lS9HhdtLF+ce4u9oCui2lNNghuoy0C3sxx2ZrpadLu4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EafZYHBccvmwcqWlKZOwsv95YGvUoEeYINTyNYaumh9Yr0UVOKrGLuJaHmg6FQpke
 /3yNBmwAEFmDMBvGQQaAbY6vuihwU7kNZ9qv2Y6iUIsV4B/qs9/15SCpiJ6EqbQFs8
 1F9osI8QY24PmCgsXc9P7RaK/wSU/9Y0TDw6uTnmDMSFRgpKFv83T1mj+nWGSjReKs
 1dUunMlq5Jn2gpj+/MiBEubS5BUz4nxSjnZSYYEjeOcc/+v+4r8G/k1NKCBmgPFHLW
 7lEUTJEpVPFtraK1Ma2gIVBEIdv49D7IVpBwK7OdSdgwEQXOqbb9h4N7mv0iQMkTKZ
 ibkP83FZWwVCw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=EafZYHBc
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 05/13] ice: add parser
 execution main loop
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
Cc: netdev@vger.kernel.org, hkelam@marvell.com,
 Marcin Szycik <marcin.szycik@linux.intel.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, Junfeng Guo <junfeng.guo@intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Rafal Romanowski <rafal.romanowski@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Jul 25, 2024 at 04:08:01PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> Implement the core work of the runtime parser via:
> - ice_parser_rt_execute()
> - ice_parser_rt_reset()
> - ice_parser_rt_pkt_buf_set()
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

