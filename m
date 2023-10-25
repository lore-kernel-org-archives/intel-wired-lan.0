Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAABC25B47
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Oct 2023 23:59:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DBDF140573;
	Wed, 25 Oct 2023 23:59:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DBDF140573
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1698278344;
	bh=0gONc3uNQTSleKBwuD/Jt6IJGccCBxHGEbp5XQiHHcY=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=vEbOUiYkJ34O8UXHReWsqi/4j6d/+Ikqc9pLBrKFCeVEaz05ljvzr9lB2qa96Wk7s
	 s8zerPTHpL37yQxIFDZOVZzx2ED8mKqkyyJQNaQoQhL98RnMaDYmv0QZkXc5/MhIIU
	 CFBr93eRb2htO8Q3qRtA+FGPISMYW+SDRxAimJMUB8RaFeGE7chyV7JIhfQxdOc+op
	 htdy7EGhprnkqQN509GLfIrFhNnE/OdRYKZ3rn4ro3bS5Bwm7RehOfPDINADYMRM5X
	 zBQHcAIy3ZJouw2NYqmlXsx5wMIrSZF/P/dFoCo9suWjH3pZprqai19BW85G1q24CL
	 cHNZj9/c+SF9w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AzOkw_g5To5S; Wed, 25 Oct 2023 23:59:04 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id B411340960;
	Wed, 25 Oct 2023 23:59:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B411340960
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 6B5D81BF2FE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Oct 2023 23:59:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 432A960E1B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Oct 2023 23:59:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 432A960E1B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3ehUEBs8iBzr for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Oct 2023 23:59:00 +0000 (UTC)
X-Greylist: delayed 426 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 25 Oct 2023 23:58:59 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E0F1460BE2
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com
 [216.40.44.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E0F1460BE2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Oct 2023 23:58:59 +0000 (UTC)
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
 by unirelay08.hostedemail.com (Postfix) with ESMTP id 73084140753;
 Wed, 25 Oct 2023 23:53:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf06.hostedemail.com (Postfix) with ESMTPA id EB8562000F; 
 Wed, 25 Oct 2023 23:52:58 +0000 (UTC)
Message-ID: <c7e45f79e04cf28b69300cc12cf47267fb216955.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Justin Stitt <justinstitt@google.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shay Agroskin
 <shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon
 <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, Saeed Bishara
 <saeedb@amazon.com>, Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru
 <skalluru@marvell.com>, GR-Linux-NIC-Dev@marvell.com, Dimitris Michailidis
 <dmichail@fungible.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, Salil
 Mehta <salil.mehta@huawei.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>,  Tony Nguyen <anthony.l.nguyen@intel.com>,
 Louis Peens <louis.peens@corigine.com>, Shannon Nelson
 <shannon.nelson@amd.com>, Brett Creeley <brett.creeley@amd.com>, 
 drivers@pensando.io, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Ronak Doshi <doshir@vmware.com>, VMware PV-Drivers
 Reviewers <pv-drivers@vmware.com>, Andy Whitcroft <apw@canonical.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
 <lukas.bulwahn@gmail.com>
Date: Wed, 25 Oct 2023 16:52:58 -0700
In-Reply-To: <20231025-ethtool_puts_impl-v1-3-6a53a93d3b72@google.com>
References: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
 <20231025-ethtool_puts_impl-v1-3-6a53a93d3b72@google.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: ewynon9iqkxk4ba7ojpnwtcnyur8eded
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: EB8562000F
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19HM4U+AZp5TxLK9aKEhza6ficBJMSjAYo=
X-HE-Tag: 1698277978-811897
X-HE-Meta: U2FsdGVkX1+p9+z8yCq32YY8S2DSMu0GtmU5Y2BLTOHLbVa47GMVGnlUfueykHLbFBJzUqiIuNUoLTjPNpuPmPmdObkyQyyYuvVzxDUXUYBXVjgtSZL2VLZt0M+ihq91yI+KJMnhw13lDleMsbRbUz2084V9BtLz3jRVgcLorLaY772BDVcKhBSdvFtDf2GPoSWp62x76n++3gowAjGE0QzGeGP1a3j/o4yx5i3/j7G9kDn6arjCylGwRoNsTERruOxHd2GpijuQvv1XVYKqXSIlXskZ2U42iC6tNJZVsKH071QZzpcUdpEeBh6ZYV0q
Subject: Re: [Intel-wired-lan] [PATCH 3/3] checkpatch: add ethtool_sprintf
 rules
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
Cc: linux-hyperv@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 netdev@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 oss-drivers@corigine.com, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, 2023-10-25 at 23:40 +0000, Justin Stitt wrote:
> Add some warnings for using ethtool_sprintf() where a simple
> ethtool_puts() would suffice.
> 
> The two cases are:
> 
> 1) Use ethtool_sprintf() with just two arguments:
> >       ethtool_sprintf(&data, driver[i].name);

OK.

> or
> 2) Use ethtool_sprintf() with a standalone "%s" fmt string:
> >       ethtool_sprintf(&data, "%s", driver[i].name);

I'm rather doubt this is really desired or appropriate.


_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
