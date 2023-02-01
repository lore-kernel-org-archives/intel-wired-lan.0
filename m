Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC861C636D3
	for <intel-wired-lan@archiver.kernel.org>; Wed,  1 Feb 2023 22:40:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A08D8199D;
	Wed,  1 Feb 2023 22:40:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A08D8199D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675291228;
	bh=tbMzvrrQLR4Qu3O0ERDfoD3dzl+Z9W+TgTTRuLBo8hc=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=TSe+DbUkALRFXU3iyevglfLxOXDffDwfvelufbtBfBZal2STETj95uHhpnkZCaUiR
	 OXxcyfcrrZfP5cYAZNEc+AQp5ik0dThmccCjM+16Kfub7sxFhx1TsbM0/8JCRWY3S2
	 UApbnNVc4jYWeQzeUe6JL/0Rrg/lPVDbyJH/ofBVZFaIiRyFgVFhj8u5TH+IRzyMfi
	 2QOyZwtUwxXfQ3sDo2NBXsIfWuMvnlsAvxdAm60CKf8DWbJ99g6QYW6rS2RgSzxxeu
	 neHV5/gP1JVSzcMunesFUbg0MG2U8dow9/xUvVsW3bP1saSf23exw9moUFeAbE1I46
	 FrfUBu4FmQn1Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H9k0vz7T5BGb; Wed,  1 Feb 2023 22:40:27 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 776EB81E1C;
	Wed,  1 Feb 2023 22:40:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 776EB81E1C
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 9572D1BF47F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Feb 2023 22:40:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B65B4016F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Feb 2023 22:40:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B65B4016F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2MtjXntslz-Z for <intel-wired-lan@lists.osuosl.org>;
 Wed,  1 Feb 2023 22:40:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5928340002
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5928340002
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Feb 2023 22:40:24 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 16CD5B821B1;
 Wed,  1 Feb 2023 22:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7316C433D2;
 Wed,  1 Feb 2023 22:40:19 +0000 (UTC)
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 9C339E21EEC; Wed,  1 Feb 2023 22:40:19 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <167529121963.1862.10552462490697454435.git-patchwork-notify@kernel.org>
Date: Wed, 01 Feb 2023 22:40:19 +0000
References: <20230131204506.219292-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20230131204506.219292-1-maciej.fijalkowski@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1675291219;
 bh=thR4MM+QmMHTRDBkyAUIHEjRBHS0bX0AjuWuC2nnyl0=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=jKIbZb4skxraDD/NnYFRLFU/+BIZJuXZ6wtTTEvnUONG/gNRmSKEOM7ekn+rjTVsD
 PBeZZ19Jefw7iqt8paI2JLJX4sY51J0KyZwTAxHeRq2QWHP4NgEuJ2ECNHhFuXvnLn
 /C0YzVBnjseksMqwQRKnD8rThz5mysp/ScEe+WGDYjM6y/NziXHpF9RuheysaKND1x
 LoDe68pm5qwbVj2FlrL111f4rNNlBhDbNdkFX9zNsQ9NStXIF4kUhyBZEiEUb6s9hz
 V0B5vKpDfBZd/ptGrNKAdBiahw894kmukRhBCd96v5YX4IwSpTlbx1Mwv9v+Ma85Jh
 +KWRSJXrfYFjw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=jKIbZb4s
Subject: Re: [Intel-wired-lan] [PATCH bpf-next 00/13] ice: add XDP mbuf
 support
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
Cc: tirthendu.sarkar@intel.com, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 bpf@vger.kernel.org, magnus.karlsson@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 31 Jan 2023 21:44:53 +0100 you wrote:
> Hi there,
> 
> although this work started as an effort to add multi-buffer XDP support
> to ice driver, as usual it turned out that some other side stuff needed
> to be addressed, so let me give you an overview.
> 
> First patch adjusts legacy-rx in a way that it will be possible to refer
> to skb_shared_info being at the end of the buffer when gathering up
> frame fragments within xdp_buff.
> 
> [...]

Here is the summary with links:
  - [bpf-next,01/13] ice: prepare legacy-rx for upcoming XDP multi-buffer support
    https://git.kernel.org/bpf/bpf-next/c/c61bcebde72d
  - [bpf-next,02/13] ice: add xdp_buff to ice_rx_ring struct
    https://git.kernel.org/bpf/bpf-next/c/cb0473e0e9dc
  - [bpf-next,03/13] ice: store page count inside ice_rx_buf
    https://git.kernel.org/bpf/bpf-next/c/ac0753391195
  - [bpf-next,04/13] ice: pull out next_to_clean bump out of ice_put_rx_buf()
    https://git.kernel.org/bpf/bpf-next/c/d7956d81f150
  - [bpf-next,05/13] ice: inline eop check
    https://git.kernel.org/bpf/bpf-next/c/e44f4790a2ba
  - [bpf-next,06/13] ice: centrallize Rx buffer recycling
    https://git.kernel.org/bpf/bpf-next/c/1dc1a7e7f410
  - [bpf-next,07/13] ice: use ice_max_xdp_frame_size() in ice_xdp_setup_prog()
    https://git.kernel.org/bpf/bpf-next/c/60bc72b3c4e9
  - [bpf-next,08/13] ice: do not call ice_finalize_xdp_rx() unnecessarily
    https://git.kernel.org/bpf/bpf-next/c/9070fe3da0b1
  - [bpf-next,09/13] ice: use xdp->frame_sz instead of recalculating truesize
    https://git.kernel.org/bpf/bpf-next/c/8a11b334ec9b
  - [bpf-next,10/13] ice: add support for XDP multi-buffer on Rx side
    https://git.kernel.org/bpf/bpf-next/c/2fba7dc5157b
  - [bpf-next,11/13] ice: add support for XDP multi-buffer on Tx side
    https://git.kernel.org/bpf/bpf-next/c/3246a10752a7
  - [bpf-next,12/13] ice: remove next_{dd,rs} fields from ice_tx_ring
    https://git.kernel.org/bpf/bpf-next/c/f4db7b314dd5
  - [bpf-next,13/13] ice: xsk: do not convert to buff to frame for XDP_TX
    https://git.kernel.org/bpf/bpf-next/c/a24b4c6e9aab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
