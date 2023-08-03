Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90001C0015E
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Aug 2023 10:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D0684035F;
	Thu,  3 Aug 2023 10:04:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D0684035F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1691057098;
	bh=+DARA7kK14B5OHnlflA81VpKo4eRWbGuj7pR7fxgalQ=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=FfjfQPDZoeEhrcognPT1z1t9hIFHTVThGvZpUx9kY649tG35IbTuwJseHg4GmfRAf
	 6hZfiXf6k+8xI8UaoNVm05r+2Y4X8GVek0ugyUPuftGd+me2IxCsn1MQqofEBHcyTH
	 i46jz8e+VH72PqADnxPRoJUjX+pLoZOn/qhaUHBD7bT7mCjXLgHSgFKAFC0BDFug1y
	 0uGvuBjxHqAY23nAdFaDybYry6HIFO9vrsoKy2mqH9rH6i1oMizko23iJBwbC8SUuE
	 LHAQqBX+TbstXMAZgXCiu3XI1+sRf/xPyHnLkrt8TfxSeZsBUvp8QmZOJoMnR1pMkc
	 fxmg7IeICr4YQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ThBpKsRyIWMd; Thu,  3 Aug 2023 10:04:57 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2FFC41962;
	Thu,  3 Aug 2023 10:04:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D2FFC41962
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 72E661BF368
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Aug 2023 10:04:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DCC5981271
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Aug 2023 10:04:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DCC5981271
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k2eUaauOHDMg for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Aug 2023 10:04:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CDC7181268
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Aug 2023 10:04:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CDC7181268
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-vepu2SXPOPSd7Iv9AKo3Tw-1; Thu, 03 Aug 2023 06:04:37 -0400
X-MC-Unique: vepu2SXPOPSd7Iv9AKo3Tw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-40fa24ab5c8so2320101cf.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 03 Aug 2023 03:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691057077; x=1691661877;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=McoNTIMuK5zMDVano2/oBxpTU9klATcskOJG6KujI/k=;
 b=lKHh5GSL/jhs6D7Tr/WQrLwGa/QhB/Qc0QJYVjhpYcyg/NOz1oxqMapj1K+mX611gY
 1lPufKz1z5aU+U3prV3DFlLCXDRKCjgpvc1L8LzjTSnLMTbTTDlchRSYyS5JV7wKkNWh
 O4TWxJzTvHvG3hjr2jR1RTmROn/3iOlL2HYGTYMQEydZV1lAyxqTjls9+WKf7PWt3D+m
 vLgseIb39JH3VgDkSmig0n5KyjLxBE6yKJx8V3zq0tqmRlU6EOadeFSDQwfc5JKgeo0j
 Iss8349W+vxBf8fugOys14HVcK9IXF0taqsnqHPFqrPLtcgOPDRCp/dRz/taPgL6hEVR
 MY9w==
X-Gm-Message-State: ABy/qLZxNCKRtubGiWtd4Osjd8d6ZD/zxCGBe89IiO9Crk9necX4JsE/
 WIkkbTAyjyUR+7sACk0b1qtFOYI3i9GAeXp5f2BwZ0uhe9c5pBp2ylU4WkqsmtmIotMzUxqprUj
 8Sp8ZLCAddCtsDxzWDdDQW9Sg41pcwA==
X-Received: by 2002:a05:622a:1aa5:b0:40c:8ba5:33e0 with SMTP id
 s37-20020a05622a1aa500b0040c8ba533e0mr19691164qtc.3.1691057077037; 
 Thu, 03 Aug 2023 03:04:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGgowyf6XhafmTFhwd4kIxj/a9sk7muDM9IwOhYJ5Cfu4506FYfrrjqry1ZVBPlzqgd92Dqag==
X-Received: by 2002:a05:622a:1aa5:b0:40c:8ba5:33e0 with SMTP id
 s37-20020a05622a1aa500b0040c8ba533e0mr19691138qtc.3.1691057076756; 
 Thu, 03 Aug 2023 03:04:36 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-226.dyn.eolo.it.
 [146.241.226.226]) by smtp.gmail.com with ESMTPSA id
 q5-20020ac87345000000b004069782c943sm6061394qtp.40.2023.08.03.03.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 03:04:36 -0700 (PDT)
Message-ID: <c90e655ed51d8a0e21e529573ebb46040de91663.camel@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Date: Thu, 03 Aug 2023 12:04:32 +0200
In-Reply-To: <20230801182421.1997560-1-vladimir.oltean@nxp.com>
References: <20230801182421.1997560-1-vladimir.oltean@nxp.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1691057078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=McoNTIMuK5zMDVano2/oBxpTU9klATcskOJG6KujI/k=;
 b=HQk4S49khcCCpSl08/mO5GUJw6C04YfTHVfvfJp/CxT0e0gn+hhbPoe4rVAuPmNrHf0p2Z
 VFL1tLfCa7lD/qPZUpCNWW6eSfS9lvAPUP2ZwKebUJ2rGlo+S3MoJfG24tiIp1EUCpjNdG
 Zvfk6Px/lY4lJXv7nau1uP2ziwh6Wro=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HQk4S49k
Subject: Re: [Intel-wired-lan] [PATCH v3 net-next 00/10] Improve the taprio
 qdisc's relationship with its children
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
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Richard Cochran <richardcochran@gmail.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, linux-kernel@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Pedro Tammela <pctammela@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 intel-wired-lan@lists.osuosl.org, Zhengchao Shao <shaozhengchao@huawei.com>,
 Maxim Georgiev <glipus@gmail.com>, Peilin Ye <yepeilin.cs@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi,

On Tue, 2023-08-01 at 21:24 +0300, Vladimir Oltean wrote:
> Changes in v3:
> Fix ptp_mock compilation as module, fix small mistakes in selftests.
> 
> Changes in v2:
> It was requested to add test cases for the taprio software and offload modes.
> Those are patches 08 and 09.
> 
> That implies adding taprio offload support to netdevsim, which is patch 07.
> 
> In turn, that implies adding a PHC driver for netdevsim, which is patch 06.
> 
> v1 at:
> https://lore.kernel.org/lkml/20230531173928.1942027-1-vladimir.oltean@nxp.com/
> 
> Original message:
> 
> Prompted by Vinicius' request to consolidate some child Qdisc
> dereferences in taprio:
> https://lore.kernel.org/netdev/87edmxv7x2.fsf@intel.com/
> 
> I remembered that I had left some unfinished work in this Qdisc, namely
> commit af7b29b1deaa ("Revert "net/sched: taprio: make qdisc_leaf() see
> the per-netdev-queue pfifo child qdiscs"").
> 
> This patch set represents another stab at, essentially, what's in the
> title. Not only does taprio not properly detect when it's grafted as a
> non-root qdisc, but it also returns incorrect per-class stats.
> Eventually, Vinicius' request is addressed too, although in a different
> form than the one he requested (which was purely cosmetic).
> 
> Review from people more experienced with Qdiscs than me would be
> appreciated. I tried my best to explain what I consider to be problems.
> I am deliberately targeting net-next because the changes are too
> invasive for net - they were reverted from stable once already.

The series LGTM, modulo the minor comments from Kurt on patch 6/10. I
agree they can be handled with follow-up patches.

Keeping it a little longer on PW: it would be great if someone from the
tc crew could have a look!

Thanks!

Paolo

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
