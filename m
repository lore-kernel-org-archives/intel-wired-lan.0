Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D367C5AC67
	for <intel-wired-lan@archiver.kernel.org>; Tue, 11 Aug 2026 09:22:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03998607B5;
	Tue, 11 Aug 2026 09:22:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CNrpW9nIJA4K; Tue, 11 Aug 2026 09:22:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 27FEB605FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786440178;
	bh=xhrmhmKQnBiMqyuZBIrkTcD39j+vBf27BgA5PWPxugQ=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FBnzwbYojBEO8p8GmR8621enafgNR7P7i+WyeCSqFPbuPPyhcz87OXdG80tCLFAFh
	 hmM07jgdc38GIeNRxrXQq/CFSnSpI1P1rN/F8zjM4iJKZ25ABYP3xtXM98JnV0v1mb
	 nRlCh3DQTd8MDohk3+45un6OeV5s4+8E4K03KNGUDeS+VYAAkSwZv0S1QkBpXOYmEo
	 TDyAZ+f7MlZXzqPmplGnxa5RKc6l/1euDwuNyjHOyF/xE7L+jAIGNDi/wxBzFqt9hk
	 Pe8Ie5OR8+Py8PSt5DFVnNhOvnLGaKT6q8qVp2aMlxjXWYZYPjrVWVzV5wYaHVxn8q
	 EVCPR11xV19gQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27FEB605FF;
	Tue, 11 Aug 2026 09:22:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id ACA1028A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 09:22:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9282680EE1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 09:22:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IhM5oOeGYXi9 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 11 Aug 2026 09:22:56 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=jedrzej.jagielski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6A00180EBE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A00180EBE
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6A00180EBE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 09:22:55 +0000 (UTC)
X-CSE-ConnectionGUID: mQ5llgvSTuOoo5wEKcHvyQ==
X-CSE-MsgGUID: rzrkikqdQxiavlO5tJjCSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="74499157"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="74499157"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 02:22:55 -0700
X-CSE-ConnectionGUID: M95dA21MTdGII2Z90eGi3Q==
X-CSE-MsgGUID: C+kxEGfWQ/u0dKEZ4Kb8jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="261527265"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 02:22:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 02:22:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 02:22:54 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.43) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 02:22:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9XyqE57YqKbkzNe2hB/RIlC+bdk0cOYVOZX2EICgadxxkVAbM5lkSPJL8OdN3jOgU55gsFr0Ee3EaaDIqfqswgMUb2diqFk+4wMmdUqyBNdnTz5+GtsGM5CwBKvI5hma/fpj2zSP/Zu+dUGpwXqp4+2exkZczIZN8myamv/LsnY6k55vgYbXWBhreyPljJ2Pt/QJrfBUYW7chja8uVoKCYhZREt26xD5dPwg76IkoG67JfPMsuW6PVtvJQtx+vAH9AZRnCnrF6U8RBPxY/t0GmrNw2CXlj2w9RGdU88osBH0L+MMPXfWqRzZMqS96eAAqCSa8/txzMVRGCSDtMcRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhrmhmKQnBiMqyuZBIrkTcD39j+vBf27BgA5PWPxugQ=;
 b=H1L7PyMeR0jMuCOcyPbOpwERSu4uqBFvBMN7c3VnjeHG+Q7FWVgGyk/bjEv23+qvGFvgYdYCoDtQdC2Ei4nZFVDA8ofHEHCAFdQLA0O1TpsymFWXZXcBQXCLtw4GjjweaypSRelvJd1eZ4qJ6zW7MyjtYnAR1y77rr8mS9eODFkGi4DMcIUZDLQJ1JnTnKAdNwjsGuLawqbun9tFCbTO36zYFQruWC49b1iKkatW0nR+kpcvhUM1WGH2pDdqzEvstL2aQqzlbML5nV6GM9CLS79pAjFp1A2ER/ZmEUwpv5d4597RjWczZKLHOVyy+OoXcrERQM+wwCkvWQZ+Vmkvrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by PH7PR11MB8012.namprd11.prod.outlook.com (2603:10b6:510:24b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 09:22:43 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 09:22:43 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: "Hadi Salim, Jamal" <jhs@mojatatu.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>,
 "edumazet@google.com" <edumazet@google.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Marcin Szycik <marcin.szycik@linux.intel.com>
Thread-Topic: [PATCH net v1] net/sched: cls_u32: feed u32_replace_hw_knode()
 with correct set of flags
Thread-Index: AQHdJlbew182irbzCU2Dp6CwznRq97aXVFIAgAFCp7A=
Date: Tue, 11 Aug 2026 09:22:43 +0000
Message-ID: <PH0PR11MB590230F7DFE8FE5FA6C16ADAF0DD2@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260807100356.1083774-1-jedrzej.jagielski@intel.com>
 <CAM0EoM=L4LBAnyxf+NG1D_dY2nre8fKgVxoycXK=sY-9Ruc9+w@mail.gmail.com>
In-Reply-To: <CAM0EoM=L4LBAnyxf+NG1D_dY2nre8fKgVxoycXK=sY-9Ruc9+w@mail.gmail.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|PH7PR11MB8012:EE_
x-ms-office365-filtering-correlation-id: f32bc0cd-4991-4718-aa5c-08def78a1943
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|11063799006|4143699003|3023799007|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Op6xgxs2NFyRW24s+/zf2XOzUxi0vTC5YoUHg4zpS0zlBatImvP8AhHqkGP56ld44t9CPDoQYZzBnE7YAhg9Nf8p3e/CxyeNv+999N+Yn8X0FIWhh/8mCvYy7fJQDqkmR4cmfHcUG/hXMEydDZEARqIXXib3olmKDd9GC2UPsvcOsnS8dSnHXk8Nm39VInz2/bnKBeu8m60dMv1CzNGCAvsK9E+nX5Yq21jn5aWyekhoPVrlVhpIHi4mcccU2leFsmnsYwDKOdgnHjMnjwB66DL5ZJqVpPfFQvLGFKilg+s6Fmbe+VGPMHxzBAc2MmjV7MKfzYdj5IOnQWwcfI/ir5B2nUJ+8FZDSG6+fdkg+FiNyUQpW3sw1o9btfeYIS4hf+/KPE9b02mFQ/m7G23xfReHGqN70Bp0AzBe19erx5dOERQu5HWx6Yy+jBV0/EHK72cWxkvJXaQs+LXoKA7nfHdJ5egYUp0Qa3Kl4lKO3Vvfe/FSd8qQR9aFeR1zjZ6bHk2tF4QDTEsSEeY4P2pgpjxgiTJOA5r8fnHPr4HvROaYEAQx/y74oOXo24W26mpAi7olqWr3tWli3EMs0cyXs9FBC647lbZKk3DP/BTg0l7ObaCCW54VRoD7vrAj5vt5XfvIeXaXCYUC1R6gRXuzpuhxDhbi+xSRhOH/DNN95p4ZYdaRwIU/28XZd1IesR4xkhZ/GKg1k2BVJxJShx+CUonzf4fXfp1iPFLWx7AqEm4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5902.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(11063799006)(4143699003)(3023799007)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wm9XdFZVeENmSUw0TGpSWWphQ0ozN2txWFY2SzJ3enV0ZUhjQUYxU1N4MkM1?=
 =?utf-8?B?MWFDdkprYUJWQTg2SzhINFBoMlBJYkkrOUV2SXdScytKRDlWM0ZqMHBaUnhB?=
 =?utf-8?B?VFh5MHpKM0lmczFVdStValFsdmJmaWp5ZHlGaUIzTTFHdXhReUs1TktkV0NX?=
 =?utf-8?B?OUp1UExFRmU3M08vYXFCSVNBbE42TXZpNm5vTW4yT0pIcE1QQkpUVXNXNEVM?=
 =?utf-8?B?RDVRSDhnSlBlcG8wTEZNTWxTdGFrbE14d0xPSXprSXc5cEZHQlI1VytJTTdl?=
 =?utf-8?B?V3JoTHdaRWxDZFJlWGJWWEl1Vy92OVFMbmJianhxVm1ITHBkV3IveDQxbHVw?=
 =?utf-8?B?RHM3RS90VjcxeDVBWFo1QVEyZHM3ck9BZEpZYitMeHgwTnNLTGxuVDdPOHdq?=
 =?utf-8?B?bnJMQmhLUmdCcDEzNUhGTCtsNy9La3RiTytlcU9ybmhyVFc1eGl3ajdsajI4?=
 =?utf-8?B?ck5DWVVETUg5bXNqVXJ1TmpucXRyRGdjWFF0WWYrY0NBTVUvOW1lQ3g3UmN3?=
 =?utf-8?B?c1pmNzVyUHgvM2ZyU1dIdVpESjdRaFcvbFJiM1Bod0xYc2tubVFUVEFhcFRu?=
 =?utf-8?B?Kzh3d2libXlRcmZ0Vk81L3Fub1lRNloxeGZvRzZ6MFptRE5CaVE2azZ0OXpq?=
 =?utf-8?B?Y3NGTjROc0liL0ppMDQwOUdBOHEzUVN1SVp3QjJ2VHNHS0NBb2orS25IK1Rn?=
 =?utf-8?B?MXFodGxvRHJGR1llcG5oUmNBU3pPVDJzSjh5ZTFrMFN5bURRQksvOTB4K3pN?=
 =?utf-8?B?eFBwWEF2UVFWWVBIeEFFMWZ3QkRHUWwyOXM0bXVPbEZpT09ZVWRWeWt2Y0Vi?=
 =?utf-8?B?VTROZm5hRTNLRlc5SkdBTXl2SVRNMnNMc2tqOU5yTkx0aDRRNmVGSmtGUUVw?=
 =?utf-8?B?Y2tuQ21TaFNOd3hGWVFkQTNheFFRWllMOU9MRG9Eck1VWWFpNjhiU2lKRGIw?=
 =?utf-8?B?WWw1RkRpSVF6cnR1SkdURVFlZ0NLTHNoUG5OcWNGN0x1VmtYTTFhR3ZOL0dD?=
 =?utf-8?B?aE4vakhMemJoR010SVRQeFFMdjlGWjRVT29WdkhyV21neWZtbmJZODM4ZmI4?=
 =?utf-8?B?c0VKai81ejBTV0QrUTNrNGNjK3F5dXRlVW9lajlyekY1VFBVWHNodzhZY0Nn?=
 =?utf-8?B?Y29yR1dnMkMzQS83ZnlXbTlPdk8yT1VlZ1FNdjk4V2FpeWFkK3RiU0s4OTV6?=
 =?utf-8?B?Y0tJS0NHczY2Y1VCSXdQalV3SHF4VkNHdEZOcis0WDJMdVVmdWlKR2pMSk11?=
 =?utf-8?B?NkhxK1pnUVdDd2Z1NllYTWorcUpHUXhESXFSNGNRQmtuU0NnbjhWdjZxK2dU?=
 =?utf-8?B?cVNyQnJRSlZPTUNpaUpsdzVadkJTOWRrbHI0MmR0RkdXdzVyQmk5QmVDMm1P?=
 =?utf-8?B?WEljQ08xVm5DYjNxWWowdmI4ZEFxVGRsQ0szRHdpQTV2Zmo5UjUvRFhwRVJL?=
 =?utf-8?B?bDlqcVY5allURFVUY0VxWFkyMkhMR2J6TFJ5c3EzaUswNTlUbFc5czRkZit1?=
 =?utf-8?B?clpEUkxIa2ZYQ1pzTEFPeU92c0VuMStWaDc5ZUhJVVdDRGpZY0RPSTlJbVkw?=
 =?utf-8?B?ZmxLTmhRWWlJMUNHRWw1NDAwY0R3N04xNzgwem1NT29SVkFjQzRCM0dIdjNw?=
 =?utf-8?B?RlE1dDI2UzZUd0s2dmhQdjMzK1hXTiswME9TdnpFV2lRTnIxQjloOU8wZUNY?=
 =?utf-8?B?bjNQcjFqZXVrV0Q4bTVtU0tQNjZrV2VvZFNXQ2ovNGkyUG9mZVBmS2RDQkY5?=
 =?utf-8?B?bkd4WGdRVzNEd01jRERTR3dIUVhhL3JnVE9JMm5GTU5QR0luNElubTNDU3ZM?=
 =?utf-8?B?a0IzY3B4ZDMzeHFWK1NzdEFRODJoNGpQL1VSUTY0Zm5mZDRMenJscjRVbTAy?=
 =?utf-8?B?RWs1TnIwc1F1YVZoMFJNb0V5SkNoaGh2dkFlRldxN3U0YTNzRUJxNGZaS1Rk?=
 =?utf-8?B?MWhHb1ZGeVUyZGxTR2QvTlB5YzRLeE1CdDJMSlQ5MkJSaUkrd2xlWkdkOHVK?=
 =?utf-8?B?cnZnK29PSy9wbmhEaUFLZTJ2eFdxbElvbnhXT25VQUkzaEM1ejBBeWZQN3hn?=
 =?utf-8?B?VUNIekpYNmp1WUxoZzRhMjhKV3o4bDhJUnB3RDVNRkE3dGZ0MDFqZTNFQWpo?=
 =?utf-8?B?djNTNys5TjZrUGRqbFJKbDQrQ2FPZlR4dlJuVjdoZTkvL0IzanJlY0hkcUMr?=
 =?utf-8?B?TWVSQWNiRVo2QUNNSkxiazJybEhReG9UNmRiTVROUUdnblo1enBxeTdMUmh6?=
 =?utf-8?B?K3I4cmdUdlFNRmNJZ2NLRW9pSm9mank5OEx3aFpoaVRKSUJQTDdxK3l5Wm9F?=
 =?utf-8?B?NzBKR1ljaysxU2xTMFFNLzVVNUx0L3lVRUlzSklJSjh1RXk5VldCQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qk3QuIkmu2UFekBKJjomyf9jRQurUMKCMKnpq0vaongT8YJqd8a1+YruNGJ2w9ljo2T5TlrKENWrBNJIaqa1CtfaU8mzEv2q6eJ/w2v6xCuRL2M5MT41NLrD4U3o0+ymdq7b/ddmnZjvgPFgUsMCNMuV7o9Pn7mFqOfb/NEzstnv+nPWvv1xJZgvALS7lJ7G2WYXzQrd5HGTKB//LxAhRdzDoqTBAQJGfLcP0aMp9dNhlKjBfMgXJNvJAfYHY3nl6BmKE4mMj3pDw4tI+b7U94OgptasJduHviv1af3bQYHcejDzO5/X4677cDgd3EaId7kOBpSlYq2pSojcnS0EMA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32bc0cd-4991-4718-aa5c-08def78a1943
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 09:22:43.4004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eA2uJ5WDlJVrz9FN45pwTmDF6grbn3suS4cJ+DVTiOjg8lwZV31qr0c3jgzRqvW0AG6a978Q4JaWdg+xnE3sU68ZEpgpQHSr3q1+T9sZY8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8012
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786440176; x=1817976176;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xhrmhmKQnBiMqyuZBIrkTcD39j+vBf27BgA5PWPxugQ=;
 b=FajpfZ5YHKc4rFcyy54F0WU91o64BQMWMkl5UHYvZb725LfNnzqhd6BU
 6PBf/h66ETuB9x4IzkghchcusJclKf9/AuA6+PeugQN2zXWLF4TSCTz1A
 A+WS8dRi6PAW1HrXTeHrchk1jAYZvZEKgiezPSygvAfRzzej4eUtGpzaT
 hcz8deM8YG0iqpD0zwLupcpHDW78XvZWcfJNFO1qwWZHIk6N34b3VPs51
 Z67TMvjxJEJHEANbd+HTMvZGN7TdU/NnY7KbATYMd3aJyvOz+plizsuGA
 Eq9jN1DrLubqcwEPk3IQfcJAWZB2nN0SeP1yWIyJaqMH78sSIvUKss+4t
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FajpfZ5Y
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH net v1] net/sched: cls_u32: feed
 u32_replace_hw_knode() with correct set of flags
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

RnJvbTogSmFtYWwgSGFkaSBTYWxpbSA8amhzQG1vamF0YXR1LmNvbT4gDQpTZW50OiBNb25kYXks
IEF1Z3VzdCAxMCwgMjAyNiA0OjAwIFBNDQoNCj5IaSwNCj4NCj5PbiBGcmksIEF1ZyA3LCAyMDI2
IGF0IDY6MjPigK9BTSBKZWRyemVqIEphZ2llbHNraQ0KPjxqZWRyemVqLmphZ2llbHNraUBpbnRl
bC5jb20+IHdyb3RlOg0KPj4NCj4+IEZpeCB1MzJfY2hhbmdlKCkgdG8gcGFzcyBwcm9wZXIgdmFy
aWFibGUgdG8gdTMyX3JlcGxhY2VfaHdfa25vZGUoKS4NCj4+DQo+PiBXaGVuIHRyeWluZyB0byBv
ZmZsb2FkIHUzMiBjbWQgYnkgYWRkaW5nIHNraXBfc3cgYXR0cmlidXRlcyBpdCBnZXRzDQo+PiBp
Z25vcmVkIGFuZCBpdCBjYW5ub3QgYmUgY29ycmVjdGx5IHByb2Nlc3NlZCBieSBIVyBhbmQgdGNf
Y2xzX3UzMl9vZmZsb2FkDQo+PiBzdHJ1Y3Qgd2hpY2ggaXMgdGhlbiBwYXNzZWQgdG8gZHJpdmVy
IGxhY2tzIHNraXBfc3cgdmFyIGVuYWJsZWQuDQo+Pg0KPj4gdTMyX3JlcGxhY2VfaHdfa25vZGUg
aXMgZmVkIHdpdGggdGhlIFRDQV9BQ1RfKiBmbGFncyAoYml0cyAxNispDQo+PiBpbnN0ZWFkIG9m
IFRDQV9DTFNfKiBmbGFncyAoYml0cyAwLTQpIHdoaWNoIGFjdHVhbGx5IHN0b3JlcyB0aGUgZmxh
Z3MNCj4+IHBhcnNlZCBieSB0Yywgc28gdGNfc2tpcF9zdygpIGFsd2F5cyByZXR1cm5zIGZhbHNl
LiBUaGlzIGxlYWRzIHRvDQo+PiBpZ25vcmluZyBzb21lIG9mIHRoZSBhdHRpYnV0ZXMgd2hpY2gg
YXJlIG1lYW50IHRvIGJlIGNvbmZpZ3VyZWQgb24gZmlsdGVyDQo+PiBzZXR1cC4NCj4+DQo+PiBO
b25lIG9mIHRoZSBUQ0FfQUNUX0ZMQUdTXyogaXMgYWN0dWFsbHkgdXNlZCB3aXRoaW4NCj4+IHUz
Ml9yZXBsYWNlX2h3X2tub2RlKCksIHNvIHRoZXJlIGlzIG5vIHBvaW50IGluIHBhc3NpbmcgdGhl
bS4NCj4+DQo+PiBMb29rcyBsaWtlIGNvbW1pdCA2OTUxNzZiZmU1ZGUgKCJuZXRfc2NoZWQ6IHJl
ZmFjdG9yIFRDIGFjdGlvbiBpbml0IEFQSSIpDQo+PiBzaGFkb3dlZCB0aGUgbG9jYWwgZmxhZ3Mg
dmFyaWFibGUgd2hpY2ggdXNlZCB0byBiZSBzZXQgd2l0aA0KPj4gbmxhX2dldF91MzIodGJbVENB
X1UzMl9GTEFHU10pIHdpdGggdGhlIGZsYWdzIGFzIHRoZSBuZXcgZnVuY3Rpb24gcGFyYW0NCj4+
IHdoaWxlIG5vdCByZXBsYWNpbmcgZm9yIG5vbmUgb2YgdGhlIHUzMl9yZXBsYWNlX2h3X2tub2Rl
KCkgY2FsbHMuDQo+Pg0KPg0KDQpIaSBKYW1hbA0KDQo+VGhlIHNhc2hpa28gcmV2aWV3cyBsb29r
IGxlZ2l0IHRvIG1lLiBNYWlubHk6IHlvdXIgY2hhbmdlIG1ha2VzDQo+dTMyX3JlcGxhY2VfaHdf
a25vZGUoKSBhYmxlIHRvIGZhaWwgZm9yIHRoZSBmaXJzdCB0aW1lICh3aXRoIHRoZQ0KPmFjdGlv
biBmbGFncyBpdCBhbHdheXMgcmV0dXJuZWQgMCksIHdoaWNoIHR1cm5zIHRocmVlIHByZXZpb3Vz
bHktZGVhZA0KPmVycm9yIHBhdGhzIGludG8gcmVhY2hhYmxlIGJ1Z3MuDQoNCm9oaCBub3cgaSBz
ZWUgdGNfc2V0dXBfY2JfYWRkKCkgaW5kZWVkIHdvbid0IG1ha2UgaXQgZmFpbCBhcyBhbHdheXMN
CnJldHVybnMgPj0gMA0KcHJvYmFibHkgd291bGQgYmUgYWxzbyB3b3J0aCB0byBjbGVhbiBpdCBp
biBvcmRlciB0byBub3QgY29uZnVzZSBwZW9wbGUsDQp3ZHV0Pw0KDQo+U28gSU1PLCB0aGlzIG5l
ZWRzIGEgdjIuDQoNCldpbGwgYmUgcHJlcGFyZWQsIHN1cmUNCg0KVGhhbmtzIGZvciB0aGUgc3Vn
Z2VzdGlvbnMhDQoNCj5TdWdnZXN0aW9ucyBmb3IgdjIgZnJvbSB0aGUgc2FzaGlza29zIChJIHR5
cGljYWxseSBzdWNrIGF0IHRoZXNlDQo+c3VtbWFyaWVzLCBzbyBtYXkgbWlzcyBzb21ldGhpbmcp
Og0KPi0gUmVsZWFzZSBuLT5odF9kb3duIG9uIHRoZSBjcmVhdGUtcGF0aCBlcnJvciAoZS5nLiBk
cm9wIHRoZSByZWZlcmVuY2UNCj5leHBsaWNpdGx5IGJlZm9yZSBrZnJlZShuKSwgb3IgcmV1c2Ug
X191MzJfZGVzdHJveV9rZXkoKSkuDQo+LSBDb25zaWRlciBzd2l0Y2hpbmcgdGhlIHVwZGF0ZSBw
YXRoIHRvIHRjX3NldHVwX2NiX3JlcGxhY2UoKSAoYXMNCj5jbHNfYnBmJ3MgY2xzX2JwZl9vZmZs
b2FkX2NtZCBkb2VzKSBzbyBvbGQvbmV3IGZsYWdzIGFuZCBpbl9od19jb3VudA0KPmFyZSBhY2Nv
dW50ZWQgZm9yIGNvcnJlY3RseSwgYW5kIHRoZSBvbGQgcnVsZSBpcyByZS1pbnN0YWxsZWQgb24N
Cj5mYWlsdXJlLg0KPi0gTWVudGlvbiBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgdGhhdCBza2lwX3N3
IGFkZC9yZXBsYWNlIGNvbW1hbmRzIHRoYXQNCj51c2VkIHRvIHN1Y2NlZWQgKGFuZCB3ZXJlIHNp
bGVudGx5IHNraXBwZWQgYnkgdTMyX2NsYXNzaWZ5KCkpIHdpbGwgbm93DQo+cmV0dXJuIC1FT1BO
T1RTVVBQIG9yIC1FSU5WQUwgd2hlbiB0aGUgYmxvY2svZHJpdmVyIGNhbm5vdCBvZmZsb2FkLg0K
Pg0KPkFsc28gc2VlbXMgd29ydGggQ2M6IHN0YWJsZSBiYWNrcG9ydC4NCg0KY2MgdGFnIGFscmVh
ZHkgdGhlcmUsIGlzbid0IGl0PyBvciBkbyBpIG5lZWQgdG8gZG8gYW55IGV4dHJhIHN0ZXA/DQoN
CnJlZ2FyZHMsDQpqZWRyZWsNCg0KPg0KPmNoZWVycywNCj5qYW1hbA0KPg0KPg0KPg0KPg0KPj4g
Rml4ZXM6IDY5NTE3NmJmZTVkZSAoIm5ldF9zY2hlZDogcmVmYWN0b3IgVEMgYWN0aW9uIGluaXQg
QVBJIikNCj4+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NCj4+IFJldmlld2VkLWJ5OiBQ
cnplbWVrIEtpdHN6ZWwgPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+DQo+PiBSZXZpZXdl
ZC1ieTogTWFyY2luIFN6eWNpayA8bWFyY2luLnN6eWNpa0BsaW51eC5pbnRlbC5jb20+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBKZWRyemVqIEphZ2llbHNraSA8amVkcnplai5qYWdpZWxza2lAaW50ZWwu
Y29tPg0K
