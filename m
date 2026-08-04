Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1DCC55822
	for <intel-wired-lan@archiver.kernel.org>; Tue,  4 Aug 2026 13:16:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E7A5605DA;
	Tue,  4 Aug 2026 13:16:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9mrq0fPgZrTu; Tue,  4 Aug 2026 13:16:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C739260715
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785849416;
	bh=iS1YUP/L0Wbv3mKrbFgAqD1VRBnTsa+6/KHvKSoiCWM=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NbrMVeIA5IEvzmVZcs3NqUThJtjB7Ue+5UIxLiwVeiYJ5YLt834ggnSGZpuLYrR1b
	 shVzXs1x7BqzGbgMUJXyVs+o8u2DSCIvsBI4EEgRI6TIGuNs2Vz8QKpcDdDfJCFAxy
	 PvfnbER/J+gX8ApuRzE1+xQHTe5+Nbne7yH2zH2Ekuqwa/yzfTkxVySd0kWLcm91MP
	 LaDPYJmxTwO7+6j+mzU+P/byjWWFUGo1Sp7xmgEQyfWesXuPmnkwjRCVqYk8oewXEu
	 7v6JUx0eqWutYXG4Jvw5uTIX3dnjoSkptUcNE+wi2NJC3klc77pjRWI0FuCCPkU/tH
	 ETxLOfSTaB+TQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C739260715;
	Tue,  4 Aug 2026 13:16:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 978322AA
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 13:16:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E64280B96
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 13:16:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W_hgiyeCZaN6 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  4 Aug 2026 13:16:54 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CE5C480B92
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE5C480B92
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE5C480B92
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 13:16:54 +0000 (UTC)
X-CSE-ConnectionGUID: 7gpX9Y6OT1ueViTQLjQ7qw==
X-CSE-MsgGUID: o3l/Yx2JSLGo910GXaUz6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="103938103"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="103938103"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 06:16:54 -0700
X-CSE-ConnectionGUID: xRPX2QhCSFiwj5vj2IEmEA==
X-CSE-MsgGUID: YFgElHB6T6GzhIWLqzUFSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="286146709"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 06:16:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 06:16:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 06:16:53 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.18) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 06:16:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsZHMvy8o/M9ac04I+YDPFU9TLeIqTjx/FhS12btrK82nNCMtMmGb2a/xNZmViqhgCe/EDzqr8LT8pXw7BBXqkbEPVD/zG1qm2KDQaTieXHYCBabbzuM+oXoT003wP8GU600XdsCT3rduLsblPV3xp+G1tJDxTqxLQfdI3vM1AgnKiWZHCrwHco0QZvHkGU+a4Wv9ThnQwrMcY94lkI4VBgRb8oczLw5AtvVoJ8mloFMIyGH4JyEz7FvsRAhnjgzyfD67Cn7ogVJX1//oDRnAyEpioYs+KdppgPjiOjRHwKmYSg29d+HipDEp/y+aONWRH3q6C1B9F+/ZbeSwE77Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iS1YUP/L0Wbv3mKrbFgAqD1VRBnTsa+6/KHvKSoiCWM=;
 b=e5h89U8XuLG0+p66AnePOgozSNwvNHOZy3CCNQOG/Y8UwX0K0+dDY6KVG/9CzDk5qrzggRG+b+lgam/h44+WARSotpZDZV9RVDUs12vnsQKqo1ekPa4VPuXe9SdQOSqzpepC+jw85XcvvnYlgYLKzSfcQflgBjHo24HD7C9jcQo4P4SIc7WyPhEe4xvsrd0LGth6DZIriajMfocmTmFuZGsrHjhAFhfYjsbTG6OkOSYt7oee4eoerQyVzX9+TSu8jaxUY2Pea55bRzZMio7nTblvYWbBbekCZfCwTBw7wX7zkuzE2K21A/KWI6kOtFfrGPO4LDtty5XwY9zTxeRn7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Tue, 4 Aug
 2026 13:16:32 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 13:16:32 +0000
Message-ID: <4fd4b897-923c-4e48-b8e0-73fa70c6a273@intel.com>
Date: Tue, 4 Aug 2026 15:18:48 +0200
User-Agent: Mozilla Thunderbird
To: Robert Malz <robert.malz@canonical.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>,
 "Jacob Keller" <jacob.e.keller@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
References: <20260804083537.3997889-1-robert.malz@canonical.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260804083537.3997889-1-robert.malz@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0010.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::14) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|MW4PR11MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: ec2250d2-e7be-4e2c-9b03-08def22a99eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|1800799024|376014|3023799007|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1Tw3toQeWt44dWq7HdaFJu/WoSFGFFVBLbGbwfIG32KQ0VkX6g/odnVXg97CE5zIY8oNEprArzoXHcU3clq7phb5hFjIfpceNdTB4FSuCBL0TEjonSG7aqsTy3nAR0CPPUxIGh2q+okq51esSCkXRHJBdZK2ViYkJqGx+izFNwYTzpsRFbSWIPZol4JhI2JfdNclbRJqeLdrUL1YSM/VkAzlcug1NbsXFiYBfxF8il9LFHulTV8meWUW5X5ey3NNTs8/DUidsC4p6TXqZ5kaSJkUj7vUDj6r4Hctya10i3fA1lccOrStffg0XbmssTv1w2IjFGfMWADfiuQOnEO9xCpZS4bFPY88d7MLIsa2J/yM19GYT1L4c+8N73+lQhJThDWm+l+si1bjB7qLwA+SvzScEdjdNBt7fCpXso8hDiKAj/hM7wMjCKwMqYfVvHEiS42SYLm7W+qFCCy7WEBvwMz+ywQ3yA5o95kw0y5ZdgyNDGmH+DQcwB6pPuwQ0vNrdIf9eIgMHRj/ZWLo8fPMVjndYKhuGmLF53ymvBZREMCluOHxWyXAqTl9nA8A1HHYDzgZ1bHKQixPfM2/JINoHqWyYwIDzEwL5wq2gEEODhB5vPFwwocuEAm6NCfOyKKL5rB+HwTpN8a2hzraMNm6TlqzCIU94Cr9lKgY7KPO1gI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(3023799007)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEhrM2FCTk5WL3dVWElOcGpPUjJXRm5XL2RLNXJxY0N2TktTRVB2S0hqMzAr?=
 =?utf-8?B?TEFYSjdyOUl1V0FCK1loN1Z3UjBVenFMMDFFcm5MTWM3cGMrb1RLVGJtcVJR?=
 =?utf-8?B?cHg2ME81TG5sWXhrdWVETlpqV29BK3g5cXpQU09Tb1dpVk05MlRYZXpYMStw?=
 =?utf-8?B?Mk5Zc0QrSmRQRlppR285ZUM5MThKZ29Sc1N6My9yRVZ5SGVGbGY1YUdnK1lz?=
 =?utf-8?B?LzJCSnoxMnRUQjBYYVRkTGtMNGhXRTh3ODA3WWJqVmgyRTRxWHp0bisvN2hu?=
 =?utf-8?B?UkJlWGp0ei9TZzNHZmFZYkR0cHF1Mk5EWjJ2YnBrUXhSNkVLdlJaUUg5cFBD?=
 =?utf-8?B?K1ZITTI1ekJFUk9ldjJXRVBBR01HTCszSTVEVUtmZnFQSExDYTlnUXJQaWRr?=
 =?utf-8?B?SHFVSENtZlg0aHZYZ083ZXRadlBpL1laQVZYVmZpeXJCa2dHYjdLOGU5dUdT?=
 =?utf-8?B?RkNtcHFnaUZJekVQNXQvYmJnMFdYUWxLLzNQT2JYMW1uWlNHSm44UktMeFUv?=
 =?utf-8?B?TUQ1YnlkWXFGbEFTZ1dkSUR5SXNvZ2RKcmVpcitJUkpkZUZiTHVWdWo2bmRF?=
 =?utf-8?B?MTJ2cGEzdTl6Mk8vWkRwdXFBYWR0QUpvWmQ3bDcyOVRiZnd2NGZ2MlFGRWp4?=
 =?utf-8?B?ZjQyNUxjM0J1UUsyamRhSC9BNDZ2OEQ2RldXR3hyVytSZjNYNnhiQWpiQWhw?=
 =?utf-8?B?QlRudGdZbk1VWWJyQ3dpYjRCQnJlLzBSWHo0bmpFQyt3d1M0a3JzQmlWSVpU?=
 =?utf-8?B?SEZOZGtDUTA3VzRta3ljNXNZTXVvazlqQWRUeVA2YjN6SmhKYnBMR2ZWRDAx?=
 =?utf-8?B?UGJXcmJKM05HV2F6TUwxTkowNWRFTnc1ciszYlIwZkgrenNPNlRVdnowZlJQ?=
 =?utf-8?B?TzFzQmVaU0JhcEhPcmpzMURKUW9xT3JlNUpJbDlyWnpDemZ1NUdla0JCZkNV?=
 =?utf-8?B?T1ZCWm5UNU8xbTNYRXV0dzlCdVZxMEdGNkwrZFRqSXdGbXcvWE92VXlXK2lq?=
 =?utf-8?B?OFkrUVp2TS91c2hkZy9MUHFuazc5bUM5L3RKNStuekRXcFUveTd3cWdEblU1?=
 =?utf-8?B?K2NXczFXanV3K2hWYWE4RE15NFBuck9IMjgwamptS3BmNmRSc0kzOGk4ZjFq?=
 =?utf-8?B?WU5QZ2xnWDZPeS83bVdpbDBiUlk1VUlCOWprenhiQXdDdTR3aXEwS0lrQ0Qr?=
 =?utf-8?B?ZHJ4TlVYZVpuMUZ4blZINTBSY3JnMWFwUzhoMG5jaEhRR3NmZkZZODlJZXg4?=
 =?utf-8?B?Ym1hZE5KdmtEL0NKajF3L0pLc1l6bW0rYThBd3UwR2d4SXVIQzV1djlibGNi?=
 =?utf-8?B?RXA4aUhiVFRMRnY1M1JmdXRmdmFaR3RJd2dsL21jS3J4b0NlbHQzVzR3RU1a?=
 =?utf-8?B?OUV0aEtwWGVsaGZCMWlGZmxzNzdCYkgyVTVYclcvNVlUb2JNNHpCbnhBbHAw?=
 =?utf-8?B?UnAzQ20zS214ME1KRnN1U3VnRzkxYzBKY1pHeHQzUDNrZTU2RVE0R09ud2Nh?=
 =?utf-8?B?Um1IbkQ4TFFSSkpKYmh3VHl2OUhsMGtZbnpQR3U1ak1LekZXdWtmWGJ4RmtJ?=
 =?utf-8?B?NitRWXR6ckk4Rk1zd3VKWUp1U0JEQmhkSFJwc3k0RGdORHVJbGwwOE9sdlV3?=
 =?utf-8?B?REQzL1JNZS9DeHJHa3NlaHVhM2tkTGJXU3VJMGhDTHJiSllzb3pBc2hvYkcz?=
 =?utf-8?B?a0JOY0o1ZkJ5VGg3YmE3dVVKaXg0RjZxV0NjWUo4RHlQSVlkcU55cE9hRi9s?=
 =?utf-8?B?N2JDMVNVRDdvMk1OVG45NUFVL2FQYWZ5NksrUGFCV0l6bkk5aDcxL1JxYVZk?=
 =?utf-8?B?b1hPWGxHVTY3WVNLK1BnQ3FheUJUczhJZFQ4dis3dVRkSnIweVF3Vk9OZzhv?=
 =?utf-8?B?Q3czZnZ1Ym9KbGRPcHdHTE9ZYzVjNnE3VVN2MzlQcFBVVkh0MGFjL09qU25z?=
 =?utf-8?B?T3g4d0JlSGJqTTVzZWwrbVdBYlo1LytScURsVFYra01HQUEyenR3ZVlwcTdB?=
 =?utf-8?B?YVNmNThZUTlhbnpvYWx6bndXaS9ZclhNTjFoSlE4S094WVBicDZMenI4YUFM?=
 =?utf-8?B?a0VsY29SRHA4NU1KM0d6WDFyR3JIR0ppQ1I2Rll4M2dsSHBaTGpxRGQ3RExQ?=
 =?utf-8?B?MDV2clEwZ3pMRkNRZm5VRlRHSWh6TVNQSHN1TE82eUlkeU14WkM2YmF0NTdB?=
 =?utf-8?B?RDNZRHJ6WjBrbmhrTTE2TmpyeFBUbEpteG1lZU10L3VnaU9xTTkvZXM4TVFT?=
 =?utf-8?B?OGNwaUhMbEd4ekV4UWZQNncydUlDcndDRG1PVitEYWxNZ3JkY2NDRkRyTi9C?=
 =?utf-8?B?SExXQ0lCczlQOExoaW9Fc24wSlJ3ZXlEcUhlUmdqa0w5dkU4V0t1ckJtL2lh?=
 =?utf-8?Q?z68uuswjXzKTdU14=3D?=
X-Exchange-RoutingPolicyChecked: QE171fVetS+n1do6nVbceeO3vxHPTlKsI/BiEspnqWsuGYXoxMpanCKn280XrTQiFu0nPhEhq9Hz+sG04mb7jFU+Ya4U8+BE/kHV6K5qrOyr/gRTIWBe80DxxQnPPMxsXPqmY7UuKVFKfT9aBFhyb23ej0nxcSvyuxJVl6nGpCcmNNDmG1abz792cqxWEWG3Tn77x4pIoMIdqJY3SQickkJgSV5HUF5G84R35C6mdnFYLsbuvEXgDgh+l2KS7V1pyph7012N9eFmFGGdpq1+nDTpl9Y+YD3exglFyhKRcSZsnvwfbqXWXV6ookGEw/sVGzATEbW9f93xfH8/kHrm+A==
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2250d2-e7be-4e2c-9b03-08def22a99eb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 13:16:32.1392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8MxhQJ7oooEiw5Yzo5oZy9sCZGShDNydPXiR8TgOwiyFu5If188/dxwe92ptu7ihAjdNz6AN/7B9LQZblOb/ORDtP8tJiq89DiidUPGpIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5911
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785849414; x=1817385414;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5q6u//++cJ6LOFkntRjrgfge/v1JTkR7UO8y8LgbqmM=;
 b=I3AO8m/9tjj+oU0eG0ulj+8Nbkddl7R8PQXTTLGRSFDJE/yS3coEIvep
 jDUdNvX97QRjvRUTNG4Van4scy8E64UQk1ewkrsFxd4oW5AG0HFXR8BUm
 O22gNJTYgT0rj1rxVEtu1sVqjMktQr/4Ia6iUYC/smKLix3YKHoiBSjp9
 NWPNr2QBMoAQJgFyBIzQ+k1Iqfwjel6Rv24hwOnfB7k7sjI71IP405aDy
 NZ4lHKMFNLrVcmSXO5W/K769IskNYe7IXL8fFCn9ySHV1ae5Xq4XI7Nsj
 sN5Nb0m+ql0l5ZjtltyTeRI9nzEjIvQPoyF4NmROOuM8ltcfsv3c8Lv7C
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=I3AO8m/9
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl v4] ice: acquire NVM lock around
 each flash read
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

On 8/4/26 10:35, Robert Malz via Intel-wired-lan wrote:
> FW caps the NVM read lock at a maximum of 3000ms regardless of the timeout
> requested via ice_acquire_nvm(). ice_read_flat_nvm() splits a read into
> multiple ice_aq_read_nvm() commands, one per 4KB sector, all issued under a
> single lock taken by the caller. Reading a large region can exceed 3000ms,
> so FW reclaims the lock mid-read and the remaining commands might fail.
> 
> Move the lock acquire/release into ice_read_flat_nvm() so it brackets each
> individual ice_aq_read_nvm() command, ensuring the lock is never held
> across more than one FW read.
> 
> ice_release_nvm() issues its own AQ command and overwrites
> hw->adminq.sq_last_status, which some callers inspect after a failed read.
> Add an optional read_aq_err output parameter to ice_read_flat_nvm() to
> capture the failing read's AQ error before the release; callers that need
> it (ice_discover_flash_size() and the ethtool/devlink log paths) use it
> instead of sq_last_status, others pass NULL.
> 
> Callers that previously took the lock around ice_read_flat_nvm(),
> ice_read_sr_word() or ice_read_flash_module() now call them without it.
> The now-redundant per-block locking in ice_devlink_nvm_snapshot() is
> dropped. ice_read_sr_word() is now a thin wrapper, so ice_read_sr_word_aq()
> is folded into it.
> 
> Fixes: e94509906d6b ("ice: create function to read a section of the NVM and Shadow RAM")
> Signed-off-by: Robert Malz <robert.malz@canonical.com>
> ---
> v4:
> - Fold ice_read_sr_word_aq() into ice_read_sr_word() now that the latter is
>    only a wrapper.
> - Reduce the scope of read_aq_err in ice_devlink_nvm_snapshot() to the read
>    loop.
> - Fix reverse christmas tree ordering of the added read_aq_err declarations.
> v3:
> - Log the failure via ice_debug() when ice_acquire_nvm() fails inside
>    ice_read_flat_nvm(), rather than silently aborting the read.
> v2:
> - Replace the save/restore of sq_last_status across ice_release_nvm(),
>    which could race with a concurrent AdminQ command, with a new optional
>    read_aq_err output parameter.
> - Add missing "Return:" kdoc to ice_read_sr_word().
> ---

very nice, thank you for making the needed changes to have cleaner API

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
