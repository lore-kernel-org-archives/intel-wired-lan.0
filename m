Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112A8CA5FF0
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 01:41:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C79DD40600;
	Tue,  6 Oct 2026 01:41:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oDqM0weUJZqA; Tue,  6 Oct 2026 01:41:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1575740606
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791250910;
	b=XBkG6r0G69+e79JqTJtJq4brlyb8PNu9dmuxav10PlnoMLzSCJtRg+whq1J2U0sN7KEZ
	 i/Ucd8tZmQYS67faEFbvfDWXkRBs89hvQYeYj9OYOv1q+jsmVpm9VsxIYzxxPojJC53gZ
	 Zw+MbwnTV+w2BaZqzxmySgJ1lpiRJplik2+IyxBnw1Y7Z+QXydNFkB0f3vLP/Eo4bPQxm
	 GY84sAXzCf9BJd/j5nHQoS7ONPBOwpHBCxaD0JRqEW7yV+9fFtBTMvBeqrLscjD9Gc+uc
	 7BgkV8MI7PAjTfbtgoYMpVNBiXxzpZmBHDfUU9tSx/CGNvpAK9LN8G1/+V2qxI90J1Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791250910;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CDy1WGwtmbatyxkR8iDwNNU0d8+iS+qyaX9opIOO7ME=;
	b=kzbv7EcwMGsM0Q0hPWO58zf1QcAi80gfwMD9uAX/jHrqiNrehbgQSipTdtK/YAlXqY7H
	 fF/43HtzTFtlJzw7+pt5Swav6a0WL5sJWh2InDsYNsrwRPU6b3RiclcNwbkWlrFu5/9gA
	 6MM/u3j5L+ksjDIIx53CUvb44ViAvafNTwDGgWsdcmLq/ftjrP5Hm6w7YGmrHR+AnSlMF
	 OVrcpbPHX99cbW5/wyIyGHe7PIygwnavh9NcwHUJvnxPKgLq+Nglct2w1Kdadl1ePY/Ip
	 CE+h8jc2i7v/W2Opwy0mH8Lajao0UheuIvkiPwhqWy3MYSoRdhacdu8MQaixrEfXY6w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DnpKYb2+;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791250910;
	bh=CDy1WGwtmbatyxkR8iDwNNU0d8+iS+qyaX9opIOO7ME=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kifg96mJdWBZ6YFxvXrYJbA9x2JTc1K/L+I47elg87j9ElBfuDFuvjc3ciaJiV3Bb
	 V21Py7sJLoZRri7Pq6royuOzHGHtIL+FFhTH4yEDX0PNSWhDX6zhX9KunOi8iZfTcF
	 X2rKtOpNj1NnJv4uBMkpSnxltzgcZSJIbkpdlKqTBERkUhHMjLq/fpnWCIzFUZAnaQ
	 WVZ+m89wvANDKQSllgxFyzT0Ta9hL6D17GN4Zbm+HzL/498ttqooWB43Tblapv/Tc5
	 qTZErsaEFPmKYyGzNji1AZf6Bii9h9MvQeZ/dP35R9ccGKTLRusdqsS4xhOAyudiNU
	 cZZZ90/Q6NsIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1575740606;
	Tue,  6 Oct 2026 01:41:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 485931D2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:40:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2DD0140606
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:40:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aD_YNJJNSJmo for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 01:40:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 58BFB40600
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791250846;
 b=JXGRaGXmVPrrYdpuGQ35aa3VXHD2NZPlKmWsxxqLQsqdiM17MJwncVhgYqRAR7HzLYzQ
 IZxI7iA6ra5xSBgJziupeP8AT66zr1gmvXvflWv69Ro8U02PdrX0kkSHVFLunNTrI+tHZ
 k7Y2dALYRSsGcPmlkLW2Cu0XhtRWyzB6aH81WbxszeswvJ8rg4jcRIuWFav4Jo6xknoji
 WqDm0D5KMIIAkf/SzICPnHfMWrqZPkzXDxqPQtsU29rliSRXRA/bHqDncXm7KnYlgsJ4p
 0RQ5t85e/AjwJDcYuPYNOa0VmKjOm6ZUt1HtuALwrH/yNTSe98v93GaFJ9IaNcJA+7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791250846;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=CDy1WGwtmbatyxkR8iDwNNU0d8+iS+qyaX9opIOO7ME=;
 b=rzVZNaU5TezRRuzoFwgdAfsDfTuoFu6MDgq8ZshUiGNaPQqTR2BxCjc3Ix8LJJfA6QEE
 kyf/+W85rl1y7qO3pS4Bs4meuXXPP6SaYKibKfXRBrVGGYArxT5SnCnTAXfQLhPBMSwpu
 zsPYvD2Y6oAa/BHPyVuziV7Z4/e/ZEIrtNktzdosnOqaDa4IMuAktB5fDvwBPHZDaYL+u
 2cwIIFSt3k6/UsmmGFH021I/PSPk1ezCrvy35tg1qB8gZvyqq1q1ozEaEM22Upy3L3VX0
 YmbsxnSQvOTj5L6cEHop5CITJmduklIllfdJeXEuIAQLZUkxLiaOLpVI4u+yXnwkmtg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=DnpKYb2+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=DnpKYb2+
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 58BFB40600
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791250846; x=1822786846;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CDy1WGwtmbatyxkR8iDwNNU0d8+iS+qyaX9opIOO7ME=;
 b=DnpKYb2+MDic6U2biWaqZhxKK+6AcE/22UWdlpbXUiXM5M93Rv6lbO4e
 QMgJw6MAO96hBcf/J4CSg5j3WqluzdxDZ6OKo3Rz7y/vU8Ae5+xKxxBt7
 5VrkyACWT2D0aGA3R1TU5TDZRM1ASfxsgmDxqsbDxfGqoI6NuB5l6aHYy
 qLyFfzW3aKZpziLbbgCcXAOnlb8yf+5mr1YwIf+dGTX2yWkWnGKgkQaN2
 EnGzaVN/DQ3OhfYT6YKfGqAgerrbjon7lYEqpbpT2Li7kyWKqScCzNX9c
 c3To+RG9hce1p3MjtGaRmRaS3hcwv/0+bvVBJL8dCLIHXd4kaIFznK/1d Q==;
X-CSE-ConnectionGUID: alkx7WueTG2l1DO6ljVfmw==
X-CSE-MsgGUID: KeTub03dRvCaSJLDxMKEjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="95751543"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="95751543"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:40:45 -0700
X-CSE-ConnectionGUID: kFcpDrxURwCo1Cq39kEcSQ==
X-CSE-MsgGUID: 0vm3YmUeTPOnelVbXXlAKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="277093766"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:40:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:40:29 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 18:40:29 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.64) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:40:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuKedZ13QblebEYM/SnQNd3k9GodCZ6pEp4KnIJ2qqUkf5Fqsjt5g3ue5aN7gqo4GhXfl1pXk9IQ/QgPW9DrTi3JMT83w+VpG/szPxc9gP4LKSXjNfBYhQ7Sdxiboxp8vwoH9Urb6KuQoBMYWHX4eeMgphZLDfaZ+y56NTIj7xY0OrIfelG3EAbUvV+od2nEeRAAAhxBZzGbcDalxzOjXDJqhN/Ajz8VpUK/OqDs037LHU/8FjdSAKVXDmurrfzOmkKYLj7FAQmE64iMr7dk/2GQ7mQ9RZRem/2jM3Wd4B8jCc0nuRcctJ3WeXS2RXW0wOEtsKsd6/X4ab05ukDS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDy1WGwtmbatyxkR8iDwNNU0d8+iS+qyaX9opIOO7ME=;
 b=QZLTX++d6fjUGTk/Jlco/cFtY0DfAsXRB70mu9L46Atfa7zGOAwmaYNSWjBoRkbd5gSfL/RW/5KlUzxIVDVX7Ee1XpFHQUP+5s48ahokSrkcegv2gQvkWSBOWq5RqMZJUe8vhTYpqi9Yp+gDv0OBW8KK0Ai0GTsDhTZKuIvn+MmAN030Kb+jsTJ/qS6HcTnGPssZA82QhngcZjvSM/K0PU0722QWj7aTjL9JUN5KK/HPlN/cFG9b/o2aAHdeYSQeImcGQQlXBUu52LvhvaFxOxLyV7whM3aJo43e0kvo/SuaMD7mdaYp5IFACAkadnCAeXZ4vWPuG6vk0VFHizx0LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 01:40:12 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 01:40:12 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Korba, Przemyslaw" <przemyslaw.korba@intel.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Nitka, Grzegorz"
 <grzegorz.nitka@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "Korba, Przemyslaw"
 <przemyslaw.korba@intel.com>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>
Subject: RE: [PATCH iwl-net v3 07/15] ice: E822: cancel offset verification
 work during reset preparation
Thread-Topic: [PATCH iwl-net v3 07/15] ice: E822: cancel offset verification
 work during reset preparation
Thread-Index: AQHdTUnCNnXoPvSqzkypT2NGGuc4d7bvzIuw
Date: Tue, 6 Oct 2026 01:40:12 +0000
Message-ID: <LV1PR11MB87902B420B6F510F2003F37790952@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
 <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-7-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-7-6532598e8da8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW5PR11MB5907:EE_
x-ms-office365-filtering-correlation-id: ab029308-9810-4607-58b7-08df234ac39f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|18002099003|10067099003|921020|38070700021|4143699003|56012099006|11063799006|5023799004;
x-microsoft-antispam-message-info: YNI3oguhK+AIxzx6sHDD48U9R6+01sVS2A4CiH49F65+7pKgH2QyrWmCMhr7r7pdpgOqbj1INgzrm/hKpI4svTOa+xgcGvQUqXDURVXpdr36GZwNug9SGjH6M40cYLyrv1JNdmNJJVXMXQcjjXKi+5MiihBSENVmxPumpVd/ztD1m1i0DcXHDd7l6U+6W8wvKYsE50B4nikT2hO871tbv9PDIpWcse9xt2//Ux53jtutdA5eXhKGXQl3Aq9/2aGSEj1U+muJSJ65mNnfiZkOKa4Yr9gO1/AbuLnql41ToYvP17BCz/AuJMSLgyt+ihscCJxe03iGoTB1Tr9iNX76cuDQcJ2mIfSg1laHL17w0L1a94Elft9FEuGfPh6mlV0p2G7bKBKXs0tqltJgSQwUnKHbO5BNQm7R3NYUAta6vL7L9efqSTP/4LbmZNPMQTo9KC+scYBLe4cpIoJdA7Mom9yV5++hNOurIkz4aW5vYFG+Uj1Aj83hApNgwFnuU23L/MgTiz3SL/i6UdkNYWFcZOqNnzz8FwGvA3QPgd8aqqU4g8b0dWhZdYIXI9CTRs4svCE/k7YkNbi0ejswG3zR68xrX1zX16/B/g5lZEJOWUfLWioy73f8nmYeVT0/QhA9jjhV0wlYmti4waUu9UFJ4JGTa7dPTDu7/UQa4fKDrkIQhJEpUenrU6DJIztUVq44asWSPSE9W4H7ciVqar0VdokZZpxIGLKmhHOLFF3J5d6Oh7eiigGze6oaJy+bBKCA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(4143699003)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkRpTDVGWXRsMVFTRk9EM3JYYUwvdnM0OUhtb3M5dXZXcWtiMXFjREdsVENy?=
 =?utf-8?B?Z2N6allqalFUR2FGUW52Z0NMcExXOFZHVjBhTTVJQUhkcXRjSEdUQ01YYk9S?=
 =?utf-8?B?N0k2ZUliRFdxdjh6TjdVZG1INi9PNGI2bXFXN1J3VWRJSmxsY1d5MnV5TXY2?=
 =?utf-8?B?eGxBdjZma09TR2pTVVZUOUUvMFhEU05kMTkwRkkvVWwvTTF6bjZ0Rkp5VHNS?=
 =?utf-8?B?Zml6V1lGR0xqRUdPRmMzVk4ydG91M3k1eEljN3lvTXlLanhjQ1BFVE9pREU3?=
 =?utf-8?B?Y3JLV0hTd0l2TTlJcy95cEtDSVZkTVROWmlOL3ZJODBUbk1zSGZZcEVOelYr?=
 =?utf-8?B?U3FWNDNDbXlEOHplQWtxcVRxTVFFMU5TSVIrZVpGWG5Yb05xYTV0d2JCam5w?=
 =?utf-8?B?Vmo1amVkWXc3SFJYZEhSTnB1VUF4akhyK1RaSXNmVzNqVmNWZFVVbDJjL0x4?=
 =?utf-8?B?QlZObSs1dzlJbU9CN0pFRTh2RER5eGluVWg3Wk1HL1VtRUFaY1RuUk9rVE8r?=
 =?utf-8?B?Y0VJY1ZCWlpxem93UXRhdW9CdDZtNXVCeTBnSXZhOTVGNTYvS1M0S3hkd2Iy?=
 =?utf-8?B?N0tSNTVwR3Z3MTRkMjZMamZ4N2NBOVJyL0RVdWluRHBnL0FIdFNGL2lqWGRa?=
 =?utf-8?B?dm4wOFlwVDhIcVh5cnBaOStReTA3R09Ia09OVXpqZzlKeFc1QUovVXVxSlBi?=
 =?utf-8?B?eTlHYi91Z2wzdUZyeTl2M25MbDF0dHBnNGVVYkxxS3JvaWJUdHBvMFRyOUxu?=
 =?utf-8?B?Z0Z0Y3lvanp0cElJVXR2TGtZMTU2L1hjRjYycThtR1FrTEdwZ2F4bDVlclJT?=
 =?utf-8?B?N0h6dGtKWEt0Z1gvdTNlZHRFbXBEbFV1UTZjTUxESW56ZlN6a2ExYUJTaEdD?=
 =?utf-8?B?V1VSQUZUOSsrZnp6OXNaeTlVNktVN0QzSzJuNis4eUx5T3dyRDI2QllWcFBL?=
 =?utf-8?B?dG5hMkdwZGl3S0d5RTlMOEl3VTdKUUxKWnpnYnpqMEd4VHJGa1hjbTBUYTBi?=
 =?utf-8?B?czNpZnltUUFFL1V0R1VTSFpha2ltUFNnT1ZrM21OUmZocXg5WWFUQVRRejE1?=
 =?utf-8?B?UmdhVkQxT1JGY0NTcnBSb2k1RFd4c0FuRUZncWY5dmpRZDJ5UnZob056TGgr?=
 =?utf-8?B?Q2p6OWE3cXhhOHNybisxZGRuLyt0QVVzWER4QmZIakhFYTgvSWdiVjJQaUNx?=
 =?utf-8?B?dUVwWXNhaEtHaXROTDNQQjlIMmgzVjlaSzFIejRJbHQwcmdURldVbTgrOGhJ?=
 =?utf-8?B?c3FacTJxY09LeW95WTYwQnZDbllQV3VwWHVBVEpuZ0VDaUI4UXQydTlXWnVX?=
 =?utf-8?B?RFRXRXpBT0xYQlN3ekZscjVzeGtKaHo5aHVuVkl6N1RBc2N2TXBoVm1oMjBk?=
 =?utf-8?B?VERlblU5Z3d6R010bjRmc1lCVmJncXhsNHQ1VXdCRXE1Ujd6MEtiK3M5ZXo4?=
 =?utf-8?B?c3JzVzJNQmVHaTJBRnZnV2tMbWpYV0dpK0Y2a00vcjFmRlpOc0VNL0tyelNz?=
 =?utf-8?B?V2FJNGEzOWU5RWpLV2wwT2RNbk1XRnFIWEdhTjBjYk1zaTdCNGRjRlNHelg3?=
 =?utf-8?B?anRsZHgzYUJlandnV0VhREloSlFEcitld0FSNjNBdjlpNTA5dDhnNm5GSWd4?=
 =?utf-8?B?bndFRzZKVHRQQVhRTnZVN0pEeFFEZld5eSs4d3hreEw2RlZZd3ZSaGVZbzlD?=
 =?utf-8?B?SVlEZ0J1L2ZEb05XSnU2SUt2QzkwR3JqNHJ6SGsxTGZWZ1loUWdtRWorSUxV?=
 =?utf-8?B?MVVFcGpSUk9mZHF0azRJWXZHZlVDdUNOZ01hcWNSOGV1Tko3ZFhlODVTTlIw?=
 =?utf-8?B?VHFoNDFON3RWU0pOM28vUit3MTU2TDdQK3JObERqRDBJNlNNS2E2b1BkdW9Y?=
 =?utf-8?B?c2cyUDhSZGRJT3ZZczFNQVUzNEJVZE1KNmMreTZya1FNdDZaL2RVWXJYcWZj?=
 =?utf-8?B?NXd3Qmp6cUdxMmo2SFFDTzh2ZkdGRWlGVmw0MnRNN0QzNlRxZUxMOG5aUXkr?=
 =?utf-8?B?aEtTVk5DZWVvZTE5Q2NOYytGTjFrQXdYa1dwbDM1ME5nWnJOcUpRem1EN0th?=
 =?utf-8?B?aTlMczJUbkxYcldnLy9kemQxZUl2N1Q2WnpFTEd2VWw2T2M2a25QL1JBdkpB?=
 =?utf-8?B?Ulo5UHBMU0dJbjlNMm5Vb3pOdm0wYjZZYmRNc3Ntb1g2SmJSbG5WVVdZRHN4?=
 =?utf-8?B?OGp6dERmQkJCQ1R3T3NRNVBaSUFHOU9IYU1UMFY2dnViTlVxc05GVlJsUHNo?=
 =?utf-8?B?TWlLQUlreElVTG00L2Uyak9mbVQyRWhUOTRpakIzZDdUMmo1Y1hEUFY5enVp?=
 =?utf-8?B?VGJ3dS90R2Z6V2dFdFFKQWxvK1VrRlNHSjgrTlBocnR5dFJLSExpUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lR1jOu0wu7YKpR5U05IwHhfto1Z+qDH3ZjHI1acmknmw9S/3mbRAr8CkIkpR73Z9fTTPsfdYh/uyONTkcKTmuS7+64dvxQmW1AoQsloIRnoICOJ2Z+Z2Y04aU+VqXnHg5XTejUG/rT4qWc5BF1LzQJW6ZObye+SZu3grmoNknutlLLdHsWVfi/uNVocdFrtrLMMeO09aus9une1jLNzSDCKFB79+yTYe76q4npYjRigq1rm5sXYlu8Nd4mOpeamoOx9ab9uo0vghzwN00W4G0h+JalCD4pCWUXL6OyZ5GR7S13gjRT86l83Qwmge0LnDu47UpZ/asVmOXzW+EntHkw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab029308-9810-4607-58b7-08df234ac39f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 01:40:12.5837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vyKb3z813v8fZcdsa1YdaWlGol9+XdwU+MAT+xDbPjyhj5rA83itj4h6M/ddY5IwC+qumen07+KPtBAwOeHV/T34en6gn/twyoq54H6DHe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5907
X-OriginatorOrg: intel.com
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWNvYiBLZWxsZXIgPGphY29i
LmUua2VsbGVyQGludGVsLmNvbT4gDQo+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDI1LCAyMDI2
IDQ6NTcgUE0NCj4gVG86IEludGVsIFdpcmVkIExBTiA8aW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9z
dW9zbC5vcmc+OyBNYWNobmlrb3dza2ksIE1hY2llaiA8bWFjaWVqLm1hY2huaWtvd3NraUBpbnRl
bC5jb20+OyBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT47IEtvcmJh
LCBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtvcmJhQGludGVsLmNvbT47IE5ndXllbiwgQW50aG9u
eSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IE5pdGthLCBHcnplZ29yeiA8Z3J6ZWdv
cnoubml0a2FAaW50ZWwuY29tPjsgS3ViYWxld3NraSwgQXJrYWRpdXN6IDxhcmthZGl1c3oua3Vi
YWxld3NraUBpbnRlbC5jb20+DQo+IENjOiBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVy
QGludGVsLmNvbT47IExva3Rpb25vdiwgQWxla3NhbmRyIDxhbGVrc2FuZHIubG9rdGlvbm92QGlu
dGVsLmNvbT47IEt1YmFsZXdza2ksIEFya2FkaXVzeiA8YXJrYWRpdXN6Lmt1YmFsZXdza2lAaW50
ZWwuY29tPjsgS29yYmEsIFByemVteXNsYXcgPHByemVteXNsYXcua29yYmFAaW50ZWwuY29tPjsg
TWFjaG5pa293c2tpLCBNYWNpZWogPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29tPg0KPiBT
dWJqZWN0OiBbUEFUQ0ggaXdsLW5ldCB2MyAwNy8xNV0gaWNlOiBFODIyOiBjYW5jZWwgb2Zmc2V0
IHZlcmlmaWNhdGlvbiB3b3JrIGR1cmluZyByZXNldCBwcmVwYXJhdGlvbg0KPiANCj4gRnJvbTog
S2Fyb2wgS29sYWNpbnNraSA8a2Fyb2wua29sYWNpbnNraUBpbnRlbC5jb20+DQo+IA0KPiBUaGUg
b2Zmc2V0IHZlcmlmaWNhdGlvbiB3b3JrIHRhc2sgZm9yIEU4MjIgaXMgZXhlY3V0ZWQgYWZ0ZXIg
YSBQSFkgcmVzdGFydCB0byBjb21wbGV0ZSB2ZXJuaWVyIGNhbGlicmF0aW9uLiBJbiB0aGUgZXZl
bnQgdGhhdCBlaXRoZXIgVHggb3IgUnggY2FsaWJyYXRpb24gaGFzbid0IGZpbmlzaGVkLCBpdCBt
YXkgc3RpbGwgYmUgZXhlY3V0aW5nIHdoZW4gYSByZXNldCBvY2N1cnMuDQo+IA0KPiBBIHNpbmds
ZSBQRiByZXNldCBkb2VzIG5vdCB0cmlnZ2VyIGEgUEhZIHJlc3RhcnQsIGJ1dCBsYXJnZXIgcmVz
ZXRzIChDT1JFLCBHTE9CQUwsIEVNUCkgd2lsbCBpbml0aWF0ZSBhIFBIWSByZXN0YXJ0Lg0KPiAN
Cj4gVGhlIGljZV9wdHBfd2FpdF9mb3Jfb2Zmc2V0cygpIGZ1bmN0aW9uIGRvZXMgY2hlY2sgaWYg
dGhlIGRyaXZlciBpcyByZXNldHRpbmcsIGFuZCB3aWxsIHJlc2NoZWR1bGUgaXRzZWxmLiBIb3dl
dmVyLCBpdCBpcyBwb3NzaWJsZSB0aGF0IGEgZ2l2ZW4gZXhlY3V0aW9uIGlzIGFscmVhZHkgcGFz
dCB0aGlzIGNoZWNrLiBUaGUgZnVuY3Rpb24gbWF5IHRoZW4gZmFpbCB0byBhY2Nlc3MgdGhlIHNp
ZGViYW5kIHF1ZXVlLiBJdCB0cmVhdHMgZmFpbHVyZXMgYXMgYSByZWFzb24gdG8gcmUtc2NoZWR1
bGUgYW5kIGNoZWNrIGFnYWluIGxhdGVyLiBUaGlzIHJlLXNjaGVkdWxlIHdpbGwgdGhlbiBzZWUg
dGhlIHVwZGF0ZWQgcmVzZXQgc3RhdGUgdmlhDQo+IGljZV9pc19yZXNldF9pbl9wcm9ncmVzcygp
IGFuZCB3aWxsIGtlZXAgcmUtc2NoZWR1bGluZyB1bnRpbCB0aGUgcmVzZXQgZmluaXNoZXMuDQo+
IA0KPiBUaGUgbGFyZ2VyIHJlc2V0cyB3aWxsIHJlc3RhcnQgdGhlIFBIWSwgY2FuY2VsaW5nIGFu
eSBvdXRzdGFuZGluZyB2ZXJuaWVyIGNhbGlicmF0aW9uIGFuZCBmb3JjaW5nIGEgcmVzdGFydC4g
UHJlZW1wdGl2ZWx5IGNhbmNlbCB0aGUgdGFzayBmb3Igbm9uLVBGIHJlc2V0cyB0byBhdm9pZCBk
b2luZyB1bm5lY2Vzc2FyeSBjaGVja3Mgd2hpbGUgcmVzZXR0aW5nLiBUaGUgdGFzayBpcyBub3Qg
Y2FuY2VsZWQgZm9yIGEgUEYgcmVzZXQsIG90aGVyd2lzZSBub3RoaW5nIHdvdWxkIHJlc3RhcnQg
dGhlIHRhc2sgdG8gZmluaXNoIHZlcm5pZXIgY2FsaWJyYXRpb24gYWZ0ZXIgdGhlIHJlc2V0Lg0K
PiANCj4gRml4ZXM6IDk1YWYxZjFjNGM5ZiAoImljZTogcmVzY2hlZHVsZSBpY2VfcHRwX3dhaXRf
Zm9yX29mZnNldF92YWxpZCBkdXJpbmcgcmVzZXQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBLYXJvbCBL
b2xhY2luc2tpIDxrYXJvbC5rb2xhY2luc2tpQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFs
ZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBcmthZGl1c3ogS3ViYWxld3NraSA8YXJrYWRpdXN6Lmt1YmFsZXdza2lAaW50
ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQcnplbXlzbGF3IEtvcmJhIDxwcnplbXlzbGF3Lmtv
cmJhQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IE1hY2llayBNYWNobmlrb3dza2kgPG1hY2ll
ai5tYWNobmlrb3dza2lAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYWNvYiBLZWxsZXIg
PGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pY2UvaWNlX3B0cC5jIHwgMyArKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKykNCg0KVGVzdGVkLWJ5OiBBbGV4YW5kZXIgTm93bGluIDxhbGV4YW5kZXIubm93bGlu
QGludGVsLmNvbT4NCg==
