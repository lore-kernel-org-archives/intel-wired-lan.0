Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE64AC4332F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 14 Nov 2022 13:24:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BC1E4024A;
	Mon, 14 Nov 2022 13:24:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7BC1E4024A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1668432246;
	bh=HXvUftarAe38yWe6R1e7zjfwvpoPgd9H0bAw5HZZxTI=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=qY0h54/ig2jzEeiKBmxE4QqkVbxTxo1Y0A66k2TuwW8Ni0q7iNomsFPxZb/hzOyQH
	 Hh2vJsmhrvhR4BODZlYLITkDRTL5JOb1oLVhazKvmj/uEiKCsnk0gKeN/uvzgHrHqA
	 Eu/5zgC3S2ywOUTNdCMVSJl0okWqeUWSZDQQ3DVCbx0+W87aosVmGQAw/EZ4skzA3M
	 ixqn7uJWv4faspjBOmd3A1Kiab7lL84tvefvUte2Fb+bKUkp0hVIqrvmt3AyvEXTxs
	 bjIx7xYJjzWT6ZbZ+OBa67EuWNQ4GZApyLotOW0sHhWhiPaf4Xgs5HZNCnIdxpIW6p
	 yVvLUp4h7XDhg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nPD33X9sbo27; Mon, 14 Nov 2022 13:24:05 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33A8B40245;
	Mon, 14 Nov 2022 13:24:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 33A8B40245
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 0AD6E1BF379
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Nov 2022 13:24:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E56AD40245
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Nov 2022 13:24:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E56AD40245
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wRDipVzGfhwq for <intel-wired-lan@lists.osuosl.org>;
 Mon, 14 Nov 2022 13:24:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BCE694023E
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BCE694023E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Nov 2022 13:24:02 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BBF76B80D19;
 Mon, 14 Nov 2022 13:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D86FC433D6;
 Mon, 14 Nov 2022 13:23:57 +0000 (UTC)
Date: Mon, 14 Nov 2022 15:23:53 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Message-ID: <Y3JBaQ7+p5ncsjuW@unreal>
References: <20221114125755.13659-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221114125755.13659-1-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1668432238;
 bh=wnpm2NS18rFbBEvcB3KHijozvFClc8bbydDGjrnn9c8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LtTwazV4c5DKoHkz7x3vGPuCKSxlYnU6Sx8SA7P/S+nXh3YlvQMkDP8CVRmk34FR6
 tfPEcYnaHmc4OJKYwO9yR4lYO3/KhLY/nBQYlT2sANSl6H0ZoPFnljuTYZP89eMzDu
 +DviOctPjqwLCaJWXx8nNL8fwrB78laB8xn+ljVWN5zfLrTcvnrH/muEn9Z0LdFDzt
 sCKYIlNjDkvvV+FGonz/h3hKh+/SANVzAjRVogRc83xt/QmlKi+YOSHC2v8830FYnJ
 oM30yxJYhA2if6I0WLMxWOup4hUwzj2QZTuPDXMvYLoLFB0uebjAJcgEer7fzz9GDr
 2eCNoHK9dkthA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=LtTwazV4
Subject: Re: [Intel-wired-lan] [PATCH net-next 00/13] resource management
 using devlink reload
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
Cc: mustafa.ismail@intel.com, netdev@vger.kernel.org,
 leszek.kaliszczuk@intel.com, przemyslaw.kitszel@intel.com, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, jiri@nvidia.com, kuba@kernel.org,
 pabeni@redhat.com, shiraz.saleem@intel.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Nov 14, 2022 at 01:57:42PM +0100, Michal Swiatkowski wrote:
> Currently the default value for number of PF vectors is number of CPUs.
> Because of that there are cases when all vectors are used for PF
> and user can't create more VFs. It is hard to set default number of
> CPUs right for all different use cases. Instead allow user to choose
> how many vectors should be used for various features. After implementing
> subdevices this mechanism will be also used to set number of vectors
> for subfunctions.
> 
> The idea is to set vectors for eth or VFs using devlink resource API.
> New value of vectors will be used after devlink reinit. Example
> commands:
> $ sudo devlink resource set pci/0000:31:00.0 path msix/msix_eth size 16
> $ sudo devlink dev reload pci/0000:31:00.0
> After reload driver will work with 16 vectors used for eth instead of
> num_cpus.

By saying "vectors", are you referring to MSI-X vectors?
If yes, you have specific interface for that.
https://lore.kernel.org/linux-pci/20210314124256.70253-1-leon@kernel.org/

Thanks
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
