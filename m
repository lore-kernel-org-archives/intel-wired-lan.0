Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468CDCCF9EE
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Sep 2024 20:33:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66E7A84AE4;
	Wed, 25 Sep 2024 20:33:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EF8Ugi2fdNvI; Wed, 25 Sep 2024 20:33:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D57E384AE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1727296413;
	bh=IxDKxzIq7Ay7agYIrmeRomcCio3BqijV9R3jHOyZOyg=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=3bYjdPCxIl1XkTxylvM7Zl0N7DgwI1MWfovv+B+pHsQexLMz49j0v/c7gBVq4TzIe
	 3FcW53oBsE+QkmEV62uWlUmea0ZVboKNxqYYb/Be/o/iSMT+4U6oYAuqdcAcaBX0xI
	 eFaYFatXQamMvImbC+hQoBpA6ZpSiDXT+frONPrB1y2JG1RyQqRQKF+ufBKT/q8fI5
	 VhEVdrIBqrcQUkfJzdELuW2z4TSQdBcVkldRaP/BXuyUlR/7zMpzMJv4njkmIOJMmf
	 GGrD/Ttvz885XxinZ1uTL4iNkDh5TfUi1RFCq2O7adhp14cbitCbnYhLq9w5PsucwF
	 PLssS3fsqANQQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id D57E384AE0;
	Wed, 25 Sep 2024 20:33:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id AAB211BF340
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Sep 2024 20:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A55DD426D9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Sep 2024 20:33:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6tnxFh4f3tHW for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Sep 2024 20:33:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BA5D0426D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BA5D0426D8
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BA5D0426D8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Sep 2024 20:33:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 2220BA446F5;
 Wed, 25 Sep 2024 20:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E42C4CEC3;
 Wed, 25 Sep 2024 20:33:26 +0000 (UTC)
Date: Wed, 25 Sep 2024 21:33:24 +0100
From: Simon Horman <horms@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Message-ID: <20240925203324.GD4029621@kernel.org>
References: <20240925180017.82891-1-jdamato@fastly.com>
 <20240925180017.82891-2-jdamato@fastly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925180017.82891-2-jdamato@fastly.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1727296408;
 bh=HpgSrmqNuDOQLEzuojrRHnUCwj/9yjSRpB04a5p19zg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=N6rsU5vNunQbKbHiwSIhfS/0dN/TFPzyOuoYk6PkqV7PciY4Vf2tMtAQwUbPAb2ZU
 l+i31N/TOL72jBcWPDA9RdRjOBUEdEuab6ThRn9JZo/J5n+wIj/CXd7lu0TAF0rcvY
 gC6vzfdJGYm6F0dykUKOlffU3njiuFH3Spvo69DufOpxYHMGxmpt0Nd5WSjcbDllo8
 fCRsQh1E3flPt0Z3LTfLwZaDCAEEdthZwaI9k5lg0s2TrMa5IIuNd73tiMiC+43fe+
 ZJ8zxHyWtn9EshrF3Zzjoo0rx8d0A9ej1EKZLt00nWlk+nppG+CvzPHbgevu5PiOz/
 RDcySfNrJNqzQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=N6rsU5vN
Subject: Re: [Intel-wired-lan] [RFC net-next 1/1] idpf: Don't hard code
 napi_struct size
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
Cc: netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Sep 25, 2024 at 06:00:17PM +0000, Joe Damato wrote:
> The sizeof(struct napi_struct) can change. Don't hardcode the size to
> 400 bytes and instead use "sizeof(struct napi_struct)".
> 
> While fixing this, also move other calculations into compile time
> defines.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Reviewed-by: Simon Horman <horms@kernel.org>
