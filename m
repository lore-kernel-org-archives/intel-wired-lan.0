Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F29C43334
	for <intel-wired-lan@archiver.kernel.org>; Wed, 20 Jul 2022 01:48:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06C9182F14;
	Wed, 20 Jul 2022 01:48:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 06C9182F14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1658281695;
	bh=7GERCVtXEIaMn8OjW24/rYhJpcYPdC4h4FOG2XzDZlc=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=r1/wyZAnaCy1wS46XA0xlAtuBZ8JF4PqyWenb4eADbYyukP4ZVkMVkeRnj3gz39d6
	 FmcOZ4ym+lQJUb3sNYKl0nxxA4BKemHUgNQv5EUwYS2X96tz8b/IVtLSXea4JEL6sW
	 OLkLlFRJZ2e4W5qopa38jgZt1mL0e1noJ5hZ3tPMEkShgc4kfW3LnI38ZgJetX8u7h
	 rHSeO4SX9FArKTIyPz+iU9uVSATdsHcAXURWk1PvoBGRoqmpatc1pLEanUKknTnJDd
	 TFZfECM0kp8c0BwREizqkFBU48Dl28Svl55mq4ko0rKsFY8iNOjAu2OyamDfNQKobG
	 Bq6Um7g9E+6Vw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RITLCK59x0Mu; Wed, 20 Jul 2022 01:48:14 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A64882FA2;
	Wed, 20 Jul 2022 01:48:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A64882FA2
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 44C011BF4D8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 20 Jul 2022 01:48:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 101D582FA2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 20 Jul 2022 01:48:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 101D582FA2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YGfW_seDucN1 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 20 Jul 2022 01:48:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E418E82F14
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E418E82F14
 for <intel-wired-lan@lists.osuosl.org>; Wed, 20 Jul 2022 01:48:10 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id w185so15265621pfb.4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 19 Jul 2022 18:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-transfer-encoding;
 bh=PTzXbEmFEbq0B4TcIYumHmnI0rlcLmxQ4TbVKexf5YU=;
 b=UvGbrJKoFPIUKV+ic0Gkx2ds/2L6Iv7J6mwvdUPsAf3/zapHcVQWp0Si6IHSXmPG1I
 C41orgf99sqlnSIqNBWwOl4MR+xsVX1fgbf73W/g9GTe0+T6V8MsYIa8w35htEhYZmYl
 0D3pYyUiLbm5Q7IlOghaEZh47gWvweeneNXL1MmAurbx6FZgFEzxJvueRMRfnUnL/zfo
 JKX2iqlUTW1S/YGacIzaCGfEx0P+ZHbHXYmob/rJtiq2E/v1hZ5sZ/hXi/PNwUL6tg5X
 nhhUeqsCKJUT0Q6T0pj0amOIy89p5HbzFWNPFsjXozPiwbuBgH8DxEvdz1zgL4gcyh2i
 QuTQ==
X-Gm-Message-State: AJIora9q4hOHMs0LwnNoc0eF91iXFPBOr62RrLClEzxyJO8brfvJgtYu
 2VfGqNTUkAUMvEvofk6/KXK2sw==
X-Google-Smtp-Source: AGRyM1tnmE3yBCvUVdbtZzQhfAQ6KHE0Nw1D4tPBwSss9Q6Kli3pgikb10uTluxaZmT8AJO9zDf84g==
X-Received: by 2002:a05:6a00:d42:b0:52b:717d:57a6 with SMTP id
 n2-20020a056a000d4200b0052b717d57a6mr13355033pfv.1.1658281690082; 
 Tue, 19 Jul 2022 18:48:10 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
 by smtp.gmail.com with ESMTPSA id
 r3-20020a654983000000b0041a615381d5sm400541pgs.4.2022.07.19.18.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jul 2022 18:48:09 -0700 (PDT)
Date: Tue, 19 Jul 2022 18:48:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com
Message-ID: <20220719184808.7ba1d6e1@hermes.local>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:mime-version
 :content-transfer-encoding;
 bh=PTzXbEmFEbq0B4TcIYumHmnI0rlcLmxQ4TbVKexf5YU=;
 b=A0rPtiKj0VuQSwxmKm7mKK527LgjGRmYUrksOhIuwRdbZLJqmZGq35iT4imFGgjhH5
 aD8ZGcm7CvaXC0VzwuEwDwVBT/lhz30GP/uVPDBcwaMzD2I9rNgPmrjSv4lMOkn9g80i
 jwZQiHB2J5EQ0nghNcN6CIcAGaquNwkGOPquyUelOo0R8ZT94wdOgI8R5KtJLK9/AZU1
 PdbiN9k0uB/AuDc5XAdIS0E96nVPxW9iLR1Lj4hViw8T8wg0gec4ehF/GfNlfPT0phaK
 iXrbsD+uOzMxDMlx8jo5Jbg32rcWLj3YdMf3afmO6KzkUOCKlKdfsVoL3Lkdd8t6Cobm
 Xyaw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=networkplumber-org.20210112.gappssmtp.com
 header.i=@networkplumber-org.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=A0rPtiKj
Subject: [Intel-wired-lan] Fw: [Bug 216261] New: Ethernet adapter i225_LM
 probe fail, return -1
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
Cc: intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



Begin forwarded message:

Date: Wed, 20 Jul 2022 01:19:08 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 216261] New: Ethernet adapter i225_LM probe fail, return -1


https://bugzilla.kernel.org/show_bug.cgi?id=216261

            Bug ID: 216261
           Summary: Ethernet adapter i225_LM probe fail, return -1
           Product: Networking
           Version: 2.5
    Kernel Version: 5.4.y
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: blocking
          Priority: P1
         Component: IPV4
          Assignee: stephen@networkplumber.org
          Reporter: joseph.bao@intel.com
        Regression: No

Created attachment 301461
  --> https://bugzilla.kernel.org/attachment.cgi?id=301461&action=edit  
This patch is based on 5.4.206, fix the i225 probe issue caused by unnecessary
point check.

Running kernel 5.4 with intel CPU alderlake-s and Ethernet adapter i225-LM,
encounter probe failure, return err code -2. 

The root cause is that i225 devices have only one PHY vendor. There is no point
checking _I_PHY_ID during the link establishment and auto-negotiation process.

Refer to the link below.   

https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/drivers/net/ethernet/intel/igc?h=dev-queue&id=7c496de538eebd8212dc2a3c9a468386b264d0d4

Attach the patch to clean up these pointless checkings.

I tried another branch 5.15.y, it fixes this issue but has another issue
related to PCIe switch & nvme SSD, so I have to stay kernel 5.4.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
