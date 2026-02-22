Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD49EC1100
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Feb 2026 16:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B8036078D;
	Mon, 23 Feb 2026 16:15:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bBf6MeaHFArr; Mon, 23 Feb 2026 16:15:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 63F22606B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771863314;
	bh=csWFTOv2KktGnb2BGSM5zvz6p39DazK8jCF/sI6MRLw=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YYX8KsUx6qKwQ7lAVgC7dgPvrzarpy0hAboX0PotdJQedkyUwhShTPpqOcsz87Jd4
	 3oLipIlKjs30namH2/FD+QrhfxuToZSrLSaHFr6uqug50vZDdoqYL/ef/jNWY6709V
	 e/7rzMQdgrST7A/7v2rhHMS81bXBqB2XXGR+d5AMcng1h8ZnwzV3guyv+XylPp5Jak
	 8TsmOZiUSItZ2yWm//yDEX05vybRovBhUsNUXYT1S7K9W8qcDOOKnq9TFhqZDhMi2W
	 PFv/VXJ/B0vyPWLuMWQUbGCBaS1Qp+OGgIlGzQsv1DzXTlEiJp5zHWevUahhAXKiQg
	 jij9w+fC6Alhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63F22606B1;
	Mon, 23 Feb 2026 16:15:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 05C2E249
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Feb 2026 18:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DED4640EE5
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Feb 2026 18:27:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XA0qrxUNCUXu for <intel-wired-lan@lists.osuosl.org>;
 Sun, 22 Feb 2026 18:27:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dsahern@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 444FA4060A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 444FA4060A
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 444FA4060A
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Feb 2026 18:27:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BA75E60121;
 Sun, 22 Feb 2026 18:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77093C116D0;
 Sun, 22 Feb 2026 18:27:31 +0000 (UTC)
Message-ID: <56e04cb1-e205-4076-8236-1f172a75793d@kernel.org>
Date: Sun, 22 Feb 2026 11:27:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Nikolay Aleksandrov <nikolay@nvidia.com>, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Daniel Zahka <daniel.zahka@gmail.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Dave Ertman <david.m.ertman@intel.com>,
 Mustafa Ismail <mustafa.ismail@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 intel-wired-lan@lists.osuosl.org
References: <20260213084841.1406442-1-nikolay@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260213084841.1406442-1-nikolay@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 23 Feb 2026 16:15:11 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771784852;
 bh=Ix9c2Lsr9lIBEM1FL5vboG1LzP8v/vhBlJbmYuuWIa4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=o9cecG4iuguIiIQi+Nw013qptncRG2bDH4bn8SJPye+7m5lcJgNn6vJvrs6vCGyoY
 sZmhvm5/fJpCLpHzqMpK4E2HpHMhJ7ZJvuh76hHCzCxneNKqT0AW4o5ABYY3tBWpmO
 MqxUxuBdOQxEPuKu0NfKi+zFtiIP18g6nj/v5MZ0PLgd0+VApD7mbQTMTldnALtJwc
 CU0EQEfOJKDyTthEjQ+RtKLvVSvB7xAuPomSzxexQGswI7s6S6m09FXlGJ13pvHk2n
 vHxHWLbEsvSU/m+/PXTL0JK0LZ6miyA84C2dkgyT23lNgmE7C02DUO8lHSppmA9wgR
 ZxwqN04alGLZA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=o9cecG4i
Subject: Re: [Intel-wired-lan] [PATCH net] drivers: net: ice: fix devlink
 parameters get without irdma
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

On 2/13/26 1:48 AM, Nikolay Aleksandrov wrote:
> If CONFIG_IRDMA isn't enabled but there are ice NICs in the system, the
> driver will prevent full devlink dev param show dump because its rdma get
> callbacks return ENODEV and stop the dump. For example:
>  $ devlink dev param show
>  pci/0000:82:00.0:
>    name msix_vec_per_pf_max type generic
>      values:
>        cmode driverinit value 2
>    name msix_vec_per_pf_min type generic
>      values:
>        cmode driverinit value 2
>  kernel answers: No such device
> 
> Returning EOPNOTSUPP allows the dump to continue so we can see all devices'
> devlink parameters.
> 
> Fixes: c24a65b6a27c ("iidc/ice/irdma: Update IDC to support multiple consumers")
> Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> ---
>  drivers/net/ethernet/intel/ice/devlink/devlink.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

This patch was marked as awaiting upstream; I wanted to confirm it is in
Intel's queue or was the expectation for netdev maintainer's to pick it up?

