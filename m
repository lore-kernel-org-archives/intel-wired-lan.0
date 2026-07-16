Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F34CC44512
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Jul 2026 15:42:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4F1180C47;
	Thu, 16 Jul 2026 15:42:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5W3KSNKJRn9X; Thu, 16 Jul 2026 15:42:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB85480C7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784216543;
	bh=5aTqKjwHikR8zrq8LWjKLMbsyJdF5CLSQ/ngkizf2PA=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=glVaA2Kh9f9hXdEaw+jrQXLLbjILQJ1nB8BPNQfhU0BcizJIQav5HJgLDdLNvygo8
	 AaPNb9cgTd5Nng9DRhf79F/lMBKw1vmJJC/So1TDnQGA/XDQ+UpvxRJugxNi88aUrQ
	 FTT60NEsjYcEnTU522azTUF+NNbjNeGG5B+FLe4wWhYsfFjg2FiCqHyzed0SYitelh
	 S+pBIGP6Xg0lug7dGjKsxTpIzRkNAii6FNYAQi8fDjuG9gV4EY34JWduIr+S7AZsQe
	 h7U/8SAPjsTryIddP5ktKejVqyEAMKW0bIjjKJGFNab1uBJdzcsV94fYe0tTkiy/+O
	 ttydMhdRKhf4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB85480C7B;
	Thu, 16 Jul 2026 15:42:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 79B8C36E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 15:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B17F80C44
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 15:42:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yXLmRTl_Ek6E for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Jul 2026 15:42:20 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=samuel.salin@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 79A6480C06
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79A6480C06
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 79A6480C06
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 15:42:20 +0000 (UTC)
X-CSE-ConnectionGUID: CRYeUB2TTha3opXVo677Ww==
X-CSE-MsgGUID: fVWOhLaKSeGb7Fas1iK8Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="96248638"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="96248638"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 08:42:20 -0700
X-CSE-ConnectionGUID: J9zHK4Y6RbaHgmn8W1F3nA==
X-CSE-MsgGUID: lywEAJFiRtasdc4+wNg34g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="252107511"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 08:42:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 08:42:19 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 08:42:18 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.30) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 08:42:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7A+FpliIwyhiE+TgLxqiDgTUN6wRFEUj4RbqyqTEBBNruOGwkAt1eVOrNsNLXSUin5/C/NfIC2IA0Spp+pAPHdtC8fVA+WRh/AuCfYwvkLIm8HwIS/4BqrPuDimbZva1mBt/SQyOSy6MphFHKkBsucWE2B5UOcCRXefEknB0lO3PN2hE4NZETXnX7F6fVqI01ZhZGhCh9VOYJsGGGQc+TkmQdGZVooLgFJK/M6bqLzf48MGG0PKutRIIOtaL+badAjZ+Bm22OJTHNg0vWXV+Hrrqo7oCbCUqrdHgVrcUGzl31Fqd4mvncM0wf94z3YknAdFNWPY4JrgdQbVEl0Zdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aTqKjwHikR8zrq8LWjKLMbsyJdF5CLSQ/ngkizf2PA=;
 b=lMhXcrmle73Arjx7fn/iDocwwiIuEYhFSYDKm/OVOlQQom/2Am6A3DRj9KSARAEcQaXkGhoCy2OfLM1Mp6bnM0/anEKWWAscJcMb4yerR69dtez8jW5+KhvjwKanf5yrm2bGzA1iYml9IYZuMYnwp9yCVUnMAokD6REIU/4dJz0GoTXutCz+ZGgtmW5BHh2ZNq5zDPKnNgB/22kuhgJyCtH8NljK3sfr8xUO3QbR2P/aYvqjSqtlvGsNX0R/96Qq973Mhg7GvVXXA6pInHzOq038q9Kbn759W+Oic7IyFs2VejYhIEicXWI5ZeAs+O441r14/AGHlUo8SFoqakA/Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by SJ0PR11MB4847.namprd11.prod.outlook.com (2603:10b6:a03:2d9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 15:42:08 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%3]) with mapi id 15.21.0202.014; Thu, 16 Jul 2026
 15:42:07 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Michael Bommarito
 <michael.bommarito@gmail.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>,
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH] idpf: bound interrupt-vector register
 fill to the allocated array
Thread-Index: AQHc/qSXopbcpXHdbUeuA35gleH6trZDx4UAgCyuPfA=
Date: Thu, 16 Jul 2026 15:42:06 +0000
Message-ID: <SJ1PR11MB6297C75C7D11C4C6FF5318D09BC72@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20260617215754.1117178-1-michael.bommarito@gmail.com>
 <IA3PR11MB898651F1629492D018DD17ECE5E32@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB898651F1629492D018DD17ECE5E32@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|SJ0PR11MB4847:EE_
x-ms-office365-filtering-correlation-id: 37138f9c-c128-4ceb-9533-08dee350caab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|921020|10067099003|38070700021|18002099003|22082099003|56012099006|11063799006|6133799003|4143699003;
x-microsoft-antispam-message-info: BUiGvRfEUChHiEHUgWMCar/G6NH+wZN6nhp4HGFdGNMHBojUQBUUpdSw+vlHP6J5tlAhBPRA7eZV6UtZccyCc0T9kmrOlUmbifVovEeyPA5+0M1AOt0zt1PcxjUmYLRvDTL6ESbNk5PMsYK4PnJYyH8fhgJovo+viQWB6LHQLMUVVD3jJNXKjLvuVAcsbos/iRNzYvfDHxJQu9zkHLzVyrmbsDrii9x6fFrBWL5aFBJmMmeQwg0NiaPdJ9lEKp6aNg/XKH4+VxHi6OMNHfIbjDcqlP1QTNiw7HNoxOjgNIEu3XVBhuKF6KW1mMYpyNRSYfVbZqwglqquiddISketD0mmluXp0gvEeYFV9rpMSF8mfmPgAmSv+bCVhV586QwZaVUUw0d6OedrV65INiWeTR4evLPkfFQ1PKs/NBeWYfPyFwnRsr1D9xxoMk7pdEvIlyI5DPeN9zuZjGBXkLloNQ4tWhMmmjmzaNtzcs+IeU/CEr/6bKjCGNv7brZ46W8eCtbU+KeACqMKfRxMzPkB8AgQYEIkVnVlom907pKlqYiOfW2z1kupoHm4NsLyp1JPfh4BPVilT+wDOJivVAR5jkRUTKd73ijWYIYYlTrUyKWP2HRh9cLDKWLatvK4K8F5KKBf7VaHu5wNtGDa9xRSaggUECYxl1HWdl9qHb2+mlBSQXPWhKxM1up449qFWafsEr+wwQczhpCZXGpsbx58xJ64WCDFJ/TvHAMcdYU3BQ4izHNl5nY1PZcvHVCvsMyj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR11MB6297.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(921020)(10067099003)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Fvae2s+EXoyyxg9HFhy0coHDuXOF1kZsC0vylffoLKUEbQhfWwjFlggdqaO?=
 =?us-ascii?Q?iTjjXnnwN4Z53VkQNMIODYcHvugzaC2Zrp+czfUwYfM2do9pudMJhMRr3Jqy?=
 =?us-ascii?Q?5JjoqWLv0g+8bzM/pZtsFL+Q5nyJq/483vAIAReKAdj1NJ98xJVr7V6DE3wk?=
 =?us-ascii?Q?qhTwn9KWFZlEifYqwOeTcOM255wMJeXH/IgrNo2XPdLw8tyruAEzdxyw791t?=
 =?us-ascii?Q?+q5DnHXJ5UhNovBm7ueMxiU6FIp+5q6mvo5YbT4p+rIDE+lVjBv0lOuoxdfk?=
 =?us-ascii?Q?GZaHS8kfwniwe0SFruOauC8M7GO9Led58HuZcZ0hktMpD7RQtj5y/x1lyScQ?=
 =?us-ascii?Q?Kzh+y0r+zIvXXMf/L4OjMcNKI/DbkudQP2JqYeeZBgJyjQMGgprsw/PaTLBo?=
 =?us-ascii?Q?b0E61vzr+9fOnExHmlIIANegbG83DD5oHTp3/YMFKKBB80LY8K0+oz/pzmAO?=
 =?us-ascii?Q?GdOc3Rorlpiq7dHeMmFYJusAL6qNxfMGvF41VFDFm6q/eM/YElX7/Y4Y090D?=
 =?us-ascii?Q?8JkIPJhKKKDT8RDcKDygj4UARLSsa8XzgvImxUnWgt9jvl9ySoYYrRlH6Xq4?=
 =?us-ascii?Q?EVwInhj4vxq4i6DNTRBpkT6bksmxDG59arrChzBooZRiU3hx8NIaDp4maNiU?=
 =?us-ascii?Q?gEtsF8BO4Ons6XF+6lhU5RW+POir4bEfIMloPN5HNVjvWjMFMKmt+1x1Z8kb?=
 =?us-ascii?Q?WXvt+4bHo1VScCzWL3SfedDJ1KKNpOlNUS56dOIZTLvaPMHxoNRDRGnX7MZ/?=
 =?us-ascii?Q?0syEBwHu6M/hK1MXR64FQ3G8Hi4ZwcsnUyUV+eQdOzMP+zF6c2YqqbC/D4Wf?=
 =?us-ascii?Q?G8KSGF3rL3VnkrtgarSk1rC7oRoq0rjLdtlzDWqhSjQVcG0oRUv/4IF7+sRM?=
 =?us-ascii?Q?oeTuGXCQc6s/ASZlBVvVuo2llUv4q7f/dY6mS3MhOKSgxnVqFXqcKPpxUxOo?=
 =?us-ascii?Q?D9Pd+J+/zbAxSkLUAbCizdZu+mWJVZJIaEAX4BwSO8B/y9zKm6QyYg1E3Ysd?=
 =?us-ascii?Q?A0w3L05MMIYGUe25rcpKdQtYIKXBvbLlpZAL3lSdmyq8XplBzdV98bJkcY16?=
 =?us-ascii?Q?qyUum3aIhlm7wA4Y/GASZwPmKGSV47WMXi4iGINwUx1+plDEb9zCi0uOki4F?=
 =?us-ascii?Q?hDjAuYkokc50tM+e7xHcWYIeccUeEMjOgENranisz/e6P55KzI+dd+K1pjB/?=
 =?us-ascii?Q?VUp5WCsAb5AiuPM8sQrA0P3SVpRPsBoFCV+guyOiK2xNqSQ269MgE6TeJXD9?=
 =?us-ascii?Q?GVkFUgkW7hffKnphEvOaCu7exoYLlER6qZtTD/lukNp6r3Gy/eletX6wyknX?=
 =?us-ascii?Q?GaPzM4u8y7JV9GmiXMCia22JuMLZeZVmRyeB+MRzurUm03Pj2Yhc/18oDOHo?=
 =?us-ascii?Q?jR9ybMEJ9H6VyCJcK6GrFCnFjTrnaAUvpUkMivo05gQHmKCumcclKWBPGnVX?=
 =?us-ascii?Q?weYC0oPYnvlDA1XRhnxTCZo8YZZ4ErjHZe8nifGJJW4X0RAXXNhHQL+2zsHt?=
 =?us-ascii?Q?jo3wM2JDH+fT8/+HG+rn5Rp9dxVCZt4MEo5BTlwmTurfiPifbkQ5v51W2sFh?=
 =?us-ascii?Q?RD3Agu9ptycB1++UKoCLgtcUjtKmvOQNMeUX3EBbKlqE3+jcNTwtdxtpqSQS?=
 =?us-ascii?Q?bQDsdR/YZqE6ZX2+RR++kc3CXorZHkOcx+2R4rsRTzRKopZKGZOJR+m+cLEe?=
 =?us-ascii?Q?4oJJY8qXUZD+97sZT/OU4CO19w81gWcoCgtP6AK4G2fdO8vgPt3qw/Lp2lV0?=
 =?us-ascii?Q?gIyyitAoQA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qllbf86wHXZOqGhrup8Q/hbRqkC1wkWByzx9+PsPXmLkQ7x3DKLMXZWbr2Y56hRImsIElg0L4B1BA6yAV9Ca8YNxcjrXEFI/9KqoyBXNbCcWpXYXJSqzLM1FZP+bicqsHyKNbDUMWWzRHwYOLJyNdwjpCo871UWMVNVLz3TlZTz8GP1BqAuT9uGumx3abWvf5O7tEgW98wSKUENLUVL2JGxbwPcMn8u/OQwdnTPEzAvZ83jCSWV0dfWGctF8RddKxxEMoXFdSNbR6wmf6KKv2ssa/BRhQxXCD1bd90XPZQhELPLgJLM/VSUMwsjUOKEErPpjP4sEYOXVbw54YW1KRA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37138f9c-c128-4ceb-9533-08dee350caab
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 15:42:06.9509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i4LCifkKMKHnUj1k02PR7pwafkp/jV2sg6tj/8uhMOHw3EBahqC3MrpjyJIBlX3WX73aVHj35A8O0t8daptprA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4847
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784216541; x=1815752541;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=E2cdWP/C4ZfpQqPv8w1mSwRiXJ8u3nbywSlaoFDp7hI=;
 b=dtwrDrJWCECHgZsIi7KJLhTip88mRu21N9xzhI0nteiAnYEGBCxovLs0
 IsRJ6tKpnDsg2oYoR/HHrmogl53pQ4j9KWS42Jucbk/GboxMPs8653imD
 3J+SxTm6xPgw19+AMIe9dWn/e3ueENxAFXmg4cO94eW0Hg5Y+6q2KJ6z8
 mzzXVeaFzgq3H+1G0C9idXjmjEQE1aqk+HZ+2mt8HWnvAeEyHEYF5hLlW
 gcVcQpNcNGfBOzTXy8TodlIIiLwkg0dVYhdRjXhnHyPGcaO/OByR5UKuw
 wlIiptqaI3TAbYwCjO1g8+Sx8jjsiUOu9gyVahiyDOQSN/1eMP2ft1jmO
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=dtwrDrJW
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH] idpf: bound interrupt-vector register
 fill to the allocated array
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

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Loktionov, Aleksandr
> Sent: Wednesday, June 17, 2026 10:22 PM
> To: Michael Bommarito <michael.bommarito@gmail.com>; Nguyen, Anthony
> L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Hay, Joshua A <joshua.a.hay@intel.com>;
> Pavan Kumar Linga <pavan.kumar.linga@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [Intel-wired-lan] [PATCH] idpf: bound interrupt-vector regis=
ter fill
> to the allocated array
>=20
>=20
>=20
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Michael Bommarito
> > Sent: Wednesday, June 17, 2026 11:58 PM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; Hay, Joshua A
> > <joshua.a.hay@intel.com>; Pavan Kumar Linga
> > <pavan.kumar.linga@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> > David S . Miller <davem@davemloft.net>; Eric Dumazet
> > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>
> > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: [Intel-wired-lan] [PATCH] idpf: bound interrupt-vector
> > register fill to the allocated array
> >
> > idpf_get_reg_intr_vecs() fills the caller-allocated reg_vals[] array
> > from the VIRTCHNL2_OP_ALLOC_VECTORS reply in adapter-
> >req_vec_chunks,
> > bounding its inner loop only by the per-chunk num_vectors. The array
> > is sized
> > separately: idpf_intr_reg_init() allocates kzalloc_objs(struct
> > idpf_vec_regs, total_vecs) from caps.num_allocated_vectors and only
> > checks the returned count after the fill. The sum of per-chunk
> > num_vectors is never reconciled against total_vecs, so a reply with a
> > small num_allocated_vectors but chunks summing higher writes past the
> > end of reg_vals[].
> >
> > Impact: a control plane (a PF or hypervisor device model) that returns
> > a VIRTCHNL2_OP_ALLOC_VECTORS reply whose per-chunk num_vectors
> sum
> > exceeds num_allocated_vectors writes struct idpf_vec_regs entries past
> > the end of the reg_vals kmalloc allocation (KASAN slab-out-of-bounds
> > write).
> >
> > Bound the fill loop to the array capacity passed in by the callers,
> > mirroring the sibling idpf_vport_get_q_reg(). The existing num_regs <
> > num_vecs check then rejects an undersized reply without the out-of-
> > bounds write happening first.
> >
> > Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
> > Assisted-by: Claude:claude-opus-4-7
> > Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> > ---
> > The reply originates from the control plane (a PF or hypervisor device
> > model), which is trusted in a standard deployment, so this is a
> > defense-in-depth / robustness fix: it bounds a malformed or internally
> > inconsistent ALLOC_VECTORS reply. It is a genuine trust-boundary
> > crossing only where the guest distrusts the control plane (a
> > confidential VM or an Intel IPU posture) or the control plane is
> > simply buggy. It is not remotely or unprivileged-reachable.
> >
> > Reproduced with a KUnit harness that calls the unmodified
> > idpf_get_reg_intr_vecs() against a crafted req_vec_chunks reply
> > (num_allocated_vectors =3D 1, four chunks of sixteen vectors) under
> > KASAN:
> > stock reports a slab-out-of-bounds write 0 bytes past a 12-byte
> > kmalloc-16 object and the test fails; the patched build is KASAN-
> > clean; a well-formed 64-vector reply still fills 64 entries on both.
> > The KUnit wiring is repro-only scaffolding, not part of this patch;
> > harness on request.
> >
> >  drivers/net/ethernet/intel/idpf/idpf_dev.c      | 2 +-
> >  drivers/net/ethernet/intel/idpf/idpf_vf_dev.c   | 2 +-
> >  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 5 +++--
> > drivers/net/ethernet/intel/idpf/idpf_virtchnl.h | 2 +-
> >  4 files changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c
> > b/drivers/net/ethernet/intel/idpf/idpf_dev.c
> > index 1a0c71c95ef12..4079a787657f1 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
> > @@ -87,7 +87,7 @@ static int idpf_intr_reg_init(struct idpf_vport
> > *vport,
> >  	if (!reg_vals)
> >  		return -ENOMEM;
> >
> > -	num_regs =3D idpf_get_reg_intr_vecs(adapter, reg_vals);
> > +	num_regs =3D idpf_get_reg_intr_vecs(adapter, reg_vals,
> > total_vecs);
> >  	if (num_regs < num_vecs) {
> >  		err =3D -EINVAL;
> >  		goto free_reg_vals;
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
> > b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
> > index a07d7e808ca9b..6726084f6cfa0 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
> > @@ -86,7 +86,7 @@ static int idpf_vf_intr_reg_init(struct idpf_vport
> > *vport,
> >  	if (!reg_vals)
> >  		return -ENOMEM;
> >
> > -	num_regs =3D idpf_get_reg_intr_vecs(adapter, reg_vals);
> > +	num_regs =3D idpf_get_reg_intr_vecs(adapter, reg_vals,
> > total_vecs);
> >  	if (num_regs < num_vecs) {
> >  		err =3D -EINVAL;
> >  		goto free_reg_vals;
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > index be66f9b2e101c..ec7330603ff84 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > @@ -1318,11 +1318,12 @@ idpf_vport_init_queue_reg_chunks(struct
> > idpf_vport_config *vport_config,
> >   * idpf_get_reg_intr_vecs - Get vector queue register offset
> >   * @adapter: adapter structure to get the vector chunks
> >   * @reg_vals: Register offsets to store in
> > + * @num_vecs: number of entries the @reg_vals array can hold
> >   *
> >   * Return: number of registers that got populated
> >   */
> >  int idpf_get_reg_intr_vecs(struct idpf_adapter *adapter,
> > -			   struct idpf_vec_regs *reg_vals)
> > +			   struct idpf_vec_regs *reg_vals, int num_vecs)
> >  {
> >  	struct virtchnl2_vector_chunks *chunks;
> >  	struct idpf_vec_regs reg_val;
> > @@ -1346,7 +1347,7 @@ int idpf_get_reg_intr_vecs(struct idpf_adapter
> > *adapter,
> >  		dynctl_reg_spacing =3D le32_to_cpu(chunk-
> > >dynctl_reg_spacing);
> >  		itrn_reg_spacing =3D le32_to_cpu(chunk->itrn_reg_spacing);
> >
> > -		for (i =3D 0; i < num_vec; i++) {
> > +		for (i =3D 0; i < num_vec && num_regs < num_vecs; i++) {
> >  			reg_vals[num_regs].dyn_ctl_reg =3D
> > reg_val.dyn_ctl_reg;
> >  			reg_vals[num_regs].itrn_reg =3D reg_val.itrn_reg;
> >  			reg_vals[num_regs].itrn_index_spacing =3D diff -- git
> > a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> > b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> > index 6876e3ed9d1be..9b1c9c86f6eac 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> > @@ -104,7 +104,7 @@ int idpf_vc_core_init(struct idpf_adapter
> > *adapter);  void idpf_vc_core_deinit(struct idpf_adapter *adapter);
> >
> >  int idpf_get_reg_intr_vecs(struct idpf_adapter *adapter,
> > -			   struct idpf_vec_regs *reg_vals);
> > +			   struct idpf_vec_regs *reg_vals, int num_vecs);
> >  int idpf_queue_reg_init(struct idpf_vport *vport,
> >  			struct idpf_q_vec_rsrc *rsrc,
> >  			struct idpf_queue_id_reg_info *chunks);
> > --
> > 2.53.0
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Tested-by: Samuel Salin <Samuel.salin@intel.com>
