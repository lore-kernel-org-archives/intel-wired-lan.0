Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580C1606A31C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ZtRASGjw;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hg1fhM8/;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Aae6K8WT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33FBC40549;
	Fri, 27 Nov 2026 13:39:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X2BF563yjGqu; Fri, 27 Nov 2026 13:39:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 833E040534
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795786769;
	b=a4ZOrQt11pEP4ZyJJoJvr6UX+JpIU+VPRNPqZ6xjZFQJmth4P3+maH7kwZq85QZg+IiW
	 xS9jnQe5Efdk5gUcs4feSjxrTitad/N+CiMqk3HTqvabQ7T5iGdvnGkfZrYgTaDqSlbpo
	 ZaRWcNUpVk6sJXyJQB9HhdhklZ8GMFdQtoCenJdkN2fIt3AdCp/1ApxNzlOm9WMYVQHyo
	 pRa+GwBxT4tMufgflJMSVMzsTbFcUkMDi0/emJganBJhj+ZEdJUyB1iwVAxt/Y2QHN2ga
	 JEAOu7e6vOeHbIpNjzheljhAsAF1Le5ks9A/Luw94fYvEc8FaeQmutLobSQpUPQkilg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795786769;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:References:
	 From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rSGB5r2OqCjgLeGq3byMfsKVgPkMqq4UnQBx6/lxxZ4=;
	b=IZQW/7QuvWZUt6J6ngXvS0ZMvMNcVYnbuODXr1nQwnpW3zWpeTr9+DImz8HCOFkJCxmG
	 m3vXjYBGZ9TfPpaEXsnROchUvR+dowHgTJW8+34rRA10kJKGs5CUbsVBLikOTOJI6bBCc
	 FJwnU0Ii913KJ2aGkrrZbtXhw0sp6/8Tr9UxjJvaIh1jxrPGuj0qgi8T5D10Aa6HiddZD
	 Hbj3YjGBgVh/XhPMJxfoanvNhLEwlVhB/dxS0EjHVL8mRMKBUXj4xoQ3rrBexiAHusnt7
	 aQ9WnPzWtXMOPEWq+5n64BVQfOIuaMDkY+kkikrRD4xoCWHYJvZDUmGHP1yXg1/Rg8w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795786769;
	bh=rSGB5r2OqCjgLeGq3byMfsKVgPkMqq4UnQBx6/lxxZ4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZtRASGjw3eisMPRn8aqJQ3NbjRmuBwAcVEu1eLAViPHVFmidYUa4laeSXbARgDtDl
	 LTKXuo1Aln2rtTXba7CqoAlOWx2cc+opbfacFxGLveDWw+8nA1lt7g3Vl2/Cx526b2
	 WzNyl7GzjMABRDCIANNTT2Zpgo7DKQeFPWX9347C35pIM3xkMSCdSn6vhglUvOQ6T2
	 /bO8tQDbHVOpM126udEmGGvsfH3ZHvTS8C8/J7NEGwta4B8r+lIdi29Dau6OczQE+Z
	 gtl/di0Q9Sf11LC/GheQxR0nJppih/PQzNEl3JM8X4V75pvCQNObaimN+jz2iAu8xE
	 pkz26OP0YCDAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 833E040534;
	Fri, 27 Nov 2026 13:39:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 62A9BD1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 13:39:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5441160A51
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 13:39:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mePXvxVG3Rln for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 13:39:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 350EF60698
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Hg1fhM8/; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=Aae6K8WT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 350EF60698
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 13:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795786767; x=1827322767;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uSgDnylBFqSvC7/moICTM8UObndLd43JdjoTDxBjEN4=;
 b=Hg1fhM8/dd+DZ4eMqCgewJzvPz+9dlYZ+FXUSo7c+QIAc3mzbwffkzqX
 vStXb6U1KYoeIbBu6tYH5GksEoC1LgVUQ0iW6qrNDec32XaZqy34j0SIU
 DmREcdr9ac9xygXzhMfF8bjvGjfWH/GyejqEplpAfD4brJezmyhLtERP4
 bRQIpsNBEN2FFY7BKcm0pHXCsND5zlYsFu2Vi3Y/+0t9UDfhkym1Ao/+k
 u5J9L+yoamY3UuGXBq02pIBSHNmqCzgHCXgoTqCA6DTryGtMelhbWFu68
 ocL2+3ZqP3zoh3HwqaaTbGOtgPMlPbnRlH1WldwAVqKuqCFIpLzNu27KK Q==;
X-CSE-ConnectionGUID: smSwvJCrQWmuMW1VVXlpKw==
X-CSE-MsgGUID: RIB7mnoiTdC9mV/xfEu5Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4710311"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4710311"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 05:39:26 -0800
X-CSE-ConnectionGUID: CFzBc3WeTfKkNZlpBMb84g==
X-CSE-MsgGUID: tJ/XqbcCSFmxE40N5hJGWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12638223"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 05:39:25 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 05:39:24 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 05:39:24 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 05:39:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSGB5r2OqCjgLeGq3byMfsKVgPkMqq4UnQBx6/lxxZ4=;
 b=Aae6K8WTG/kbBWUj4A8CdfwBl2U7Vb9w/2UtgTcUylMiwUu+FMor+Qs9xz8HCnptzY81cFJbb/yxR3UajYnG7hMny8cSl4zzAZOnfiCMMrOOit4XSsQzftN4j/P65m21KjlelRjM9Pke3iKOajcypewSyH+uZ9iNU3vjA3PTCes=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by LY0PR11MB123582.namprd11.prod.outlook.com (2603:10b6:404:226::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 13:39:21 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 13:39:21 +0000
Message-ID: <e8a1046e-c129-414f-9e90-d165c863c856@intel.com>
Date: Fri, 27 Nov 2026 14:39:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 2/3] ice: share default RSS hash profiles between
 PFs
To: Jakub Ramaseuski <jramaseu@redhat.com>, <anthony.l.nguyen@intel.com>,
 <intel-wired-lan@lists.osuosl.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20261126123114.893916-1-jramaseu@redhat.com>
 <20261126123114.893916-3-jramaseu@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261126123114.893916-3-jramaseu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P195CA0001.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::15) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|LY0PR11MB123582:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca2ef75-e7b2-4675-80a2-08df4c8bd7c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|4143699003|6133799003|261009223027099003|18002099003|22082099003|260925021911599003|260925021311599003|260925022911599003|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026130827099003|261026135527099003|261026121527099003|261021121427099003|261021135927099003|261021133027099003|261021130227099003|261021123027099003|261022115727099003|261022113327099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: JVJAgHeF5oBvyUbdTDNQe/B4dVIzlRwIMayRJ6Sq9Ja5PhnlN1e/Ib+1HUWN9SnGjanBugKE/TRTVbXAgawF33ZI/25X5L/VxRuYs3gJpi5XboA565Dp+4EmmZijNqLpIQy9N3T+5VF8pE/1TraSYEuspaAhGnM6nIAQTSmXLsrrKECef32OIGyvuB5HNbTILRO3s/ncMULlP8LUMOyBQ1v/gbx8zRamPWa0o0+9Fdz5MUj60SadmkxA4+vtFU4Hsk0d19kSTcuV4Y/KjIFP3MTGLcc/M+DjjCR+EWkmL2P6zMKAWjbZB8cGfqYi7eYvM5p1fmafj/l44MTrJkkH4mug+5xpibZNOOe+FRBmuPb3Y/FzqVKC+KUP0y7VIUaIMeEG9AsmRoV/XFoZySjrlHZvKlhnq0/c9lEiJ1pkKoyyNv2xUtpo9PheVvYl2bn5WcejKR488KTFnNEWiQSq4UBpAm92Uevfvfa/jsbwNhqA5YuRGKUh8LccZfsYYhbOtNoqJwIbd5iS7czQhrLDfCK0KnzMtR29nAT0SMJLnoqvJhthfsbQaEuaFsNngwtDtpzAIUjzx1SFf8EoR3ABXr8aq0mGKz1/ILvLmdThpof0oN0c/UrSm07kE5nT02cm8xl83+E6OA1wJlRpSmLgtZw6nIOooa+5YIeE+YFVIHM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(4143699003)(6133799003)(261009223027099003)(18002099003)(22082099003)(260925021911599003)(260925021311599003)(260925022911599003)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026130827099003)(261026135527099003)(261026121527099003)(261021121427099003)(261021135927099003)(261021133027099003)(261021130227099003)(261021123027099003)(261022115727099003)(261022113327099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGx3YllYRHFOL1BpTEZ4c3Z1R3BrZ2JJU1pXbEJkTnRQbWhlV09sbThXU3E3?=
 =?utf-8?B?c29PRlVlSThET3pjelRkOFVoQXJMbGhhdml4d0tGWnlNc0VKSGdQeHIxS3Ir?=
 =?utf-8?B?YVV4MFFJYUdndTZPOGNVQ0pFSTM3TTFTakEwSDJZQ0tJelVXOFQ4VEJLRUow?=
 =?utf-8?B?bGdYUk1oYkl3dnhDczRIWGdKSFRSaFBOMmhrS1MvRVUwOEc1R2ROWWpkQWlE?=
 =?utf-8?B?cFZoNVdnTXNnWnM0UkpoZGMxUVdkOTdMaHdYcEc4YTBna0svdVVLQW80Rk15?=
 =?utf-8?B?c25jUFQrY0pCbWE4VzBib1Rsbytnbmx0eFBFalNNdzREN2ZPVWZjbTAya2tQ?=
 =?utf-8?B?bWxpQ1NTaFhJN2lyYzZtUTlhSVBtOTVGYXkrb09NT1NSMGZoeWZaaTNuN2Z2?=
 =?utf-8?B?dmVXUXVub1VVMFMvZDJZNTh4UHErd0VCVnR3cVkxV0luTU9PR3p3Vi94Tk5Z?=
 =?utf-8?B?b1NyZytHMVVrTU9hZFpRcFZQMDBuQWNEeTloZGVaT3VGdGJCWGRTaUg0NDhB?=
 =?utf-8?B?TjNkeTdlYUhKdThlZG5ZOVRxdUc2TVV6TktxN2lnemYzNDVmcGlpZEhJdEY2?=
 =?utf-8?B?MHQ3NGpaNjJlMjRUZ3ZFbEJwc0pnUGF6NDBLaENCRjdzc3dpeFlWb1lwQ0NB?=
 =?utf-8?B?dmpTZ0U3TGVoVDd1SzBTTGV4OCtVVVpEQXdpeC91WWU2c3NrZ0doaXFVNk1s?=
 =?utf-8?B?ZHUwQnFUK0h1d0V2K0dGV1dYR1VFZlVvcGd5SDZ2SEh6SlFqTHpkWnpTdUxi?=
 =?utf-8?B?SUhKb3V4UDYxd3pOU0czbEpORnVIVER5QStKdWxPcXl5SGhKSEJJT0tFOUVz?=
 =?utf-8?B?emI3bUZiOEF1WklmVmZmZk5qYUZXQW9rMlh1c256MHhvL1c0cVRTQW5HSGFE?=
 =?utf-8?B?RG9uNFNwendvTmt1SWY5c01DK0xRT0NHdjhpWmplbnpYMHNITUlzRC9mdTJ3?=
 =?utf-8?B?ajByU3Rsak5VeFU5VWJuYTRDVWsvNUcrWCtiQTRUY0hOMmxyS0l6UjNzTHJ6?=
 =?utf-8?B?WXhUa2pUNlJjTUxydTdKYVVpTmZnN1RKY0ZlWDkvS3dmaDROWWgwZFl0TmM2?=
 =?utf-8?B?SlNhVVNQNEMwMXJodHEzclR5RXgwWGpLdGFtR1VWUVZmVEhvb3cvc1pGYUV4?=
 =?utf-8?B?UXlOaFpFWmEzWlpzWXMyR1k3SEJXRTkvNTJJQXdwV3pZM01iY2VMcHU0bUtP?=
 =?utf-8?B?cURrZVM4QXZUdjJsVHVpTjUzcmFlV0djN2dqeUkzUGZJWmNHMklBRHp4dERq?=
 =?utf-8?B?aUlVS0FxNDdreDk1ODhBUENPZGkzc3Fqc1pmY05XOEc1VlRkZzAyb0taRjdJ?=
 =?utf-8?B?MVZjcE95cUhUUzJHNVNPTERCZ0ZrZFJMY001Z0VURlRKVlliekRjWkhGanoz?=
 =?utf-8?B?WVhIMVRlTngvTUJISWFucHMvQ0NqcmZQblhTK0xCbEhLV0RFS2hqYkVpNHln?=
 =?utf-8?B?MmM1cGdxMzRQenBuaHVjUUlqUVdHY0Q2LzFCSTJlL0hCWCtXOFlVOWJQMEdI?=
 =?utf-8?B?blovU01nQ3RkN2JIRUtPcVVwN2NzUzFRNVl0bks2OFpROGRlb29uS2JLVjBw?=
 =?utf-8?B?OW93b1JEYXNKYlVObzNseDFVa0wxK1FEdWV4bVBwRlRZN3VzMUl1K0tXZmpN?=
 =?utf-8?B?TW05ZzFqbzlSWFNyTk1GTFlPR0c4M2k2OGJmRGUzSU42a2xQc2tNSCs3R3R6?=
 =?utf-8?B?MGpDNHZ2ZEFVazhCV0pVTGNFNDBOc3lVQ0t1VzBBa0M5dmpwV00vRFJOSGh5?=
 =?utf-8?B?YWxHMFdsVWJvRWYvRXd0WDMvbzQ3WFVPRGFJdEY3TWFtZW53d3NxdHdNTUZk?=
 =?utf-8?B?N2tBZWVxb1hPNkJmUVlFVEd4T1JKMlpSRjFacFBTdVVXcHRHSkljY2NZbVh6?=
 =?utf-8?B?ZkdLQkVwSTEwY0xPWmplck1YSC9qTjlSQmRUOGdxVG81bEVrZUxFdVV4VTdr?=
 =?utf-8?B?TXZUcUNIVzZRaFRWT244U21pWjQvQ3RrR2NhU29iTVgzZFZ6Z0t4K1c1S3JL?=
 =?utf-8?B?SHo5K3BrMWtya2hlenhwZGNYSTVvT3JYSjZOeHltNEF6V3VwSTMzd0lNL28v?=
 =?utf-8?B?dzVlbE55Ny9KN0cyQmg0endUMVN0eS9PR04zU0xnZ3puL2s0YVJSTnk0UDBr?=
 =?utf-8?B?TUQ5bzVwdW00dnVGaGdKQzZxS1ZGMVpzYkNUVFRLQ256b3pJNmJ4L3hxRHNI?=
 =?utf-8?B?MU5pRmdVR1poWWlVZFpabUJsbEl4dmw1Rm9JbEJVYWZ5aWdQdVE2S3RONWFn?=
 =?utf-8?B?T1RlMnB6MTd0d1RSZ0UzVFU4MDRiUFRwYi9VQktvcTV2SUIzV1pvY01abTdN?=
 =?utf-8?B?NS9LKzRqTkFIU2l0M2NPZkV4Ty9Cdm1oS2RMczBZOGUrTTJkQkw3Q2lrT0VP?=
 =?utf-8?Q?DowG8tHwpIlWYIkI=3D?=
X-Exchange-RoutingPolicyChecked: Krl3bFrL0WFAl0o0w+OFrtEgD432fiiY4N9F2JHzX1CugmVPesHhhCEq+XeSUtNxZEclT/lGoEA0xMCJy2YW+yzM5bsHV7r5evWi2Nbpci9xnmq/vbNBpQnLi11NRMOtm3Kx2LCkVaXtFtaAQVTcpRA2YBJGkLonDlk48DkHgGGFmfpt6YWnL9fO3XyEO0U06GUtBK4iNSwnta8CKNyfVRyz4ezVpOSpEKoKPc1mSTJGhYVu3F+WfZOntG15t2+AWKVZsGR9OENcPUhW9H9cOXucH0PML1WlK60mnDMjanoBvEhLpCIJri//FPiyRV9EVWTKpfTbohPWTv+O5+Qe4w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca2ef75-e7b2-4675-80a2-08df4c8bd7c3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:39:21.6060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUj+IOSkyzwKnKqjEi4ihEfZ9k80S9IprOSjXGq/i1CVVcY7juzPJqJzC/4QbsZPST242z3wpxPeNW5yKWDTsYWIwdCK/4cJgdmDNsnLDdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR11MB123582
X-OriginatorOrg: intel.com
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/26 1:31 PM, Jakub Ramaseuski wrote:
> RSS hash profile IDs are a firmware resource of the whole device: the DDP
> package defines 128 of them, of which IDs 2-127 can be used by the PFs.
> Each PF allocates its own IDs, and since
> commit a6d63bbf2c52 ("ice: Implement RSS settings for GTP using ethtool")
> its default RSS configuration takes 19 of them. On devices with 8 PFs,
> like the E830-XXVDA8F, that is 152 IDs: the PFs probed last lose part
> or all of their default RSS configuration, and RSS configurations requested
> later, e.g. by VFs, fail:
> 
>    ice 0000:6c:00.0: ice_add_rss_cfg failed for VF 0, VSI 2, error:-5
> 
> The default configuration is the same on all PFs, and so are the profiles
> it needs. The package, for E810 and E830 alike, defines the RSS profile
> IDs as shared resources: firmware lets a PF allocate an ID another PF
> holds, by allocating that index without ICE_AQC_RES_TYPE_FLAG_IGNORE_INDEX,
> keeps the ID until its last user frees it, and a PF reset releases the IDs
> of that PF. What firmware does not provide is a lookup of the ID
> programmed with an extraction sequence.
> 
> Keep a list of the profile IDs shared by the PFs in struct ice_adapter,
> keyed by extraction sequence. When a PF needs an ID for a default profile,
> it joins the ID another PF uses for the same extraction sequence, or
> allocates a new one and adds it to the list. Each PF takes and releases
> its own firmware reference, through its own admin queue, when its
> reference count of the profile goes from 0 to 1 and from 1 to 0; the PFs
> never access the tables of each other.
> 
> Only profiles using neither field masks nor symmetric hashing are shared:
> the GLQF_HMASK registers are split between the PFs, and GLQF_HSYMM is
> programmed by every user of a profile. Such profiles, including the two
> GTP-U ones hashing on the QFI field, keep one ID per PF. Raw (parser)
> profiles program GLQF_HSYMM on their own and never use a shared ID.
> 
> A PF leaves the list on reset, devlink reload and remove, as firmware
> releases its IDs then. CORER, GLOBR and EMPR empty the list: each PF
> empties it while preparing for the reset, before it can allocate IDs
> again, so no PF joins an ID the reset freed. A PF that prepares late
> may drop entries a faster PF made after its rebuild; their IDs stay
> valid and are freed as usual, only not shared. An ID firmware hands out
> as a new one drops a stale entry for it. Sharing is off when an
> ice_adapter can cover more than one device (E825C, devices without a
> serial number).
> 
> While at it, replace the fd_swap parameter of ice_add_prof() with flags.
> 
> Measured on an E810-CQDA2 split to 8 PFs (NVM 4.30), with all PFs bound,
> then one VF created on each PF and "rx-flow-hash {tcp,udp}{4,6} fn" set on
> it, reading the IDs the PFs hold from firmware:
> 
>                 IDs in use     IDs in use after   failed profile ID
>                 after probe    VFs and ethtool    allocations
>    before       126            126                70 (30 at probe)
>    after        33             65                 0
> 
> Also checked on an E830-XXVDA8F (8 PFs) with a RHEL 9.6 backport: one VF
> per PF and "rx-flow-hash {tcp,udp}{4,6} fn" on each, all 32 input set
> changes succeed with no ice errors.
> 
> Fixes: a6d63bbf2c52 ("ice: Implement RSS settings for GTP using ethtool")
> Signed-off-by: Jakub Ramaseuski <jramaseu@redhat.com>
> ---
>   .../net/ethernet/intel/ice/devlink/devlink.c  |   2 +
>   drivers/net/ethernet/intel/ice/ice_adapter.c  |  13 +
>   drivers/net/ethernet/intel/ice/ice_adapter.h  |   7 +
>   drivers/net/ethernet/intel/ice/ice_ethtool.c  |   2 +-
>   .../net/ethernet/intel/ice/ice_flex_pipe.c    | 351 +++++++++++++++++-
>   .../net/ethernet/intel/ice/ice_flex_pipe.h    |   9 +-
>   .../net/ethernet/intel/ice/ice_flex_type.h    |   1 +
>   drivers/net/ethernet/intel/ice/ice_flow.c     |  51 ++-
>   drivers/net/ethernet/intel/ice/ice_flow.h     |   2 +
>   drivers/net/ethernet/intel/ice/ice_lib.c      |  10 +-
>   drivers/net/ethernet/intel/ice/ice_main.c     |   5 +
>   drivers/net/ethernet/intel/ice/virt/rss.c     |   2 +-
>   12 files changed, 427 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> index 9851e6140a944..aba28e33eac58 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> @@ -460,6 +460,7 @@ static void ice_devlink_reinit_down(struct ice_pf *pf)
>   	ice_vsi_decfg(ice_get_main_vsi(pf));
>   	rtnl_unlock();
>   	ice_deinit_pf(pf);
> +	ice_put_shared_profs(&pf->hw);
>   	ice_deinit_hw(&pf->hw);
>   	ice_deinit_dev(pf);
>   }
> @@ -1326,6 +1327,7 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
>   unroll_dev_init:
>   	need_dev_deinit = true;
>   unroll_hw_init:
> +	ice_put_shared_profs(&pf->hw);
>   	ice_deinit_hw(&pf->hw);
>   	if (need_dev_deinit)
>   		ice_deinit_dev(pf);
> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
> index eecad97c084d9..ea21c83155d81 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.c
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
> @@ -53,7 +53,9 @@ static int ice_adapter_init(void *priv, void *init_param)
>   {
>   	const struct ice_hw *hw = init_param;
>   	struct ice_adapter *adapter = priv;
> +	struct ice_pf *pf = hw->back;
>   	struct devlink *devlink;
> +	u64 index;
>   
>   	devlink = shd_priv_to_devlink(adapter);
>   	adapter->devlink = devlink;
> @@ -84,6 +86,15 @@ static int ice_adapter_init(void *priv, void *init_param)
>   
>   	adapter->phc.use_timecounter = ice_adapter_use_timecounter(hw);
>   
> +	mutex_init(&adapter->rss_prof_lock);
> +	INIT_LIST_HEAD(&adapter->rss_profs);
> +	/* RSS hash profile IDs come from the firmware of a single device.
> +	 * The NACs of E825C, and devices without a serial number,

I would not care about devices w/o DNS - those are strictly "pre-prod",
and if someone at intel (those should not leave our lab) would have such
cards, it will be sufficient to just use only one per machine, or to
program DNS number to some other value.

--
For the 2 NAC mode, it bothers me after working with the code around,
that it was melted with the "whole device" thing, except its shared
or not depending on the topic. Would be great to add one more level of
common abstraction. Of course its not easy given there are multiple
series in flight that touch the code.
(this is not an action item for you, just saying that improvement here
would be much welcomed by me personally)

> +	 * may share one ice_adapter, but not the profile IDs.
> +	 */
> +	index = ice_adapter_index(pf->pdev);
> +	adapter->rss_prof_share = index && !(index & ICE_ADAPTER_FIXED_INDEX);
> +
>   	return init_srcu_struct(&adapter->ports.srcu);
>   }
>   
> @@ -92,10 +103,12 @@ static void ice_adapter_fini(void *priv)
>   	struct ice_adapter *adapter = priv;
>   
>   	WARN_ON(!list_empty(&adapter->ports.list));
> +	WARN_ON(!list_empty(&adapter->rss_profs));
>   	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
>   		mutex_destroy(&adapter->cpi_phy_lock[i]);
>   	mutex_destroy(&adapter->cgu_synce_lock);
>   	mutex_destroy(&adapter->rebuild_lock);
> +	mutex_destroy(&adapter->rss_prof_lock);
>   
>   	cleanup_srcu_struct(&adapter->ports.srcu);
>   	mutex_destroy(&adapter->ps_lock);
> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
> index 3778948730ef7..6e2d8b33ce71e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
> @@ -101,6 +101,9 @@ struct ice_phc {
>    * @ctrl_pf: Control PF of the adapter
>    * @rebuild_lock: serialize PFR recovery across PFs of the same adapter
>    * @ports: Ports list
> + * @rss_prof_lock: Mutex protecting @rss_profs
> + * @rss_profs: RSS hash profile IDs shared by the PFs, see ice_flex_pipe.c
> + * @rss_prof_share: The PFs may share RSS hash profile IDs
>    */
>   struct ice_adapter {
>   	struct devlink *devlink;
> @@ -124,6 +127,10 @@ struct ice_adapter {
>   	struct rw_semaphore ctrl_pf_lock;
>   	struct ice_pf __rcu *ctrl_pf;
>   	struct ice_port_list ports;
> +	/* For access to the list of shared RSS hash profiles */
> +	struct mutex rss_prof_lock;
> +	struct list_head rss_profs;
> +	bool rss_prof_share;
>   };
>   
>   struct ice_adapter *ice_adapter_get(struct pci_dev *pdev);
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 4a5e2043447f1..ceba419233a70 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -2966,7 +2966,7 @@ ice_set_rxfh_fields(struct net_device *netdev,
>   	struct ice_netdev_priv *np = netdev_priv(netdev);
>   	struct ice_vsi *vsi = np->vsi;
>   	struct ice_pf *pf = vsi->back;
> -	struct ice_rss_hash_cfg cfg;
> +	struct ice_rss_hash_cfg cfg = {};

rct

>   	struct device *dev;
>   	u64 hashed_flds;
>   	int status;
> diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
> index 6d619eeaf0190..427ea89aa091a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
> +++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
> @@ -1215,12 +1215,13 @@ ice_prof_has_mask(struct ice_hw *hw, enum ice_block blk, u8 prof, u16 *masks)
>    * @fv: field vector to search for
>    * @masks: masks for FV
>    * @symm: symmetric setting for RSS flows
> + * @skip_shared: do not return a profile ID shared with other PFs
>    * @prof_id: receives the profile ID
>    */
>   static int
>   ice_find_prof_id_with_mask(struct ice_hw *hw, enum ice_block blk,
>   			   struct ice_fv_word *fv, u16 *masks, bool symm,
> -			   u8 *prof_id)
> +			   bool skip_shared, u8 *prof_id)
>   {
>   	struct ice_es *es = &hw->blk[blk].es;
>   	u8 i;
> @@ -1237,6 +1238,9 @@ ice_find_prof_id_with_mask(struct ice_hw *hw, enum ice_block blk,
>   		if (blk == ICE_BLK_RSS && es->symm[i] != symm)
>   			continue;
>   
> +		if (skip_shared && es->shared[i])
> +			continue;
> +
>   		if (memcmp(&es->t[off], fv, es->fvw * sizeof(*fv)))
>   			continue;
>   
> @@ -1376,6 +1380,324 @@ static int ice_free_prof_id(struct ice_hw *hw, enum ice_block blk, u8 prof_id)
>   	return ice_free_hw_res(hw, res_type, 1, &tmp_prof_id);
>   }
>   
> +/**
> + * struct ice_shared_prof - RSS hash profile ID shared by the PFs of an adapter
> + * @list: entry in the list of shared profiles of the adapter
> + * @es: extraction sequence the profile ID is programmed with
> + * @pfs: bitmap of the PFs (by hw->pf_id) holding a reference to the ID
> + * @prof_id: the profile ID
> + *
> + * The DDP package defines the RSS profile IDs as shared resources: firmware
> + * lets every PF allocate an ID that another PF already holds, keeps the ID
> + * until its last user frees it, and a PF reset drops the references of that
> + * PF. Firmware cannot look up the ID programmed with an extraction sequence,
> + * the adapter keeps a list of these entries for that.
> + *
> + * Only profiles without field masks and symmetric hashing are shared, their
> + * only hardware state is the extraction sequence, which all PFs write the
> + * same. The GLQF_HMASK registers are split between the PFs, and GLQF_HSYMM is
> + * programmed by every user of a profile.
> + */
> +struct ice_shared_prof {
> +	struct list_head list;
> +	struct ice_fv_word es[ICE_MAX_FV_WORDS];
> +	unsigned long pfs;
> +	u8 prof_id;
> +};
> +
> +/**
> + * ice_shared_profs_adapter - get the adapter whose PFs share profile IDs
> + * @hw: pointer to the HW struct
> + * @blk: hardware block
> + *
> + * Return: the adapter of the PF, if its PFs may share profile IDs of @blk,
> + * NULL otherwise.
> + */
> +static struct ice_adapter *
> +ice_shared_profs_adapter(struct ice_hw *hw, enum ice_block blk)
> +{
> +	struct ice_pf *pf = hw->back;
> +
> +	if (blk != ICE_BLK_RSS || !pf->adapter || !pf->adapter->rss_prof_share)

I guess pf->adapter cannot be null

> +		return NULL;
> +
> +	return pf->adapter;
> +}
> +
> +/**
> + * ice_prof_can_share - check if a profile ID may be shared with other PFs
> + * @hw: pointer to the HW struct
> + * @blk: hardware block
> + * @masks: masks for the extraction sequence
> + * @symm: symmetric setting for RSS profiles
> + *
> + * Return: true if the profile uses neither field masks nor symmetric hashing.
> + */
> +static bool
> +ice_prof_can_share(struct ice_hw *hw, enum ice_block blk, u16 *masks,
> +		   bool symm)
> +{
> +	u16 i;

the default type for variable is "int", and loop counters should be
declared in the loop header

> +
> +	if (symm)
> +		return false;
> +
> +	if (!masks)
> +		return true;
> +
> +	for (i = 0; i < hw->blk[blk].es.fvw; i++)
> +		if (masks[i] && masks[i] != 0xFFFF)
> +			return false;
> +
> +	return true;
> +}
> +
> +/**
> + * ice_find_shared_prof - find the shared profile ID for an extraction sequence
> + * @adapter: adapter of the PFs sharing the profile IDs
> + * @es: extraction sequence
> + * @fvw: number of words in @es
> + *
> + * Return: the shared profile, NULL if there is none.
> + */
> +static struct ice_shared_prof *
> +ice_find_shared_prof(struct ice_adapter *adapter, struct ice_fv_word *es,
> +		     u16 fvw)
> +{
> +	struct ice_shared_prof *sp;
> +
> +	list_for_each_entry(sp, &adapter->rss_profs, list)
> +		if (!memcmp(sp->es, es, fvw * sizeof(*es)))
> +			return sp;
> +
> +	return NULL;
> +}
> +
> +/**
> + * ice_find_shared_prof_id - find a shared profile by its ID
> + * @adapter: adapter of the PFs sharing the profile IDs
> + * @prof_id: the profile ID
> + *
> + * Return: the shared profile, NULL if there is none.
> + */
> +static struct ice_shared_prof *
> +ice_find_shared_prof_id(struct ice_adapter *adapter, u8 prof_id)
> +{
> +	struct ice_shared_prof *sp;
> +
> +	list_for_each_entry(sp, &adapter->rss_profs, list)
> +		if (sp->prof_id == prof_id)
> +			return sp;
> +
> +	return NULL;
> +}
> +
> +/**
> + * ice_drop_shared_prof - remove a PF from the users of a shared profile ID
> + * @sp: the shared profile
> + * @pf_id: the PF
> + *
> + * Free the entry when it has no users left.
> + */
> +static void ice_drop_shared_prof(struct ice_shared_prof *sp, u8 pf_id)
> +{
> +	sp->pfs &= ~BIT(pf_id);
> +	if (sp->pfs)
> +		return;
> +
> +	list_del(&sp->list);
> +	kfree(sp);
> +}
> +
> +/**
> + * ice_join_prof_id - take a reference to a profile ID another PF allocated
> + * @hw: pointer to the HW struct
> + * @blk: the block of the profile ID
> + * @prof_id: the profile ID
> + *
> + * Allocate the given profile ID, without ICE_AQC_RES_TYPE_FLAG_IGNORE_INDEX:
> + * firmware adds the PF to the users of the ID.
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +static int ice_join_prof_id(struct ice_hw *hw, enum ice_block blk, u8 prof_id)
> +{
> +	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
> +	u16 res_type, idx;
> +	int status;

in new code please name the variable "err", not "status"

> +
> +	if (!ice_prof_id_rsrc_type(blk, &res_type))
> +		return -EINVAL;
> +
> +	buf->num_elems = cpu_to_le16(1);
> +	buf->res_type = cpu_to_le16(res_type | ICE_AQC_RES_TYPE_FLAG_DEDICATED);
> +	buf->elem[0].e.sw_resp = cpu_to_le16(prof_id);
> +
> +	status = ice_aq_alloc_free_res(hw, buf, __struct_size(buf),
> +				       ice_aqc_opc_alloc_res);
> +	if (status)
> +		return status;
> +
> +	idx = le16_to_cpu(buf->elem[0].e.sw_resp);
> +	if (idx != prof_id) {
> +		ice_free_hw_res(hw, res_type, 1, &idx);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_get_prof_id - get a profile ID for an extraction sequence
> + * @hw: pointer to the HW struct
> + * @blk: hardware block
> + * @es: extraction sequence of the profile
> + * @masks: masks for @es
> + * @symm: symmetric setting for RSS profiles
> + * @flags: ICE_PROF_* flags of the profile
> + * @prof_id: receives the profile ID
> + *
> + * Get a profile ID for @es, which the PF does not have yet. With
> + * ICE_PROF_SHARED, join the ID another PF of the adapter has for @es, or
> + * allocate a new one and make it available to the other PFs.
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +static int
> +ice_get_prof_id(struct ice_hw *hw, enum ice_block blk, struct ice_fv_word *es,
> +		u16 *masks, bool symm, u32 flags, u8 *prof_id)
> +{
> +	struct ice_adapter *adapter = ice_shared_profs_adapter(hw, blk);
> +	u16 fvw = hw->blk[blk].es.fvw;
> +	struct ice_shared_prof *sp;
> +	bool share;
> +	int status;
> +
> +	if (!adapter)
> +		return ice_alloc_prof_id(hw, blk, prof_id);
> +
> +	share = (flags & ICE_PROF_SHARED) &&
> +		ice_prof_can_share(hw, blk, masks, symm);
> +
> +	guard(mutex)(&adapter->rss_prof_lock);

we ban guard()() in netdev, scoped_guard() is fine

> +
> +	sp = share ? ice_find_shared_prof(adapter, es, fvw) : NULL;
> +	if (sp) {
> +		status = ice_join_prof_id(hw, blk, sp->prof_id);
> +		if (!status) {
> +			sp->pfs |= BIT(hw->pf_id);
> +			hw->blk[blk].es.shared[sp->prof_id] = 1;
> +			*prof_id = sp->prof_id;
> +			return 0;
> +		}
> +
> +		ice_debug(hw, ICE_DBG_PKG, "Failed to join profile ID %u, allocating a new one: %d\n",
> +			  sp->prof_id, status);
> +		share = false;
> +	}
> +
> +	status = ice_alloc_prof_id(hw, blk, prof_id);
> +	if (status)
> +		return status;
> +
> +	/* Firmware hands out unused IDs only, an entry for the ID is a stale
> +	 * one, left from before a reset that cleared the IDs of all PFs.
> +	 */

should we clear those at reset?

> +	sp = ice_find_shared_prof_id(adapter, *prof_id);
> +	if (sp) {
> +		list_del(&sp->list);
> +		kfree(sp);
> +	}
> +
> +	if (!share)
> +		return 0;
> +
> +	/* without an entry the ID just stays private to the PF */

too many comments - general rule is to avoid (esp. in the AI era),
it's fine to comment about something that is not inferrable from the
code, like FW/HW behavior

> +	sp = kzalloc_obj(*sp);
> +	if (!sp)
> +		return 0;
> +
> +	memcpy(sp->es, es, fvw * sizeof(*es));
> +	sp->pfs = BIT(hw->pf_id);
> +	sp->prof_id = *prof_id;
> +	list_add(&sp->list, &adapter->rss_profs);
> +	hw->blk[blk].es.shared[*prof_id] = 1;
> +
> +	return 0;
> +}

