Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DC8FA1FD5
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Apr 2026 16:47:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63BEF42822;
	Wed, 22 Apr 2026 16:47:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XkpoSSM6XiS7; Wed, 22 Apr 2026 16:47:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B80542821
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776876428;
	bh=iBcNeFy4bwZg4GDcMVrL3GGrQh0CpdmkUzKSHKENMeA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fscBjqC/fvKJP2csbEODSjkN8r1lmGLf3LhAYSNanOvPqXj7Q5MYGNNvCd+JGxtM0
	 1Zh/1L84UZ3jO2EZdUVWm3n53r3g0GaR3VjedB6FUOp9GOo2JX4rK/flCIsQSPu/xH
	 SvgraWTCdnnqFlD2p+nreGva42bDysL2fe5jLhtdAODsLSAf1PgoZzCUCocnxua3iG
	 iljc8UvT559tCaMYRnRKfos4EN+bkAdNSk/JI9q81455FGChQzuA5uu3sqHTEmFsgQ
	 KpkB7h4vPRsp/lcvzt+PVZ+KNK4f7IMPgScjx4A2/cZki2Ygabv0hkfWHT4nE038jP
	 I97tE+FovklQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B80542821;
	Wed, 22 Apr 2026 16:47:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 246EF257
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Apr 2026 16:47:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 14C2384A6B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Apr 2026 16:47:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FsoPImzD7XEo for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 Apr 2026 16:47:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 44B9184A67
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44B9184A67
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44B9184A67
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Apr 2026 16:47:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 658534026E;
 Wed, 22 Apr 2026 16:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FDBC19425;
 Wed, 22 Apr 2026 16:47:02 +0000 (UTC)
Date: Wed, 22 Apr 2026 17:46:59 +0100
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Chwee-Lin Choong <chwee.lin.choong@intel.com>
Message-ID: <20260422164659.GP651125@horms.kernel.org>
References: <20260417193223.291093-1-kohei@enjuk.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417193223.291093-1-kohei@enjuk.jp>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776876425;
 bh=I8t8RTkMnBk+PgfRd8qWXKGoXCX45BEPArwzNaPdUEA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GSL703Ul2+Tt5SG3MlOUok3KwhVze8aPcd3RcX44dFVCbrvu26z6JNRLHD5EBcAxX
 kPMoIyOh85Cb4fRr2/21W4lMSVr2M+1Wsf9GAZpmfSA/asx6V7/XlO007Ov2lwUPOi
 penS2jrrKVKxLoXhuQYoAlwH5lmYZKYRiSiAp1l+4o9SKf8bLF1vCvl/iY3hU7JCdu
 DmWImt1Ndaf87G6jJJ2GXWvHXvdNTZa2CPi1LtHVIgy8YKI9RgYHM06D19nrhxQzGa
 8UPbT8bC96AKuIIXZ9QAS757e4QdivycUe3c8H1P080Id6o1ESsMz3j9kWC/S3IUMX
 7TQcHzYJB50dw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=GSL703Ul
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] igc: set tx buffer type
 for SMD frames
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

On Sat, Apr 18, 2026 at 04:31:47AM +0900, Kohei Enju wrote:
> Sashiko pointed out that igc_fpe_init_smd_frame() initializes
> igc_tx_buffer fields for an SMD skb, but does not set the buffer type:
> https://sashiko.dev/#/patchset/20260415025226.114115-1-kohei%40enjuk.jp
> 
> Since igc_tx_buffer entries are reused, a stale XDP or XSK type can
> remain and make TX completion use the wrong cleanup path.
> 
> Set the buffer type to IGC_TX_BUFFER_TYPE_SKB.
> 
> Fixes: 5422570c0010 ("igc: add support for frame preemption verification")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>

Reviewed-by: Simon Horman <horms@kernel.org>

