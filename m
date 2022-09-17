Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044F7ECAAD8
	for <intel-wired-lan@archiver.kernel.org>; Sat, 17 Sep 2022 00:02:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8718241DA0;
	Sat, 17 Sep 2022 00:02:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8718241DA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1663372951;
	bh=FMw8ZvWFTalF/SNBhRzdSrYdUNU3SwQa9KFCbUcS6pM=;
	h=References:In-Reply-To:From:Date:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=7ZDYMxSRgmxX51cioAVmSYIyV2HtgXQcUHnfM+BXIMtekEjjLN+YjL2wPt/ccwVbZ
	 Ryg38T/4pHvXdLXMp662sissSIZfn7W0uINGG18MBsR5EuRx8JmPbUTwVwikfF8VYj
	 UfuKp5fD9/2hUmMQGqvwCCqnZ5GDdI5bkkXUeu/IK4HGhPDIEy2hgm63oo0OfkA3RF
	 oTZupffOPo7GvqhVCMnXwN0eTVShcW85ejAf3XNVC3k199NaXjh93UEK/zMUZ4Mvm6
	 1ki4E1LkfsW26zwn7YKhgkT+ipkOsLTYVGCmmXLU2kOqDvYuxlVjPE6tFPKtvLPNHi
	 JCyB2Hd1naGYw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wUOOwB0o2ufk; Sat, 17 Sep 2022 00:02:30 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4189141DA1;
	Sat, 17 Sep 2022 00:02:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4189141DA1
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 9DDDD1C2744
 for <intel-wired-lan@lists.osuosl.org>; Sat, 17 Sep 2022 00:02:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 77A8B610E3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 17 Sep 2022 00:02:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77A8B610E3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5jOHGcI8kV7x for <intel-wired-lan@lists.osuosl.org>;
 Sat, 17 Sep 2022 00:02:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7224661094
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7224661094
 for <intel-wired-lan@lists.osuosl.org>; Sat, 17 Sep 2022 00:02:27 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id go34so52800583ejc.2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Sep 2022 17:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=50pfUUj/vgJFWVGyCmPh4h7BWyWJzM6r5aZUYPBRoMw=;
 b=1LvHH6CEMujF8Py+USpTbcNrUoLKB19/I+IbLsYo++mCD9LtqjzCCtRMtnXAAz5Pfm
 dbz7D9+JiWW5mBbPYs+gZFbOjX3dagf51dAHIXXaRyvvCXN+EKVbhMrUTjsia6Vb/I7A
 pG0NQo8knkYnqZEfYHI2F5UHCfG5jmLVRd0WMrcd1G3c7C94MWcGRbUTMPiJXe0hkfjK
 Mkf6EQWw0b9LdM4mCz4MIE/nbB0GK/yU7eLKhg2DI3JNtlx5TXGJ4l7zx52cfZnN5aTO
 EKMPG3HPb5OPxyoW7v3p3Ffct0B14VQPN5EgMXrfIAWA3mtm75BiNeH8QzzVwvxNupdi
 DkYQ==
X-Gm-Message-State: ACrzQf2KEVWh/duOWHAJUgsZA2yfe9VFvTplLPAWFaaIkoQCabJ9oU2p
 V3+4EGYUVo5XaNBX4JPp4RujNrZipJZoKn68NYM=
X-Google-Smtp-Source: AMsMyM5mOnaEfXDy8jqFsNuwi+v6tx4gEz61WuQMsLniHsaIqCxIJTFjMs0dk5vg4LmiLerh0z237itaAZymfj+6z2U=
X-Received: by 2002:a17:907:ea0:b0:779:6c9d:7355 with SMTP id
 ho32-20020a1709070ea000b007796c9d7355mr4956271ejc.542.1663372945402; Fri, 16
 Sep 2022 17:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220909041645.2612842-1-floridsleeves@gmail.com>
 <4ff0b209-2770-3790-ae93-3ea81c15a03e@intel.com>
In-Reply-To: <4ff0b209-2770-3790-ae93-3ea81c15a03e@intel.com>
From: Li Zhong <floridsleeves@gmail.com>
Date: Fri, 16 Sep 2022 17:02:14 -0700
Message-ID: <CAMEuxRqbmds-XXjbGsgCup1_aj4EMfRO2dVurcS1O4fd0mdygA@mail.gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=50pfUUj/vgJFWVGyCmPh4h7BWyWJzM6r5aZUYPBRoMw=;
 b=gX6FWj46IiYEMBWFzAQpW/X9rgfemENCTEGH7qioDntvtkqCifz2ld/bbtzLYyLn3d
 4PCLXtTYhHukcC4tIj6BY/X530N2+lkUJ+okA7NcKCX4ObLu+N+Fj3WoYKgikvDAsS1T
 1oIj+JeU1LsBntvA8oagnJAIbaueJXMu/m1AGzpqky1gsc1FWWBeFuMjr3Z4icUbQSNR
 twRd+k0a4mhqI2YPBVpmQOE9UwxUSUlSpE5OHqgksyIt8xMvlrNSxFWGBVKe2DDelfvA
 vIPcBaawr1vY/GtU9yI9rqIGPKtdNBVM9LV/QT05IdQt970IzFj5EVLUanspwkSOAIhU
 2ykA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=gX6FWj46
Subject: Re: [Intel-wired-lan] [PATCH net-next v1]
 drivers/net/ethernet/intel/e100: check the return value of e100_exec_cmd()
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Sep 12, 2022 at 3:08 PM Tony Nguyen <anthony.l.nguyen@intel.com> wrote:
>
> On 9/8/2022 9:16 PM, Li Zhong wrote:
> > Check the return value of e100_exec_cmd() which could return error code
> > when execution fails.
>
> Are you coming across this as a real bug or as something reported by
> static analysis? If the latter, I suggest checking the return value and
> reporting it as debug, however, not changing existing behavior. We don't
> have validation on this driver so there is limited ability to check for
> regressions and the code has been like this for a long time without
> reported issues.

Thanks for replying and suggestions! This is detected by static analysis.
I submit a v2 patch that fixes it as debug printk.

>
> Thanks,
> Tony
>
> > Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> > ---
> >   drivers/net/ethernet/intel/e100.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
> > index 11a884aa5082..3b84745376fe 100644
> > --- a/drivers/net/ethernet/intel/e100.c
> > +++ b/drivers/net/ethernet/intel/e100.c
> > @@ -1911,7 +1911,8 @@ static inline void e100_start_receiver(struct nic *nic, struct rx *rx)
> >
> >       /* (Re)start RU if suspended or idle and RFA is non-NULL */
> >       if (rx->skb) {
> > -             e100_exec_cmd(nic, ruc_start, rx->dma_addr);
> > +             if (!e100_exec_cmd(nic, ruc_start, rx->dma_addr))
> > +                     return;
> >               nic->ru_running = RU_RUNNING;
> >       }
> >   }
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
