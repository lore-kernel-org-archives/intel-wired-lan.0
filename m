Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBD4FCE068
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Feb 2026 12:36:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 663A460F7F;
	Thu, 26 Feb 2026 12:36:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pm8hTEgRL_ca; Thu, 26 Feb 2026 12:36:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8ED6D61031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772109394;
	bh=5UKH5hc5SBs04NHXnqVj3UWY3WdwuyXZHgJnTxU3KSE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DpbzTKQL6HkG3b2tIx9C2qiN22J9NeiZN/gNLRpgc2hKIj39jhhctPcDRKbntn7ch
	 RP53yGMmg15BoL8aIVBKVqtBYxSAFb9dBoFy0Uijwep4ehz3XN4w5crsrMbXchkJ2k
	 wUUNbSAPnHStZgAIeXOqjYkxLzDKbYEBNOah0G/K6mbSXxyQxohi5U6hpLXmswbRGf
	 SP4+6jWMK9A/ebnRlvaCh4cWaZj8mjWcjgGi4+z0Lm8OUE4n5EZG+p8rUuq46kTlCW
	 pVTJzkOUZT5w2yOuOrztYeMF522IXycodwJAX9Oux42Mnxcg38ypkMaYoQx7g7Hl3T
	 gs/7fNYZlZNHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8ED6D61031;
	Thu, 26 Feb 2026 12:36:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BCB5223D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Feb 2026 12:36:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A1DF283CF8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Feb 2026 12:36:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hgkNfKzE3Slj for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Feb 2026 12:36:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.167.47;
 helo=mail-lf1-f47.google.com; envelope-from=timo.teras@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BDFFA83CEF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BDFFA83CEF
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BDFFA83CEF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Feb 2026 12:36:31 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-59e5bfa4f33so639003e87.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Feb 2026 04:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772109389; x=1772714189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5UKH5hc5SBs04NHXnqVj3UWY3WdwuyXZHgJnTxU3KSE=;
 b=Rn/yTXsEsmDKEmSfvYL0l4j32aHwT8GPjMRttj1+sVm/IzyRBbxCsJulkrS6z9queF
 ZxquYS88+za2btrDDY3DHDlGfG90imHijqe4gJHwDtSfchGFAiaJZkhcjgFlE3uZZMRl
 cOqWSdaNFbn442lsgjdQP3aIj0rqP2CxofN8fmZ+A0CluVqp1zThuLtvoKNQVrUcj62y
 hkz8EG8C01dMmetBMsTPWw0YgXI7gn9miOSgMPILmxLyE9F7Cx3zxqDXUfkHWBGqcIPY
 S5LJgRzadADTrIFK9LVBKplcudBAtgqpA9hgaVAXIWYTztSmbp2Uol1ly3QuV22h18QB
 mlmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTQOLEgrtIOkZBcCSR3UKqml09q2n+ptJxjGVLMibZCZx25B1W6S6dKUtSxpFTk6lLfd1F5/kINAd2hPrtGBE=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yw3j3apUZrMA+xrCuYBBQJRKmeiFU8YUC1zFTIOJGi6mjuHPNvt
 x+ItLWCsrI44Q2cmtpkk9r45fUshcnBsZ1R6yh1sV0Ql/fRALmeJJedq
X-Gm-Gg: ATEYQzzBHmENPoukUNWK3eQG5enDZvWSvRDJ7MYGMarjcMNB6kyFJ4xv+yiuw6y5cFz
 mbENWIQ39j5pxz9NDTtajAnpAfzzDo3jWySJ2TdmDcZLEV09APeCp42TyKL06WvDwfAV898+F3r
 suyZDsymK8dHPicPbedumnnlyIy5GdM9bT1eJl8CCZDjQSTiFDIKHu0v+4b8iPSRV2BJpAp1xZA
 PZq+m+CDUztS5tLACTRbGHuNSzRvq6QZwqQc7YMtZF2o6euL0kussRhaq3HgxwKs/I+93w3sYlY
 siFSkzb2ucAVWFVGbSc5ZRAgRvembK3Xxn7cgMnNc5LYOGfhyTE7DSO2AGXtIqcoGz0FoHqDJFQ
 Xjgabnr+AJZ6XCla7K4ofDA7+j/Zn/jAwOcYQ6/P7SlCT0U+mxUDGvAKVmjCq8q365LeMsgzuqN
 7CHZSNAWT+afPTsKzYiZMHDbmCVTzEhee9KosWqrQ+rONzST2RRFjVBU4cEJhShmLvA7+D9eDGd
 BfhoLW29w==
X-Received: by 2002:a05:6512:6c6:b0:5a1:ea0:afa8 with SMTP id
 2adb3069b0e04-5a10ea0afd1mr34799e87.40.1772109389007; 
 Thu, 26 Feb 2026 04:36:29 -0800 (PST)
Received: from onyx.my.domain (n5iw1vfywuv8fjffczo-1.v6.elisa-mobile.fi.
 [2001:999:51d:5846:acc4:17ef:13c0:7a84])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a109e296e6sm777592e87.13.2026.02.26.04.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 04:36:27 -0800 (PST)
Date: Thu, 26 Feb 2026 14:36:16 +0200
From: Timo Teras <timo.teras@iki.fi>
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>, Todd Brandt
 <todd.e.brandt@intel.com>, David Box <david.e.box@linux.intel.com>, Len
 Brown <lenb@kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <marmarek@invisiblethingslab.com>, <jeremie.wenger@edu.ge.ch>
Message-ID: <20260226143616.608ba411@onyx.my.domain>
In-Reply-To: <29b8a4b4-66d4-47e5-a316-b88a03b3882c@intel.com>
References: <20260202103257.1972097-1-vitaly.lifshits@intel.com>
 <20260210131158.1055ad48@onyx.my.domain>
 <745b1cd3-3e02-4d50-b1cb-0463ae6a9dd3@intel.com>
 <20260212111506.16bc402a@onyx.my.domain>
 <29b8a4b4-66d4-47e5-a316-b88a03b3882c@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-alpine-linux-musl)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=iki.fi
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 1/1] e1000e: reconfigure
 PLL clock gate value and re-enable K1 on Meteor Lake
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

On Sun, 22 Feb 2026 18:05:12 +0200
"Ruinskiy, Dima" <dima.ruinskiy@intel.com> wrote:

> On 12/02/2026 11:15, Timo Teras wrote:
> 
> > Is there other PLL timeout value to test?  
> 
> Some preliminary calculations we did suggest that raising the value a 
> bit further - from 0x1D5 to 0x226 - might be worthwhile. Beyond that you 
> may run into other issues.

Unfortunately this did not change the situation.

Any other suggestions?

> If you can try it on your machine and report back, that would be great. 
> Currently, the only similar system I have is a Pro Max 16 with a U9-285H 
> CPU. It is the same SoC generation, but many components are different, 
> and I cannot even get the original issue to reproduce there.
> 
> > There was also never reply to the question on how likely / large issue
> > the potential Rx packet drop is? How many units it may affect?
> > 
> >  From the earlier discussion we know that the "network does not work
> > after cable unplug/plug" issue this causes is affecting multiple different
> > vendors and is a *major* problem.  
> 
> I do not have exact numbers, but it is definitely true that multiple 
> system from different vendors have suffered from it.
> 
> > If you end up changing K1 default, please add a mechanism to add
> > quirks on how to disable it on affected systems without needing user
> > space configuration. I find it unacceptable that userspace needs to
> > be modified to fix kernel driver behavior on known bad devices.  
> 
> I have been pondering something like a DMI quirk. These have been 
> proposed before for various issues, e.g.:
> 
> https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20200319052629.7282-1-kai.heng.feng@canonical.com/
> 
> Back then we found a better solution, so this approach was dropped. The 
> basic idea can be used as a mechanism for a table of "known bad" 
> devices, which the driver can check against to determine the default value.
> 
> However, I do not have the capacity to maintain the table itself, or 
> even validate every device someone might want to add to it.
> 
> At one point there was a proposition to introduce such a table of quirks 
> to a Realtek network driver, which was also ultimately rejected from 
> upstream (note specifically the comments at the end of the thread):
> 
> https://patchew.org/linux/20241208191039.2240-1-guyc.linux.patches@gmail.com/

Yes, generally maintaining a large quirk set is infeasible.

But this is my point: if the affected set of machines with this issue
is so large that maintaining a quirk set becomes infeasible, then
the proposed change will make life very difficult for large enough
set of people that a better solution should be devised.

Timo


