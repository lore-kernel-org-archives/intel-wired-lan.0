Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F2AC77B7A
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Jun 2023 15:19:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 660D9405B3;
	Fri,  2 Jun 2023 15:19:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 660D9405B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1685719185;
	bh=k/OnsO+35B3bJmEkLdfJ6r5G1GToAchHRYeI1GD0jM8=;
	h=References:In-Reply-To:From:Date:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=MWeHUUxGrAnq/kBUXasfx3A1C+0CguXyHgbk5n5A7tmeE8PFNLouPJaixs3K/lMiS
	 HHbs/r+Uff8DQApi94chD/IGV6+VQu/MM/5SugYpElQSCcMJGDcT5IEaTdK+BeZTxq
	 +41qoNIzJI6N8osA3uOcf0LQYFNoYl3pnFnNms9nNgx04k9TW2E4p2IvNxzSnmUwxo
	 wwcLyJzxGyqAFySieshqz2chha3GOl4r6QBMUyftp+3E1WfMbdxXxmYOHOixB/kSHo
	 ZYH3Ltyj7X0/2sy7SB//TprII3cg8DGv6OpKePVocBpLjUJQHj9HJJAgEX4xghQ8ro
	 truB6zxce3TWg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uGrfV2SDCgUY; Fri,  2 Jun 2023 15:19:44 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 891DA41869;
	Fri,  2 Jun 2023 15:19:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 891DA41869
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 65E2B1BF5A8
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Jun 2023 06:29:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3DADE60BD9
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Jun 2023 06:29:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3DADE60BD9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oQqskuS5wq8O for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Jun 2023 06:28:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 89E1260A8C
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89E1260A8C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Jun 2023 06:28:59 +0000 (UTC)
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-62615694bb9so14512856d6.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 01 Jun 2023 23:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685687338; x=1688279338;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JP4VtYfTpokhb/xoqxYleHsw/oeIF5+SRkQoPt6gSWw=;
 b=DYzSsiu9zV952q3Cpi0j22OLGn+NHLCr8cDZ4WTde2uWJBQaZknge4djIKW3zebTd9
 M1In1uA9eyXJl4fHr8dyNX5X580gUC+D8368qDJ+6ZM/fy8jYRcc+PL9QDSDfRD/z0pk
 jLEOzb8KSlozbbIKxl6ZwMV6CZACUtXw7dDvoYo67B+r8fi9bVGEXIYOKfv54Q7dLqH6
 bpjWLuhQpobZ+jAhk4K8wScjwr7y/LvoRf6+UEl2t4E6mJFmllUp7kNokv477fmYlEEq
 ll/2E1asV+qRzczluOhIKO9sagwy3EbOgTtU2QyrybUDK06+YEXcseDWITXuo2CG2Jh8
 dJ7A==
X-Gm-Message-State: AC+VfDzaw6cHRj6F795ubEtNiK+wE39Gf5qh1rjH7mErGlpbcGXZ30og
 VJm89PYwuNu6VYXfWG0AnTuzrxTnxy1cE+QO/Ek=
X-Google-Smtp-Source: ACHHUZ4pCynEppFlR22bUG60ASi3Bp3h0SiDbE6Ea2qZiFI0YyRf6NsmTNQsSt6SWcwvtzWgdrHbW2oONDgFlWN2zPg=
X-Received: by 2002:a05:6214:411a:b0:621:1b73:52c9 with SMTP id
 kc26-20020a056214411a00b006211b7352c9mr11323635qvb.10.1685687338157; Thu, 01
 Jun 2023 23:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230601070058.2117-1-eggcar.luan@gmail.com>
 <CO1PR11MB5089465F5D37EBA62BB1A123D6499@CO1PR11MB5089.namprd11.prod.outlook.com>
 <22e193f7-b55d-a31a-0179-4a53af692a89@intel.com>
In-Reply-To: <22e193f7-b55d-a31a-0179-4a53af692a89@intel.com>
From: egg car <eggcar.luan@gmail.com>
Date: Fri, 2 Jun 2023 14:28:47 +0800
Message-ID: <CACMC4jYdZjLKOLW0gFMOwwH-6bjGW1cBroXe6pioh+w4JQa9Bw@mail.gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
X-Mailman-Approved-At: Fri, 02 Jun 2023 15:19:39 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685687338; x=1688279338;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JP4VtYfTpokhb/xoqxYleHsw/oeIF5+SRkQoPt6gSWw=;
 b=seMnMYJUUohGcgZxh2SIuvUdPt8SMK5RA3gNuvrselKQlYVOhKv4pU3ycWHlsk+3/r
 0ZQGY0GK/pqUZUNFChxO9qvZewXJvFFaWYEcbfYmM5//O9lIYWVYSv7oPslaT/ApWk1/
 ElaTo1UTp/x4JQnxxmBaAsndLnakR4WrNIEWT1/PIo6odpT7pq3qG2L7cC8OurUR8f3u
 Ff/9YMxyb0IEINcpvAIP++InRR60kAKP8ujup4pF5lztC97W4gb2R5rjapLGW4c5Uvuu
 5nTQN3ERO5vdNm5oExz7OIcI+utztZYlznaBrrE+somdPw6ZRkQ045BAYcx+xY+pJDgs
 ksTA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20221208 header.b=seMnMYJU
Subject: Re: [Intel-wired-lan] [PATCH v2] igb: Fix extts capture value
 format for 82580/i354/i350
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
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Brandeburg,
 Jesse" <jesse.brandeburg@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear Tony and Jacob,

Thanks for the review, I'll optimize the patch soon.

Regards,
Yuezhen Luan
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
