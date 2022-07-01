Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57973C433EF
	for <intel-wired-lan@archiver.kernel.org>; Fri,  1 Jul 2022 16:13:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4B75613E4;
	Fri,  1 Jul 2022 16:13:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C4B75613E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1656692031;
	bh=GtOQvwS5XFLB6Fn8+7+begWzQh8U0LifnamdIhLDQFo=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=vITy9yFq71Wh0Eo2KteiBuR+V8fxCV9o3hL6hXbM5AW0R6FBQtmoZEflmUplDMh+1
	 QeH78a9Dv4SlNyVS5d5AtiV7aNu1yYwB3p4XCa8UKBQezD5r4q68HkN2+++e4+QpbW
	 fFw1ON62MImVAMiVWt6LrDKMDqrGbmD2TLDRm3F3rnNUUFNbQffoSHW5KxqMTouuGF
	 6DvptjXUoM2DytebuNjgwG6WrrHT+7qKQeURe05tg2g5HsFEk6RHxxveR0Ft3yOI0s
	 5lzd8wrYDbsmDvtvIQtPwgXMyqsep+7N/92SiG7b76L6ZDOAaDhNpPaYoKc/hH3ZBE
	 9UwpuRynG4YmQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gtu5grNgPDho; Fri,  1 Jul 2022 16:13:51 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F9816141F;
	Fri,  1 Jul 2022 16:13:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F9816141F
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id C45FB1BF4D7
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Jul 2022 16:13:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9CC956141F
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Jul 2022 16:13:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9CC956141F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Ee2CoDizzlr for <intel-wired-lan@lists.osuosl.org>;
 Fri,  1 Jul 2022 16:13:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE45861412
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE45861412
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Jul 2022 16:13:48 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="263084110"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; d="scan'208";a="263084110"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2022 09:13:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; d="scan'208";a="648400615"
Received: from mszycik-mobl.ger.corp.intel.com (HELO [10.249.159.254])
 ([10.249.159.254])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2022 09:13:42 -0700
Message-ID: <7a706a7e-d3bd-b4da-fa68-2cabf3e75871@linux.intel.com>
Date: Fri, 1 Jul 2022 18:12:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To: Guillaume Nault <gnault@redhat.com>
References: <20220629143859.209028-1-marcin.szycik@linux.intel.com>
 <20220629143859.209028-5-marcin.szycik@linux.intel.com>
 <20220630231244.GC392@debian.home>
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20220630231244.GC392@debian.home>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656692028; x=1688228028;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=IUQRxQu2xAb1KnXk54DHDPqMr5bFMKNCKsEmTDz48TA=;
 b=Y5D+2rphNf1FkP01YYmi6BPdzqY0wHXHRIM9eFdt+pkVtoeFg1NmaYWu
 aB8Czha0TCZf7cn4OLrvaleQ5MTq/nli8FztOuLYADHL4CM3unpy3whOp
 IzU8oJYM5rej2ENNwlBr71K/uio805squQTCyMRPk/LKKe+cP72G/MXJA
 LZrSlg6GpGaYn0HC0UFT1BNsZVytjAUaYQoZyhNMAo8I9YyJe/hqWf/Yq
 7kf+8GXfS35c2YSo8rOzmvl3DIq8IVS1NKj6GamXazR5NriSGA81wYXaZ
 YoBusZnQ9XWpz34jFmsgo12JPHpcKy1Lkpk1vRjoPvPnrL6YtG0rT/+l6
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Y5D+2rph
Subject: Re: [Intel-wired-lan] [RFC PATCH net-next v3 4/4] ice: Add support
 for PPPoE hardware offload
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
Cc: simon.horman@corigine.com, kurt@linutronix.de, paulb@nvidia.com,
 edumazet@google.com, boris.sukholitko@broadcom.com, jiri@resnulli.us,
 paulus@samba.org, jesse.brandeburg@intel.com, intel-wired-lan@lists.osuosl.org,
 kuba@kernel.org, zhangkaiheb@126.com, pablo@netfilter.org,
 baowen.zheng@corigine.com, komachi.yoshiki@gmail.com, jhs@mojatatu.com,
 mostrows@earthlink.net, xiyou.wangcong@gmail.com, pabeni@redhat.com,
 netdev@vger.kernel.org, gustavoars@kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



On 01-Jul-22 01:12, Guillaume Nault wrote:
> On Wed, Jun 29, 2022 at 04:38:59PM +0200, Marcin Szycik wrote:
>> Add support for creating PPPoE filters in switchdev mode. Add support
>> for parsing PPPoE and PPP-specific tc options: pppoe_sid and ppp_proto.
>>
>> Example filter:
>> tc filter add dev $PF1 ingress protocol ppp_ses prio 1 flower pppoe_sid \
>>     1234 ppp_proto ip skip_sw action mirred egress redirect dev $VF1_PR
>>
>> Changes in iproute2 are required to use the new fields.
>>
>> ICE COMMS DDP package is required to create a filter as it contains PPPoE
>> profiles. Added a warning message when loaded DDP package does not contain
>> required profiles.
>>
>> Note: currently matching on vlan + PPPoE fields is not supported. Patch [0]
>> will add this feature.
>>
>> [0] https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20220420210048.5809-1-martyna.szapar-mudlaw@intel.com
> 
> Out of curiosity, can ice direct PPPoE Session packets to different
> queues with RSS (based on the session ID)?

Hardware should support it, but I'm not sure if it's possible with the current driver and how to configure it. I'll try to find out.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
