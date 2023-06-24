Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71A8EB64DC
	for <intel-wired-lan@archiver.kernel.org>; Sat, 24 Jun 2023 21:43:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8AED2403F8;
	Sat, 24 Jun 2023 21:43:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8AED2403F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1687642997;
	bh=rzdY8PDq7HepzrEo8cEanCQluU9xTHlsXtlWnmObkrI=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=6ocl17Q+OGXNZozNLLVBfNNHT3J4xHgtqJpweWNFLZ9Tz1dINXL5ObrzwkJUca8e8
	 e10F21/FeEZg2DzOQOdbX+s+TmByMPcqk6ZjyTymA6N6ag4IdIbMFrcdMwzXTXTXZU
	 kV9av78gIvDSNQdisAyEkQ0A/2NejW64dEBY80/OuRETn1sbaypjLIjOpdMv1ZU/jk
	 GQboBrhIfZm3ahXfg2yyPG9H8wUlBRChU+mWOvuXPgEFVLV7OSivTn3RQJQa05hldn
	 8Gb2Hyq9xfqgkK+h1gfEeMBkoHcRMz8YuHXeBRqxaeLz5evdIERfFjG16//8YerLcs
	 b3QZETP1xeU4g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lty7PWH46UWe; Sat, 24 Jun 2023 21:43:16 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 997EA404E0;
	Sat, 24 Jun 2023 21:43:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 997EA404E0
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id BE7A01BF3FC
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Jun 2023 21:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 765DC4024D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Jun 2023 21:43:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 765DC4024D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jEzMVAdPYKT6 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 24 Jun 2023 21:43:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7965640249
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7965640249
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Jun 2023 21:43:14 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B6AE7606DC;
 Sat, 24 Jun 2023 21:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E909C433C0;
 Sat, 24 Jun 2023 21:43:10 +0000 (UTC)
Date: Sat, 24 Jun 2023 14:43:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Message-ID: <20230624144309.71aa507d@kernel.org>
In-Reply-To: <ZJa2GEr6frhHQrS0@nanopsycho>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
 <ZJW37ynDxJCwHscN@nanopsycho> <20230623085336.1a486ca3@kernel.org>
 <ZJa2GEr6frhHQrS0@nanopsycho>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1687642992;
 bh=lmOEecdkRp4pBOR9oOVxNztmp5HIMJkVrx6xS1MQx8k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=AILdp2c5CxOsj6tC0tqBVwvgFwGEWi/HNCqgnUP9ie2N/3J8Q6hT7ivMLWul3XZHr
 K0F527m3/A5wfokBRBq2EoCdMo9FsgZZ4xXrI34JiaXoTZs6r2Tqo0mWGyNuvkT5Hx
 rqBkXq7TJf9KNU0u4uFislfstbrlfbHFz3kgruQ6jVE3iG5BADxR8sM3S+eQaaELaB
 U9QP8K7Retu4ZVuHIWC+4aWzH36dvMxjUeAGjhNXxvzpZGdUy6XFg4nqRO05CBGEs7
 ChgFMA7WUcZdECRkGHISdSMolv/X7dTDd+Jy57O7j1GzG0otI8Oj52RnmkIxn5x8Ut
 UPn4FnOQlZyHg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=AILdp2c5
Subject: Re: [Intel-wired-lan] [RFC PATCH v9 00/10] Create common DPLL
 configuration API
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
Cc: geert+renesas@glider.be, mst@redhat.com, razor@blackwall.org, phil@nwl.cc,
 javierm@redhat.com, edumazet@google.com, benjamin.tissoires@redhat.com,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org, linux-clk@vger.kernel.org,
 lucien.xin@gmail.com, leon@kernel.org, corbet@lwn.net,
 linux-rdma@vger.kernel.org, masahiroy@kernel.org, linux-doc@vger.kernel.org,
 jesse.brandeburg@intel.com, vadfed@meta.com, intel-wired-lan@lists.osuosl.org,
 airlied@redhat.com, vadfed@fb.com, pabeni@redhat.com,
 ricardo.canuelo@collabora.com, arnd@arndb.de, idosch@nvidia.com,
 richardcochran@gmail.com, claudiajkang@gmail.com, kuniyu@amazon.com,
 jacek.lawrynowicz@linux.intel.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, linux-arm-kernel@lists.infradead.org,
 axboe@kernel.dk, sj@kernel.org, vadim.fedorenko@linux.dev, linux@zary.sk,
 gregkh@linuxfoundation.org, ogabbay@kernel.org, nipun.gupta@amd.com,
 linux-kernel@vger.kernel.org, andy.ren@getcruise.com, tzimmermann@suse.de,
 jonathan.lemon@gmail.com, saeedm@nvidia.com, davem@davemloft.net,
 milena.olech@intel.com, hkallweit1@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sat, 24 Jun 2023 11:23:36 +0200 Jiri Pirko wrote:
> Well I would like to conclude discussion in one thread before sending
> the next one. What should I do? Should I start the same discussion
> pointing out the same issues in this thread again? This can't work.
> 
> Even concluded items are ignored, like 3)
> 
> IDK, this is very frustrating for me. I have to double check everything
> just in case it was not ignored. I don't understand this, there is no
> justification.

Yes, the open items need to be clearly stated on a new posting.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
