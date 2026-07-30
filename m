Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12077C55165
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Jul 2026 12:13:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6E0C60890;
	Thu, 30 Jul 2026 12:13:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FL68QCE6uGIm; Thu, 30 Jul 2026 12:13:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 49F4460888
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785413584;
	bh=8QDnP8THLnmu6LbiH2s8O/GRhSl1ZtAadYBFzezpHzM=;
	h=Date:From:To:CC:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hbsACu/bUWvscG6RJWsElg75RYcrClngxt3LwCCdL7b6xp5WO0wVAhafEINJyfExX
	 mMyeNCjArYnwMivLT93F4GQ6BJcx4Ng3dwJISFi4eCLTS+NEJaARn2Rqd0OBviwCBU
	 GEPAFqesOlRRn8y+zoD730fMDnYJGtNhPakJ/SfyrS1yYj6ZEPitOj9xe+dhAk5n68
	 cvL2It7L5Cwuy6yiJZQF/Zv4iUiuyEM2Kl4GMpBT9BWpDdc3whGAuwgndjKeE1Waj6
	 3JEPU23cBNjODoUymNTZZqai+N0TXr8YOoUtDtjUugYi+qCMqHrAwPww/E68sLXq5S
	 6aTlUdf74wSEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49F4460888;
	Thu, 30 Jul 2026 12:13:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9186C27B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 12:13:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7368740224
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 12:13:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ghog8k9IQ9S9 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Jul 2026 12:13:02 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=larysa.zaremba@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 55FDB40219
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 55FDB40219
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 55FDB40219
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 12:13:02 +0000 (UTC)
X-CSE-ConnectionGUID: vp9iTvfPT3CP7CTXorhYQA==
X-CSE-MsgGUID: RmrAyncYQZGLxBDoNBlC/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="89918298"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="89918298"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 05:13:01 -0700
X-CSE-ConnectionGUID: WK2BopesSUOyWWbaixF8Fg==
X-CSE-MsgGUID: hSeOj4uiTe26eXJ1P0g6rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="256945332"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 05:13:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 05:13:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 05:13:01 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 05:12:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GihGJBJ7zsbcp9ZduwO04peOKGVnz35TvkszcVYJagWSazGTVhrSq4zdi80AJcNZ0HsqizWcCxP7R2E6uWg1ZsVUMOfJRPAR44z14kz0N7OUVzxu3s3U0U4Jpqo7tVZPwUvhtZhQNVpKD+vOxaEQRGf0jM98LJQ/kMR6Xg+CRvpGIN4VtyffToQSY8NZNpFqbo9TEqmFGe0ZVqa5b9hyT1xyHRXC/w02mNic/HttpzO6IDB+M60kaME0i22ALdusU9oP6qekRHZOElGFtT6XtiLS2zNZOFHf65qgOA6PGe9lWwXwZbxJusl+TmLz3Tt3DzIIHvt81l4Zymw1M1SfoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QDnP8THLnmu6LbiH2s8O/GRhSl1ZtAadYBFzezpHzM=;
 b=nJlc+cDgU5Ku8D7hyscD+MIr/l/6dByF1hrk2i0mJLT2rUXJ1dSd/fFWEcZlmQBuLbRTutOPFY1gdHK8F/a1Sn0RxPwS671vIlQcirMVSLeEphl4kEMtPZlS5UUP8Qx2no7SrL9ontuDP0VlMzIkf1oVISyg7iFx3JYefRVaqer8WhJhVzN+EmqoNYmBiFo+eJZ7x4lXH/rC1xH1GV2MKf3RKIksKTK1+zlZoZrqx+OEUfDfoZfV5PHnoTpNBCQdeh1rX4x7sZ2a5nnsS+Jknwg99FJOWUYpEa6RcN4sd1tLTw5TvQ+uieH8bzeXeTU3V5oPYNDMM/sfar4J6TFPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
 by SA0PR11MB4749.namprd11.prod.outlook.com (2603:10b6:806:9a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 12:12:55 +0000
Received: from MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d]) by MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d%6]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 12:12:55 +0000
Date: Thu, 30 Jul 2026 14:12:46 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <kerneljasonxing@gmail.com>, Chenguang Zhao
 <zhaochenguang@kylinos.cn>
Message-ID: <ams_vj-kZ-2djCCW@soc-5CG4396X81.clients.intel.com>
References: <20260729054916.720750-1-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260729054916.720750-1-chenguang.zhao@linux.dev>
X-ClientProxiedBy: AS4P191CA0045.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::28) To MN2PR11MB3949.namprd11.prod.outlook.com
 (2603:10b6:208:138::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3949:EE_|SA0PR11MB4749:EE_
X-MS-Office365-Filtering-Correlation-Id: c2942ffe-7a6c-44bd-c5f7-08deee33e20e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|7416014|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: VXg8GnrMQkX5mQ8GHmg5vx4zVqzc0fXXzIfs0vEitlpCwSJUyaAkDyptyw93kzy68dHtAsC2j16aoeIOjTJB3bF3YCo+jeetHNRc7C/zihzCwSfyHy+zR6Qn/aYIm9P+bashQv+QRv3sEF3k/pwQAn0pFxQvOyI7qApBe6bBJc8ipr4OamEGvcboqV4MHCUvmFFtBgEW94TXp49AL6+PJTYFTGgsB2GR5t6PRTran/JX3lMzNvWa++6q8cMLF9o3FeaOo0QdiLgreJFInWHugtZVDGK14hnZ9Bipg85bDIu4i3svM/sPolxHMx6Bed5usx6OVnaDPKqww3HmEm5xneUoIgbe19TED5TX0dWDou7OTAIjJawiARVagLdCthx30KoEavPfI7LZKIwv4OSYllaQ04bmIFd8BCJOnZR10o3WhVD9v6HVf5qEqIch/kNpaL11g02Ti1tekDMkGX3CdarBhW96lTlYwUUhnIRXk/AV5I7Ryo7SJFNEVKCSLzsugklzr67U8BJVnjh11jJv9TNq0H/OPgtUuS0aexSOT9UQU0YExrK9tbSx/vN59jvN14gLnoLCRurdPDWrImBTcozTNSVzdtrKo7YsJiz+zQI3C3vd4G4hUxZb03Bpc7ou79SkI6TnFjoRisb7Htrm4aQk4sN2gbPBD3MmWeeoAPo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR11MB3949.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(7416014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?siPtJ8vaCeSIhHohvUaCGopfL3GEGJTQC3MCYzcMdtO+P6qONe2YUjZaShy/?=
 =?us-ascii?Q?2pJ3Uc3DcEF8hPwiMLPm+edShmeTylRFWkYsuv2tBHlHSwIQZustyiod92kR?=
 =?us-ascii?Q?GWkjEs3fpq6b4u70F+Hf3lLXYGiIliMD+qHQf+0Jpaga3Od9QauvcDrrRt/s?=
 =?us-ascii?Q?RpRvsF5YiNK968YznoIiKqDgdI5Gfe/gNL6aC/6djvTfYEefXpF0Xj8ojmgg?=
 =?us-ascii?Q?89Raai4XvAaznS2qs0rVVMqRqRvQjnS38oe+MVwybzh//Zhmou7exm+tInhb?=
 =?us-ascii?Q?u9dinW1tqAdRf2pg6mBsUCvxc0IhPosEUv5K1iF2re6HU+DThlSJkmkrTJFx?=
 =?us-ascii?Q?dKwJaDVUJLok8HORj0HpS7Bf+xsJyhcUCYg3rAk/qtgdV45ZSbpBaSKFSfXO?=
 =?us-ascii?Q?p1ITqs+/BaiTGn0YpY5JobHmRdVHSIHoJLt6n+jwFNgJPKb+m2U2Htw+/0hK?=
 =?us-ascii?Q?wfPXY53+hYXmhI0nSRGEeZAfi/qusOZUvamjma4Vp+MsEnpKjEA3a6h3rk42?=
 =?us-ascii?Q?0qqBpZstzE5Ka/T44lgUd+arP1QdOIqJ0iBfLfe42ghnkBEBdfku3Y1OyWO+?=
 =?us-ascii?Q?mEQNYcNs47jgx5yeC6WM0KdpLyI5neZxkjsuJ/LN1yZyEmqL97qOVUWUrqYZ?=
 =?us-ascii?Q?021G2kt/yWIbjwHrnWif+ggod5Ah2jwcnb+T/ozMgNO/4tDPo0abKutfvPYy?=
 =?us-ascii?Q?s1m9OHnHvutvSjQnLGRf456lYbNPW7C9HBO4ZMvQAxHQHSroZWHTeNwMZvn6?=
 =?us-ascii?Q?2YbFv/6cPugwZWaaEuTVDBRryQfXSoyIdIlzDFwHyUtlWGIfBPfcqfXY0RpE?=
 =?us-ascii?Q?OJBUvw29v/CRAKcx7mugyAwTSxmEDwKxvhmHQA6OVtabSbkOmLZpx5EcMISN?=
 =?us-ascii?Q?Lf5ioOvAh7/u1bryzz9KhBnFDaVlzFvbYalNphHJqGPJhcqVxAyquOmr3sfV?=
 =?us-ascii?Q?Z6PPBe9ZH0O+tTQRevqeLQH8I0vIdm/LiefOpXbIreBaq9FGkJsiIXSBaFmw?=
 =?us-ascii?Q?tmS5bp6R6ND0JO2E8m9CAZ1PNrz5iZ5jpyg/2BCVD1eriHqU9UiVIdYB1xWV?=
 =?us-ascii?Q?j2KN/mUwB3BnNomsov07CYPogVF7gC7qedcZecoDzPdRCj4H9FnRgvIUs+Ny?=
 =?us-ascii?Q?iFx/uK2N4fkt3QsQmUj9KcrsanjawWXSch9dFPbiJtkJ7iZGppIE02oPeVW4?=
 =?us-ascii?Q?MttYPfIRtmFdz+xV5UPcqsksqDZdVU5xSb6Q6gN2KjibYu8u3CYpJYdgtRG/?=
 =?us-ascii?Q?bwzwM6MkNqa4LSSiU57EpZXMdLh7zz2+OCRy7hZ84uhhJedRx/UHmnro2b9t?=
 =?us-ascii?Q?WRkoQYnzExJeBREpqfxwtUn/XuQmAsIz4u5Uqko9pnkam+WptxQ+0UeW6rFP?=
 =?us-ascii?Q?QYJlpwEPzvk+BWBg8fvhPh64yuU7pFUGsONSZZBRBcURB1ldpH5U1qsoREn2?=
 =?us-ascii?Q?b0D/GQuMN1YxXlMryyOvAD3J1qx6O0agxFpYc+Ue8Lpzcd7/QCtPyz8TKwwo?=
 =?us-ascii?Q?4Q3MFcgTFGr2A34xKRoG+LQi2I0vi1IWv0bRrTVn+ADsRaergPfBQHtrr6bO?=
 =?us-ascii?Q?Nh5w0CMjerGvrFaTzbKzXczAQy3r77xkJ9yCYeOtpQl+3+fMcDwYaB1b1J7Q?=
 =?us-ascii?Q?v2bf+/NR/ph7oAIDQzsggrTu9DqBN8R8S2MzvbE72A40LUQe7W4vvJfi7lp4?=
 =?us-ascii?Q?ecJgUu999S+j7FlRjrY540Yt2vf8oiA/O0hvLgtj6ljbqOvfx/TDAWpvDowc?=
 =?us-ascii?Q?Iddc+nqSWUactRvzBL7nThJ0BHd1BHbvNliqlczbRIsMiXyx4HmDEB7vlmbb?=
X-MS-Exchange-AntiSpam-MessageData-1: V4veVakDRFYcPmZJPW7LL8u4nNA3sZN1LOo=
X-Exchange-RoutingPolicyChecked: km2jpstnjxJrakawSFSQ3LTXfbT7EmyuqJtcEON7ArxE34bLhb/OLaOorUmIljvTVbGxoeDcR4EoLctf7RMmKylEFWReDVpg/Sttlr5214m/MqMqWcIYt1WPx4BTwwkyTGv7XkUIGJaFjjx7k7v6R92JO6qAB84KUDpz01fdAWmaIADAq1cHuPfUeQnNBpG79Jsd+S2IzVtmQS60TqvIWHIBYUo2A8XdzIkJn0RrrH173AjanKuUM3979KNuIanOjCq/RDJRYPIj6FWB0QL6PDYpw4JO55BTQ8ke7zvfoMgZt1iSQfM5B+UfEOoaCOvyiV8Gvi2Y8X178mgWktyhtw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c2942ffe-7a6c-44bd-c5f7-08deee33e20e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 12:12:55.3164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7NYa1DLjeK/hPXMgUIMiwai0N/Rifc/OuKpbwJhPEREEhxM7EerUDPWQ3GWDNt3RyOfR2i83IIaS65PNzVartGxvUbTHY3gpZHSKIHuwOL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4749
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785413582; x=1816949582;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=n3zgTv35ALRGluAeZfg8VJ5qdFmjTiSgc5DN6tmLeO4=;
 b=XEZK3mqmVEz9I43VK4FF0rOhrZ7wSuWrtFhyQfZe3jiSRY70sMHcqKRb
 1OPPx2Lyv7AacjK2kxGMVMofY8OS3hL357wv0TfiQTWSQ5vIEFIg1Kf3f
 3P3FJj1+VMlty45w2qlOxcxyDVKW7Wy+ykOVEP1c2FPqPtcUYCxyL1xXU
 2nQiqzOqwPCg8BOZYoY8k6bXTCmniAChnnOTZELKKhh3eAN9HCS8/ouzU
 Ypm0KJtWIK9RwvNRZIpRwOOySpNDnvxAUuZnoGtfni8cZ6Nho0WHA8lwY
 o75xagLO2JKaLdcCOD/K1h+tm9WDnhW75aWtOSXLy1oCzXo147KY5vaME
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=XEZK3mqm
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH net-next v2] i40e: xsk: use
 xdp_build_skb_from_zc() for XDP_PASS
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

On Wed, Jul 29, 2026 at 01:49:16PM +0800, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> Replace the driver-local i40e_construct_skb_zc() with the common
> helper xdp_build_skb_from_zc(). On failure, free the xdp buff in
> the caller.
> 
> xdp_build_skb_from_zc() already calls skb_record_rx_queue() and
> eth_type_trans(), so pull the remaining descriptor field setup into
> __i40e_process_skb_fields() and use that on the XDP_PASS path.
> Briefly restore the Ethernet header around eth_skb_pad() so padding
> sees the full L2 frame length.
> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
> v2:
> - Extract descriptor field setup into __i40e_process_skb_fields() and
>   use it on the XDP_PASS path, so skb_record_rx_queue()/eth_type_trans()
>   are not repeated after xdp_build_skb_from_zc().
> - Keep a brief __skb_push()/__skb_pull() around eth_skb_pad() so padding
>   still sees the full L2 frame length.
> 
> v1:
>  - https://lore.kernel.org/all/20260724020125.246333-1-chenguang.zhao@linux.dev/
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 32 ++++++--
>  .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 +
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 76 +++----------------
>  3 files changed, 36 insertions(+), 74 deletions(-)
> 

[...]

>  static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
>  				      struct xdp_buff *xdp_buff,
>  				      union i40e_rx_desc *rx_desc,
> @@ -372,21 +309,28 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
>  		 * BIT(I40E_RXD_QW1_ERROR_SHIFT). This is due to that
>  		 * SBP is *not* set in PRT_SBPVSI (default not set).
>  		 */
> -		skb = i40e_construct_skb_zc(rx_ring, xdp_buff);
> +		skb = xdp_build_skb_from_zc(xdp_buff);
>  		if (!skb) {
> +			xsk_buff_free(xdp_buff);
>  			rx_ring->rx_stats.alloc_buff_failed++;
>  			*rx_packets = 0;
>  			*rx_bytes = 0;
>  			return;
>  		}
>  
> +		/* xdp_build_skb_from_zc() already ran eth_type_trans() and
> +		 * skb_record_rx_queue(). Restore the Ethernet header only for
> +		 * eth_skb_pad(), then pull it back.
> +		 */
> +		__skb_push(skb, ETH_HLEN);
>  		if (eth_skb_pad(skb)) {
>  			*rx_packets = 0;
>  			*rx_bytes = 0;
>  			return;
>  		}
> +		__skb_pull(skb, ETH_HLEN);

I am pretty sure that eth_skb_pad() is not needed on Rx, network stack handles 
small skbs just fine, and no other vendor does this. We were trying to figure 
out the historical reasons for eth_skb_pad() being there in the intel drivers, 
but with no luck.

>  
> -		i40e_process_skb_fields(rx_ring, rx_desc, skb);
> +		__i40e_process_skb_fields(rx_ring, rx_desc, skb);
>  		napi_gro_receive(&rx_ring->q_vector->napi, skb);
>  		return;
>  	}
> -- 
> 2.25.1
> 
> 
