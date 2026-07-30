Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E26CC55167
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Jul 2026 21:08:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F8CF60608;
	Thu, 30 Jul 2026 21:08:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V7GIB3fZTQJg; Thu, 30 Jul 2026 21:08:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 48D82606A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785445730;
	bh=q4zaIKkluQfYEWERQQJo0dWiORQ+u+wy1nxb+bCCs50=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZKb/JiIwqzVu8hoZrLeqUDKrBI190Obsq711SeqEfBiKK+cY9A+EYw7Zfr0/7FmX8
	 oDcUO6EqEjT/5UKPYLM89xVjT8lQvTwIVoI9yL6UqEFmqnGlsIOgFPF7yUPYG7lkrN
	 sZv2Sq/6W5BzrBYqfTVCeMzk85p4N5E7Vzy68Xw3kIGUVg/aSUKIoZFuHgcSJGN2Zx
	 yachEzWT9vtyc91dshbZKfkktAjGyriFoVSjBI+epfdc6AhEojZfNaGV2GoEFSqqE3
	 RYkWuoNbA1Z8vr5P5q8+GqSPSPu6JpjXMO6fzEMBY0K26C9L6bcOPpWGEI/l5qNYM6
	 Nq3WHaUOCvrow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48D82606A7;
	Thu, 30 Jul 2026 21:08:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B95FB2CE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 21:08:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AA57C40DA2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 21:08:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IyBBheT7pAHk for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Jul 2026 21:08:48 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C734A40DA4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C734A40DA4
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C734A40DA4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 21:08:47 +0000 (UTC)
X-CSE-ConnectionGUID: JQmhfovDRuGOx82BMF2lrg==
X-CSE-MsgGUID: 9vZ/HUepQvC3MiHAVZqb7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="89964114"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; d="scan'208";a="89964114"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 14:08:47 -0700
X-CSE-ConnectionGUID: 3rB7ZNGeRI2cX9U+gfXirQ==
X-CSE-MsgGUID: bunxNP4+TWOLKOPRF6XfJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; d="scan'208";a="262347261"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 14:08:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 14:08:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 14:08:45 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.34) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 14:08:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zB4CRA/DTeoVZQDJWmPBVG0Qp81mX25iZF88+lbH+1HDYDEsbeJNWgP/smNuxOik5J1ySGlU3iecwbOhyg6fWO0YWEBONrieSnoi+SOh+vQPqG0fUFT6j9JAMFAQc9ARjPdBkDv5CjfFoZOAwPyrwWzG+6rA19x+W4tLrNivVYyWHQyld4Q8TXoB0FOEB0Qzt+aPOtqMhQqyqyVYAGfOCgm525h0Ake2KS/RGAxQAB7yDMMvL4EFDIdq7WROGvBjbLhamZ2b/C+5UTqXJd/S36Of7pEYoH4TayVs1DCH2+q06RFANd7fbBZ4gvFuGwGz+cqV7/P+BZCtq+jBVErayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4zaIKkluQfYEWERQQJo0dWiORQ+u+wy1nxb+bCCs50=;
 b=S9tHLZNlJ6J30oqtbtwRkC+mMxBZ/KVGZjgxUe14KS74HmqrcE2DnGM+SSc4ygyD4EVAv82HqA8TthvjTbKHaJx1nWdTrxb1Jd4GNY7cVO14CVUPUmg8o4XMlcllsoHwwVouGrevVQLGDfaPe7Ys1k+samE3TAKUQEwFvoeHuydT3G62LAr86Zhl2kg7lvVopQH4IsjunM5cc50a95j7vZSu5FdF/aU2VEWZf3lno9jBUW2k8MQqW8Zsblf/vePLJap/AAHuyAj9NK0BYBWopuGDspvHNcMn8gTNcJZ//KdvNIYL9TNeV6pYnJOn3darFjntjtO329S/KsZeeQCS+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN6PR11MB8241.namprd11.prod.outlook.com (2603:10b6:208:473::9)
 by SJ0PR11MB5085.namprd11.prod.outlook.com (2603:10b6:a03:2db::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 21:08:34 +0000
Received: from MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46]) by MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46%7]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 21:08:34 +0000
Message-ID: <7d4b3b11-e303-4e02-aed9-802e76381836@intel.com>
Date: Thu, 30 Jul 2026 14:08:28 -0700
User-Agent: Mozilla Thunderbird
To: Andrew Lunn <andrew@lunn.ch>, "Jagielski, Jedrzej"
 <jedrzej.jagielski@intel.com>
CC: Seongjun Hong <hsj0512@snu.ac.kr>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260729080100.2057448-1-hsj0512@snu.ac.kr>
 <PH0PR11MB59025D22F4D0A00D5A8671ACF0CA2@PH0PR11MB5902.namprd11.prod.outlook.com>
 <a422c52e-27de-4c10-93ca-4e82e7cbc517@lunn.ch>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <a422c52e-27de-4c10-93ca-4e82e7cbc517@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0353.namprd04.prod.outlook.com
 (2603:10b6:303:8a::28) To MN6PR11MB8241.namprd11.prod.outlook.com
 (2603:10b6:208:473::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8241:EE_|SJ0PR11MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: 9105d63f-767b-4c0d-50ed-08deee7eb639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|11063799006|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dGp21rJfymN9L+JKWgnhJ88sQa2I7MvUWct7XG/KyHASicE3DyJO7V8axe0un7YCIjKc2r6yAiS88joc2SWg0uIkMuAjRI7G2QtvoQBjZ/6tV0kCzMWM9iV0SWSq8KeoXX2iPN5aBaDD3ffqdWGuNlnBbVvEozExmwnEa8i4w2FxLDRcjn7kyqBsWm6a5vplpo+URyznKk7k+QwHq2fgpGQY9tSS3lVnqGSm2H9w4nHCAkEe43jTAVIDap9RZ9SU+KACgK10B+9M4UsiyOz/Yu2eES3l2DFmt/69EEJ4M9tcEUczGHbYJ3igEQYW1hJU5ZKjFghI2o1UfHQh8OCV2rgbdc1r6KaTBOjOc0UORCktWYIUF4kmJ+rWEGPXahCrM5+Asjrz6QAretcr0FXV9shDlNs5BFKvWzUSq4BZzySs6+JCQgZh/w4TZ8psSudxO5MMXRKG86TL4A8PBOGs2tml+D6stnRtK/lUzfIUPc7TXJpufn/Fo5A680iO328bvT50IBVG2x3b4GNqDNYrmfqraC4lxe1qjI+vRyvHBbAei6DueMkl9Z+4q/MpRfD+ADT3hAAlzPxyecw9LNpo3f7pSY/Rncank7N5n6V8wAV7SXhPQ9PQLN9uTeWCdjTK11YBpyrUiDU6yUID5zIQ3Q2wkgMrqXD0ZYCXQ7PT53w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR11MB8241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(11063799006)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFd1MDg1Qy96MzlRRTFlZUJCUktRNFcwTlVoZ3hXNXQ5ZTdjRk9VYXRtYXZX?=
 =?utf-8?B?OHZJaCtUM0lra05MYjZOckZXaVMrZU50RjB3Ulc2WmVlOWxZakhlTEdKVm9a?=
 =?utf-8?B?NUZZOE1IdVlUVzdLTVJlV2o5Ulh4NU9GUHM3dzlNa2Q4MDFIdjBxdCtIZjlq?=
 =?utf-8?B?TDlxNkwvbWdadE5Yc1BhK21sQTk4cWM2WU4wVGtvaGNCTHR2VXZ1b1lJK09p?=
 =?utf-8?B?WGZxaFJWWlVlZUpvYmVDZDIxb0RmL0ZGVCttSHdaN1BlRFdQbE1YV01KczlM?=
 =?utf-8?B?K3crdHpCRFFtVFMyUFlmZWFTSlgxbVBCcXdYREthYTRmRWFIYlRENmRwdE4w?=
 =?utf-8?B?TEV4MExiZEhCNE0xYW02WThxdkpXRVQ2RG9JYmtjNXJGMEJsUzdCUi9hL3pF?=
 =?utf-8?B?WEQrLzNyeEtWMHRGNE5WajdCMEZwVUpxc1I5Q3NtM05kdTYvbjZKdXZjSm9w?=
 =?utf-8?B?M09VaVJWVU9IZGM2UlEvdWM5UVkzTnQ1U29GR3lELzhJSE9LMktsbWY0YjZ6?=
 =?utf-8?B?bUEvRGlybmpnTWY1S0RXZ05hMU8xWXhtZUVLOCtqK1NERHhZaTFhbVZwU3Rs?=
 =?utf-8?B?Y1lUUTB3ek5ENEozbmtrWm9tOWVGbUpsZU91aE5SZXlkYVJoTmc2NmFEMjB2?=
 =?utf-8?B?SkNNaUVQU04wTnVIVGtnRSs3c2NkNlYyYkxIc0kyWWtJK0w3OEExcjVmdkRG?=
 =?utf-8?B?N2VkWmR0aHowdFNMUUlDMWJmVE9oSlFJeE1CczAxL3BIZnpUWWRCYVVnSGFt?=
 =?utf-8?B?TXZyTDVnTVRraEtyc2ozU2RPUEVWbXFSVytKVDRXcE4yeGtKanR5K1dvOEVa?=
 =?utf-8?B?bmYrVklCNnlITHd0STd1UDRGUDk5OE1pSzRkVFhIRXhjZkZXdEltMDE5aHBC?=
 =?utf-8?B?aTYrU2VWUlJhcVBvNzlaUlZXRkYvNndWclF2MUZmaGpZRWVoMjR5ZUFiR255?=
 =?utf-8?B?MjZ0aUhiam5VN3F4cC9BbHh1dVRWbHhiQ21BS0huc0IxcmhaeUVqbHo5a0FG?=
 =?utf-8?B?cUNtUC9DZGhOYy9YTkxtZHRnVTc3RHFacXZOY0ZrT2o5RHZwMTVaVW9sQ1Yz?=
 =?utf-8?B?K1UxRU9MSjErWS9nMFZCM3RGWW1Yb092UEQxMXFOaHRLOHNrNGprVW5ZNlpW?=
 =?utf-8?B?RkZsV29kZmREdU5XVy9hc2xQMkVNeitvMnhXZWExbVRzeEtCa1Z5REdkTjUv?=
 =?utf-8?B?NTAxd2JkRGpXUUdZT0Q2WlJRSWJ5SnlGSEkydmw4Tk1rTnEwYi9ka2xVcDhh?=
 =?utf-8?B?cStzR0Foc245YkZBdGdERTdzbThmdFhPckxZR2sremM4ZTBiMHJPVVdDcTBw?=
 =?utf-8?B?dExXcHpQQ0NXUG1Yb3duUFBabGlmci81U0ZwNkpOd1RkZUd0Tit6T0xUbnVQ?=
 =?utf-8?B?Ym5XUEZja3lPVldZd3Ryc05kdzBpRmVuZzdTS2ltYXJ2YjhZV2lFTy9qb01v?=
 =?utf-8?B?NktteXM4ci93a3pQc0NLdVRGNFJsdjFaanRvK080dnoxcHZNVVJ3Y2hjTkky?=
 =?utf-8?B?SEdZZmltanhLR1k0bmpWaHNYb3RoZnJ6RUEyOGVFZGtsWjFXb0hGQVR1RlRx?=
 =?utf-8?B?blBObUNCV0MwcjgzRTZhQ1pmemJmQlIvUEl1OUVhNC9jTDdQRzBvZjliR0l3?=
 =?utf-8?B?YWVOYXlmc3FtcDd6MmdGcUJuWmRxcGoxR0RyK3d3d0hjeEl2b25PRjcwSjVL?=
 =?utf-8?B?NzZDQldEbVZpbkdXTll0UHBsUzZmSW9SMjhIT1RXNlpMMGEyd1JTNlNLTjB1?=
 =?utf-8?B?VlRDTVFNOUw0Vk12V2FWSDlLN283VDFIeHMzV3dtc2YyQUU2QVpiZ1pqeHNj?=
 =?utf-8?B?bDVScFVCc05UTnFoTm9idkR4cWlqWTZBckMvd2NQdm5hTFFxaWRoU3RIc29O?=
 =?utf-8?B?ejlYSXFBWDFPRDNFSXVwRHZGb3J0WjAzbk5oaTU2SEoydnRoRU9vTXRBbmR6?=
 =?utf-8?B?aXJFQjFMNzdnSEcxV3J1U243aXB4TWR0b1Z6YjNRNVFhWVBtbEdvL2F4aVFY?=
 =?utf-8?B?VWxiTElvWGovVTJwL2FRQ2g3anM4MW5nbjFQYkd5bjRVOGxpalBjeldDYnk0?=
 =?utf-8?B?bVBpM3RNeENyOG5PTUtEYXhHL2c4Z20rNjZZdUFyS0NOK2hmSE9DYkpVSmNp?=
 =?utf-8?B?NW1zTFlxNk4zaWR4YWNIeXlzYUpwbjE5bXltMFJteGIvdlBrZGdBdGxaMTRZ?=
 =?utf-8?B?aVZUa0lycjNhNmZSbGhWdndiSE43QVh6RW9oZ1BWWCt6aDVheVYxUW9sQVJx?=
 =?utf-8?B?QWtHNXF2U1NNYUVUTkdCM2FLajlGczdPendLSGlvY1lkd3NRYTZseEFqTlFj?=
 =?utf-8?B?eVBrSlgwNkNXaC9NOUV6RjVmL01McWgveTE5VkowdHA3RWtyZUlSTGNTV3JX?=
 =?utf-8?Q?S0Mm2PvMBZwd+L8g=3D?=
X-Exchange-RoutingPolicyChecked: O8xYMM+Pc3nV16HP5vmd8tWGTTNYL6MT4CSqK3S4mjHoIeMB3slbYXoVOP4SosYW4OhaZLq+NwyClc0iEuwbPrUDi5oNUka+FAK+iu2sK9/Fh9L3REcVeFxSvu++Mw+Xy+Df8lgXqR3RLOi7hjoEXrKbgOcWZgh/a/J2Qd8OslBJ1ZP97Zj4UyagWpgqZzS/zH/3dTtEdD0W40BKhi9kYbZkwIBMyWO6qZ9vjlfRElkwjFEX5LFEwiVm2mud7l4tmwF2ijessAEy75qBS4r6lZHznQBue5rwlu7pBKdteT+oC1Tajmiro7xVtYU7RsCabB7KN+DnQpKRuASN+Es1bg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9105d63f-767b-4c0d-50ed-08deee7eb639
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 21:08:32.6090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sRcMM0uRS+NYtAJzAI1t42OPHdoHEUGL/xxiaMHPQWuSult1mjhRcMiD50DU5ieyw2wzAwi1ow4p0HtA9bB6Ws7zmwcNO4CLGA0wPwqkqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5085
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785445728; x=1816981728;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1zPOpNebFx8Mst060eNNmVZWkQtrjlYfA945B1jiLeo=;
 b=V1ETV3Hf0rlKd3spdQZqNyMxV9WAE1BSFG1Lk4oKuothm7Pm9Fcj1hEZ
 IN/dmUkigbM/pn+GLYOx9KtYc3ZNF6Yk7oL+x914IhL3atTLF1z4XgPDS
 l1m5iWoMKLeidpGNgurFXGUqhMxEXxRuWVyu0GehOz8v208mPpCvEOJHO
 6iFkXrLQZktJ8csLo/XTrzdr6M6G/KQr7V0mgOe+rlM22ujTygaBgg8Vy
 lCplLUncYVDrylcFzzv9lQ/FqTKflIFuu+TyTTAUE2d0DZzBc7pq9efVb
 erulEpWxn/ldWlKsZHLFDxni4u//tZasyU1CBBqZW/cPxAo106uXBtm9G
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=V1ETV3Hf
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH] e1000: drop dead switch statements in
 configure_tx/rx
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



On 7/29/2026 8:00 AM, Andrew Lunn wrote:
>> I see the point, but as the code is quite old and its extensive development
>> period passed long time ago, i believe value of such cosmetic patches is
>> rather questionable.
> 
> It might be worth looking at the history of this code and see why it
> is this way. Sometimes odd code like this is actually a bug of some
> sort, maybe a merge conflict resolution which want wrong.

Looks like this was introduced with 24025e4ecf88 ("e1000: implementation 
of the multi-queue feature") and the multiqueue portion was removed with
c1605eb37aa6 ("e1000: Remove Multiqueue code until we have support for 
MSI-X in our hardware"). I think it was intentional but probably an 
oversight that this only left one path after the multiqueue removal.

Thanks,
Tony
