Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09835606A320
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=QUNDkVVi;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XR4Cn9vh
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D88FD40DD9;
	Thu, 19 Nov 2026 21:38:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1d4cU2LCv3fU; Thu, 19 Nov 2026 21:38:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3E63940DDA
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795124337;
	b=f6maEEhVxGYZ1cTbf+yHUL8Ga0XIUJ5UVm3R5wQJsMzIm8g9ehb2sm09CLwwt5DUH/Oj
	 Zh1hStZKUbkHFczOPLEOcP2DMJBM+zjyfoKyQ6Sbm36MvcRD831TPnLkDLjltcy07fA9+
	 jqfYtSIDVfi7hXdD+GLJdFp9kCFzgBR3k9erXWRQv4u7mR0p/BGoy/k4PFz5bXbvECHhA
	 L9smj2+TUxqGT4wmlB/gC4AE/taWmMCIsQzmeZ488SAgZwD/+T5/QvU5GQxCSYrLdILVE
	 MrmUinGzQlGB+hl77euvkVYvTXpShKaAUWmyv4XIP4A5H5jMo4Et3W8xYKjNo6sg7OA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795124337;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cAl6G7PN2cvyWtMhOuMNPb47Pa9JkEc0ZDSwTNQz0D4=;
	b=Ogj3WxR1sFupfg6s4iFsDfmtpp6IOLhFT6/JSj8FITnhDdmVCVUR/ZVz+EUHtMdz+9r0
	 t6FTolISsfYU0iresL4FIeMfS0srY6CwZxaR1iYJRcXrE+CJ1tVkiVsa6WMcLjzaqQYbW
	 M/XcPxFtF37PITkiZD1cHyr/sOOm5JFDRfY10PwcxtIQ0EyB/uU4Y3BmdNjlC+xt6xRSw
	 CB/QfDf1uL4wX2VaGnef2herFLCoQj36OM/SyNQMd/CuvD8Qi10FGPNcaB5E61oMG5qBR
	 r/Pk1UmDBdtm4UqB3zbF4qIryjzEXNMfdQJW5FqqlcYxCaHL5GGirom/5fVBYOpx2Uw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795124337;
	bh=cAl6G7PN2cvyWtMhOuMNPb47Pa9JkEc0ZDSwTNQz0D4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QUNDkVViVeSgUOStdv91qqQuLDxyuwBAuUR8v47+0pqIle2BfXX07yI5GiaVcrC+w
	 BCpqcSFSV3+tR254nDoD7YclB4HnnqQ33sKDiZWrvLMH/69louwfqzjvXesZxwvWxw
	 5FNDa+kQuOh1Tp2r2Uib/Y3fxvOyP4cXHfS3SAg90FkmbNpwt1aswEOXa1lZlpvcJn
	 b7REKchESD9POuRbJ04z0aU5x+POlFAQNCmdur/LpVvMQIwJY5krHI+scJ8Atb/mO3
	 XWht2tld6QmM0zXB9ki/0UvAWfyHsAsMvt9Yz5TMw1neSbTVdE4pYbPfFCsDRVUQMS
	 p1ietLmSW1N7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E63940DDA;
	Thu, 19 Nov 2026 21:38:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8833B3A8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 21:38:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E7AC40099
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 21:38:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2ZuUrY2Cz1AX for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 21:38:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7865440079
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XR4Cn9vh
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7865440079
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 21:38:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C439A61F97;
 Thu, 19 Nov 2026 21:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F781F000C0;
 Thu, 19 Nov 2026 21:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795124332;
 bh=cAl6G7PN2cvyWtMhOuMNPb47Pa9JkEc0ZDSwTNQz0D4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=XR4Cn9vhmFnwx73O5gdc7uck9RG3VNO/323LpVdTxJ2fi4Kgr09iN4VB1eVn/xex6
 YkN0pZ3Xab30C3CLkFsrwh992szEpBhb6v5PGJVJeX60OW0hDciwSBA49XY2jkmVin
 huieF160JNXq9XgCj+sNlfrw4zgvd4fNmJrwZmsMQaxa2ajpXMY3Nsr1Hny77D7PMp
 YLejP6K+qow1eoC35fjus1ZaNSvX8bv76JK/TBegd/NzSNJVhUGgbRYdEzBHoc2MZn
 WiOo6D7Mrm5Mpth4e7Iuze3rzESXNZRX3mre4k9dvWQQK6CtybwiOPtE89L8695hOu
 Y2h6FQJFa/lAA==
Date: Thu, 19 Nov 2026 13:38:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Min Li
 <min.li@microchip.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, Grzegorz
 Nitka <grzegorz.nitka@intel.com>, Karol Kolacinski
 <karol.kolacinski@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq
 Toukan <tariqt@nvidia.com>, Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next v2 0/9] dpll: do not serialize driver callbacks
 under global dpll_lock
Message-ID: <20261119133851.3f25074c@kernel.org>
In-Reply-To: <dd1d61d7-7bef-4a02-8518-e17d2f50369f@redhat.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
 <20261116181612.107a4b57@kernel.org>
 <fe1dcdd5-ef75-4231-bf9f-03bf8536c2aa@redhat.com>
 <20261118174424.32e9f130@kernel.org>
 <dd1d61d7-7bef-4a02-8518-e17d2f50369f@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 13:29:11 +0100 Ivan Vecera wrote:
> > Right, for these level of waiting async seems like the right direction,
> > at least naively/without knowing the HW.  Why does the device wait until
> > PPS to apply the step change? Is the programmed time supposed to
> > correspond to the pulse?  
> 
> Yes. The device has no immediate ToD write, it can only write the ToD
> on the next internal 1 Hz edge, the next input sync edge or the next
> internal 0.5 Hz edge. The written value is the time at that edge, so
> the seconds stay aligned with the 1 PPS outputs.
> 
> Looking at it again, the zl3073x holds the channel lock while it waits
> for the edge, although the dpll callbacks do not touch the ToD, TIE or
> phase step registers, and they already run while the device applies
> such an operation, because the PTP ops return right after issuing it.
> I will look at narrowing the lock in the driver.
> 
> For the resync, async is not only about reporting the result. Fast lock
> is a setting of the DPLL, not of a reference, and forcing it makes the
> DPLL ignore its frequency and phase error monitors. While an
> asynchronous resync is pending, everything else done to the DPLL runs
> in forced fast lock. A reference switch, whether from a priority or
> state change, a manual reference or the device itself in automatic
> mode, would follow the fast lock phase rate instead of the configured
> phase slope limit, and the resync would then report success on another
> reference. A switch to NCO would keep the force bit set until the work
> clears it. So every request changing the DPLL configuration would have
> to fail with -EBUSY, cancel the resync, or wait for it. With a lock per
> chip they simply wait, for at most 1 s.
> 
> > Do the failures only happen because of "unforeseen circumstances" / EIO,
> > or there may be more common errors reported? If it's just the former
> > a devlink health reporter could be an option.  
> 
> For the output start and stop, only EIO. The device does not report a
> stopped output and the driver can only wait for one period, so a health
> reporter would work there.
> 
> 
> For the resync, no. The wait ends with -ETIMEDOUT when the DPLL does
> not enter fast lock, for example because the selected reference lost
> its qualification in the meantime. That is a result of the input
> signal the user needs in the reply, not a device fault.
> 
> Beyond the zl3073x, with the global lock any callback that waits for
> its device, for example an mlx5 firmware command with its 60 s timeout,
> stalls the DPLL devices of every other driver in the system.

Well, I'm not convinced. The relations between objects in DPLL are
already quite hard to follow, and objects from one driver routinely
"plug" into objects from another. The explanation of the locking
rules in patch 9 does not look clean or clear. The driver facing
API needs to be much more "dummy-proof".
