Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60992C98302
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 17:45:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10A8580E27;
	Tue, 22 Sep 2026 17:45:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qfbopYg5yPKd; Tue, 22 Sep 2026 17:45:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 476C380E3E
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790099104;
	b=FrrI8Hin7Ns4rnb7o25mvnUtIFVwboTXPxyzTjd9aNCYYf+xADbnYmhHB256XSUF+ZrO
	 N4awU+iBq9wCmTYVfOl3Ist2w/CRb8A7JGw17Od0PcpQq7fbiahtoTFCnB9GXeDBwuwvK
	 GsDzr9/hWXJbSEuP9QwdIrqLel4G8NL5I2nc9/TA6Pzc/kAyC1d74L7G4+J0aGpLDCcJ/
	 nUofVl9YyGab2/SA9Wlmb5E6zHVLPVWjFpNsLIJ7x5iX+/pnRIBXgFpVZ//3smde4jyfA
	 YEAgsYrhnT+P1x9X5RwBequ+ri+Z3KxCFvkD9HISOWZOU4zLsNoWMUEPfsd+K/HrMTg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790099104;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1xQEpzKfFhKlK0PSvghR1djW9oWwxrZU6zM4PATfwAk=;
	b=AlQTXxjeMD8uzVan9D5q64JGoEBXmtWt6n4gp953nD3oSjEoVa9IjyQzMvxr8LYfI7cB
	 tXcieoQQl1N6wZDkh8QfDeez4SeIQgl32rNikk1hzjeOgKpb3DZAG2Z6QwneFZDjx/8Ws
	 U30Lp9zPp8fbCVQurMa6zqQ8fgzEfGxGX/9J10Y5dZb3E7mMgvsxi8vcAqhRNx9f1VpOB
	 4eT5DvQt1+CvMam/5SOLH0WQ/cO2b9+qKwi0uXPc8oh1pYuOXSBxhWDBMLqM5cEs2NbNZ
	 Ey85XpEDumJksDS0PkZMd9jgP56NCnTXw1vYFNExcIw6dbqMl1iqEFU4cETJDzcFVpQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=none header.from=atomlin.com;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790099104;
	bh=1xQEpzKfFhKlK0PSvghR1djW9oWwxrZU6zM4PATfwAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SWax7pFHbErsPBD0W7tl2RXED4OtPPmRDEJ1rZqiUp2b8EhB/rORfL7RTrnrjstfO
	 ZN6U/dfN4DNh5FNCsd8ZMaYm4zFKxePjhSGTlkYawFv7UecuJAPfmhJXRDhvSzlbV9
	 YQjbnastWGTcmoN01JR9FsRCD9FbSzpvdo6OsvGgyHgfK94p0mumerN0v2xz3F+NuJ
	 jm2uL72DFGW8SUEyeKcc1wHyvmAOPucEITKaQLtjOX42rDYCw7jFdM7rn11BsKW8Vy
	 1tCWxLpEIs52BtS0u1dog8YLA9ZBSVBvjfIWpG6YGvQ02FH1xEwZDDgW9EGAk8SI8P
	 uCR+JDzwJX10A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 476C380E3E;
	Tue, 22 Sep 2026 17:45:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C1F8E355
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 17:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A7B2D80E27
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 17:45:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S6Nh3eiFtH2z for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 17:45:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8401E80E21
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=52.101.100.113
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790099101;
 b=Tl/LNETF5zzFYXsJrqhL0E7Yf1hOPP8yRLLEuSnOsHRPetyJDCqsAZyGEQCpYyE4vsRq
 19ayJbtHb2mvcEJmW+JPLYk2vfwFSLStD9DTHT5W6StHO83yU8gjfsMliyHrBqD3nHWYm
 X4y0TdnexfdQxYYOxHTYtNXPtgBSVDWI65yUoLzGFdbqC4HxedeHG/bjui+i3RUKvJCb1
 DtkkemlHBlGaQ926PHg6+TnBFVSop3vA1CdBf7m4la7TVyIUqmaRV/gHABQF/9VKWH1Tz
 CXMx2SuXHp/xb8oxCPtpzL2itE3yCBATJg5NOYuuJg3cjYWt+QkkaCf6J0M/aVMXO5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790099101;
 h=Received-SPF:Received:Received:Date:From:To:Cc:Subject:Message-ID:
 References:Content-Type:Content-Disposition:In-Reply-To:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=1xQEpzKfFhKlK0PSvghR1djW9oWwxrZU6zM4PATfwAk=;
 b=nPIGKKdRSfkYQ+mlenjJQWX9Dut1vkLUqWdvQWhAGaYuyPXKq1vqL0IXmhr2EdmB0XQc
 QyYDkqPK5ZZdRSZEr9CW/p9V+ZWJj1Q7wVFYat/bWMzGPkWCH2tetqhPv6eUxfGbkVcOn
 qBWAe0DGFcmwoZkGoTfgfyDi52rXuTrj7y1k+vGZj65HQNuX7XGXBPPyA6wHgMfL07NUF
 D+uHIJNDyV26okuJV7Uao5fIWNrJTbLhR9pHLgEYah7eA0w3HPOBAiZ2ncDsdcopFR1A+
 ZLrP2cORh5jYr0GL9edMohpYm2lbmgXIWj8E8XdUstrFSV+MhFYhbb9pVmn6WgTIssA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=none header.from=atomlin.com; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.113
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.101.100.113;
 helo=cwxp265cu009.outbound.protection.outlook.com;
 envelope-from=atomlin@atomlin.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=atomlin.com
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021113.outbound.protection.outlook.com [52.101.100.113])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8401E80E21
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 17:44:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYZEh80yfKjNs9yBQFwPmX13rvMUBTKdzt9mf74W3sD71BwAeb6ChlevJfTDKFYZhUQ7GSDR1ZyEYAuYGKVdu4+3R3opK1KfEsQGMsdqP379rurPPVUkRFYiZ31W+u4a+WPTKV3mDyVl1HRzg+D1KtP9D9nJ6I7UTDzDmwCubvOa1eSESx+kJVi7iMkS62f6UD6RVUVysSChrR+l1VTVnAQI/JFtnpMqylY/DW7pWxWop+AwOiKdGernT4CfeOIkr6BKqhSsV5QyLDNuqdciQ6HggaKj/XRLJA2FvGIk02XdV2QWW5Fs7WpeVXevxUBARZoWEKO8LX2MKxvUMY4IXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:MIME-Version; 
 bh=1xQEpzKfFhKlK0PSvghR1djW9oWwxrZU6zM4PATfwAk=;
 b=sNlBG/AZSAEfNe2AHJ3NnhmnhPKgC0Z+NYZOhSVeHSVnFH+sXlUKkvQ9f0k86sMA9vgpReDziONPZRRjz1oAkejPaNdZPkuevX1d48fDOB6FwJEsveprl8qFyAt6ZcS3K4X4H2gWTKrVACDScJc2fv1gXiilXDq78QPlfyvq1d/l1AmHc0EL04Zers2rosMqK+h8h6cCy/FSOoQy8+XfFhwGqNLhv0SSPWvtpiyntpvTrk4q9L7fCXvJeQPUdRFW0XjPjH6WvsMkW9YKYGUscDYW9Xzoqu7D9jNyppufNgUw8bpJ+UwBewDMQPpG1c8/Kxbldjq5emKLnhdt17up7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB3937.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 17:44:55 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0428.011; Tue, 22 Sep 2026
 17:44:55 +0000
Date: Tue, 22 Sep 2026 13:44:47 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>, 
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rudolf Marek <r.marek@assembler.cz>, Andi Shyti <andi.shyti@kernel.org>, 
 Chris Snook <chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Andreas Noever <andreas.noever@gmail.com>, Mika Westerberg <westeri@kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>, 
 Chas Williams <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, 
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, 
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, 
 linux-atm-general@lists.sourceforge.net, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] module: Remove obsolete __MODULE_STRING()
Message-ID: <gzyxlqx3u2a6rrzu752k3i7mepicb27y6ifblzutzvkogaquuh@uqk3fo5azozd>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-3-c18766690185@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260922-module-string-v1-3-c18766690185@suse.com>
X-ClientProxiedBy: SCWP298CA0013.CHLP298.PROD.OUTLOOK.COM
 (2603:10d6:300:14f::18) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB3937:EE_
X-MS-Office365-Filtering-Correlation-Id: 124c6736-0887-4a67-ae1c-08df18d13655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|10067099003|4143699003|56012099006|41080700001;
X-Microsoft-Antispam-Message-Info: iCCjdPyxhzEDHHVyVvy+ZLDFomfLJAye1vax3W6QVf9aooO/UWLzegaSnGJBhUNZucGWPjLII0u/HsBo0qoTIn8XPUbGgplH/hbEdk/pZ7O3kbSBR7flkh5LDCEVKBng4fD1L5Y9qgROxWii1Isgtxik2jZIxD3Vy8pX2kjmtVx9ZksqAZcz5ewrXjsvDGzMCv6HvqE5nQLazjVcdLrC50/glQ0I9rQUI1j3Nq8kAvUkR7vLDGrrj+k61SPtHSt8pINLDAf3JDb+dEJsRiDlqRqFsoCfCTx8caSSjPPOrFYnPXA2DgEe2livC397Z8sPC8NbD97GTBbgUq7bPIAsX6l1KpEpboLCOG69OsjbOz7/R/GgWl2+hzvkBmbfB4lW35y2qsHVMqBuwIRd2H34L4Ih+ZmyHNaiJ5qBEIPjqA7fx4I5S/i8gnbFKRYwAMSkh6x+90pTXefcdCp/ERLvVzaSsBfZPrJMvhPWmzy6L8UNSfxZBtMtDo7A+GdHCAljmYsyxnRb9TcYGHUjoIi7zs2VNO8RIDjCypW7nXWUm5W9jPgkDOXkzNdVPPm2x5bzneQaEgi0Gk72PUGqFdPD3vyo9ayUr0ICUoD8EFTO+cRPq0yLs9fLiwg0nB+TFbMS+K+FcEEehldtq/wzTQLazpp74B/0N2OsXYO6PKKYD6/RBbBM1N+6hUJAf/aU6A73sq8Xu8zyJCiGy0l76iOONxOnaOrk7ZMzqElPPrRNOVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(41080700001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2p6VkxTb29ucnMrUDh4akU1NTVaanptTFVqUzJTVFNOSDhPVzJsU0V3MlBE?=
 =?utf-8?B?YkVHSFM2TnZYSm5IWU5ISGN5MUVldHFiNFgvNytrVndFSXcwc2F1V1lFR1Zh?=
 =?utf-8?B?SzVhRzFGalFacUdDRWE1TFgzUHhmOUtsUVpQMXRlTFJYUFdkRGJEcktlSVMz?=
 =?utf-8?B?WGpxeEpnUUZRbGd6cUJqMXpzYXB2L0dKbDVMblFGTXhxRTVYTDh5blBhRkFv?=
 =?utf-8?B?N29vaHQ3Y0hkbDhGRXF0NVRHRTRQR29Bb001UjdRV2dXNUpCSVMyd25Ia3By?=
 =?utf-8?B?VGxiRkthSkxJcmdUQ0tNWTZrdW1SOXFNaGtPcE5leFFZMkthcHFXZkdTUWg5?=
 =?utf-8?B?aldWR3lPVndJK25MU0hzZXBYcTZRZXJVK2tTNGcyb09wZ3lmTWhLbnlDRWlW?=
 =?utf-8?B?ZUgrYWkvYTdlSzVhTzBMSytRZ2pOT0VoNW9DYWRldnhZREYvVmlKVi9BcEtp?=
 =?utf-8?B?U2xKRWd1UzZ6Z0RpTllxdXU0Q0lXYUxXTkdmbEYwNlAyLzRKM050eklMV0Mw?=
 =?utf-8?B?dkVHclVUancxY3Uvbm9ZYzQ2WmJqR3c0ZHQvTGVvcEhZaEZnSkQrUHV5b3d6?=
 =?utf-8?B?UVplM3VhN1ZmQnJKenBTR1RiZk94cGhXMDd0SWl3VDVUMElpRVVxTWplMlhP?=
 =?utf-8?B?enN0cXpzc2g2OUJoZkxjZGtOcm9PZ1hCeXpjaGJIRitjR0FhU1l4Yzg5b3A0?=
 =?utf-8?B?ZTU1eVRZcUhWaVlORkZPTWMzTFlLVU1tT0R5ckN1TFpoU1dnMHVCZkpNK1By?=
 =?utf-8?B?SVB6aXpEWitZL0toTW1GSk1yTFZveWt5VzlYbUdjSm43T0ZnQXJWZllZR0F3?=
 =?utf-8?B?U0J3Rit3SWpvTHE1N29wUGl4cTFMbmtkeWlpT0x3azVyaVE1dFlQZHlxOElL?=
 =?utf-8?B?YkVTQ3ZxRForL2ZnSHBPb0R3MVFab1FWTDJpaUFYUHRpT2xtTUI2RTlmdUt6?=
 =?utf-8?B?Q2tVeEhrWm9rVkFyWHl4d3dKUjFyTm9hN3c0WWs4blZ4VERTRXFVbFJlNXJX?=
 =?utf-8?B?SWdPc0FkbCtkNTAwQ0wyN29yaEpiRGs0M3N2clZEUnhsSnl3RkxCLzFzQ0dZ?=
 =?utf-8?B?U2ExUkw4TG5rNnVldU4xZ29WcElRdlpJU3hnc0xWbUp6QVZFOVZvYUJvV2kx?=
 =?utf-8?B?a3pwRjBRTUtMa0swTk8rZWQ3djJrOXdzc2Z4UUhNcm5ia1dSQlR5YWJ3OUtD?=
 =?utf-8?B?OFVKN3lHeUdIMktoSUp5eUdQNGpGRFhST3Jrc1BidjFlL2U0d1MrVEpldEpS?=
 =?utf-8?B?Tm9RL3NnZGtqNisvYW85bmN4UWcxSWF2cUFaUTVCcU00YUlYUm1MYlVMM0JT?=
 =?utf-8?B?eCtaMW1qUTRxUjN6YW5Eam5qMHh3UEtaZGFXWGs3aUlEMDlNUmV1Uko2UGFt?=
 =?utf-8?B?ZUtyZUlUUTNZbEwyS0lJMU9jZnVrajVRTkIyb2N5MDAybjRwU2pGaS8wSmlM?=
 =?utf-8?B?eU9oQ3ZGWW5HZytBcEJFcTlqMkEwTjh1T2NSR2hPdnd1ZEt0WVFCczhFMzVN?=
 =?utf-8?B?REJjdlQ3dVRMNmNmR0hXOWRHREVIWWNYTTFBN3dnMG5VdVRkVm5PTUMzUXBM?=
 =?utf-8?B?bHBHaXlzRmFUNzkxRkUvTkZ6ZVVQYmpzT2JLVzVRUnNiUnBkRkEvNUZacFV6?=
 =?utf-8?B?ZnZzOERaZ255dWhPYVUyYUpndjF5ZjNENU9iRGFmYjNGV1RBeFZlcEgrekQv?=
 =?utf-8?B?VEFIcjEyR3NFM01zWTl6MHQxZ1kzaVdDcVFoRStxY0QvVlMxTSszR2cxUEhy?=
 =?utf-8?B?U2VTVHpyVmNOSWZncFZYNythK0lUZ0xHTVB4TEtNeEtkU2Q0NDFhSkxXZld1?=
 =?utf-8?B?YUEyeVVUUTAwYmg3Z2E3b1V2bWVEQUJPTjVaek9wNUpkVW4yRlFXdWN2MjVM?=
 =?utf-8?B?UXFXRVNkMjhWSHpDQ2VzK2w4eE5VR2Y3ekQzV0tyUm9tUlR4Z0dQWERHUUQz?=
 =?utf-8?B?S1dyV3lLblY1RThrb2xkMDZoejY4c1dKS0lwWDl2ckhoSW11T2E0WnZRd2NQ?=
 =?utf-8?B?cmdBMWFWSkVEWElDZi9aWjV2U1U5TmtoSjZ6Nlo2alA2TXFqSFl2WTJISlpE?=
 =?utf-8?B?WDlGbHZGT0ZCNDVPU2tyUHJKTCt2YmwxSlVGaVh4QmY2NUt1RGtmZjBGSnkv?=
 =?utf-8?B?OGdycnQzTlczNWNydXdRN3V2UnNrUk16N3orTENpd0RYV2pZVlNwVGFUN001?=
 =?utf-8?B?TXFydU9ucGlmTzJRc0h2UkphRTB1U0I3VDF4Z29RVzRKRWtlUlZzT1hsRHl6?=
 =?utf-8?B?L2VBUklkamhwQ0NlSWJzSEE5NHNnUC9neUxnN3c5TVEwMHdGNGN5a252Yk1Q?=
 =?utf-8?B?TzF0SE5ZVHNmc09KbGh1d0d5ajQyckEyL1ZXYkRaQ1hlQ2VxcUNQdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 124c6736-0887-4a67-ae1c-08df18d13655
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 17:44:54.9610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /aKK8JcXrvnEfdwy7GEoiMZaZdylio9/vRuD4xZQKfM8ycaRTtdV6m/WckyJMyJ3YH9JXk6ZOlfMrGFEt1zr4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3937
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

On Tue, Sep 22, 2026 at 03:32:23PM +0200, Petr Pavlu wrote:
> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
> 
> Remove __MODULE_STRING() now that all remaining uses have been replaced
> directly with __stringify().
> 
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  include/linux/module.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 96cc98568eea..0d9157a2d487 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -886,10 +886,6 @@ extern const struct kobj_type module_ktype;
>  
>  #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
>  
> -/* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
> -
> -#define __MODULE_STRING(x) __stringify(x)
> -
>  #ifdef CONFIG_GENERIC_BUG
>  void module_bug_finalize(const Elf_Ehdr *, const Elf_Shdr *,
>  			 struct module *);
> 
> -- 
> 2.55.0

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
