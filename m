Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2757C79F99
	for <intel-wired-lan@archiver.kernel.org>; Sun,  6 Sep 2026 10:41:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B046060619;
	Sun,  6 Sep 2026 10:41:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hXoNh0anf_rd; Sun,  6 Sep 2026 10:41:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5DFDA6060C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788691302;
	b=MxoA3xbUfVBZAiOE8w4yMjIS4JIQjGzZV1hPt6m7uDwUGwE7tNvcAahQj0AREfS8dCrZ
	 OpAUKI1iRQa0imOUDha2+JZLlExGNoMV/35kjuyXEOHBrujWIQJcAHrydGA5GnUHDca0v
	 VTv0+HpsRQuw+JMcY9AboTkvqaO31c6ypgrzOZo2fHHFt8JBPd/ZrQvCP+jP1EQW5SwCP
	 IqZB9kQBaseuTnmh9tF8WHGvzv+E6FvMDbj3xuBBMcil6Du1+LLOiKXz9m0xniFPRlqrZ
	 rEoHAC6BJ1OQKNorHPm1t6Mn7eBPKVN+1rXS7vDE20KwTR2MmIqmLigTpg7/WH9VDzw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788691302;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PH5he0/t1wUpcTpJrkFuKTpPoHenXUo73jGQJGnPHb0=;
	b=e6Qbkq7sRvteGT7alwa5aGxyomCvhSW5JXBMTpfuoNOAzsjpsX55W+bK5XQd8n9QEO+t
	 hn4cUJk1GOrJObAu0GXPfFJF+L1wz9vR5WTEq6hXX7cu5X+nodalQHx6Hy7jJmQmRVx4Y
	 S4CZKtoAj/YQQOBjToF8OQtF5yXzUM4a6sOak/dHH9euwR4LqhDov0A2GMcqMLLhxqaqa
	 pOCET44hMfsq36SGog5cExG5es/oXYimXj2kUX2UPptX//WtkWJk96ngc7BptkZdmbhLW
	 aYGO6QJ8sbNgFHGRDKKMF3MtvghqkuausEoReQ8NIPUeI+EVbjm4EDhA4C93Y4wS42Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788691302;
	bh=PH5he0/t1wUpcTpJrkFuKTpPoHenXUo73jGQJGnPHb0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ju2sVchPZR9+y72Ew4OLNB+tBkV04wAWZPPGi1X9MM6EC688MrNAH2ZU5wNC5URQ7
	 yeUltdBTVHo5zNShaec6v0t7zbEAPdk+Vt1Xa/RmHlv4kZLXpvKWlIi6TbrWFrfmUA
	 NO8LScvU0Nqyt8lASMu7x9yfCcV4w28Gto27jW3bnEq7CRmxTyw1izJbLvVq5X9O0p
	 ZSekcR6kNt2yBizHVjI3SMZX5StLWUDl2xN5h/7QWqlfSMoPcSWOGz045z+Zazv8ou
	 fmRqWLmrLDAOsuyqi4MoiahcfIi3RcqGzChwwsUm4miSIBtguPI+y1kB7UDCrDG+CT
	 4Sg0xLCWcPh3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DFDA6060C;
	Sun,  6 Sep 2026 10:41:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1398A3AF
 for <intel-wired-lan@lists.osuosl.org>; Sun,  6 Sep 2026 10:41:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 054814007B
 for <intel-wired-lan@lists.osuosl.org>; Sun,  6 Sep 2026 10:41:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YiGpSfFndqtp for <intel-wired-lan@lists.osuosl.org>;
 Sun,  6 Sep 2026 10:41:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B7E6D4006B
Authentication-Results: smtp2.osuosl.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788691300;
 b=SCK6koZQtThtpgzmqYgsYe9qzhdxv7n5XQ9f3wvGZ7kX4VMugpm8urYoXV1N0hSwnidj
 M6ftj0VtqjBBsWMSoiFNXnoracHYVsxVvZlO3X7viH38G98dVELkkT+7Td4e8N7OycLep
 V5kKbXBfLUuvAI34ai1G2ASMdx3VsAVm7E289KgDxiTlPOYkjpJiLQnYlicZwHY9NDrw5
 iGm4HtVotwvfHoQBPYGq5dQbvx549aakV6FD6bEsK/fWlakCVyudppeuRcXj5GGy2bXlM
 AUlEGSBKO+0GogrTwa4UAjHBxiSQ8ZHLda0Q1wXal3J27iNgMj/ZCGfdplMFCn2scQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788691300;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
 References:Content-Language:From:In-Reply-To:Content-Type:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=PH5he0/t1wUpcTpJrkFuKTpPoHenXUo73jGQJGnPHb0=;
 b=fto72CL4z2FdEfyK+BGl1tE62Bqdbv3eWVQoRw4A7crIy9GqkewM1/AJ3NEvUd8yXw8M
 SCL+Ri3c7F1YLOu1Ts378mtGtnNKSGBEbMaWbw6b1hW5RxCjUvwbHucRebPFZOquLEcar
 5Rw7IGmH8q08sbOij47ANBVNn8SeZ+NITg26wNCjAt3GH0Wqx4xpWAYGjw6ant5iQ3EIS
 Ixwy0H9/xCWYC+n1quqNidSDxSlh9qt6mw7DkJ10OBCFZUPfRbfEwCTugoTmN3wgCGKSB
 wAJ7ZGZjyxtVxQ5eLbdMRSy+ymNcXm9TVdMJy67YpLFQGG14/PceNiYtq+qDGlh6/TQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OheJazlF; 
 arc=fail smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OheJazlF
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B7E6D4006B
 for <intel-wired-lan@lists.osuosl.org>; Sun,  6 Sep 2026 10:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788691300; x=1820227300;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=04lUJmOSVqxLErSy1FqJ/Vnx4TjbhI0Xuz9mS5L2WFU=;
 b=OheJazlFwkodDHpdQ+sRJbiuvnco9vuhCZ/qR1DFr9VyeJmMpHIGiYrI
 W9HHdv+cUaftYDQY8lV7AZuNnZFH041k5JxJZUKVof8p2mP9TUjYlwTn6
 /lhszyjkckXSj5HaLg14AOzBrYyzXAsX5LMNjOxXuO8W5K3oEDp/eTlkO
 hgabfg20T3x69uvllWb2spl7rUkpLv4+rtNl0VXUY0wAoTMs/Cawdr466
 FKxvRrOouUKLhuBMdoFNWyHFDoViu17wUuwHGwKChSMd+A6dhDhXwiYNe
 MfzFelC3+wJLZYm0mncViznTSHtvS7jDIN5Qe5oH5WfqCDKfaj595GV1W A==;
X-CSE-ConnectionGUID: vhtTd4u1Qayt5Mdv/GZVsg==
X-CSE-MsgGUID: z8yjoEnDRxWBDKuFD6Z9TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11897"; a="89046871"
X-IronPort-AV: E=Sophos;i="6.25,265,1779174000"; d="scan'208";a="89046871"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Sep 2026 03:41:39 -0700
X-CSE-ConnectionGUID: YjdIlPgPQ/y8God2G4W+Ng==
X-CSE-MsgGUID: 2YoGioguQguUgiSbKo8mnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,265,1779174000"; d="scan'208";a="269942724"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Sep 2026 03:41:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 6 Sep 2026 03:41:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 6 Sep 2026 03:41:38 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 6 Sep 2026 03:41:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNclxbBHHqLcqy1RwLTA3s/9jYjDtnbgHstKarSxl1k+WRugHW8IeqLXbT7yk5l1lKDOuURbQjw81qfIUKnd9nZzhJDhgCfhQkJz17syomwLu/ue/TrJOW0BifNKvJcoiPTCDLesW2lHJJNcJbC7vI6fA1Mwe7TnnOAKwZnGwdNyaetCSX7nzzFIW2RTtsd/S0iUgy0qui+J3w2F0QprlqhgQGJPh7kNSxUXPK6lbQiV+lzEwyw9gZWPAT1Z/It+UK0OU+vdXqqF+Cx0+2nZBIcAhWXaGXwdd9CzaJB0CKWfyCYrKuNm47A4QMS5/Dbm1hRMZdlLOzC6Sfw4+cug2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PH5he0/t1wUpcTpJrkFuKTpPoHenXUo73jGQJGnPHb0=;
 b=R1smQlRlrXqL3QJgkmEY4KDOS5cxY3Jv4h7EQvwzuR3hLgrf2b1ts5o+K6kw1EeuuFm7vEUCg8QR7p17ZGqP3CHoRvaQZCWz4Z8tN2ehEi33kwyd2VKgQ6Bk+TdG/Ilufn1r1Z89clEJqfNADxXBYXEKkNOkYG1fcLvynkoN73tgM+5G96TUX1CSA0czcevcfAPB8Zsr136tKmCnuLbKj7mVxHysKpuxJpkj/gxZ02gxIJwFF5GjctaIJ/cfEh2NYTiyNbG5a3MivTNKCyFOMAkxlzlJFUEecB59nV+nO+znT4hVfuBcz4qB0kIqfy1UmkvRhZx88I4dAkbjKzvwmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV4PR11MB9514.namprd11.prod.outlook.com (2603:10b6:408:2e0::10)
 by LV3PR11MB8460.namprd11.prod.outlook.com (2603:10b6:408:1b4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sun, 6 Sep
 2026 10:41:36 +0000
Received: from LV4PR11MB9514.namprd11.prod.outlook.com
 ([fe80::79a5:106b:2126:a7fa]) by LV4PR11MB9514.namprd11.prod.outlook.com
 ([fe80::79a5:106b:2126:a7fa%5]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 10:41:36 +0000
Message-ID: <77b21bba-9dc8-4fd6-a703-d6e32447e2e4@intel.com>
Date: Sun, 6 Sep 2026 13:41:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] e1000e: set fixed clock frequency indication for Alder
 Point
To: Simon Horman <horms@kernel.org>, "Rawda, Tony" <Tony.Rawda@disney.com>
CC: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "vitaly.lifshits@intel.com" <vitaly.lifshits@intel.com>,
 "sasha.neftin@intel.com" <sasha.neftin@intel.com>
References: <DM6PR03MB383684B3604D2B332361B810FAB62@DM6PR03MB3836.namprd03.prod.outlook.com>
 <20260906085042.GF40544@horms.kernel.org>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <20260906085042.GF40544@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To LV4PR11MB9514.namprd11.prod.outlook.com
 (2603:10b6:408:2e0::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV4PR11MB9514:EE_|LV3PR11MB8460:EE_
X-MS-Office365-Filtering-Correlation-Id: f9997e11-9b12-4d40-137d-08df0c036cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|3023799007|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: RtqMSVUZN21AsHgbrkJb5zxBea063IpcVC3mtFlD4Dj7PqNBVlucDddzLcTlKJGhoQW6q5DlSQYOGLoWAB/9xuPYyp1mp9n3wxceEVk7u2l/tg7to+J95vBNiBaLwCghCKjKVmfXryf0PB68BdISciZGGWBR9Bkm0mlu/XybW8E2p6f1prKPdRsV5OUeN/eAQlE/+b3Yr5/ig64qBxIfYsL+1sY9uXMBxHe8g86SImGpU02QuwsUHG0TlafiMk4PeIsmAAjo6gz5DUTw4IvjlQWlGa1W7ZKFOV20325WIMC4aaVKtgCbw0bztgPeU/Ypsds9rE+l/9Q5YDSHsBfkYn914zB/K7aKMR5Q1D7cKXy5gcgJrdNKd7CF2JCxeRH+5yFV25tKWCG6eKJaEMf86cg4TSTRAeAWqmYFcGNCZanK+Q0nxAR9Q1nH7+xqPhnfWCLupa/xuENiPfZTjewAMCUeklJEkyQSgrt7XPWGWdOjPJskKL5FN2aZqmO/ITsgVu47pUchioFZAxSHt0WjrpuS8LnFMPCJKUPm2FhafX1ZSjJeBu2jBK0H0ENCIImzU40nmphSPn+dIfaqX1V7lH9H6jrUJqjzp+yFIUbqMeI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV4PR11MB9514.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(3023799007)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXdhSGhjRG5kS09EbU9oM1kyY2J6RHJkelM3bGZ1WHd3YlhmRExmYWxpU1pL?=
 =?utf-8?B?VTM2b2xVNDJYUjdBa243SGR2UFB3MWJSeHNMUVBMTmxQMUJwenVqaElFcHJu?=
 =?utf-8?B?aGpPK2RYMkZyT0h3RStuMDhrVE1WeTNWVzdvMmRJRGZaMVdIYTVQWCs1SHc2?=
 =?utf-8?B?b1VRMUN2dzJTVjg5bHZZUmFza3dCVm83Zm0vOUVqNkp4NU5wMnVEOGN4aFpk?=
 =?utf-8?B?OUZscEwzVWkrN0N1SGtzNXhSMEQ3bGRFTUxQSWJOY1lBdDZBbWNzVG93T3Jp?=
 =?utf-8?B?V0orT0dyNmR5blhaNWN5Y2IzdVFBVk11eVc2NTZkMkRFNzVjMEYzVDhKRUlo?=
 =?utf-8?B?bUI3bWorRHBTQzFhck5IeEZLTHZwS2Z4cXA3SlBoSDFjajBnMzNtb1p5R1Z1?=
 =?utf-8?B?bmhxOGdEMHRGTmdXTGZVUWxmUk5nTkNrMmR2TS8xaEZHUUk4ZjgwTHBEQ0Vi?=
 =?utf-8?B?WTdsTm1SR0VCUUFjQmlGT3ZtM09TSkNDcjN4UDg0QldzdFZWZEhwZGtZNmt0?=
 =?utf-8?B?azVtQm5PQjJnaVdrd0xrL2lZc0NqZGRPYkdnR21SSjJXV1o3TGZSNmRqc216?=
 =?utf-8?B?L2xvNGtPdUN6RjFMTk1TVkpkT0orRDlNbW1ZSE54MWs3NXBxVzE4eWgyRHRa?=
 =?utf-8?B?ZzVlVWV0UmpjeWQ0UUJWaEVDeTNsODJpQ1YxdmNhbHZQYmpvY0x1SllFSksr?=
 =?utf-8?B?bzVvSTA0TDN6REtvYlBGYjZxajc1RDJpVDcrblJaUnJXUG4yNHU3dXluUWM1?=
 =?utf-8?B?QUhybUc3ZEd1ZHFQdUVaV2RsVXBzVGlzQ252dFJlY21QeXh6M2pDOXdNd1ZP?=
 =?utf-8?B?d2wrVTk2czI5WWhCL0ZwWmhobm9JM0dmS01keDljNkxjd2d3Yjh3cTF3aHRB?=
 =?utf-8?B?TjdBUVRzUldwMUdyeVJrR0RqNUxvRnFWT3lKTzZVODZBSEhnVHRRMnRQbkhG?=
 =?utf-8?B?NnhQb1NKUE9WLy9relV5SForNTU5aDdGSGVEalU2RXRJdDZJbTRkZDVNZWYv?=
 =?utf-8?B?ZlJyb2pGK0V4dUYvN0lLYTVxS28vcUVhZVJqYnVibzdCQzhhYXJRWW5FQWxi?=
 =?utf-8?B?bDAvZGJsRVZNNk4wMzFZaW5oSjRwbDlFUVBlSUo1dEFCT3VRQ2labUVGb2Rv?=
 =?utf-8?B?UGZ6QmM2RmZZUUQ3aHIzU3BkRVgwNUR4UzVqSE84VGJmVm9SY2FtSWplYlU5?=
 =?utf-8?B?Umx4d1N0V1NEbHV6eHA0Um9yV0JhMXdnY3ZGTVB6YUt2YklRSkJwOVZRSVRY?=
 =?utf-8?B?Q3NMM2JkUFBwRjg2UFNwb1RTcmRvNVJDL1lhT1plOVZTbDRNOGtrUzdyVU43?=
 =?utf-8?B?aXZjSGsrcVYvQStmUVA2NmE0djJrN2MyZ1NQSFl1bUlNdEsrcDVPM1hTUk5H?=
 =?utf-8?B?TGpueklyWGlKdExSTlFUQmxXY3hkRTRFeC9hNFo0NUhkcnNFNUxSdGhTV2V2?=
 =?utf-8?B?dm5ZT1UxdVF3U3phcDZSakh3ZUFwNlFSSmRiYUc5a2hSQzUyL3cxdHJXVmwx?=
 =?utf-8?B?Ni9UeklOZ1NWUzZacHJURkdkTnBpdVJ1eTBzUUVJS3JCVWw0a0VLK1VPYUJv?=
 =?utf-8?B?QjFvczdQQTZiUXROV25kTzhZSklXbEVQc2hVVlduYytjdUhJN21wWFhuTnRJ?=
 =?utf-8?B?WXgxNVgyVTJwRytOdG9HNC9YVjlrSGJDNW5NbTNRYU9XT2tyV1AzSkVsOG40?=
 =?utf-8?B?YjN1dHhZSFRRZkYvL0hTdFU1eDRRdzloTWVYNzJveUd4V3ZFeGt6RUtGenhN?=
 =?utf-8?B?di9xRWs4VG03KytGVCswb0tVNXQyOVBXTkQ0aTY5SGluc3c0WXE0V3N6Vkwx?=
 =?utf-8?B?VTc4MGRMWm0zTTF1aXh4RFJ6enZlWWhiMHhmQm5abmFHTndmajlDVU9OaGZz?=
 =?utf-8?B?VVRQR3FwVHZDUzhDRGJXOVptZTVBalJxc0FDTDJJb0dwOEllT25wR2EzMVJu?=
 =?utf-8?B?bEkyV1NPOExyVkxsRHJSMjhMZitJUG9GRnFpdTY4VCsvSE80V0ZHZm5NT1g1?=
 =?utf-8?B?RjFYRmZuZm5wT0Z0TkVBUXhrTGZKb0FJai9kVFZGd2ZyQVluTXVoQlY1K3pz?=
 =?utf-8?B?b1ZaZ0lUTzFtUTJWUEJucHhucW02b3hBa0lJYklJTkNVVnBIeDhiRkN1K3Yr?=
 =?utf-8?B?dDBnZHZKQUNwUnA2bzFtNS9oS2UzUG8vekNnVG1rV1puWXR1MWozQ1NjeENP?=
 =?utf-8?B?YVNlVGREV3AzdGdwR0NmN3dObng2amJWY2YxL2liL3d2Tkd5VjNObTI4QnVC?=
 =?utf-8?B?WVlzeU1pMHBmbWdndjJDY0orTjlERFREZGx4cUNIbEtYcXB3MmVJdUoxeGJu?=
 =?utf-8?B?K0FJRjRGWTdaTlR6eURmcm9KcG9OdmpteTJVcXRuamhad0N4UnI3RjNzRXp6?=
 =?utf-8?Q?9G+0X6iYkdQkO10c=3D?=
X-Exchange-RoutingPolicyChecked: 3HpxbRfiKZruQDpgHpD6OfIBBbpLG0akwg+VERb5YlaQ6WYPfRt9pIRfaeG+PEXGuNdrYBLBxl0q381vCySeLkoGQNxDT2vmMBAvMxgyhmPDZn3ts4Walhyy+fkEisdsTQ0FqYybNKHbt3r+Gmcx/qyjWOAz1tEUd9UY3DJvTgHzz0+B3RwmFqU/Aa6b0Ukx+7DkVt/DbygCFL4ia1oi15LTSpX75mrToB8jXhKsZgTaNMbyQZ4F9ZxCdOkcJBX0ikr45k0SMzQ91dVFzDEvq6uUrP0XJeJdwIXfhiBkLI1je6JFQsh6JmlIWJ4zRI1PixhFyVtJdn2G8y51YMDlfQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f9997e11-9b12-4d40-137d-08df0c036cae
X-MS-Exchange-CrossTenant-AuthSource: LV4PR11MB9514.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 10:41:35.9562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUZkjCIxV/CP3aWezRnr+SQq3s8HMjpxtESruUyGcLxAmV4APuZNU3vV7KHROkb0zeqE4xksaAcrd8hVLCQ+YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8460
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

On 06/09/2026 11:50, Simon Horman wrote:
> On Thu, Sep 03, 2026 at 06:06:33PM +0000, Rawda, Tony wrote:
>> On some Alder Point (e1000_pch_adp) platforms the XTAL value reported in
>> the software STRAP is incorrect, so the SYSCFI bit in TSYNCRXCTL selects
>> a 24 MHz base frequency while the SYSTIM counter actually advances at
>> 38.4 MHz. As a result the PTP hardware clock runs ~1.6x too fast
>> (38.4/24), which prevents ptp4l and other PTP-based time sync from
>> disciplining the clock.
>>
>> Commit 688a0d61b2d7 ("e1000e: set fixed clock frequency indication for
>> Nahum 11 and Nahum 13") fixed the same problem for e1000_pch_mtp,
>> e1000_pch_lnp and e1000_pch_ptp. Alder Point silicon likewise always
>> runs at 38.4 MHz, so give it the same fixed-frequency override in both
>> e1000e_get_base_timinca() and e1000e_ptp_init().
>>
>> Observed on an HP Z2 Mini G9 with I219-LM (17) [8086:1a1c]: before the
>> change the PHC advanced 16.0 s per 10.0 s of wall-clock time and
>> /sys/class/ptp/ptpN/max_adjustment read 999999999 (MAX_PPB_24MHZ);
>> afterwards it advances ~10.0 s and max_adjustment reads 230769100
>> (MAX_PPB_38400KHZ).
>>
>> Fixes: 59e466888038 ("e1000e: Add support for Alder Lake")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Tony Rawda <Tony.Rawda@disney.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
Hi Tony,
Thank you for this patch.

Unfortunately, what we found out is that on Alder Lake platforms (and 
also some Tiger Lake), the clock does not _always_ run at 38.4MHz. 
Depending on platform, it can be 24 or 38.4, but some systems in the 
field have the wrong strap value reflected in the SYSCFI bit, so there 
really is no way to know in advance what the correct clock rate is.

We have been working on a patch that runs a quick check during 
initialization and adjusts the clock rate automatically if it detects a 
drift. The patch is here:
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20260414065809.3021177-1-dima.ruinskiy@intel.com/
(
also here:
https://sashiko.dev/#/message/20260515182419.1597859-11-anthony.l.nguyen%40intel.com
)

Unfortunately, Sashiko pointed out correctly that the patch is not 
robust enough, because the fix most likely will not survive subsequent 
adjustments from userspace. Here is the review:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260515182419.1597859-1-anthony.l.nguyen%40intel.com?part=10

Could you check whether the current state of the auto-adjust patch works 
on your setup? I expect you will see correct clock, at least immediately 
upon driver load.

If it works for you, we will rework the patch to address the 
aforementioned shortcomings.

I'm afraid that your current patch will simply fix it on some TGL/ADL 
systems, while breaking it on others.

--Dima

