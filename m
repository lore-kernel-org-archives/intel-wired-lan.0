Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51858EE14B1
	for <intel-wired-lan@archiver.kernel.org>; Wed,  6 Sep 2023 16:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D85EB41554;
	Wed,  6 Sep 2023 16:44:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D85EB41554
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1694018679;
	bh=iIUcUlwwF3mj9fhh5iUklAXSAAJYocX5owaI6ABoC5U=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=SmXum276Z3QCTIEcrqWhJYMNlnLzeVRx9h5fPJ67HuKQ7bbzD7sa6FcCD7vrS0ObK
	 MJRtinClbut2o19SvYLbnML2y6YEoZETTmuAeIafXkztcu+V6YOe8LSTMcyq1ZQYut
	 eH73cquwnLbfoBgICIlmO6ozhr2OJB/OGYmIxS0AWC8DnCZQmhaLJfFQxo7wkvHOD8
	 b2VopHJd9aSifqsHCNQfnO21jdZC0CGeiJkK9XV3M3ycE3PeEdiID2IdA5XwjvzJ+2
	 oyuaiK7Nni/AxE9Yt7bFQBlGFsaLep+xxzKhSficXpX7eEDX2wmBkjXaxDXQWt9sHm
	 f57VIbuwMXx2Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LgHijqKEuf0c; Wed,  6 Sep 2023 16:44:38 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 371DC4155A;
	Wed,  6 Sep 2023 16:44:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 371DC4155A
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 896471BF5E9
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 Sep 2023 16:44:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5FEA84089B
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 Sep 2023 16:44:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5FEA84089B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vRlYGbJXBGf3 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  6 Sep 2023 16:44:35 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8BEB94060F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 Sep 2023 16:44:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8BEB94060F
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 053F1CE16E6;
 Wed,  6 Sep 2023 16:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EE7C433C8;
 Wed,  6 Sep 2023 16:44:28 +0000 (UTC)
Date: Wed, 6 Sep 2023 18:44:27 +0200
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Message-ID: <20230906164427.GC270386@kernel.org>
References: <20230906141411.121142-1-poros@redhat.com>
 <bbb51ddd-ceb1-63a8-a06a-f365da5ac4b7@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bbb51ddd-ceb1-63a8-a06a-f365da5ac4b7@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1694018671;
 bh=EI+fvmvCWqkc2KvJRNNxL/0XTQiGCQyC+Wq7BVvHLbw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GJphocDoYaCEC2q0FlyhwS2052waXIDzJHzIdPzpiWlS4y3p2SAOqx6BQ4eW0Gnb5
 xTrcawY491TpXvsTGriQLa+fxiX7nyheq/JKMcgosSjwVcEXVIzxOCiuU83ckmdA+M
 wZpcgQb+FJH78SF7AMyBQ3X15P6qV/3iCsMf8+dNc8JMjzeGzbXBEIhsLZzsjZMGJX
 xmeoWKGPUKSMa5FjSA2+A3nTJ8TMicZRBt+PdowRHmvOHxLg5s5c4RytvrZnJ0+qQe
 uw0o/K694wTBRD8YTenWL8xQ1PUfXTUYoWVdZvBZHZuEQHV6ZFWGNt9dWr3i7S1pRo
 ouGcdjKJGgkAg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=GJphocDo
Subject: Re: [Intel-wired-lan] [PATCH net 1/2] iavf: add
 iavf_schedule_aq_request() helper
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
Cc: ivecera@redhat.com, edumazet@google.com, netdev@vger.kernel.org,
 jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
 pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Sep 06, 2023 at 09:32:59AM -0600, Ahmed Zaki wrote:
> 
> On 2023-09-06 08:14, Petr Oros wrote:
> > Add helper for set iavf aq request AVF_FLAG_AQ_* and imediately

nit: immediately
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
