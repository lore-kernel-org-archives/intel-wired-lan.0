Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E5CC433EF
	for <intel-wired-lan@archiver.kernel.org>; Tue,  5 Jul 2022 12:51:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0125861063;
	Tue,  5 Jul 2022 12:51:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0125861063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1657025491;
	bh=hyhQAu/32b/b2ciewNBDqAhpbs6Rw5G/Wvjpwc+3ozg=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ebKGN9a2yeJQRjLFQsv9083YHyxTwIGJxGAOOEVGMR/x8jSxG7qaQewlmhTY8EQcP
	 4LKqG8dj0MJY7uyNjVwlyQBucZZFqZritEU4nmVj5NWCCcf5NBnUPrPHw5D3z2gylw
	 M32csEjZ/E7DGJh17cTopQZ0OnhBLh2R7k6jcGbLFuKPp/XfFyKGC5fyu9K9jpStgY
	 /E2N4S/soYKpm695J9/VWJ0sm+mcPxyzbpAVJm8SOGHrhCywn0FwhShLaHCs+pZYhL
	 eYYFm8TjvC8Z2HyR/qeozsJml77nlLOxlGYdlEW30UGknVkhcowrzDJoss7HqspCEE
	 DmJhQXX1C/Ecg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UDixa3pNMSin; Tue,  5 Jul 2022 12:51:29 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31F9661065;
	Tue,  5 Jul 2022 12:51:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 31F9661065
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id D17481BF284
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jun 2022 23:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B8C0F40B48
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jun 2022 23:12:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B8C0F40B48
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N9SiaQfoKRnM for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Jun 2022 23:12:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A60EE40B43
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A60EE40B43
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jun 2022 23:12:50 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-a1LY9RYmPoitGjY1Cw_YnA-1; Thu, 30 Jun 2022 19:12:48 -0400
X-MC-Unique: a1LY9RYmPoitGjY1Cw_YnA-1
Received: by mail-wm1-f70.google.com with SMTP id
 n18-20020a05600c501200b003a050cc39a0so169258wmr.7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jun 2022 16:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NJTz6TTYPiibEbFrJGuunU84ZTQOGySwDHV3J5pRPec=;
 b=YVDUbdidbtd3Pu+q6wkR9KSPBAwf/U26qzxr7r5HJ69gFy4kVN3QJB9bFPfKg/jgmi
 xF03zWn2jTp/W10X7j2OojUrBKmHN+MSXCeElvDWPtdDT6xB7sLyDmPvz2AOuvMUZzOO
 MLAjDP/YZ7MGP+2ulLYxbrzrJLBdRhORWIYQ06gyejveIeK73n1R7uVkrfaksFyUgFgf
 Waw+HMUu3ePiY9LLVxVMOTzODWZw8Ljs0zPv5BFQXOK4INynOxArfk8yrnd2jIzYjill
 jdwOMkmn6la/nC3P+rz2ozWsuivVz29mQp0fcjzvNINhVazM5dO3+8gsV9rwLBuTl2Lj
 Titw==
X-Gm-Message-State: AJIora/as00KLVug2chVRcbKD0swmFzdFmshyFulaOjqXaDnFxvdJTgx
 7Y4M8/5HWjCDM/aaf8xphLH5mA0hG4rDgFuDL4olK+PcMu0wKJYlf2ReFgPjy5pqRRwmziDSZEL
 11uLahgPeO/+X5DGzrFU6MkAW9lG/Ag==
X-Received: by 2002:a7b:cc96:0:b0:3a0:4aa0:f053 with SMTP id
 p22-20020a7bcc96000000b003a04aa0f053mr15132041wma.89.1656630767286; 
 Thu, 30 Jun 2022 16:12:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tzGEeKpPU2QJgFZfBZfnbC6qNg00CZfwhz9y7HZ3IRo/29uWs68Y3WtOkZ3zJ7mM9fGlZ/Ow==
X-Received: by 2002:a7b:cc96:0:b0:3a0:4aa0:f053 with SMTP id
 p22-20020a7bcc96000000b003a04aa0f053mr15132007wma.89.1656630767121; 
 Thu, 30 Jun 2022 16:12:47 -0700 (PDT)
Received: from debian.home
 (2a01cb058d1194004161f17a6a9ad508.ipv6.abo.wanadoo.fr.
 [2a01:cb05:8d11:9400:4161:f17a:6a9a:d508])
 by smtp.gmail.com with ESMTPSA id
 d10-20020adff2ca000000b0021a38089e99sm20545676wrp.57.2022.06.30.16.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jun 2022 16:12:46 -0700 (PDT)
Date: Fri, 1 Jul 2022 01:12:44 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Message-ID: <20220630231244.GC392@debian.home>
References: <20220629143859.209028-1-marcin.szycik@linux.intel.com>
 <20220629143859.209028-5-marcin.szycik@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20220629143859.209028-5-marcin.szycik@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 05 Jul 2022 12:51:15 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1656630769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NJTz6TTYPiibEbFrJGuunU84ZTQOGySwDHV3J5pRPec=;
 b=W2bxRheMoL+15+COMb56/Y5XcvJsbxhGXwI4ieZTbiCxZ2Z2Phg+qC6wg9M7GUOOvaW0ui
 DeF90svPr7LJSm3PvgnLS3t4L/xjmY+EO69SEnNXytYulMtI2PtEF8UAIKEgKTZRGku2N1
 Ye8PLXpf0jKv39M/X53mCf+ypPgWUuE=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=W2bxRheM
X-Mailman-Original-Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gnault@redhat.com
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

On Wed, Jun 29, 2022 at 04:38:59PM +0200, Marcin Szycik wrote:
> Add support for creating PPPoE filters in switchdev mode. Add support
> for parsing PPPoE and PPP-specific tc options: pppoe_sid and ppp_proto.
> 
> Example filter:
> tc filter add dev $PF1 ingress protocol ppp_ses prio 1 flower pppoe_sid \
>     1234 ppp_proto ip skip_sw action mirred egress redirect dev $VF1_PR
> 
> Changes in iproute2 are required to use the new fields.
> 
> ICE COMMS DDP package is required to create a filter as it contains PPPoE
> profiles. Added a warning message when loaded DDP package does not contain
> required profiles.
> 
> Note: currently matching on vlan + PPPoE fields is not supported. Patch [0]
> will add this feature.
> 
> [0] https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20220420210048.5809-1-martyna.szapar-mudlaw@intel.com

Out of curiosity, can ice direct PPPoE Session packets to different
queues with RSS (based on the session ID)?

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
