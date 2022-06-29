Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFFBCCA47E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 Jun 2022 15:19:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6158460AA7;
	Wed, 29 Jun 2022 15:19:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6158460AA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1656515986;
	bh=JFUQOvYynGk1QDloB5lcXUlRLVlIFn9vJIw3gvp87XY=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=WlB1Fz46dqJsOWQrxx6bPlfPt9uUVAzBGzQgAclq+4q0rFRfMQmY1V6Utqv7JdIeT
	 F9Vc7Gp7gtTCauin8sd11YrQEqNXRzNX0TwT5QIzqvyJ8yc0vHFShUngg8bUJFjDLP
	 DwkNMwlkhJMYcl0dTRtWNkXQilWEXo9stC0YatFtT9v/t9e0b4FbY2ZzS1SKGgo49e
	 uh2EzoWTWMzb3sI3jAiumSgKKyLyecfNcF7lfffw7N1IIliTa3g/fkaCuRHKszdlUP
	 /10mD2884VUYDul7HHF4oKqfg4D4BgaJzptZ6NODpiY9/Pba/R5/7kP8kURrlXj9C1
	 mzDprnnY6cgMA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M_hDTlT2pGE5; Wed, 29 Jun 2022 15:19:45 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 656C560B30;
	Wed, 29 Jun 2022 15:19:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 656C560B30
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 2AF101BF48B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jun 2022 15:19:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 03B0A60B9A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jun 2022 15:19:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 03B0A60B9A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U6kPl3-VRptm for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 Jun 2022 15:19:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CDEF060AE4
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CDEF060AE4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jun 2022 15:19:41 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8F1B060EEB;
 Wed, 29 Jun 2022 15:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0948BC34114;
 Wed, 29 Jun 2022 15:19:38 +0000 (UTC)
Date: Wed, 29 Jun 2022 08:19:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>
Message-ID: <20220629081937.7270e7d7@kernel.org>
In-Reply-To: <MW4PR11MB57761A084A3A556F4070F8CDFDBB9@MW4PR11MB5776.namprd11.prod.outlook.com>
References: <20220628112918.11296-1-marcin.szycik@linux.intel.com>
 <20220628112918.11296-2-marcin.szycik@linux.intel.com>
 <20220628214020.0f83fc21@kernel.org>
 <MW4PR11MB57761A084A3A556F4070F8CDFDBB9@MW4PR11MB5776.namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1656515979;
 bh=tLBQwVe0ndA2/6U5cX56akazDpzZj1TmPAaBtu08mIE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Qzp4QRBc44PQ+vHPZwo0SR2XFHaxcFyy8eMYzzjXXFih2pbAjnhFk/WsHOxOuvtsD
 GVaNlzxTmgR+5bZWCMBSuVohJYVFdzau5cchVCvxUhfmNbU7zaM54r2PYxKqr6AVP2
 bdf2lyRbQPItpukrwDVOsYlcw8jHIL6xxQAAMOntYhm3JfpBsZeSXbrP1ysw8+2YR+
 yPVTyGywzM4RJxecVRAynbg5Q/81JdEx1rXfuiNzKGRRZIE//8BF8VbYTBSDevut73
 iiuKB6pbgUpnmN3KhRe75YRdp8hWWdbgzDAxN6SQ9KbfJH0Vhhxa2HREeJuN09VeMZ
 rN/kn78cSGAIA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Qzp4QRBc
Subject: Re: [Intel-wired-lan] [RFC PATCH net-next v2 1/4] flow_dissector:
 Add PPPoE dissectors
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
Cc: "simon.horman@corigine.com" <simon.horman@corigine.com>,
 "kurt@linutronix.de" <kurt@linutronix.de>,
 "paulb@nvidia.com" <paulb@nvidia.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "boris.sukholitko@broadcom.com" <boris.sukholitko@broadcom.com>, "Brandeburg,
 Jesse" <jesse.brandeburg@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "zhangkaiheb@126.com" <zhangkaiheb@126.com>,
 "pablo@netfilter.org" <pablo@netfilter.org>,
 "baowen.zheng@corigine.com" <baowen.zheng@corigine.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "komachi.yoshiki@gmail.com" <komachi.yoshiki@gmail.com>,
 "jhs@mojatatu.com" <jhs@mojatatu.com>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, 29 Jun 2022 07:44:50 +0000 Drewek, Wojciech wrote:
> > > +static bool is_ppp_proto_supported(__be16 proto)  
> > 
> > What does supported mean in this context?  
> 
> It means that only those protocols are going to be dissected.

We only dissect PPP_IP and PPP_IPV6. This looks more like a list of all
known protocols.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
