Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB86C00A8F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Oct 2023 22:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A919C613FA;
	Mon, 23 Oct 2023 22:04:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A919C613FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1698098648;
	bh=JVfU5omBy/z84PSVbj77rWIt5Ocw9OXpLB8ZxTK7O5g=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=QzGwWswqzppcThw3VTsM+mNlhLJXJ6no2mDCnq1YnxS938lai+hdrOYRlNVMnVAsL
	 h0G8D0jbEzyyAQXc4HaRPThDWgeVK+nSvWaoTSC5ZSxm+Z3Cv35tTkrptk6yE9FFbs
	 zpLX8A9IWH1gj+NBMNJMMXk7Iz51tEgiffrWYHZ5gG/kDxVMEHXclnPzEePm+48B3i
	 L+hl45gbJmDG5D6d8QcNfxvtjxX5pJ+KD5oPUQjWZzXwWFa3FGY3LyEcEgPPwvoidM
	 W5NjYX4jyz7lDwkxFJqCPMx1z4b/piGDos4f29f5S4ESa4GowgweUzNBHz7dA2KUCJ
	 7eBOvmNxZBMKQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nzVF4oLvTQeE; Mon, 23 Oct 2023 22:04:08 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF838613FC;
	Mon, 23 Oct 2023 22:04:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF838613FC
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 8DDC91BF3EA
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Oct 2023 22:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 609E9613FC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Oct 2023 22:04:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 609E9613FC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wZLzx6FSQjTn for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Oct 2023 22:04:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 00D17613FA
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Oct 2023 22:04:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 00D17613FA
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="473162931"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; d="scan'208";a="473162931"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2023 15:02:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="848902031"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; d="scan'208";a="848902031"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Oct 2023 15:02:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 15:02:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 15:02:40 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 15:02:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7Yid2teVkmznM9v+aPKo5+FIpBlqcLDMupiQBYXLSu6+NI/nwfWsj68Ev5OfAhSfetNk3oKrgyLsrgFinXIJbfXaqGR2cYqURTpmMAsb0WUZ8EWoY15Jy2W/Ny2WMM6Zebo3hxgt1cjU2oPox+i6tf8XupehIMuHrcbWqJKn2OBqfwCpSK06WeLCsItnMGV9h55cluaU4b3WdslQpGYqLVyO2KRzjW2rqyoqWkCn/rdgFXv2BWPxKHqgPXGwlYMbQp+aYbbbRSH7iJs5HJCpOoWyEN3Fl81lnWocshtnVUa+Be7fSVTi/DPw4LE6SHaM6DsuAdljT6681IidU1PFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMsF7UiKNEWG0jfihp8UnTIek2Js+l77Tgpgf8+S0MU=;
 b=WR01hM/jU5v9g+hmOg655nT/behggTS5uqyak8ybUDcRDJDgcBQV6VqZ0l4o82V1kmF0tmnz9+4LzRZ+mKVYKzioPac4BDsPFAbI07ZJfzqsRF9SUs6matXBU4KvyFcqC2qWl7+PueWQsJQMQCEGzXEI9AVX1hi8eC5b0H2OgK0L0uMQy4SjYblPHpHMf9YlRpAl6Ejy9f9ukIHyWXbJjAuoiQRbKfAGhAbe1kj03Ccdwvz6HosU9LVK9V6M9oU+S+kgnk3tCKEy3/RL8pHzDbk4qjP5nFdgEZzIRZtHfBP5zyLJtMGHFVXvknaTDZy+7zJKFyh+TwnRmOrW/d6ddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL3PR11MB5700.namprd11.prod.outlook.com (2603:10b6:208:33f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Mon, 23 Oct
 2023 22:02:37 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1%4]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 22:02:37 +0000
Message-ID: <d3651e7c-9c68-426a-a3a0-5a0bb269d173@intel.com>
Date: Mon, 23 Oct 2023 15:02:36 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
References: <20231023162928.245583-1-ivecera@redhat.com>
 <20231023162928.245583-4-ivecera@redhat.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231023162928.245583-4-ivecera@redhat.com>
X-ClientProxiedBy: MW4PR04CA0347.namprd04.prod.outlook.com
 (2603:10b6:303:8a::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL3PR11MB5700:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e17f41b-7ad0-4472-ac1d-08dbd413c4f1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M9rjD9yVw2ETIaommKU7ErVu+/eObwCrbCdkUQtKf4X6teHXRgd7D1tRSQEMiE6RgWYAln9unpX0OH4DuOTts2eo0+93JzEoNo8DTamxheW+ZBaAT4uLvTVKnFiOmJJCvySZUOKAZgk4sRAJZ7DFe2xS/oaBmPbeZYWbtmGfUEySiuGrfakGDcD4tGIWC3T3AUQKEXpOx8q57uzRAWgnDoC/cUvEe0EdIrmHiC0Ld9SoveyW2uR9Pr/uYracWytgOd42Y+KZh0xPPDTwngUmYfDxSdrlt0o0GG6o9VVVyQGMbKxSVXae/nKgBfV1NAasQMN5JMQVWIAiWcQirHMjDXOru0d8GefUbKrQuUWtifJP/JAmr4mjiIk8iY9MidECTUvfpb+NDFYA8Z6R6eK6LzA38qe5knIpUyn4ZTmELQih375z1M75f56JMYafuoAfP62TEThsB1F1YQuJeVnsugP2Hzkpv+XV5F7DikBXb3ULHNoAFUXEBTrlwwaaCzF4z5hDQdRzVfo7UijAuWL8cjsnDMDN/xqqlWuqkpY0M2hZ98z/tdDqhWUjkJghqSq24EQ+D5uonG3ZQd6Ldkk7TBycJP66YiI0pqmZJuGM1DLVQVzCq5G5fS3UO0MflHupg9MZyfyczUUtBaGhp2b+rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5089.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(26005)(31686004)(38100700002)(2906002)(86362001)(31696002)(7416002)(5660300002)(36756003)(4326008)(8676002)(8936002)(6506007)(478600001)(54906003)(2616005)(316002)(66476007)(66556008)(82960400001)(66946007)(83380400001)(41300700001)(6486002)(6512007)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFZrc1lVTk52ODJsSkVFcnVDSXYwMEhNRERCN09kb05nTVhwVjFvb0J6RW5s?=
 =?utf-8?B?TTYxbUJlWXczbDdTbFAzaS9Lbmc4M3VLcHQ1SFRzc3RlNzJoQU1veXpVT1Fl?=
 =?utf-8?B?N096WTJ2Mk4wbjZqeHFxT2U2L1EwUFRsemY5NkpmQUxBNlFlUlRkNm9kaFJI?=
 =?utf-8?B?ekRGSzlWN0I5NVFvRHMxa1MyOEQ2VGRNWFFZMUV6bEIrNjdyTVE5V1FzWGx2?=
 =?utf-8?B?TDYwQlNwQitJZEZYNEJKQ2tVRUpIS0RjN3g4NjNBaWUySlNTUnFpbkI5cVJi?=
 =?utf-8?B?NEZnNkZENC9qNzNuejZjLzN2c3ZYb3kzYVZTckFjVUwydmJOMlVzemJZbERM?=
 =?utf-8?B?SUFmeEo1c081amRyL1ROcFFxUWlHN0Y4SEJFSFU4akJtK0ZtTmt2azRrdk1h?=
 =?utf-8?B?S29CM2JvVWxQa05MSThRc3JnWDkwRlRERHYwbUFNMU9uV3ozalQrYVQwc1Ft?=
 =?utf-8?B?bWRKb21HcDdqbDl6NTJtZFNEUXVpQmRBdExwMDVWa0ROOC9JOVFqNWs5c1ov?=
 =?utf-8?B?N0NjSytta0Z0WTZTanNFQm50aTlJc2RTS0hLWG1XbklDWW5zcWczRUF5emNv?=
 =?utf-8?B?R1FJVHRnaTdQTGZtQlB6QnU4WTBjd2ZyNW9YMWRBaFBkcHB1S0hlVDV2V25B?=
 =?utf-8?B?Z0xFQU1qRFF6QUt2N2M0QUtwRmpXTnZabFBjZEJUN2l2VHlmWFVDVi9vS3k5?=
 =?utf-8?B?Vm44WmNmcGFEYVZaVE1aeHM4MnVCZ3Bobkdpd0NUbk9EOFVCS1dHc0w3T0Rv?=
 =?utf-8?B?MHpoTzYwUmN3ak9LcWI3TXRZNGJLUDdxQkRkbjB4eWJxeDYxeW1rOXZMc2pR?=
 =?utf-8?B?Z2dTb1FjTU1PR2swendDdngvc3ZKUGpkUHBOd2hZUWhlRXZocjhDM3Z3VSti?=
 =?utf-8?B?aFgxditjbzRMY2tIb0tVWEk3ekFXaEQreS9HUExUM3FsNERnMFRJUi8yNlZB?=
 =?utf-8?B?Ny9MNFduVGdOc0Q5alVpV2RteGJOc09kbjdvbThMeFJQQm01SVVXKzI3YmNt?=
 =?utf-8?B?aDdXUjVrVVFyM3hFZ2JNaEhYV3NVZlBaQkw1U3ZieTdvbTlUREN6QUY1ZGhy?=
 =?utf-8?B?RGN4cThadWhpZ0U2eEw0SmpSZ1BpcDJhMGliK3FJNVR1V3hWTkh0OUJnNWI2?=
 =?utf-8?B?K2t0ejNRbVJLV2ErblRoUjlTYlhSN1lvMXJqbVZKVjFGeGY0akExYXdabXZz?=
 =?utf-8?B?Tkl5NVdVcUEveEQwMnBwSmk0d3gyMTBRSW9GWCs3RW5PQ3ZIV0FRMWF6YTdh?=
 =?utf-8?B?ZE9EVUozUUp2V1l5MWdIRGFQQjYySC8vMDdGcGRZa0RTUFNBT2Y3TlNIU3E0?=
 =?utf-8?B?ZDZ0K3U0SzB1Qlc2ZWZyeHpYSGFhMEJNTmZhOXF5MVJ2cjYyaVhOajFkK0Rt?=
 =?utf-8?B?dEdQQXhqRk0yMVd5eTIzamRtcjZwYXhYQm9rSXFmMWVsV081MG5hVmcrUXRh?=
 =?utf-8?B?c1hqa3Z0ZElBYmNLcU9XR1pJellCUW8zenlDYTZpeGNueVRnaStzaUZabElW?=
 =?utf-8?B?dDcwTk1Ld3JQb01IMWY5T1lFQVVCLzY4T3ZDK1FBZGJyNEc5MnJZU2pNTXox?=
 =?utf-8?B?K0tUbXcybTBGcnQ5YkNGU0Z0Sk1pejJxZk5aSmpLa0NPQ1hUQzNyVnpQeldI?=
 =?utf-8?B?OGJaelVxMjRuNDBldUx5dkxIYWw3LzZmVDVTU2hzaGYzNzUvb2RTci95N3Qv?=
 =?utf-8?B?UldzaDYxWWNLVDU0MHpNQUFEWDhNN1FGVDR3TVBiYTZaSnZkaE1PVklUQTRE?=
 =?utf-8?B?TERwRUNja0tXUzFpTnlYYXk5RnkrMWhkL2V3Y2JxcGZHd2Z3cW4raFhxNFFJ?=
 =?utf-8?B?dmloTkc0K3RUbFplOTdJcEp4NmhuL1NTNTlTc1BnMEZqc0NHLzJ4bjhXaG83?=
 =?utf-8?B?WENFc3dHY0FHK1BMVlJLdG9Idmd6SVlFZE1Sd2FqNFBEMlYxMWZKRVdwWkJ4?=
 =?utf-8?B?K21CZzN3MzBSc1o4U0h4aHBlcmlnUjkyNS9SbFRqcndPNDgzQUxLV1FMNmNO?=
 =?utf-8?B?L0xKSVV0SithQ2Raa3h0anFXZGp2S2ZURitwcnJndks0Q1lrcG9rTThLZ0pt?=
 =?utf-8?B?YzJaNjZwUkV3Yi9sOVd1Y01qSWZHWjdCMGRmSmRPd1F5U3VOcnVITytHUFNu?=
 =?utf-8?B?ZXVpaWFPbitTY3pTV3BSQ3VyTksvZG9UR0s3Yk4wb1BBSGh3dWQ5VVhYVXB0?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e17f41b-7ad0-4472-ac1d-08dbd413c4f1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 22:02:37.7975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sD2lq3epDeQ8zBe0Q3LXLwuvOYdx3pJXFHuRPEMa8s3WMqtjfXuXrWvrevYsR9F4v+DA7RHwAxojCkIqYSQz/JH2OQQxKXhP3Gyaly4OpeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5700
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698098645; x=1729634645;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kt2q5nrVyNKxl015QBw5cEXgkZHSV6SVAGXf+Z1DiI8=;
 b=BJD75tqX6Qpgkt/quuzkzK/x/OpHA5AqCYnlq8XHyPAjDQNTS52k/2BQ
 Eg9Px0T0s+7aNH8BT3CggkJxKTJH5VgYeOJ3xJ8JXuHsOKAaqQjWmLOOP
 8fdWSkgVDwaq9WsrQo5WcEBzcRtHMcv/nmjkSiLgOlVTXAYvVe4mlKfXG
 V9rQyy5UBJ6dawoqV4pyWPsZCp6WBS/ZQ7RtXqQYCzkkpy4jCGLIxJmOg
 mWH9f52NJAaNVpcfQ5GocggjJE89NKLDrjGpZ+R6Ys+0kYdxmZ3bk3+f4
 0zgfKZVFHJntuTZg5MzZGIECIpSwRECY4/pJ20W6so2Vw6+hq+EHkBFun
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=BJD75tqX
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 3/3] i40e: Use helpers to
 check running FW and AQ API versions
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
Cc: intel-wired-lan@lists.osuosl.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org,
 Eric
 Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 dacampbe@redhat.com, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



On 10/23/2023 9:29 AM, Ivan Vecera wrote:
> Use new helpers to check versions of running FW and provided
> AQ API to make the code more readable.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---

This has a couple checkpatch.pl warnings:

> CHECK: Alignment should match open parenthesis
> #81: FILE: drivers/net/ethernet/intel/i40e/i40e_adminq.c:566:
> +               if (i40e_is_aq_api_ver_ge(hw, 1,
> +                               I40E_MINOR_VER_FW_LLDP_STOPPABLE_X722)) {
> 
> WARNING: braces {} are not necessary for single statement blocks
> #110: FILE: drivers/net/ethernet/intel/i40e/i40e_adminq.c:583:
> +       if (i40e_is_aq_api_ver_ge(hw, 1, 5)) {
>                 set_bit(I40E_HW_CAP_NVM_READ_REQUIRES_LOCK, hw->caps);
> +       }
> 
> WARNING: braces {} are not necessary for single statement blocks
> #118: FILE: drivers/net/ethernet/intel/i40e/i40e_adminq.c:587:
> +       if (i40e_is_aq_api_ver_ge(hw, 1, 7)) {
>                 set_bit(I40E_HW_CAP_802_1AD, hw->caps);
> +       }
> 
> WARNING: braces {} are not necessary for single statement blocks
> #125: FILE: drivers/net/ethernet/intel/i40e/i40e_adminq.c:590:
> +       if (i40e_is_aq_api_ver_ge(hw, 1, 8)) {
>                 set_bit(I40E_HW_CAP_FW_LLDP_PERSISTENT, hw->caps);
> +       }
> 
> WARNING: braces {} are not necessary for single statement blocks
> #132: FILE: drivers/net/ethernet/intel/i40e/i40e_adminq.c:593:
> +       if (i40e_is_aq_api_ver_ge(hw, 1, 9)) {
>                 set_bit(I40E_HW_CAP_AQ_PHY_ACCESS_EXTENDED, hw->caps);
> +       }
> 
> total: 0 errors, 4 warnings, 1 checks, 212 lines checked

Thanks,
Jake
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
