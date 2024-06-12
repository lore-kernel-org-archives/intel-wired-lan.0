Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97CBC27C79
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Jun 2024 02:38:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C9B6402C4;
	Wed, 12 Jun 2024 02:38:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3_OnqlkgC59r; Wed, 12 Jun 2024 02:38:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A1691402B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1718159925;
	bh=vmyR4QR4O0qDRG2Tdpec3h1CFmxBVl5p9LVA9RJcQdI=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=sTq08CZcz7XeGXlJBqN/1hiXTlgzFm8VR6CwRwNxvvPbJS8rk4eXVba/KI9Uw8Dvv
	 2RJ94rTIrb6IdURSu9kzoPtQSU4Q5Qphkbro1PNdMex1G2a2MTRlb7EC0zr23f3rzq
	 z26K99kvKiG5bbuIXcLMlsdsnO5SAZYjgjTxFdjbryhOdR+CAF0ppAQwh9Ex177eBp
	 pBrOCKjfaIeoxP1mAIiFbZWbz3ChYBFznK9XqdRzc33G34luHmwQ4jGDnMhdJpTRVi
	 y6UXtqEsTWfGZ3Hw9rhJSUQcB/sALJy2pGpMhW+tGQAu2qPN7dH9G72RL/ExcjFNWP
	 OftIe+qYFT/vw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1691402B8;
	Wed, 12 Jun 2024 02:38:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 413541BF37F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jun 2024 02:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2B96382098
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jun 2024 02:38:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WpMtRYAyWI_x for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Jun 2024 02:38:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55;
 helo=sin.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5AA6D82055
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5AA6D82055
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5AA6D82055
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jun 2024 02:38:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A1F46CE1F0D;
 Wed, 12 Jun 2024 02:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470C9C2BD10;
 Wed, 12 Jun 2024 02:38:38 +0000 (UTC)
Date: Tue, 11 Jun 2024 19:38:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Message-ID: <20240611193837.4ffb2401@kernel.org>
In-Reply-To: <20240610153716.31493-1-larysa.zaremba@intel.com>
References: <20240610153716.31493-1-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1718159919;
 bh=vmyR4QR4O0qDRG2Tdpec3h1CFmxBVl5p9LVA9RJcQdI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=q4Dbs5RhFMxmCf4wPg98NTH3+/I9L9tA8L1Dd26Ree+az3alISPp++DLwEbTkooeH
 7mpqTsp9L/TwFgkAjzxpaT0/Kk5w8gOnfgtgtRZrgfj5Wlx9NUmcIhNSlVmo0dTFMF
 dORbD3frvAt4dw59LOqQwFNcU84Dvn+HPYmyx85C34rQWHw1Gl/zaoUdVXXZSos7is
 FsrbDHVYi2UP7BDpb3xsrZRI9MXvDIIr/vK1VbICxBgo3ltEOvpfAWLxJ9GU2Q1OWd
 L3lLtlPtaxHjWkW35y1KupSpchPvTxCOLmHTCmQXklypyRGgJ5lIrdueFfSSrUpnQo
 7MMRvmyt2cQxw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=q4Dbs5Rh
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 0/3] ice: fix synchronization
 between .ndo_bpf() and reset
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
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Michal Kubiak <michal.kubiak@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, magnus.karlsson@intel.com,
 intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, 10 Jun 2024 17:37:12 +0200 Larysa Zaremba wrote:
> Fix the problems that are triggered by tx_timeout and ice_xdp() calls,
> including both pool and program operations.

Is there really no way for ice to fix the locking? :(
The busy loops and trylocks() are not great, and seem like duct tape.
