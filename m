Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF28C606A321
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=dWZSB4TF;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eHmrKl6K
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43B654062E;
	Mon, 19 Oct 2026 17:31:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xpmSX_P17Pf3; Mon, 19 Oct 2026 17:31:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 470E740699
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792431066;
	b=Q7qmDTq0kFfxnYcs3kI4Kd0RsamdtAVeJDbETzitO5+Y3rzOgnw60kHJ73DdLUv7rUxt
	 JI6JArRgzkhjYiz/2tRrGc7ET4j4q+Y+9/f0Z/ADWebAXSdMznHbwHA3MPS5hGmbXIe6z
	 t9WAjGkD0z6Oi3FZS3mKVIcP3rNv+oiLkEpNy1SupLjEBsIqUMFF71+cJRWrY0vX9vyZN
	 VpHIXAwL6M5RGa/8NdG9bFSzOirQZG6Y86jRwEqK0GMypMuZT0E9/xtlX9svzj1D5U5jC
	 zgkXt/6l+qO1lwyKYZXHTzzTQ/7HgKIiqcMG7XJOsB7eE2Le5KNYWO0VJMJBWrhAH4g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792431066;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Content-Type:Message-ID:Date:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=NR3jZFulcGHVy/pZ5fuojxIoGr1PKqA0L+0uiqN3tEg=;
	b=HOzS9+QzyTJQji9UsCCQwiFSK66lzo95OfXeDyaV7uq2ZosQnWyCgnvTIidlUBb4rEH7
	 cpKXBBls3CMtmzfpnZZAjmflT6qG1aXdviX6ZFnc2wET+y/wzp6NqPL+I8RtFsoHsWm8L
	 ZSvfFtcV9qNGF4WHsPmwqPOFWYV979NyGawiIzA6JyvnkzIlT/ZdR4lp0QLWL24NK4H+u
	 kH+hT9n4ozo9htZQdW2OafGrl8alPRTvfe+3OoHiVajevizjGilQZAKmvl6Duc7o2PfKj
	 T0XQcSIpg9EnJ3FHjO+VlGxYbgM1D/rLGbVVXzLl/FiU15XfCZd8SxI5/VqbBEjaPjA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eHmrKl6K;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792431066;
	bh=NR3jZFulcGHVy/pZ5fuojxIoGr1PKqA0L+0uiqN3tEg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dWZSB4TFiPk3otM5ThhQAHz3m3ZZN8++Lq4Xi28A/4Fu92EppI5ThC6bfHUQRKxTm
	 M7rLtk24NZtMOeQXaHbwmHOqGqZAfyDLKUHCINUWXUPqG1WEY7hPDgFgbI34EDfQBF
	 I7q/1zg+28VFR+LdvMcxY5Frt+ZmDZ4PMIi7aLN6wQyyuU09A1MJW4bhQe1bVluV77
	 M2YkMBoBoaN7+e6yiPtN4f/egUsviYeVH46FFFHZ/KMjkL/z5fj0Ic414k3Rhrj1Hs
	 xd10xZRzzhOVWP5ySx1BXXp5q9b1UEuUy7028i7ieFgumwHWIaYX2O5fB323+w+tgK
	 WitQXp9Ctw8mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 470E740699;
	Mon, 19 Oct 2026 17:31:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 53F731AB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 17:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4577540699
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 17:31:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LPHAiVdcDtji for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 17:31:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 367AA4062E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792431064;
 b=gG5DCodsmn94psAhUPYrZA5TAaDy+cxp+mwQyj8m22mdZiwsEbQjokXUXSJLJbbc/9R8
 RvzypfGnuv46ezqhBbegWx2PNvRImqpyb6jcDKS3qd9cPwM/aeAIkmcqcVkzld+nM7zEs
 MQpz47wU23uzxEJmJlv2supMecD5LG8WXRSP5NbRlhnw+VkKtY87tFyoYo8uQxfPePzy6
 kxIU600TbLPomIJicOfOnMAZcZLFcLEHsHC98SvZir1aTzSNVA0RR5j2IjFXL6f8PGPC/
 woNVR/mE0uCvEp9Utq40Zb1iHnrtgwim6dJcNGfxH9groSXBYSJqOm/BD5dULYBB2wg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792431064;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Content-Type:Message-ID:Date:User-Agent:
 Subject:To:CC:References:Content-Language:From:In-Reply-To:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=NR3jZFulcGHVy/pZ5fuojxIoGr1PKqA0L+0uiqN3tEg=;
 b=qNoOo4gU7fbZTr8F15697rbCS60CeaeMqDhmLQCEhsr0dHfns+WICsxpxx76CYmfTwaG
 DzZDCcDu6ARxGxVPN5wnJxaogJSuYo6XPDAd8fuNxu0vBKzQQH/D/xK/vFcyd+Wq5nlBa
 H2bVUkqD/svf9l9DYbKpBT8M8a80cADCj0MFB8uEtdrcTif5TF2pc7WB4UfkvjykDtARd
 tPlR25EMzY9tIkxuD9FXbAEIekDplSYUpOgI/zFQM5IohhOibUw7r7qylTcYqo6zC4uYl
 tcPY9ChxmyeWb0Hy6dLqPud5QSM6nI0E7IIZjccBEKN2BJxvI0Hq6XGfCGN8qo7aoZg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eHmrKl6K; 
 arc=fail smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eHmrKl6K
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 367AA4062E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 17:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792431064; x=1823967064;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=yNl6AUpE/WWgldIo/AA8AKQQiwJ+CSTwoj38eelfMNc=;
 b=eHmrKl6KcUX8ssyC/UWHzd90GGLlAyET0/AsUUakmGKDoVn12tK7TSVM
 qw6+Bp8iwf8bQNI7UbOicJI51Vym7Pm2zFpFmm9PFGrrsbFFvHaHsFTFH
 j25Kd2hacOBhaizt84caJPqdibMdQpHbwJNAQtNUFYAua+6yjI51Qsctj
 961pHK3jWVrzwNRpvzvplfWkXkBvRhbLeFZtZcim+y5J7FQIC9rxveH+d
 UfOybRGjIpfaBF1BjZwYWxf2qRiinmrtHzc3Dk6rCqfUkHVIc9XIJAO/4
 JpuZHpVkDy6XKFXjDIF++xTDieQ0skSk4iTq98PO98e/UkvyxX4qLruoJ w==;
X-CSE-ConnectionGUID: GGdQ+ukvT2GQhMqQO6IVMg==
X-CSE-MsgGUID: cbBEESRhT0SonuBDWQ7D+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1000005"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1000005"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 10:31:01 -0700
X-CSE-ConnectionGUID: AeTuoyRFTeSZej9zRZ0Ymg==
X-CSE-MsgGUID: NXtASfeESbO5tv+/O8ceTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2970879"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 10:31:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 10:31:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 10:31:00 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.59) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 10:31:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3HR0HKjl+uCZWvRZ3SieBtBRQCYpQiF6fCG3TClMMVl+YktIETuNE+6oRSQyG/812uB3mE3MEekDUSvLYVQwVP3WQy+JmnKTPNYgS3pnMWURIFuNUn565RQCIG2pcwPxTqfZYPmPJra+7Yjb5BunVHMVzKuRMmwK+vw6uSo3A+NZmTCCHYWal5grlpmYdGPKJ9iBin4uH4yUsKiKbjVLc0PbzJ3erud4e5+c+ArOydow6KZLw/QCqkveswCiYDJN1nF4r4ltKySfQYKnLQIr6UaG9oRuwd/m6iJ5HW0JBMMRbwtz8REFL2GLUaRZR8Gn4lraeB64VhXAdaUp2cgAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tskK8T7sfdOV3t6v2GnxKiHvkYyUeovjs+S3Hq3+tFc=;
 b=rN6YDtiQekl+tXOWaNq1KHI5JwmR8vEPz17P2/C3qpiTl5XBmJtrDDk0B25UbMTlcM55KNNU9MtdK0Z6IMh6V689HB7uezJDNE6nmffMWSOKXGjKBpaC5jisftsHJ73P24Q0UFrY8VJUjJjH6IvOc5QBy/wavMYK482qlwGSHPjPtfYEQ/OcLzcNWg2Om1h2m4rpEI/cANqTTNcTNY7wr45NQertxdTIhXDaiqbnDpgUN9opKE7DhP3kiEz9qPZmJTuw+/cHj5wrVNy3/9WNIgP8WieNvza9nmXP6hGMnmREfPODrVG+QFMQCyIsQIFCnRrL0xZkzPJ3DJkJx9ioBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6)
 by IA4PR11MB9036.namprd11.prod.outlook.com (2603:10b6:208:565::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 17:30:58 +0000
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3]) by SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 17:30:58 +0000
Content-Type: multipart/mixed; boundary="------------5ivQh4pUisaZRkRLa0yOe2kc"
Message-ID: <396762d0-9e46-4fad-b2c3-463ff62bb2a4@intel.com>
Date: Mon, 19 Oct 2026 20:30:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: igc (i226-V): persistent RX-path cost regression after rx
 buffer-exhaustion storms
To: Frank Zhang <zhangerfei@gmail.com>, <netdev@vger.kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>
References: <CAFnR4j-mCem16E7c46E-Ty_uN5-z5MmH_X0MBddY1V-Mi8KBXg@mail.gmail.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <CAFnR4j-mCem16E7c46E-Ty_uN5-z5MmH_X0MBddY1V-Mi8KBXg@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To SJ0PR11MB5630.namprd11.prod.outlook.com
 (2603:10b6:a03:3bb::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5630:EE_|IA4PR11MB9036:EE_
X-MS-Office365-Filtering-Correlation-Id: 674d02d0-22aa-4648-0ead-08df2e06bcf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|6049299003|376014|4053099003|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 5KFeklfNYfYFQPxnfgrqmkWRyayYdi0N12FA5NW+Mdf4n0F0VmzDh45iwo4+/EsbLNXKfOqiUE0FvBHfodGDh4HYPpqPS68gJFyDSLtJ00NEZ88izWAjft72V2suxzsyrHy3S9Uo1uF20+vsuQOLazcRISwmkOFD0TuFQj4Mcr6DcpXXPQW+SFYebO9rQ/3tm2FGTzEUJLiDxqhNQnqolo82/vT14GcybbRM+GsWZAj4tV/2Msu6nMCje9c1+XrN6lnON+964GQNwkOPcMNL+w87QBZ44VZHx7aER+BApfNovfffRXkrbsmYNsWQxpeGolq+r7fSdlXgRPLrKGGN5U3BmlFZcaGk0vW5E9xiXCDUd+vg6zDUBuyw/xfKsrcUORHZ2Zr34Fu5KIUKMoO7x74O1V/QIUO/LU8mCtmk3ZvFHWOmC/xKvD287AknpJVLHqdJn6csiLRAX/QL6gw5+v5gt6N3Odh32fkBqFb+vee6rFFWGPWRbwtV2c6aitUosN5ODCOCVtcMS6O9V6nzwRvi/fTq3z4HlpB0tU9C+JM3kd+Zl5lP+n8luUxA31WvsQ72d1YizqOPhamHET5X5tLmTHhdBXbNjuf36g1FzAV+V7xjyh8dfkAHDfhHTrAtmEuSW3V0mcwgG3ZQ65ieZBY9nd03vk4w79x3EWRfPz0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5630.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(6049299003)(376014)(4053099003)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clQ4cEFkeHdRTy9WUnh3enJZSk1vN1hKeWxNejJOckgwcFFzYm1FRERsdGV6?=
 =?utf-8?B?V1dMUXBuSm5ocExheWNPYUhISWFIQ1B5SjZCS0NqUTlXYUhBRDVaaDhtT1Q5?=
 =?utf-8?B?b2hMMG5CV3FHWi9DallYTllRVURTamY5YS91NFhLbDFkM1h3SE40U0ptSzcr?=
 =?utf-8?B?eXc3TWs5aUlUQjVNc3M3aFd5TDdJdk1PMXZvb3czTitLeGhhTDEzSGhnMEVW?=
 =?utf-8?B?V1AzL1ZoeThhVHlHVjdBTjFUR0VRcVdNbExDUy9wMXJPeVFSL3hCVTJjeHlB?=
 =?utf-8?B?SkdWMmhTS0lIYUQ5dTEvcHI5VGZxVkpFYnB2eURoK3Q5QWxhSEI4Sm5pbUo5?=
 =?utf-8?B?ZWtlRkhCTktsZ2N0MXJNYXZtU1hTOVdjTXJkUXZPcWt2TS9pYTRDUlVqbUdx?=
 =?utf-8?B?L0VrZ2VQODBzcXdPOXhsS0FFN3hBTGxpcnVnRGFoOWhYOWdpNkdtZktXSHVL?=
 =?utf-8?B?N0ZmQ1hOMGxueElneHNsVHMvU21xK1pLaldDRWVidEoxTWFCeEpVT0FFdU9E?=
 =?utf-8?B?OXVxandadjNMSjIzTzdZTTV2YU5RNXNDbTkzSUU3ZG50ZW5ZMFhVbXErOVZU?=
 =?utf-8?B?THpQRk8xVnpFaW5FZUNVUHAyRm16dnhKdkRJTWFIYk1KQ3B5eFpLcUw1YnhF?=
 =?utf-8?B?NC9taUkrUmIxbmxUSWc5N1R4cnVYTk43L1VPZkIxbUN3TXV3SmdKRXRnWEFi?=
 =?utf-8?B?K3FKaDI4ZE95ZjU2cVFMSnhEbEk2cjBUUFlMNllFc2hrWHRhVUFzYlZPRkVl?=
 =?utf-8?B?YytOa2lQMWhMN0cxQmxUK2NKTHRGSTVtSXk4K1NkSWdVRWM3dlVkUGF1TGpP?=
 =?utf-8?B?SysyaVVadlQ1Y0dPSWNEZGx0SVlZbis0bDhOMXpLMnc5aFJOVGtJaXQwSkFW?=
 =?utf-8?B?NkYyYTU5UWI0YW11ZnBDK3FKbXF6QjkzVE95SmtEZVFGOVhuRmRhY0VabVp2?=
 =?utf-8?B?VzZPL2Y4M0hxYTFqQjdKNGRZbjk2MU9WdXI1aEpGR1VMZDV0VE1IdkFpb1hp?=
 =?utf-8?B?bnV5SlRnbWZlQzUyVUptV2dMSHY3akZyNktxY3JNc3czYkNxZy8wZ29yQllq?=
 =?utf-8?B?b2xZSkFCVnRLMGU3TlJJZmc0RXVnKzV6cU14dlN2THNndFoxbHhKNnlIbkl4?=
 =?utf-8?B?MUNKVVBhdHdUbkdIOTJ2Z1RiQzRSbExWZkdlOGV4V2QyaEVpYlB3R29TSU9q?=
 =?utf-8?B?c2dpd3o0clJoNFM4Wk9EbmZpMDh2VmYyQkp0azdCaVUveG1yWTluMXA5Slhj?=
 =?utf-8?B?aEt1bjNJeWFFZlR0a1Y1aFVHMmQzdUdFY0dYQUhtTlJ0Q2tDbWlENjhaYmhD?=
 =?utf-8?B?M1ZyTVluaWJIeVdYMWt2aG52TkNNMnJyNkdRSlJVb3I5WXBnMHpKSnc3enB4?=
 =?utf-8?B?dWo3eGlyMHlIS0czWGdONkE0OTJjcWJ1MC9TY09hUjJJSU90NTRhZTFpYkpt?=
 =?utf-8?B?M3pTcEVzaTRyb0JKeVpWRzhhUGEweElVV3BZaUpzdnB1RHBGbnBva05HTGVR?=
 =?utf-8?B?b3JMditieVhHbFdOdlQzR0Y3clFQa3pvejFxR2VOaUo2bEZzeTZCSkx5Sk5o?=
 =?utf-8?B?YWlYR3lqQll2MkJKdlVhMjhRWC9jcTdoUzEvN2VFL2Q3eVBodWtsdGx4QytY?=
 =?utf-8?B?UDNWU2FXajlxZWYwb3VNenF6ZUlMeXRYR2hkbzE0YXZmOWxuNTZLaFhjaEx2?=
 =?utf-8?B?TzMzRUFtaVhnZEVzM0JqTnpZUStnZG8ybjBXUFc3UitsUHlBNVhHQWNYY3pq?=
 =?utf-8?B?R3RmV0tVMmlOK1c0OUxBSUV3VGdtM0QzcG1WZXpNMEJVc1pHRVhxdXVVT21z?=
 =?utf-8?B?OUMxQ2M5U1ByVGFZelVXNUpkcHdsWm55dCs3TUdEd0NuN3gvMTdCV2FERkJy?=
 =?utf-8?B?a2pMVGI3UlJkeHhrYWlzMGEyaU9uc3JDQ1V2aGhPMWNQYjFKdzRjSWNtS3VM?=
 =?utf-8?B?cUVmY3dTUWtQbmM5a2pmcmVPditmVVZkSHNkdVJmRjQxWnBKdGhiMlBFY0tB?=
 =?utf-8?B?OGdDcitwQ214Rk5rTHdkaU9uTkVzNENqZmdad2tvMjVOM3plSG9wdlRBMWM3?=
 =?utf-8?B?TTNQcy93NjVaVG1tNnhUQzkrMXh6NncvaTNtTUgrZUo2MHZmZDBQK2xabkNn?=
 =?utf-8?B?NzRBaytuMTUybTVtMHNCbFdvb3h3U2xjSkxwRU1hUDZUUjVSOGFnU3NJOEFV?=
 =?utf-8?B?dE42RlVmT296OXovbVdzU1EzYlZZN2NONnBKcExhTWVnNEd2V3Jlc1pFazNS?=
 =?utf-8?B?eTF5S05hQW5EM0FUUVZISkdFK0xncEFDeWJLdjFQTkh2WitOSjEvdkNNYzBm?=
 =?utf-8?B?ZTlLb01FaDVoRmtXQWdaRlAybGJLMjUzTUtYc1hBc1kxdHRiUHdzdz09?=
X-Exchange-RoutingPolicyChecked: eQx9VMWJxlYyisQUC8sFJ33JT/Oqt0qxjvrGxF0UrFKjTWxKRkWkSUai74r7rgBqEyQRStGIz7KP8ze6/bAhYaRkyWrCFRuBIdxbwkR4snM6dSy9HUDzKXLhzaNANX36zaZSkvAUDl4i2tZoOVq8QaPKdfkn7ufUDqkwygxquo+kWBxpesH6T+eZWKIF2ONE/CjkrT56caVl0Y/SxUPHBTbU8x6Z+Ns5u78CpvNC6znpQx2WLglwDBNyLqjQzQWsqm1BoUngNCzZmi99Z9MFw/nAWx4oeGjaNG0KKXDxLKah1eIFFOYwNA/p6pKdXQxoKcrgp55qPpDzfr+S7iiF0Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 674d02d0-22aa-4648-0ead-08df2e06bcf0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5630.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 17:30:58.5329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MePxRCarKRuI/6lgnapZeUS04iwl2hW0b2yhsRYMSv4WMFwe7edOpXWKjJk13Qa041qu9BiTH1Q4del4ZkoFsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9036
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------5ivQh4pUisaZRkRLa0yOe2kc
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 14/10/2026 19:02, Frank Zhang wrote:
> Hello,
> 
> We run a native-XDP forwarding datapath (an eBPF GTP-U user plane) on an
> Intel N100 mini-PC with two i226-V NICs (in-tree igc, firmware 2023:889d,
> 2.5GBASE-T; Ubuntu 24.04, 7.0.0-38-generic, iommu=pt). Small-packet
> capacity is ~2.6 Mpps/port here. We found that after the port is
> over-offered for a few seconds, the RX path keeps a persistent per-packet
> cost regression after the offered load is reduced back to a clean level.
> It never recovers on its own. A comparable storm-and-return test on a
> second box with an ixgbe NIC did not leave a persistent regression, so we
> would appreciate a look from the igc side.

Hello, Frank.
Thank you very much for this report and the in-depth analysis.

Your description makes me think that it is probably not a hardware 
limitation, but more like some inefficiency in the allocator, or 
specifically how the igc driver uses it.

> During the storm __page_frag_cache_drain runs 0.45-0.73M times per 15 s;
> storms that do not trigger this recycling leave layout and performance
> unchanged. Our reading: storm -> buffer recycling churn -> refill from
> fragmented blocks -> scattered ring pages -> per-packet page-metadata
> misses.
> 
> We are not claiming this is igc-exclusive -- ixgbe shares a similar
> RX-buffer lifetime shape; the X520 result above just means we cannot say
> the effect is universal either.

This observation suggests that there may be some secondary factors at 
play. I confess that I am not an expert in the details of how this 
allocations and recycling works and what may affect it. I consulted my 
AI agent, which suggested to add a bit of instrumentation to see which 
places in the code dealing with this are hit, and when.

Maybe this duplicates some of the data you already collected, but just 
in case it will help, the instrumentation patch is attached, with the 
following advice:

Apply 0001-igc-add-rx-page-lifecycle-instrumentation.patch (need to use 
patch, not git am), and collect ethtool -S before storm, during storm, 
and after recovery attempts.

> 
> 3) Recovery (measured)
> 
>    ip link down/up, ethtool -r, FLR, compact_memory: no effect
>    rmmod/modprobe x1: partial
>    rmmod/modprobe x2-3: near baseline, stable
>    reboot: full
>    (local workaround: force fresh ring allocations at refill: full)
Interesting observation. Could you elaborate more on this "local 
workaround: force fresh ring allocations at refill" which successfully 
recovers the performance? How was it implemented? Do you also have a 
patch to share?

> 
> 4) Related observation (happy to split out or drop)
> 
> The default RSS indirection table is block-interleaved
> (igc_setup_mrqc(): tbl[j] = (j * queues) / IGC_RETA_SIZE). With
> correlated tunnel flows (GTP-U flows differing only in low tuple bits)
> and a per-boot random RSS key, we saw the whole workload collapse into
> one 32-bucket block -> a single RX queue (2 cores saturated, capacity
> ~halved). ethtool -X equal N restores the spread; we apply that as a
> workaround. ixgbe initialises this table interleaved. Flagging because it
> materially lowers this box's small-packet ceiling and makes the storm
> above easier to reach. (Also: RSS key get/set was merged in July 2026 --
> thanks; our distro kernel predates it.)
This might be worth to tackle as a separate patch. If ixgbe's default 
initialization is more optimal, then we can consider updating igc (maybe 
also igb, which I believe is similar) to use a similar approach.

> 
> 5) Ask
> 
> - Is this persistent post-storm state known for igc/I226? Any recommended
>    mitigation?
Not something I am aware of. Such persistency is not something expected 
from the hardware, and if it is a software-related inefficiency (which 
it sounds like), then hopefully it can be tackled in the driver/kernel.

> - Would keeping the RX ring pages collectively fresh (allocation
>    strategy, higher-order pages, a local reserve) at refill time be
>    feasible in the driver, or is this considered allocator-side?
Depends on the fix. If you have some workaround that resolves the issue, 
we can think where it naturally belongs.

Thanks!
--Dima

--------------5ivQh4pUisaZRkRLa0yOe2kc
Content-Type: text/plain; charset="UTF-8";
	name="0001-igc-add-rx-page-lifecycle-instrumentation.patch"
Content-Disposition: attachment;
	filename="0001-igc-add-rx-page-lifecycle-instrumentation.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2MuaCBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2MuaAppbmRleCBmMWVmYWRiZDlmNzQuLjgxODYy
YjdkNWIxYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnYy5o
CisrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2MuaApAQCAtNjUsNiArNjUs
MTYgQEAgc3RydWN0IGlnY19yeF9xdWV1ZV9zdGF0cyB7CiAJdTY0IGRyb3BzOwogCXU2NCBjc3Vt
X2VycjsKIAl1NjQgYWxsb2NfZmFpbGVkOworCXU2NCBwYWdlX3JldXNlOworCXU2NCBwYWdlX3Jl
dXNlX2ZhaWxlZDsKKwl1NjQgcGFnZV9yZXVzZV9mYWlsZWRfZGV2X3BhZ2U7CisJdTY0IHBhZ2Vf
cmV1c2VfZmFpbGVkX3JlZmNudDsKKwl1NjQgcGFnZV9yZXN0b2NrOworCXU2NCBwYWdlX2FsbG9j
czsKKwl1NjQgcGFnZV9hbGxvY19tYXBfZXJyOworCXU2NCBwYWdlX2RyYWluczsKKwl1NjQgcmVz
b3VyY2VfYWxsb2NzOworCXU2NCByZXNvdXJjZV9mcmVlczsKIH07CiAKIHN0cnVjdCBpZ2Nfcnhf
cGFja2V0X3N0YXRzIHsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ln
Yy9pZ2NfZXRodG9vbC5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19ldGh0
b29sLmMKaW5kZXggODlmZTI3ODhhNTY1Li4zZWZmN2EwY2IwZDUgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfZXRodG9vbC5jCisrKyBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfZXRodG9vbC5jCkBAIC03OTAsNiArNzkwLDE2IEBAIHN0
YXRpYyB2b2lkIGlnY19ldGh0b29sX2dldF9zdHJpbmdzKHN0cnVjdCBuZXRfZGV2aWNlICpuZXRk
ZXYsIHUzMiBzdHJpbmdzZXQsCiAJCQlldGh0b29sX3NwcmludGYoJnAsICJyeF9xdWV1ZV8ldV9k
cm9wcyIsIGkpOwogCQkJZXRodG9vbF9zcHJpbnRmKCZwLCAicnhfcXVldWVfJXVfY3N1bV9lcnIi
LCBpKTsKIAkJCWV0aHRvb2xfc3ByaW50ZigmcCwgInJ4X3F1ZXVlXyV1X2FsbG9jX2ZhaWxlZCIs
IGkpOworCQkJZXRodG9vbF9zcHJpbnRmKCZwLCAicnhfcXVldWVfJXVfcGFnZV9yZXVzZSIsIGkp
OworCQkJZXRodG9vbF9zcHJpbnRmKCZwLCAicnhfcXVldWVfJXVfcGFnZV9yZXVzZV9mYWlsZWQi
LCBpKTsKKwkJCWV0aHRvb2xfc3ByaW50ZigmcCwgInJ4X3F1ZXVlXyV1X3BhZ2VfcmV1c2VfZmFp
bGVkX2Rldl9wYWdlIiwgaSk7CisJCQlldGh0b29sX3NwcmludGYoJnAsICJyeF9xdWV1ZV8ldV9w
YWdlX3JldXNlX2ZhaWxlZF9yZWZjbnQiLCBpKTsKKwkJCWV0aHRvb2xfc3ByaW50ZigmcCwgInJ4
X3F1ZXVlXyV1X3BhZ2VfcmVzdG9jayIsIGkpOworCQkJZXRodG9vbF9zcHJpbnRmKCZwLCAicnhf
cXVldWVfJXVfcGFnZV9hbGxvY3MiLCBpKTsKKwkJCWV0aHRvb2xfc3ByaW50ZigmcCwgInJ4X3F1
ZXVlXyV1X3BhZ2VfYWxsb2NfbWFwX2VyciIsIGkpOworCQkJZXRodG9vbF9zcHJpbnRmKCZwLCAi
cnhfcXVldWVfJXVfcGFnZV9kcmFpbnMiLCBpKTsKKwkJCWV0aHRvb2xfc3ByaW50ZigmcCwgInJ4
X3F1ZXVlXyV1X3Jlc291cmNlX2FsbG9jcyIsIGkpOworCQkJZXRodG9vbF9zcHJpbnRmKCZwLCAi
cnhfcXVldWVfJXVfcmVzb3VyY2VfZnJlZXMiLCBpKTsKIAkJfQogCQkvKiBCVUdfT04ocCAtIGRh
dGEgIT0gSUdDX1NUQVRTX0xFTiAqIEVUSF9HU1RSSU5HX0xFTik7ICovCiAJCWJyZWFrOwpAQCAt
ODY0LDYgKzg3NCwxNiBAQCBzdGF0aWMgdm9pZCBpZ2NfZXRodG9vbF9nZXRfc3RhdHMoc3RydWN0
IG5ldF9kZXZpY2UgKm5ldGRldiwKIAkJCWRhdGFbaSArIDJdID0gcmluZy0+cnhfc3RhdHMuZHJv
cHM7CiAJCQlkYXRhW2kgKyAzXSA9IHJpbmctPnJ4X3N0YXRzLmNzdW1fZXJyOwogCQkJZGF0YVtp
ICsgNF0gPSByaW5nLT5yeF9zdGF0cy5hbGxvY19mYWlsZWQ7CisJCQkJZGF0YVtpICsgNV0gPSBy
aW5nLT5yeF9zdGF0cy5wYWdlX3JldXNlOworCQkJCWRhdGFbaSArIDZdID0gcmluZy0+cnhfc3Rh
dHMucGFnZV9yZXVzZV9mYWlsZWQ7CisJCQkJZGF0YVtpICsgN10gPSByaW5nLT5yeF9zdGF0cy5w
YWdlX3JldXNlX2ZhaWxlZF9kZXZfcGFnZTsKKwkJCQlkYXRhW2kgKyA4XSA9IHJpbmctPnJ4X3N0
YXRzLnBhZ2VfcmV1c2VfZmFpbGVkX3JlZmNudDsKKwkJCQlkYXRhW2kgKyA5XSA9IHJpbmctPnJ4
X3N0YXRzLnBhZ2VfcmVzdG9jazsKKwkJCQlkYXRhW2kgKyAxMF0gPSByaW5nLT5yeF9zdGF0cy5w
YWdlX2FsbG9jczsKKwkJCQlkYXRhW2kgKyAxMV0gPSByaW5nLT5yeF9zdGF0cy5wYWdlX2FsbG9j
X21hcF9lcnI7CisJCQkJZGF0YVtpICsgMTJdID0gcmluZy0+cnhfc3RhdHMucGFnZV9kcmFpbnM7
CisJCQkJZGF0YVtpICsgMTNdID0gcmluZy0+cnhfc3RhdHMucmVzb3VyY2VfYWxsb2NzOworCQkJ
CWRhdGFbaSArIDE0XSA9IHJpbmctPnJ4X3N0YXRzLnJlc291cmNlX2ZyZWVzOwogCQl9IHdoaWxl
ICh1NjRfc3RhdHNfZmV0Y2hfcmV0cnkoJnJpbmctPnJ4X3N5bmNwLCBzdGFydCkpOwogCQlpICs9
IElHQ19SWF9RVUVVRV9TVEFUU19MRU47CiAJfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
Z2MvaWdjX21haW4uYwppbmRleCAwMTlmMGMyMzc1ZDcuLjM2NjgwODkzMTllMCAxMDA2NDQKLS0t
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMKKysrIGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMKQEAgLTQ5NSw2ICs0OTUsMTMgQEAg
c3RhdGljIHZvaWQgaWdjX2NsZWFuX2FsbF9yeF9yaW5ncyhzdHJ1Y3QgaWdjX2FkYXB0ZXIgKmFk
YXB0ZXIpCiAJCQlpZ2NfY2xlYW5fcnhfcmluZyhhZGFwdGVyLT5yeF9yaW5nW2ldKTsKIH0KIAor
c3RhdGljIHZvaWQgaWdjX3J4X3Jpbmdfc3RhdF9pbmMoc3RydWN0IGlnY19yaW5nICpyeF9yaW5n
LCB1NjQgKnN0YXQpCit7CisJdTY0X3N0YXRzX3VwZGF0ZV9iZWdpbigmcnhfcmluZy0+cnhfc3lu
Y3ApOworCSgqc3RhdCkrKzsKKwl1NjRfc3RhdHNfdXBkYXRlX2VuZCgmcnhfcmluZy0+cnhfc3lu
Y3ApOworfQorCiAvKioKICAqIGlnY19mcmVlX3J4X3Jlc291cmNlcyAtIEZyZWUgUnggUmVzb3Vy
Y2VzCiAgKiBAcnhfcmluZzogcmluZyB0byBjbGVhbiB0aGUgcmVzb3VyY2VzIGZyb20KQEAgLTUw
Myw2ICs1MTAsOCBAQCBzdGF0aWMgdm9pZCBpZ2NfY2xlYW5fYWxsX3J4X3JpbmdzKHN0cnVjdCBp
Z2NfYWRhcHRlciAqYWRhcHRlcikKICAqLwogdm9pZCBpZ2NfZnJlZV9yeF9yZXNvdXJjZXMoc3Ry
dWN0IGlnY19yaW5nICpyeF9yaW5nKQogeworCWlnY19yeF9yaW5nX3N0YXRfaW5jKHJ4X3Jpbmcs
ICZyeF9yaW5nLT5yeF9zdGF0cy5yZXNvdXJjZV9mcmVlcyk7CisKIAlpZ2NfY2xlYW5fcnhfcmlu
ZyhyeF9yaW5nKTsKIAogCXhkcF9yeHFfaW5mb191bnJlZygmcnhfcmluZy0+eGRwX3J4cSk7CkBA
IC01NzgsNiArNTg3LDcgQEAgaW50IGlnY19zZXR1cF9yeF9yZXNvdXJjZXMoc3RydWN0IGlnY19y
aW5nICpyeF9yaW5nKQogCXJ4X3JpbmctPm5leHRfdG9fYWxsb2MgPSAwOwogCXJ4X3JpbmctPm5l
eHRfdG9fY2xlYW4gPSAwOwogCXJ4X3JpbmctPm5leHRfdG9fdXNlID0gMDsKKwlpZ2Nfcnhfcmlu
Z19zdGF0X2luYyhyeF9yaW5nLCAmcnhfcmluZy0+cnhfc3RhdHMucmVzb3VyY2VfYWxsb2NzKTsK
IAogCXJldHVybiAwOwogCkBAIC0yMDc2LDIwICsyMDg2LDI5IEBAIHN0YXRpYyB2b2lkIGlnY19y
ZXVzZV9yeF9wYWdlKHN0cnVjdCBpZ2NfcmluZyAqcnhfcmluZywKIAluZXdfYnVmZi0+cGFnZWNu
dF9iaWFzCT0gb2xkX2J1ZmYtPnBhZ2VjbnRfYmlhczsKIH0KIAotc3RhdGljIGJvb2wgaWdjX2Nh
bl9yZXVzZV9yeF9wYWdlKHN0cnVjdCBpZ2NfcnhfYnVmZmVyICpyeF9idWZmZXIsCitzdGF0aWMg
Ym9vbCBpZ2NfY2FuX3JldXNlX3J4X3BhZ2Uoc3RydWN0IGlnY19yaW5nICpyeF9yaW5nLAorCQkJ
CSAgc3RydWN0IGlnY19yeF9idWZmZXIgKnJ4X2J1ZmZlciwKIAkJCQkgIGludCByeF9idWZmZXJf
cGdjbnQpCiB7CiAJdW5zaWduZWQgaW50IHBhZ2VjbnRfYmlhcyA9IHJ4X2J1ZmZlci0+cGFnZWNu
dF9iaWFzOwogCXN0cnVjdCBwYWdlICpwYWdlID0gcnhfYnVmZmVyLT5wYWdlOwogCiAJLyogYXZv
aWQgcmUtdXNpbmcgcmVtb3RlIGFuZCBwZm1lbWFsbG9jIHBhZ2VzICovCi0JaWYgKCFkZXZfcGFn
ZV9pc19yZXVzYWJsZShwYWdlKSkKKwlpZiAoIWRldl9wYWdlX2lzX3JldXNhYmxlKHBhZ2UpKSB7
CisJCWlnY19yeF9yaW5nX3N0YXRfaW5jKHJ4X3JpbmcsICZyeF9yaW5nLT5yeF9zdGF0cy5wYWdl
X3JldXNlX2ZhaWxlZCk7CisJCWlnY19yeF9yaW5nX3N0YXRfaW5jKHJ4X3JpbmcsCisJCQkJICAg
ICAmcnhfcmluZy0+cnhfc3RhdHMucGFnZV9yZXVzZV9mYWlsZWRfZGV2X3BhZ2UpOwogCQlyZXR1
cm4gZmFsc2U7CisJfQogCiAjaWYgKFBBR0VfU0laRSA8IDgxOTIpCiAJLyogaWYgd2UgYXJlIG9u
bHkgb3duZXIgb2YgcGFnZSB3ZSBjYW4gcmV1c2UgaXQgKi8KLQlpZiAodW5saWtlbHkoKHJ4X2J1
ZmZlcl9wZ2NudCAtIHBhZ2VjbnRfYmlhcykgPiAxKSkKKwlpZiAodW5saWtlbHkoKHJ4X2J1ZmZl
cl9wZ2NudCAtIHBhZ2VjbnRfYmlhcykgPiAxKSkgeworCQlpZ2NfcnhfcmluZ19zdGF0X2luYyhy
eF9yaW5nLCAmcnhfcmluZy0+cnhfc3RhdHMucGFnZV9yZXVzZV9mYWlsZWQpOworCQlpZ2Nfcnhf
cmluZ19zdGF0X2luYyhyeF9yaW5nLAorCQkJCSAgICAgJnJ4X3JpbmctPnJ4X3N0YXRzLnBhZ2Vf
cmV1c2VfZmFpbGVkX3JlZmNudCk7CiAJCXJldHVybiBmYWxzZTsKKwl9CiAjZWxzZQogI2RlZmlu
ZSBJR0NfTEFTVF9PRkZTRVQgXAogCShTS0JfV0lUSF9PVkVSSEVBRChQQUdFX1NJWkUpIC0gSUdD
X1JYQlVGRkVSXzIwNDgpCkBAIC0yMTA1LDggKzIxMjQsMTEgQEAgc3RhdGljIGJvb2wgaWdjX2Nh
bl9yZXVzZV9yeF9wYWdlKHN0cnVjdCBpZ2NfcnhfYnVmZmVyICpyeF9idWZmZXIsCiAJaWYgKHVu
bGlrZWx5KHBhZ2VjbnRfYmlhcyA9PSAxKSkgewogCQlwYWdlX3JlZl9hZGQocGFnZSwgVVNIUlRf
TUFYIC0gMSk7CiAJCXJ4X2J1ZmZlci0+cGFnZWNudF9iaWFzID0gVVNIUlRfTUFYOworCQlpZ2Nf
cnhfcmluZ19zdGF0X2luYyhyeF9yaW5nLCAmcnhfcmluZy0+cnhfc3RhdHMucGFnZV9yZXN0b2Nr
KTsKIAl9CiAKKwlpZ2NfcnhfcmluZ19zdGF0X2luYyhyeF9yaW5nLCAmcnhfcmluZy0+cnhfc3Rh
dHMucGFnZV9yZXVzZSk7CisKIAlyZXR1cm4gdHJ1ZTsKIH0KIApAQCAtMjE3NSw3ICsyMTk3LDcg
QEAgc3RhdGljIHZvaWQgaWdjX3B1dF9yeF9idWZmZXIoc3RydWN0IGlnY19yaW5nICpyeF9yaW5n
LAogCQkJICAgICAgc3RydWN0IGlnY19yeF9idWZmZXIgKnJ4X2J1ZmZlciwKIAkJCSAgICAgIGlu
dCByeF9idWZmZXJfcGdjbnQpCiB7Ci0JaWYgKGlnY19jYW5fcmV1c2VfcnhfcGFnZShyeF9idWZm
ZXIsIHJ4X2J1ZmZlcl9wZ2NudCkpIHsKKwlpZiAoaWdjX2Nhbl9yZXVzZV9yeF9wYWdlKHJ4X3Jp
bmcsIHJ4X2J1ZmZlciwgcnhfYnVmZmVyX3BnY250KSkgewogCQkvKiBoYW5kIHNlY29uZCBoYWxm
IG9mIHBhZ2UgYmFjayB0byB0aGUgcmluZyAqLwogCQlpZ2NfcmV1c2VfcnhfcGFnZShyeF9yaW5n
LCByeF9idWZmZXIpOwogCX0gZWxzZSB7CkBAIC0yMTg3LDYgKzIyMDksNyBAQCBzdGF0aWMgdm9p
ZCBpZ2NfcHV0X3J4X2J1ZmZlcihzdHJ1Y3QgaWdjX3JpbmcgKnJ4X3JpbmcsCiAJCQkJICAgICBJ
R0NfUlhfRE1BX0FUVFIpOwogCQlfX3BhZ2VfZnJhZ19jYWNoZV9kcmFpbihyeF9idWZmZXItPnBh
Z2UsCiAJCQkJCXJ4X2J1ZmZlci0+cGFnZWNudF9iaWFzKTsKKwkJaWdjX3J4X3Jpbmdfc3RhdF9p
bmMocnhfcmluZywgJnJ4X3JpbmctPnJ4X3N0YXRzLnBhZ2VfZHJhaW5zKTsKIAl9CiAKIAkvKiBj
bGVhciBjb250ZW50cyBvZiByeF9idWZmZXIgKi8KQEAgLTIyMjIsNiArMjI0NSw3IEBAIHN0YXRp
YyBib29sIGlnY19hbGxvY19tYXBwZWRfcGFnZShzdHJ1Y3QgaWdjX3JpbmcgKnJ4X3JpbmcsCiAJ
CXNldF9iaXQoSUdDX1JJTkdfRkxBR19SWF9BTExPQ19GQUlMRUQsICZyeF9yaW5nLT5mbGFncyk7
CiAJCXJldHVybiBmYWxzZTsKIAl9CisJaWdjX3J4X3Jpbmdfc3RhdF9pbmMocnhfcmluZywgJnJ4
X3JpbmctPnJ4X3N0YXRzLnBhZ2VfYWxsb2NzKTsKIAogCS8qIG1hcCBwYWdlIGZvciB1c2UgKi8K
IAlkbWEgPSBkbWFfbWFwX3BhZ2VfYXR0cnMocnhfcmluZy0+ZGV2LCBwYWdlLCAwLApAQCAtMjIz
Niw2ICsyMjYwLDcgQEAgc3RhdGljIGJvb2wgaWdjX2FsbG9jX21hcHBlZF9wYWdlKHN0cnVjdCBp
Z2NfcmluZyAqcnhfcmluZywKIAkJX19mcmVlX3BhZ2UocGFnZSk7CiAKIAkJcnhfcmluZy0+cnhf
c3RhdHMuYWxsb2NfZmFpbGVkKys7CisJCWlnY19yeF9yaW5nX3N0YXRfaW5jKHJ4X3JpbmcsICZy
eF9yaW5nLT5yeF9zdGF0cy5wYWdlX2FsbG9jX21hcF9lcnIpOwogCQlzZXRfYml0KElHQ19SSU5H
X0ZMQUdfUlhfQUxMT0NfRkFJTEVELCAmcnhfcmluZy0+ZmxhZ3MpOwogCQlyZXR1cm4gZmFsc2U7
CiAJfQo=

--------------5ivQh4pUisaZRkRLa0yOe2kc--
