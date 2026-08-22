Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7C0C5DF97
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Aug 2026 04:18:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A52C580FA8;
	Sat, 22 Aug 2026 04:18:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SK9GkF9-jfjW; Sat, 22 Aug 2026 04:18:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787372310;
	bh=EsCXqKEwtefOJpwg7LGe3Xgyo+2+Hb5uDdJvHELI78Y=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NbNbbnUlgGMCEaw6AjxHOMX3Dv75vF22LptV36uvQRv0hrbWc+1VsJs5zeWBYt6ui
	 Ru7VXXiRi1jg5lgUMvKZ28KlIyau3+92Kkn9AT4vUbTIDAjI+RDSCbekPH+3q+bGNR
	 Kq2sbrpp7unXYrWCY8j9Ut6IB5BsWiD/bmflIwJm26mBZEW4k1pI9Buk6Hzthsj0ar
	 28AA2YJV3CBj0kNAcwqD6IWeDjt2w2cLeDe5qzAkGKl5UxBeZaZe67gK11keufY8Ro
	 IoVug6OocKy9dLu4PUJrRTCxPH1qNU7IHh9zFr4x7tYvIEyjTrO9X8IY0OGLePGGg6
	 YwbgmxY3KGDug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC69E80F8B;
	Sat, 22 Aug 2026 04:18:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E8E1476
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:18:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E905080F8B
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:18:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JVECkHj8EcYD for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Aug 2026 04:18:29 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kSmj5WH4
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD04F80F80
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787372309; x=1818908309;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EsCXqKEwtefOJpwg7LGe3Xgyo+2+Hb5uDdJvHELI78Y=;
 b=kSmj5WH4R8ImM8aeBiNlzTSLmxH4aBhpjS/vxHtIPBqs+56Of4hxVJFA
 bIH9tgefxrxgtxgPhrIn5rl5W4cWZjlEymwo/WWvY67Wko5wxar3Cro+W
 /WdXOlEwAtwg7Wxi5XuZmgxSTpfKSh/yhAoKJuzrCtS47ZPTcXeS5vkG7
 WsU3yekMCV5BDIv1w62nEdpRzAyDAsyco3C377+C96ujBGSVcryJdAGDh
 i8RVf4qf8V0CHcsgsBjsDm52bIY6FtiFhVhnqIXPG2p9gRsX0duy0Nsjx
 I9rBhrFTteJBq9lYAUt8oKDzsZojFnCcFIs57Xm7KOm7tl5cOPQbes96s g==;
X-CSE-ConnectionGUID: XIDUZoQHRhSwq6t+Rzakww==
X-CSE-MsgGUID: fjzX8knQS7W1zJ/KtM9Mbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="99074705"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="99074705"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 21:18:28 -0700
X-CSE-ConnectionGUID: UFqlSuZvRrii6scvtUQfdw==
X-CSE-MsgGUID: wG7ZyDw2QWWQJI3kiesVAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="296423633"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 21:18:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:18:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 21:18:27 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:18:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fodcec5HE4atR937MrdbH7d7Z6BwyuHGyFTx1r7AMewphxeORd9/6ZH+WLpgb7ptcS6r55zdMrILmW9gDsDmjxJ/fCDghvUNxF9LPnK8FYTB4N71XuCmYDgGMiAhh4lAXLtSsp2Ho8ubgzDUZlzQs9yPyTM4tP4eh7f4/7ROnYpztwxPGtjwgh4/PpXpgPKh4+6An+PD8u6S4E6IzUwdfz6QCxPHK8X9ebPhizVcTisG1Mjp3TPVY0fHthUiN2NOvzyMNHq4QVyoAK8WMqmeMf7uaTI/EuOz9Wui5C1UzA6aibENLh3A30TxcFuisdolOqiLWI6uifHYd7DFP/+p4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsCXqKEwtefOJpwg7LGe3Xgyo+2+Hb5uDdJvHELI78Y=;
 b=PASJ2UyftxOb/tPmJ77apqWOXc5fNWUSJ5xNh0kanEo/o9YrpeUX4GcErGU91JCh4n2cRXsd8+0YVFI+7sbGxH8i6QqfU9IwnKgNmp0/YzqtSsMVHnxn5HqGA7cbsqs4qv8YsrCr/P4v74iIMNoAFhiGmyg5NMBBhXviT+U64YfPo+MtIYmKVj6bJWnKE71WZJNUt7JCHav0nHaeUY1dXFwK18oAeNJp8HtjkpGi9UGjo525A8dzdEY4PrCfh7uheVF/L7KYORXP4rG2+aMgEeTqTg26Nf04cnUCQdM5YL3mPMRMKEI1wjhG67PcuN+bXoLCfjTf8xqzxuCsROHuTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA3PR11MB992400.namprd11.prod.outlook.com (2603:10b6:208:61e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 04:18:25 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0315.014; Sat, 22 Aug 2026
 04:18:25 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Korba, Przemyslaw"
 <przemyslaw.korba@intel.com>, "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 "Oros, Petr" <poros@redhat.com>, "Bross, Kevin" <kevin.bross@intel.com>,
 "Cavatur, Ranjit" <ranjit.cavatur@intel.com>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>
Subject: RE: [PATCH iwl-net 09/12] ice: keep Tx timestamp slots tracked until
 completion or timeout
Thread-Topic: [PATCH iwl-net 09/12] ice: keep Tx timestamp slots tracked until
 completion or timeout
Thread-Index: AQHdMctQ4CGk+WJjikeLMVnteykiObapds0A
Date: Sat, 22 Aug 2026 04:18:25 +0000
Message-ID: <LV1PR11MB87905258356F2CEF0E32862E90A22@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-9-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-9-9d0731eb4858@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA3PR11MB992400:EE_
x-ms-office365-filtering-correlation-id: 55d6b9bc-4647-415f-6f16-08df00046939
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|38070700021|4143699003|10067099003;
x-microsoft-antispam-message-info: ETicanOFPxUk6jUua0OacWr42zRzI18V+Nto2MWv1lLuFFG55fcyksu0khDHY1vhPNRtrpHwor+N6SMWqioAOHopGXxSa9EvwXe/OlKR6BzOMklMxrPxxTn89Favb0TViUQHdD6WKWEyLAmDdDbsRCO9YXgpdng6NyXGH6wcesv+l7urQc3HwxBT45X36k+rZkZWbvVUBme9PocIBVOMfWpnjUjb8DOkDwu/uohrNqqmhh6Z08jXm44xWgTT/9Lqe9GA+eNnlMmfu4d0dtudaaEPzSSlaS7oCAUvQzEt8q9nBfbzREnoiO1FTkFasVIhYcdYkfG4Ezk3SSrSlS0JHyO7GzZj/d/IigWBG5gXsMZDH1TqwjxzHRge4C+iQi+kwzolaCUTDyWuVcwy+ZGRyNpYEIxltYy9HDm3y6csM9Ni6q0zwXmZeZysw61L0UcNMrDE+6quWUjBQaHcZPsDnoaRjCtRUBiV8O3hZF/mphdNTueH8LO2AXDu6OH2yU7re4hbFBrvPYpbaQ1PZphymGJ3miEpfSRW0tTei18oBFEqHlsdmxNL4p7x5zJLO+hWSM5eso4lSZJGWVkTRdoPqtIUbz4WUV7mnUf3+qoGnurX2wJrB/2x52Y6RWycwTYI3mjM+r3RjplYzJ7E5d5ebmoWzyaKr2pBBZgt6d93LMflkZK5EJL51uVzagGARnM9b5G7euFXbg4MO5mMDQdLNY8lOBGIboo7u6AmiRVLwf4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkYxNzhUU1c3NmZncjgwU0hRY1N2Y0d2S0JRN3lTT3lpRHAvYmhqRGxvSHFW?=
 =?utf-8?B?MTI2TTc4RllUWUlzMVRuZ2R5SVlBTUlmWlNYRzBWWE9vQmRXLzN4NnJocFRm?=
 =?utf-8?B?MC9rUXErRWZwb3dNaE9tbVo5WkxubDIyUWtTNlRvdzhyRXJGUGJua3hzM1h6?=
 =?utf-8?B?anJVOGFFZy9LZFB5NTA5RSs4K09OZkJzK2dkWTFsVTlweGsvdmhWNGdDUS9Y?=
 =?utf-8?B?dXhOc09ZWnFWeUp5MlFKcXFXRHVqMnNDdVowUzhnUDlOQkk2dXBpbjVaaWdQ?=
 =?utf-8?B?NDAyVjZZOVB6VWNJVGZrVTRpcmw0Y3gzMk8yaDBTeW5wd3QwMk14enlpQ0Nu?=
 =?utf-8?B?djlVemJ1aTl6ZExVV2RVYlFpYjROMERmSUJwalNjaWlJS1RGOFFjOUlHOG8z?=
 =?utf-8?B?WnloSDJFK2VsQnlsRSsyYlkrYU9FVnFPQ1dQNy9oTFFoSVppUmEwSUlydkZ6?=
 =?utf-8?B?UnltSHhhNlplclg1T3F4WnJwMnQ5aFVTcHlvaDZXY0grbDIzTEFMdTdHd0lC?=
 =?utf-8?B?SFZzdFhGamZvQnIrMElTb1ZLdlBzUzRjK2YxNWkvTlFkeExERjBVVHAycG0y?=
 =?utf-8?B?aHpVZkpMYzJzbzR4Ry9MWXNmNlcrclpCYmh3YmVNZDhxRXRvTCtKemVtZytO?=
 =?utf-8?B?N3Q0UlEwS0xZYnZiM2dGZzJjLzJCekJPem5XbExVa3N3dm01MkpHZm50Znlr?=
 =?utf-8?B?UUVKMDBaTGdEaTJqSlI0eTZCd1dKMUZ1T251SXNRb2xCalEwRXJOVFdYSkN6?=
 =?utf-8?B?QjNQZ3NWT1R6aVVHbEFmUVUvdVhmaU1VVVlvWEcxYXZZZE5CRFZ4Z0dSczla?=
 =?utf-8?B?ZE13NXZnQWgramozVjJ4eFRKbU5CeTVOQ3ljZkVRb1BrNDBpT2UwMEU2aTNv?=
 =?utf-8?B?TGNydzJPaU9TWDdjY1BKKzJiTFpzRUJnSlAzd1JDOHFhd2pBRWdkeVkycXNF?=
 =?utf-8?B?SWNFMjNSZ0REdFRUYll0NnFkVjFjcTFRMG8rcGZWTmpiY0J1eXY2NU41c1Zj?=
 =?utf-8?B?NkFQMFk3ZmYzbXN5Q0VOYk9jNEo0aFBEL0gwMXh4U0NFcDkwd1Btc2I3WjB5?=
 =?utf-8?B?ZXZERE5TQTVuZDZTS3RNUTdYQjBCMDh1N0tkRno2a2ZwTEkzYWo2M1BCbFJO?=
 =?utf-8?B?cWtTcW5RTmR5R3Arc09hcE9QSVV1dDBjUlBsb3VJVy9xUzhZaTRGbGlKMjhY?=
 =?utf-8?B?M1VLV2Noc3hQY1hRY0l6ZWhKWDYycFlmZndXSXR1NWxOYXVIb08yM1dIK1Y3?=
 =?utf-8?B?bEVCb2ZvZU1zQnVBelUvVU5hOGJsYi9iY1VFY2M3TTkvRTU1MzVIaHphQUVB?=
 =?utf-8?B?bko4Nk44QkVvUWxiSlRQczhmZXpub1kzcTlzQnFnZm04WDVOendxMnpnaUd2?=
 =?utf-8?B?MTQxajlaWU10emo4L2FLMElhZ2RKR3Y1OERqZ1lXUXRBV0FxQksxcG10RVVN?=
 =?utf-8?B?NXRwSU5PTGErL2JPcmE3ZXdENWhQVXAvNkN4RHk4U2oxU1hvTG0zT3Q5VmJu?=
 =?utf-8?B?aXJvTStGa3FMSGJDdE1wK2FNRmZDWm9tcmoyV3BBd0prVkRFRUt3VjVtNEtm?=
 =?utf-8?B?ZmRoWHkwQjVWRXhWN1psVTZqU1MwdU1lM2Iwc2UvMG9EK09odGdBSWkzR0hi?=
 =?utf-8?B?cW4zMWd0MzR1Z0duRzRySHpBUG1hSENFZGs2L1VuOE9kZEVmMGlUYUNqQ3Nz?=
 =?utf-8?B?RmFyV0Z5RGwxUWU4cGZhZGorRGswb2hnL0p2MUJHbkJiZS9qNDQ1TkVGV2hx?=
 =?utf-8?B?b1NHVDlZVnlIMzVzNFpSWGlmY3RvVDVwYUY1dkYveGZRNkN0M3ZicFZ2VTgz?=
 =?utf-8?B?WWF0cS9FaTZadWowbTc0TGZhWHd5ek1XcWttVjR4OUU4VVdwbGZxS0dVdWly?=
 =?utf-8?B?RWVyOWVIZmtMTWs5MTlpSm5HWDI0UUhYQ0U3eUl4TmJ3Tmx6dUtnL1l4clEy?=
 =?utf-8?B?ek1NcDJqOTNDQkxua1J2Qmg5MjJPb0FFd1pFaTJIUzNiNGkvemEvd2dwbGdU?=
 =?utf-8?B?V0dqVUNVUHhEWFhPRVJiaU9Ca3dnQVY1Yy9KbEFLUEs0SHBvTWRnVW5RcnVq?=
 =?utf-8?B?QS9VcVRwU1diTGVhS1JZQVpmVWppRjU1alRQd2IxMlQyQ01KSVNZN1VycmhC?=
 =?utf-8?B?NjRYY1RJZDc0RjZySklxc1NMeXpiTDE0SG9BOHhxV1FlUHdhVmNEdldZSnVy?=
 =?utf-8?B?SHY2ZzVRVzM5WmxuRjROOFlJWFVCSnhYNEFIb05sVWQ4YU02bmdwMzIwbENs?=
 =?utf-8?B?Y2RhcGtDVHorMFR0ajZHRUdmYWdvSFVqVC9xZEN1bmtsdGRVTGdGT0tuTDRt?=
 =?utf-8?B?SkdiK3o3ckZUZmRtYmk5YS9GK3lDTWc5cDlzWmFFTTF6RlU3TlhTUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s/9SLfVUGuTdn+BtD4Lr+J/tS/+z15Eld4+UvUaFpqZuF/hWTkBiHLps8+h5OnMKm4w5BJJyRda5anfrrWXYl+GHxCiMuvum0W0vebZkVvFkVhffPNBj1PV3dTGv1mNKYPCa3t6kMW6SsUYrsD5d/kix4uYtFRZ0JYX48dChQfxF0SGOpAjSCJ1fRpczaY3YBKRtlstyYF8VP05VH/ih/ylKl3LymjuqOAonmr9CwDk0WgX4I3OuHHkAOwzB7iO++AmlsR5MN8q5SbZJnhxIghULCsBuhzZt3RsoyJJuMqGSSpEImrUH8qvIxY8jFLt57JO2nmVUVruCuKrIsM/jNg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d6b9bc-4647-415f-6f16-08df00046939
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2026 04:18:25.4840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2EebMYe6VZ3nqJJzWsSDcEyYVIJ98LonPcoPnuEFeUArUI1PVa1v2sjgby/CBRGDcKQ2d49EwtFW3480QPH5I4VNdSFDosfM8qpUw1XzHXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB992400
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLZWxsZXIsIEphY29iIEUgPGph
Y29iLmUua2VsbGVyQGludGVsLmNvbT4gDQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDIxLCAyMDI2
IDU6MTMgUE0NCj4gVG86IEludGVsIFdpcmVkIExBTiA8aW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9z
dW9zbC5vcmc+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBNYWNobmlrb3dza2ksIE1h
Y2llaiA8bWFjaWVqLm1hY2huaWtvd3NraUBpbnRlbC5jb20+OyBOZ3V5ZW4sIEFudGhvbnkgTCA8
YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBLb3JiYSwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xh
dy5rb3JiYUBpbnRlbC5jb20+OyBOaXRrYSwgR3J6ZWdvcnogPGdyemVnb3J6Lm5pdGthQGludGVs
LmNvbT47IE9yb3MsIFBldHIgPHBvcm9zQHJlZGhhdC5jb20+OyBOb3dsaW4sIEFsZXhhbmRlciA8
YWxleGFuZGVyLm5vd2xpbkBpbnRlbC5jb20+OyBCcm9zcywgS2V2aW4gPGtldmluLmJyb3NzQGlu
dGVsLmNvbT47IENhdmF0dXIsIFJhbmppdCA8cmFuaml0LmNhdmF0dXJAaW50ZWwuY29tPjsgS2Vs
bGVyLCBKYWNvYiBFIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+OyBNYWNobmlrb3dza2ksIE1h
Y2llaiA8bWFjaWVqLm1hY2huaWtvd3NraUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCBp
d2wtbmV0IDA5LzEyXSBpY2U6IGtlZXAgVHggdGltZXN0YW1wIHNsb3RzIHRyYWNrZWQgdW50aWwg
Y29tcGxldGlvbiBvciB0aW1lb3V0DQo+IA0KPiBGcm9tOiBQZXRyIE9yb3MgPHBvcm9zQHJlZGhh
dC5jb20+DQo+IA0KPiBXaGVuIHRoZSBsaW5rIGdvZXMgZG93biB0aGUgcHJvY2Vzc2luZyBsb29w
IGRyb3BzIGV2ZXJ5IG91dHN0YW5kaW5nIHJlcXVlc3QsIGFuZCBhIHJlcXVlc3Qgd2hvc2UgdGlt
ZXN0YW1wIGlzIG5vdCByZWFkeSB5ZXQgaXMgZnJlZWQgd2l0aG91dCByZWFkaW5nIHRoZSBQSFkg
c2xvdC4gVGhlIGhhcmR3YXJlIGNvbXBsZXRlcyB0aGUgY2FwdHVyZSBhIG1vbWVudCBsYXRlciwg
dGhlIG9ycGhhbmVkIHJlYWR5IGJpdCBibG9ja3MgdGhlIHBvcnQgaW50ZXJydXB0IHVudGlsIHRo
ZSBuZXh0IGxpbmstdXAgc3dlZXAsIGFuZCB0aGUgZnJlZWQgaW5kZXggY2FuIG1lYW53aGlsZSBi
ZSByZXVzZWQgYnkgYSBuZXcgcmVxdWVzdCB3aG9zZSBzbG90IHRoZSBoYXJkd2FyZSB0aGVuIG92
ZXJ3cml0ZXMuIENhcHR1cmVkIG9uID4gYSByZXByb2R1Y2VyIGFzIHJlYWR5IGJpdHMgd2l0aCBu
byBpbl91c2Ugb3duZXIgcmlnaHQgYWZ0ZXIgYSBsaW5rIGJvdW5jZS4NCj4gDQo+IFN0b3AgZHJv
cHBpbmcgb24gbGluayBkb3duLiBNYXJrIHRoZSBvdXRzdGFuZGluZyByZXF1ZXN0cyBzdGFsZSBz
byB0aGVpciBjb21wbGV0aW9ucyBhcmUgcmVhZCBhbmQgZGlzY2FyZGVkLCByZWplY3QgbmV3IHJl
cXVlc3RzIHdoaWxlIHRoZSBsaW5rIGlzIGRvd24sIGFuZCBmcmVlIGEgbm90IHlldCByZWFkeSBz
bG90IG9ubHkgYWZ0ZXIgdGhlIHR3byBzZWNvbmQgdGltZW91dC4gVGhpcyB3YXkgYW4gaW5kZXgg
aXMgbmV2ZXIgcmV1c2VkIHdoaWxlIHRoZSBoYXJkd2FyZSBjYW4gc3RpbGwgd3JpdGUgaXQgYW5k
IG5ldmVyIGxlZnQgdW50cmFja2VkIHdoaWxlIGEgY29tcGxldGlvbiBjYW4gc3RpbGwgYXJyaXZl
Lg0KPiANCj4gVG8gYXZvaWQgYW4gSVJRIHN0b3JtIGluIHRoZSBldmVudCB0aGF0IHdlIHJlYWxs
eSBkbyBoYXZlIGEgc3RhbGUgcGFja2V0IHRoYXQgaXMgbm90IHRpbWVzdGFtcGVkLCBtb2RpZnkg
aWNlX3B0cF90eF90c3RhbXBzX3BlbmRpbmcoKSB0byBpZ25vcmUgc3RhbGUgdGltZXN0YW1wcyB3
aGVuIGNoZWNraW5nIGZvciB3aGV0aGVyIHRvIHJlLWFybSB0aGUgSVJRIGZyb20gdGhlIG1pc2Nl
bGxhbmVvdXMgdGhyZWFkIGZ1bmN0aW9uLiBJbnN0ZWFkLCBvbmx5IGNoZWNrIGZvciBzdGFsZSBw
YWNrZXRzIGluIHRoZSBhdXhpbGlhcnkgd29yayB0aHJlYWQuIFRoaXMgd2F5IHdlIGRvIG5vdCBj
aGVjayBpbiBhIHRpZ2h0IGxvb3Agd2FpdGluZyBmb3IgYSB0aW1lc3RhbXAgdGhhdCBtYXkgbmV2
ZXIgY29tZS4NCj4gDQo+IFRoaXMgZWZmZWN0aXZlbHkgcmV2ZXJ0cyBjb21taXQgZmNjMmNlZjM3
ZmVkICgiaWNlL3B0cDogZml4IHRoZSBQVFAgd29ya2VyIHJldHJ5aW5nIGluZGVmaW5pdGVseSBp
ZiB0aGUgbGluayB3ZW50IGRvd24iKSwgd2hpY2ggdHJpZWQgdG8gcmVsZWFzZSBhbiBpbmRleCBi
ZWZvcmUgdGhpcyAyIHNlY29uZCB3YWl0IHBlcmlvZC4NCj4gDQo+IEZpeGVzOiBmY2MyY2VmMzdm
ZWQgKCJpY2UvcHRwOiBmaXggdGhlIFBUUCB3b3JrZXIgcmV0cnlpbmcgaW5kZWZpbml0ZWx5IGlm
IHRoZSBsaW5rIHdlbnQgZG93biIpDQo+IFN1Z2dlc3RlZC1ieTogSmFjb2IgS2VsbGVyIDxqYWNv
Yi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFBldHIgT3JvcyA8cG9yb3NA
cmVkaGF0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxl
ckBpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBNYWNpZWsgTWFjaG5pa293c2tpIDxtYWNpZWou
bWFjaG5pa293c2tpQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pY2UvaWNlX3B0cC5oICB8ICA4ICsrKystLSAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50
ZWwvaWNlL2ljZV9tYWluLmMgfCAgMiArLSAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNl
L2ljZV9wdHAuYyAgfCA0NCArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tDQo+ICAzIGZp
bGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQ0KDQpUZXN0ZWQt
Ynk6IEFsZXhhbmRlciBOb3dsaW4gPGFsZXhhbmRlci5ub3dsaW5AaW50ZWwuY29tPg0K
