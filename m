Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABE1C54798
	for <intel-wired-lan@archiver.kernel.org>; Sat,  9 Mar 2024 04:05:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13B7860843;
	Sat,  9 Mar 2024 04:05:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vsD-YKwpwKh8; Sat,  9 Mar 2024 04:05:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD24360755
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1709957149;
	bh=v/J/QUMKxkeerU6zuwRX7dl78JiGq3RnZzjiSZDDxzU=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=62K8y6mm2nwn7t50oh1kuAFKg8zFt1DPREoh/N33aOAmqKv6XgvKi/T30fcokDk1J
	 sQqzivCbUXdsfQfVtnZSjvdqkcuGZ2zO4Yv66+LiElVoxD0zdxGz4+UuhX60qftXSp
	 8ksEAjupu+ocMqMmKw+X2hx1ikUqzC8FUhWDzbV25rfQDF/D2yEfj0QtL23uto5d+6
	 WgNpTbPCwBnifa94slTRw9RU8ULq1oIvGxA/53dj4ap+8dTaTri+Rb+XML5abeX7L9
	 A32W+Wpxm2qJYQUuA4YZuMo1Y6BimkOw2BKrC7M0OCT87uGExv/lt3LrPzW2ifF3WS
	 hVXiMh7RedIfQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD24360755;
	Sat,  9 Mar 2024 04:05:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id F067F1BF39D
 for <intel-wired-lan@lists.osuosl.org>; Sat,  9 Mar 2024 04:05:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D9424417CF
 for <intel-wired-lan@lists.osuosl.org>; Sat,  9 Mar 2024 04:05:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YLpAuiSfqLeI for <intel-wired-lan@lists.osuosl.org>;
 Sat,  9 Mar 2024 04:05:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F29EC417A2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F29EC417A2
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F29EC417A2
 for <intel-wired-lan@lists.osuosl.org>; Sat,  9 Mar 2024 04:05:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A3CD2609FE;
 Sat,  9 Mar 2024 04:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D89EC433C7;
 Sat,  9 Mar 2024 04:05:45 +0000 (UTC)
Date: Fri, 8 Mar 2024 20:05:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <20240308200544.42fcb93e@kernel.org>
In-Reply-To: <20240308141833.2966600-1-aleksander.lobakin@intel.com>
References: <20240308141833.2966600-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1709957146;
 bh=/tmyKSiu5FPQ1u4wgG/x5qvkp5nypX5JxvMrTuDSWco=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=GqdGkETW6sZzP6Y+mf+bcDa7qnzOkH1lb3Grx45Brcy//Yb2Ijvt7zrJTBqNnpDf5
 OueGRJ5hBAfgovN6oaGrCAdyG023bZpZPRCpXgVnJSbW3D9IXF+M8DOVaDydyALFbc
 wEJ/TDuvlzEpWeQTlomr/aCqsRK8pZXDB0zBxpIv7Ted3GI6qV+vs8xmhQhcGMC0g0
 GOiFQN4X0RawHdAZLYmKv4c9tPOSdsEf88Ohe3gq9z9U1SVE2J4oUIUOEZo60D3qJX
 rG0pGkj/3l1niodvwHQlTL0dJZrefv+OuRpnXrQUMevSWGbKVQBsZ+FBWO2FMZhwvp
 WaHVbPdSEDPNw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=GqdGkETW
Subject: Re: [Intel-wired-lan] [PATCH net-next v8 0/8] net: intel: start The
 Great Code Dedup + Page Pool for iavf
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
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
 Yunsheng Lin <linyunsheng@huawei.com>, intel-wired-lan@lists.osuosl.org,
 David Christensen <drc@linux.vnet.ibm.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri,  8 Mar 2024 15:18:25 +0100 Alexander Lobakin wrote:
> Here's a two-shot: introduce {,Intel} Ethernet common library (libeth and
> libie) and switch iavf to Page Pool. Details are in the commit messages;
> here's a summary:

./scripts/kernel-doc reports some issues here
-- 
pw-bot: cr
