Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C48CD8CB5
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Oct 2023 19:32:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 460E241DD9;
	Tue, 10 Oct 2023 19:32:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 460E241DD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1696966365;
	bh=frpfjCbu6Pt7414vTYqg51/41Ovy4YvOpGCLC01QE1U=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Rg8F+Awemfr7f4j3St9odfhvrAh68PqFtwAbkB2dfHKfArRL6GKwbHEDurgiiYGJq
	 mYaKte8W7oPp10cH0PM15pJ8oYXuVu1CbLa+qnuKWWBMmAJZnrjRCBlhpF1ZG4xSKa
	 6vNaH8D3YDWzKfsNElfCBFjuotaq56gKz3W5Q49Ek62uF71HCdiYozZsuq8RVoO/Ek
	 npJt78kOzE0x2ZYa/0IaIMwZol1gR9pv4QXoDULXI0zn0IDrumV0Y02+8JwuZE7Vji
	 OJIXccG0SWTrPrW/VH3wDOHrQvRNDvfgdkYiDQETCRgXN3FmWMUJoDur46PHFl8pKu
	 p01pUPSD+ITDQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ruj-aMJP9xVE; Tue, 10 Oct 2023 19:32:44 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60D2841DAC;
	Tue, 10 Oct 2023 19:32:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 60D2841DAC
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id F07E81BF32B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Oct 2023 19:32:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD65441D98
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Oct 2023 19:32:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD65441D98
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tao0y7QsWcD8 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Oct 2023 19:32:38 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F3B4417EC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Oct 2023 19:32:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F3B4417EC
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 38836617D0;
 Tue, 10 Oct 2023 19:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962F4C433C7;
 Tue, 10 Oct 2023 19:32:36 +0000 (UTC)
Date: Tue, 10 Oct 2023 12:32:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Takeru Hayasaka <hayatake396@gmail.com>
Message-ID: <20231010123235.4a6498da@kernel.org>
In-Reply-To: <20231008075221.61863-1-hayatake396@gmail.com>
References: <20231008075221.61863-1-hayatake396@gmail.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1696966356;
 bh=GPjua0IjCuMmByKlFL6lkNxV/332at3VwhBzisfdC1A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bgQRxMcvNVVtr9a++yWmtIV8aRE4qIlhES2ie00klEHXAI4mm1LXGCzByBIEv3th6
 DbBMK1z1cDlS5GonXRB1Zevzm3uChV8KKdPxdjM2oDpYCILXlIMKy31hatUQWL8R57
 RyzhYyLY54XXXY+dYJOW907p91R/NA0H82XkaZm6Wf92w+B9y9BjsL4P9tjK5CkGUO
 Mn9EPEgFt0v75/3f6OW2bSN3kus9cLE50edhw8BcDkJO+ALPTGxrxPd15djB7ViAS7
 SplqRtSI3pCgyJvf26XuBMHyR6sW+lFwmX6C1P5YzGz/smaclVJKUtvQ9lFiZRL1Mr
 q86GKoXJPXBfw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=bgQRxMcv
Subject: Re: [Intel-wired-lan] [PATCH net-next] ethtool: ice: Support for
 RSS settings to GTP from ethtool
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
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sun,  8 Oct 2023 07:52:22 +0000 Takeru Hayasaka wrote:
> This is a patch that enables RSS functionality for GTP packets using
> ethtool.
> A user can include her TEID and make RSS work for GTP-U over IPv4 by
> doing the following:
> `ethtool -N ens3 rx-flow-hash gtpu4 sd`
> In addition to gtpu(4|6), we now support gtpc(4|6), gtpu(4|6)e,
> gtpu(4|6)u, and gtpu(4|6)d.

This is for tunneling, right? IDK much about GTP but we don't have flow
types for other tunneling protos. What makes this one special?
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
