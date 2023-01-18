Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781B3C38142
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Jan 2023 00:58:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F18A360E14;
	Wed, 18 Jan 2023 00:58:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F18A360E14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1674003494;
	bh=a3Cu9/1oq0K/nJfA6q3hDLwwIijkD3QdzH7Ms7F9sbw=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=CtCGvUA/3i2tqJ/WFv/Tjp0HwD4odCfdEgEUJ+gtUZt21AH+cHA+frshkAcrjExGy
	 ybeVG24eC6Erb5Buh1sXNdOlmTu3U8Fs6TT0kEKAwZh5dlP5vNWT6uUACV+rvyH5+S
	 inMyiHm2AiHQtXwMMimBIP1MJOGYUOlYXAFg2hnKGtGq3+Z77+MAAGliOOSPgYE49w
	 F2J02NxtDItJ62uWBwUtLWMwgTK29FA3AhpTGoSl5te5OD68OQibfEy3zILVALc6jI
	 lkBTwlYhTddSa3myuo64KcOy55FErFM53aMHmoTDInUCKoHRYmiylBsjRsMv/Fcvlv
	 moDh5xzUk0sbA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id arckf_KM92X5; Wed, 18 Jan 2023 00:58:13 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E8EE60E49;
	Wed, 18 Jan 2023 00:58:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E8EE60E49
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id A6F711BF95F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Jan 2023 00:58:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C5834175C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Jan 2023 00:58:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C5834175C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3CXgWkxYU8uj for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Jan 2023 00:58:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AAD8A408A8
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AAD8A408A8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Jan 2023 00:58:10 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 9BDFCB81A94;
 Wed, 18 Jan 2023 00:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274D8C433EF;
 Wed, 18 Jan 2023 00:58:05 +0000 (UTC)
Date: Tue, 17 Jan 2023 16:58:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Message-ID: <20230117165804.65118609@kernel.org>
In-Reply-To: <e58d34cd95e39caf0efb25951bc2da9948c6f486.1673710867.git.lorenzo@kernel.org>
References: <cover.1673710866.git.lorenzo@kernel.org>
 <e58d34cd95e39caf0efb25951bc2da9948c6f486.1673710867.git.lorenzo@kernel.org>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1674003486;
 bh=wXGvhpjsTJaidPvLSv6kMt4Cg9G8YdRR9e5sVriyHis=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=HeZ3N+eMQcA+aA3DkAM0Je/rQ2PdXhZZ0jzYpE7luOv31va8EDz8WVXJJux6nVLpV
 VP40nsuqTuRj64vQElVJ0jg5y2MCExOfPkKPnXZ2cw9V8X4nbFINuEGjKKIDIK61lV
 dLvDje5bARFynorpmLAVk7vSKIw2dFXLo2033Dorp3ETx0cDjCVlKqcxbslw2X/l2u
 llqgAfTh+L1NTAUi1kpyTUG3R+pmAAa7l50tD949ZpwXOayBq5vFobPGQvD2nvsXZ0
 b0nNKGPjDzG6/9wvA5A6fxNm46tlV4G97YxKNyrka/2R5WVbZrwoZq3KewjAuuRpyG
 6Koz9Gv8/Oy5w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=HeZ3N+eM
Subject: Re: [Intel-wired-lan] [RFC v2 bpf-next 5/7] libbpf: add API to get
 XDP/XSK supported features
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
Cc: mst@redhat.com, vladimir.oltean@nxp.com, ast@kernel.org,
 edumazet@google.com, anthony.l.nguyen@intel.com, daniel@iogearbox.net,
 andrii@kernel.org, intel-wired-lan@lists.osuosl.org, simon.horman@corigine.com,
 pabeni@redhat.com, aelior@marvell.com, hawk@kernel.org,
 christophe.jaillet@wanadoo.fr, memxor@gmail.com, john@phrozen.org,
 bjorn@kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 leon@kernel.org, netdev@vger.kernel.org, toke@redhat.com,
 ecree.xilinx@gmail.com, alardam@gmail.com, gospo@broadcom.com,
 saeedm@nvidia.com, davem@davemloft.net, nbd@nbd.name
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sat, 14 Jan 2023 16:54:35 +0100 Lorenzo Bianconi wrote:
> +	struct nlattr *na = (struct nlattr *)(NLMSG_DATA(nh) + GENL_HDRLEN);
> +
> +	na = (struct nlattr *)((void *)na + NLA_ALIGN(na->nla_len));
> +	if (na->nla_type == CTRL_ATTR_FAMILY_ID) {

Assuming layout of attributes within a message is a hard no-no.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
