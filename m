Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7B0C001B1
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Jun 2023 06:14:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98F9560C12;
	Thu, 29 Jun 2023 06:14:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 98F9560C12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1688019276;
	bh=f1wR/yD6Dk5kLQGuM035gnnhC/7YG68NCKTr5WBguJs=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=RhARxuEOcaDxRKhFtR90Bnioxuq+rxP/8Ake7MzOB+07kKIqOcL7Rv6H4oF96oeHX
	 1X9HD761WMxmeXFYOY6XBF7jABKeiTVXTzU21w3LdA1Qser0sbZnd/xh5uawMSJXds
	 GMiHK/iRfKiZc/sYaVy2uSya8ND63XkXYTEw/PuV5ETStdZPTBguNRTCaojrOn9xDX
	 lBPyoi2tUAzD4F8WfiZGe9YXLuoWxopvHWfgBfPrhUH+3r4Z5LP8IXYM/dE5egRjVe
	 nI0pXbvo04sHYlTEVOYQg3t2tOdh3G6KHapdEyjnS1afigsn/YME52YbkspysOLGS2
	 QRU0WIuw9aKTw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YixSJ9P6aAlf; Thu, 29 Jun 2023 06:14:35 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id B84C460E44;
	Thu, 29 Jun 2023 06:14:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B84C460E44
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id EE53E1BF853
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jun 2023 06:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D2BE560E44
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jun 2023 06:14:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D2BE560E44
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JMIYmUPfoH4f for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Jun 2023 06:14:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D8B260C12
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D8B260C12
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jun 2023 06:14:29 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-314172bb818so317619f8f.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jun 2023 23:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688019267; x=1690611267;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BxPmChzKXR1dj/ko+9tzcHvICaNxDCij9PscVU1CwGY=;
 b=XvVZSsVpUFTCG6RzE7N2kQ3cqUJQFtvwkjpGlBA4nKr7BV8T9i62WwLicPoIfgU7Y5
 epz3MSUdbDg+oa5at6NXsEnenaT2dClCkoDQTqGE5Jo19lb2h1uKHjwOyWQKC46ZKDms
 tBUvlpAYIMOip51QPYiE4uN4exr96nFDuCKEZvhWv8q7k8N+454Ko9cEymh+MzLMvet3
 asxrid8zdodMBbjk1CZFFGlNmIlMuHr2c4P/DctJEhKN9dnxOWcB50vaTKAwdDHQWUA6
 8Zs/a81CUtyKWmV4hIQDnTm2M55dnMbbK9iqtrnjP4DcaT2aluB3oYqkxCWcYSOjnwDm
 MlBg==
X-Gm-Message-State: AC+VfDyZb4WmLVXLrNNYO1xaOyZ3gCCkODuPLQJrl1Lp8Gq89yJ7sW20
 h2zGfShB5pfKsEX0bzJDDc98Og==
X-Google-Smtp-Source: ACHHUZ7KKCQek3b9yJkpoCmAdgzst9lXvnl9IF1wrn2teksRP3fkGVdr25X0T5kABFTNqxM9KgVooQ==
X-Received: by 2002:a05:6000:181:b0:30f:d218:584a with SMTP id
 p1-20020a056000018100b0030fd218584amr32939868wrx.23.1688019267545; 
 Wed, 28 Jun 2023 23:14:27 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net.
 [213.179.129.39]) by smtp.gmail.com with ESMTPSA id
 b7-20020a5d45c7000000b003141a3c4353sm460558wrs.30.2023.06.28.23.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 23:14:26 -0700 (PDT)
Date: Thu, 29 Jun 2023 08:14:25 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Message-ID: <ZJ0hQRcm6S05r8VE@nanopsycho>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
 <20230609121853.3607724-9-arkadiusz.kubalewski@intel.com>
 <ZISmmH0jqxZRB4VX@nanopsycho>
 <DM6PR11MB4657161D2871747A7B404EDD9B5FA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZJLtR0c+tvCbUgri@nanopsycho>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZJLtR0c+tvCbUgri@nanopsycho>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1688019267; x=1690611267; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BxPmChzKXR1dj/ko+9tzcHvICaNxDCij9PscVU1CwGY=;
 b=g4spu/YTypGbdobXCPpsNMEE7fZgSTh6dwO8ck/RlyJzKG32ec8qbcH4voInoYNI6o
 nG6/zJ1n82WItH1lu3qQCRFI8uw3L8ph8dhnODO74Jobt9mAAC6aVPmcAOEeHa3CijaY
 GQ0EQQTgLWtAzMyQV8sZkz9pP1Q5sB+jGzX0IRtVzmIH7vRZDqd7kAqk/QYf3QTa8aEJ
 QSuo/h0rl0fcrDEeomgjT4HhlbHIS1Bzm651nwZXtQyAM08WdVMOLO0uppwo8McOoT1j
 8CGh366oXSh0q2wYy6HTFoOLtXKgeVtSm3qpnqhqbheagjwO+/UJVS4tnevaSr7XLabv
 Rrig==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=resnulli-us.20221208.gappssmtp.com
 header.i=@resnulli-us.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=g4spu/YT
Subject: Re: [Intel-wired-lan] [RFC PATCH v8 08/10] ice: implement dpll
 interface to control cgu
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
Cc: "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "mst@redhat.com" <mst@redhat.com>, "razor@blackwall.org" <razor@blackwall.org>,
 "phil@nwl.cc" <phil@nwl.cc>, "javierm@redhat.com" <javierm@redhat.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "lucien.xin@gmail.com" <lucien.xin@gmail.com>,
 "leon@kernel.org" <leon@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "masahiroy@kernel.org" <masahiroy@kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Brandeburg,
 Jesse" <jesse.brandeburg@intel.com>, "vadfed@meta.com" <vadfed@meta.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "airlied@redhat.com" <airlied@redhat.com>, "vadfed@fb.com" <vadfed@fb.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "ricardo.canuelo@collabora.com" <ricardo.canuelo@collabora.com>,
 "arnd@arndb.de" <arnd@arndb.de>, "idosch@nvidia.com" <idosch@nvidia.com>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "claudiajkang@gmail.com" <claudiajkang@gmail.com>,
 "kuniyu@amazon.com" <kuniyu@amazon.com>,
 "jacek.lawrynowicz@linux.intel.com" <jacek.lawrynowicz@linux.intel.com>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "nicolas.dichtel@6wind.com" <nicolas.dichtel@6wind.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "sj@kernel.org" <sj@kernel.org>,
 "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
 "linux@zary.sk" <linux@zary.sk>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "ogabbay@kernel.org" <ogabbay@kernel.org>,
 "nipun.gupta@amd.com" <nipun.gupta@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "andy.ren@getcruise.com" <andy.ren@getcruise.com>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>, "M,
 Saeed" <saeedm@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "Olech, Milena" <milena.olech@intel.com>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Wed, Jun 21, 2023 at 02:29:59PM CEST, jiri@resnulli.us wrote:
>Mon, Jun 19, 2023 at 10:34:12PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Saturday, June 10, 2023 6:37 PM
>>>
>>>Fri, Jun 09, 2023 at 02:18:51PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>>
>>>[...]
>>>
>>>
>>>>+static int ice_dpll_mode_get(const struct dpll_device *dpll, void *priv,
>>>>+			     enum dpll_mode *mode,
>>>>+			     struct netlink_ext_ack *extack)
>>>>+{
>>>>+	*mode = DPLL_MODE_AUTOMATIC;
>>>
>>>I don't understand how the automatic mode could work with SyncE. The
>>>There is one pin exposed for one netdev. The SyncE daemon should select
>>>exacly one pin. How do you achieve that?
>>>Is is by setting DPLL_PIN_STATE_SELECTABLE on the pin-netdev you want to
>>>select and DPLL_PIN_STATE_DISCONNECTED on the rest?
>>>
>>>
>>>[...]
>>
>>AUTOMATIC mode autoselects highest priority valid signal.
>>As you have pointed out, for SyncE selection, the user must be able to manually
>>select a pin state to enable recovery of signal from particular port.
>>
>>In "ice" case there are 2 pins for network PHY clock signal recovery, and both
>>are parent pins (MUX-type). There are also 4 pins assigned to netdevs (one per
>>port). Thus passing a signal from PHY to the pin is done through the MUX-pin,
>>by selecting proper state on pin-parent pair (where parent pins is highest prio
>>pin on dpll).
>
>Could you show me some examples please?

Arkadiusz, could you please reply to this?
Thanks!

>
>
>>
>>Thank you!
>>Arkadiusz
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
