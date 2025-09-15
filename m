Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBD0CAC592
	for <intel-wired-lan@archiver.kernel.org>; Mon, 15 Sep 2025 15:29:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55288403F6;
	Mon, 15 Sep 2025 15:29:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tQcbz2Wvluiu; Mon, 15 Sep 2025 15:29:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9618940464
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1757950141;
	bh=CAygs02+g0MbJDsAinwMyJxPXjZQb+F5N8Jalspkf7k=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xCP8V/Tci0ZGdNRc901XCeuYERcPG8tM9QzzyJKtKIK9N2bz1nPzANyyJgOZRfeTH
	 ilBOR0Wmfo+83PFQwN+sYQSgBqyIGoosgDCWE3orCWV5kbkdX0yQ8GDIDdWAfgL7R6
	 Dru7hP+nrPVXjth/gZE7Pj48GkUn52opyszyyGm0jSW/ymrEI45Ec7ouFMmPO7Bzok
	 egpBF9XKXD7Dbjf4VgWgnK0Z8K5/hEGkHa37N6IXIuntqLg+aK3E9hBRVKwLqTPoNn
	 p2kLahYniFu78NN8Rdiwq2Uu0fJcJHDvx+M5J1j+Lpf9bCqs7s85nPm8thePyah+3z
	 xa9ahpFsYpR8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9618940464;
	Mon, 15 Sep 2025 15:29:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 75AD712D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Sep 2025 10:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6735740DC2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Sep 2025 10:14:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hlezFJEcycIs for <intel-wired-lan@lists.osuosl.org>;
 Mon, 15 Sep 2025 10:14:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.208.48;
 helo=mail-ed1-f48.google.com; envelope-from=breno.debian@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4C23C40057
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C23C40057
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C23C40057
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Sep 2025 10:14:27 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-62ef469bb2cso4478339a12.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Sep 2025 03:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757931265; x=1758536065;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CAygs02+g0MbJDsAinwMyJxPXjZQb+F5N8Jalspkf7k=;
 b=PRJ91BHqSn3cNhA23zJe210WZha1bMvbfto+aZsVj61a+pVKGngF9hlBU8LGxByyYi
 i+G85pnj3+EI3/n10tCIpnuUnEQ69ArzBV/c1ZCV81oXKky7fz2M7zl5r/9Cl8q3Ewid
 7qMeD1o3rxErgknhsNNJv8Yl7hK39d04IC5f7UYDOv037s4Mjbyq985QSkC+rktu2Emw
 Akf1SlfaHLZWeqdxV2Ls5i52LVc/R3XavbpnKSGHaf43LM4L/THsVM618E4OhCo8giku
 uGu2Eqz5LuS347V1xbkI4r4Lk5JxpeSWCpx/dlGUd+BvYwdoYCKstgQbX7GTZ0ZfIFSe
 mVeg==
X-Gm-Message-State: AOJu0YyyKK+ADIsRv0SIIfq0P4SRt7UrIC99hzFb3wWonI7yTb5ahDVZ
 jsWC2iG1DlwQGfvhcyyWlZvsPlWBe8FH9YBnHlL0T/mvXv5PwBhYD+HC
X-Gm-Gg: ASbGncvwur+nOilkrGba2lGpaRQ805bVq1cqW2tN6Nl1pVxEIGV718XIOlW4ggaGuul
 oihm35pNLTDDiXaD/NHvWksCLZ/rxWCFTxFmi3Xg8YYnVVFHa1MlPQIS0VY4LXe48iy4vSsEWY3
 IdYgTttuHn5bzH9kDYLPEd6oGJ204VkreaKvqh09U0DMDpo4mWc9u2GRA5IcWtHn33ao4lCdntD
 UAZQvO/0lpBM7ZLAw3ZARusSOJHnC5lGS6vqmhzf3jYE3N/9M9+/bWnFjo/lpA5OcE7fbYlHsh9
 20t7Mm4r3HuLiGTPN/Y6tHrLumMk0tjWtFJvOGTAMHR8l/VC5AIPL1lTivwREK4wMyfac5l0Tro
 w4LQ0k+92tfHXVdtkMlcUdQ8c
X-Google-Smtp-Source: AGHT+IEoBsVRHvl1p4Zrqcs2rmBL9VAocz0nQOrX2z7rXzNaRyuk3E8aAvo7oAfIKkCJMF0C0LG8DQ==
X-Received: by 2002:a05:6402:454e:b0:62a:a4f0:7e5f with SMTP id
 4fb4d7f45d1cf-62ed840792cmr10145278a12.34.1757931265011; 
 Mon, 15 Sep 2025 03:14:25 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:72::])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-62f31fa406esm2498318a12.11.2025.09.15.03.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 03:14:24 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:14:22 -0700
From: Breno Leitao <leitao@debian.org>
To: kernel test robot <lkp@intel.com>, anthony.l.nguyen@intel.com
Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, netdev@vger.kernel.org
Message-ID: <mpxxgmukbabs7hkasdph24vg2pt3myjojab3vocpgerm77so4m@n3dwy7mypowe>
References: <202509140606.j8z3rE73-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509140606.j8z3rE73-lkp@intel.com>
X-Mailman-Approved-At: Mon, 15 Sep 2025 15:29:00 +0000
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=debian.org
Subject: Re: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD REGRESSION
 a6c7254e995a80be8c3239fb631d9d65c9e75248
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sun, Sep 14, 2025 at 06:05:17AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
> branch HEAD: a6c7254e995a80be8c3239fb631d9d65c9e75248  idpf: enable XSk features and ndo_xsk_wakeup
> 
> Error/Warning ids grouped by kconfigs:
> 
> recent_errors
> `-- loongarch-loongson3_defconfig
>     |-- ld.lld:error:undefined-symbol:libie_fwlog_deinit
>     |-- ld.lld:error:undefined-symbol:libie_fwlog_init
>     `-- ld.lld:error:undefined-symbol:libie_get_fwlog_data

I am having a similar issue on net-next, where the kernel is failing to
compile due to the undefined symbols above.

This happens when CONFIG_ICE is set.
