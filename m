Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDAFC433FE
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Oct 2022 21:10:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC3FE416F8;
	Wed,  5 Oct 2022 21:10:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC3FE416F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1665004239;
	bh=NZIoQZ0p2FwRaOq1zXla3SDWxh2TiFHbDqIeFNhWTZc=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XtRiRADgy0jvZWfSeDWCkXmgwZl6C2iX+Zh3ob0WfjAId0Tx/XPPczSg2KCM//8Tq
	 EVAeoEb0RZXRfzlPuDM9RGZAT0IeX9AWfBDXKbIdGnYeqcnQwuGm5tJhDOM2Z+0yVO
	 j8OMxlDPguLBnH31c4YC2d8LLY2bRKuzvj9x7Y8TLX5fQyq8jM3w3IuJlKC6LbqOk9
	 or7kHhVgmBbbYlIPMOyYe0Dcst5Z+EGnSMisIpIQUzBRemlaKWArj0AouzfsXDtDcq
	 m/bK4eXWVkBvvBJC+nDLVMwbQzOtgzNOUl6PgvcUmJbblM0cHFvT9Yo2pt/BV9epMo
	 J7C+6zerpbGqg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EBh3XZfFrA66; Wed,  5 Oct 2022 21:10:38 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 861A3417CE;
	Wed,  5 Oct 2022 21:10:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 861A3417CE
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 1703F1BF301
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Oct 2022 21:10:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E65C360FD5
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Oct 2022 21:10:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E65C360FD5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nDTVnqVMzAXw for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Oct 2022 21:10:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D2C460D53
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1D2C460D53
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Oct 2022 21:10:35 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="304267650"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; d="scan'208";a="304267650"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2022 14:10:34 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="626750208"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; d="scan'208";a="626750208"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1)
 ([10.54.70.10])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2022 14:10:33 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
In-Reply-To: <MW4PR11MB5800C7EFFCA3CFE32A351EFB865D9@MW4PR11MB5800.namprd11.prod.outlook.com>
References: <20221003095519.539390-1-karol.kolacinski@intel.com>
 <20221003095519.539390-2-karol.kolacinski@intel.com>
 <7b4176bc-a5a8-467f-f2f2-a7defb37b89f@intel.com>
 <MW4PR11MB5800C7EFFCA3CFE32A351EFB865D9@MW4PR11MB5800.namprd11.prod.outlook.com>
Date: Wed, 05 Oct 2022 14:10:33 -0700
Message-ID: <87bkqqou2e.fsf@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1665004236; x=1696540236;
 h=from:to:subject:in-reply-to:references:date:message-id:
 mime-version;
 bh=kG12J6bHIPnLR/2CRKT2dSoe1vaH3Osy1bCl4nHehpo=;
 b=QqH1gz+foRSuqEyPRaGSnxH4L3duIAlYX1kny2e+ASwvV1IAS6yQyVmO
 DnYhERoVdwJewl+eQ1LEaxEVBCwbea2yK1f4GKVitBLtE0Kvz5mU41ywB
 WnvBN19O/KDhC8Fm3CQRpObM96EAYxWZ3Q9U861JGrv/nGKNC63wpOrq2
 +croFKSeOGo4RgFdgD9EJVxb6r7it3beEoVRo5uyZPitHe2XxPNAsfU84
 1cRCC4+Ua1CVp/z2S8dfR/Ax23eUVsxBzlanh3HmVrnoqCWmRpEr5mwcN
 s9KEK6afph+rPO6jK7Ej53HR+yiOZRlXGG9mEnVP3+ZNyVJDFPLZuqGVj
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=QqH1gz+f
Subject: Re: [Intel-wired-lan] [PATCH net-next 2/2] ice: Remove gettime HW
 semaphore
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

"Kolacinski, Karol" <karol.kolacinski@intel.com> writes:

> Hi Vinicius,
>
>> I think the problem is less about concurrent writes/reads than
>> concurrent reads: the fact that the registers are latched when the
>> "lower" register is read, makes me worried that there's a (very narrow)
>> window during rollover in which the "losing" read (of multiple threads
>> doing reads) can return a wrong value.
>
> The issue in this case is, it's either risk of reading slightly wrong
> value or having multiple timeouts and errors.
> We experienced a lot of simultaneous reads on multiple PFs (especially
> on E822 HW with 8 ports) and even with increased timeout to acquire
> the HW semaphore, it still failed.

I am wondering if using a hw semaphore is making the problem worse than
it needs to be. Why a kernel spinlock can't be used?


Cheers,
-- 
Vinicius
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
