Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EB1606A31A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=XpTXYhni;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nM8l+qHp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A67A980B08;
	Mon, 23 Nov 2026 12:46:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PX7_LL-4EO31; Mon, 23 Nov 2026 12:46:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 23E3380E29
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795437966;
	b=c7VVtC2W0jvJk5bSWfYjlhX5BhfcCLJtIGDa1lIYpEIyvpgosvPRmAqx+91i3QX7mlAI
	 A/4HvFWc6bMC2cBODF24lnNg24+jNtZzd9byL1+4FrHE5VaLpEamjKywGiP9kOmSkElad
	 GJkDKqDCEb216uC6v9/Bu22O4EZF0B52rQAS8B4+657b8eKzGLNe0a5c1tYzCuelm8Y8d
	 12JHrTbZdXBKAS+8GVcNlFDx9P6msgNfyi3ztk2SKTTAaarXt4uXkeTKL6VvNoca/WUYR
	 kym2fuK4CyXIPnFpKLrI6Ovlo7kg3hGB6qTZl4+haYvp2ACsI9Lci4Itz32Ukx4aX9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795437966;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=k+m0IX8hBrBVsWLx6cEzIqWPXX+HhBPIB4+GKXs5J9M=;
	b=AuTW2d0GIU7yN5JLxd9IEwfc4Fw2DSvVVKKg8bizQyxCl2b5v1fxGjozhELRWLaXecGG
	 1tbTAh9JDvY2FMcx7cd/afY9vKJxgWj4QHpEyS0IowE+x2NlyIoFKMEkDiXFEUlBv+uXC
	 B91aorYdvyI9AiyyLbB5bVfNMM3rkKCyg+SnYn7e8Z2jxPcUdunx6dpIdj46Lu9AbSNWf
	 vXDI8Q6e/we5WQFKLl0S2pFpCHwBVUSE0EjzuySs9oHY4zqASlYvJFihFJpXr5oEO+qea
	 LsC3PVs2MqqDR/XMExFpbbPa7VP9K3GLk30AbOH980IORmbgHoi1AAQPHoJ0Lj5uByA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795437966;
	bh=k+m0IX8hBrBVsWLx6cEzIqWPXX+HhBPIB4+GKXs5J9M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XpTXYhni9NZdV4sXLosuIJ9WMpfZkakcGxySow0rc5093pG2ORHOnqujN2YZjyinH
	 xbx02LDx7EKH1j8oYO2EgF4zpUJK5W/QG85zxDBCIcmJ3DR0bSz5v12/DJ30eVbe5O
	 InW6wiWWrn1wHNiQrhDHxIuR9nK2WntE1wZv+XLjwReK8rm5yk4zTW+/3JEshrHjqT
	 2YeABPQ2QgEDdCtGw8vNJ8fBGrWg8sjj6PxtEvPk3eyQXxMVjh77nC0dg7rzKTnwUz
	 rXutMZj5ZZdg9uCv86aRnb8gTxwnjP6wufZmSy8jxvcmd0Bxcu5hmmCDi6PrmMdF2x
	 eJHyycpwxgM6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23E3380E29;
	Mon, 23 Nov 2026 12:46:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 37D4E3A8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 12:46:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1D6256076F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 12:46:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZPzQum5YvkJR for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 12:46:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7D8B36073D
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=nM8l+qHp
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7D8B36073D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 12:46:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CBD60620E2;
 Mon, 23 Nov 2026 12:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63251F000C6;
 Mon, 23 Nov 2026 12:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795437961;
 bh=k+m0IX8hBrBVsWLx6cEzIqWPXX+HhBPIB4+GKXs5J9M=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=nM8l+qHpX2CPS8G+N76arvvHWhKAIb6PyXS2EMPgDbqZNJ06elrV7/RNl4V7N6dTh
 +JGwoPBNFAWJ4jXxcAt4Yumx7MYyjIvTOEOSnmfRXXqIUBTdGOsH5Ix6XX+rHFqoV7
 9rAV7N9oKulwQ8jsibb/xKrt0Lc88cdDrz8+4nPvEMo6jWIsJQlI5EsL4Su6RVJj+H
 TIQ0xXanx0afgdA3TxeIzYGGADc1tbZVN1Hg6bZHUxbFu4ZnJ801S0QAT3CupE2sk6
 gvUeeL4wWJCMsNWPtOkSUFELvqhZ+Dcg2h+VrrKavEnRWNtsQ6EvLDttSuq5mtvWWQ
 Tb9KraGLPBQAg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Magnus Karlsson <magnus.karlsson@intel.com>, netdev@vger.kernel.org,
 magnus.karlsson@intel.com, magnus.karlsson@gmail.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kerneljasonxing@gmail.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com
Subject: Re: [PATCH net-next 3/5] xsk: ice: add USO zero-copy support
In-Reply-To: <20261119165340.1071525-4-magnus.karlsson@intel.com>
References: <20261119165340.1071525-1-magnus.karlsson@intel.com>
 <20261119165340.1071525-4-magnus.karlsson@intel.com>
Date: Mon, 23 Nov 2026 13:45:58 +0100
Message-ID: <8733sr1zsp.fsf@all.your.base.are.belong.to.us>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Magnus Karlsson <magnus.karlsson@intel.com> writes:

>  Documentation/netlink/specs/netdev.yaml       |   4 +
>  Documentation/networking/xsk-tx-metadata.rst  |  47 +-
>  drivers/net/ethernet/intel/ice/ice.h          |  10 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |   2 +
>  .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |   1 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |   1 +
>  drivers/net/ethernet/intel/ice/ice_sf_eth.c   |   1 +
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |   3 +
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  22 +-
>  drivers/net/ethernet/intel/ice/ice_xsk.c      | 502 ++++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_xsk.h      |  13 +
>  include/net/xdp_sock.h                        |   5 +
>  include/net/xdp_sock_drv.h                    |   6 +
>  include/net/xsk_tx_uso.h                      |  20 +
>  include/uapi/linux/if_xdp.h                   |   5 +-
>  include/uapi/linux/netdev.h                   |   3 +
>  net/core/netdev-genl.c                        |   2 +
>  net/xdp/xsk.c                                 |  24 +
>  net/xdp/xsk_buff_pool.c                       |   4 +-
>  net/xdp/xsk_tx_uso.c                          |  97 ++++
>  tools/include/uapi/linux/if_xdp.h             |   5 +-
>  tools/include/uapi/linux/netdev.h             |   3 +

I think the non-ice changes should go in a separate patch.


Bj=C3=B6rn
