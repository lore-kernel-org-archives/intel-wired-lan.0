Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD175C48297
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Feb 2024 20:03:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 271C882CCB;
	Tue,  6 Feb 2024 20:03:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FyohUFcPZw64; Tue,  6 Feb 2024 20:03:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79C8E82D0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1707249792;
	bh=TzIMmWAKQO5A4KfA76ddO4uV7TcMXj4Dgd2Qo4qWax4=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=F/P2IxiHadiOss7NWLfqP3iVBj1lKYYACYDaRy0Ui3IzMCrN5vCOtL6/xAnzmiOMg
	 XHqK4mFgNKbAgUzpoEhPI0n79y5htTgiWG5xdEK+NmcFUIhiRvlLzcWObO7HJQ3hx4
	 /sphbcSnWZc4JtRcEFRqTjQ19WA7wG13Jt2Tj9KFxe+NFLUJjO2A8U/mfYE1VD3tNf
	 ZLiSNMVLix2HC/OIUlt7Y+fcPKt7SG3ubPyCEUZig7miTy7NIK4NrJE/M3vwzBGkqo
	 4yWIB9A/zmTQSUjTKpFDYan6nq1luSt2ybuOeXetycK/yKYXDAEkG/mDGnKZHWDGdV
	 dR4TR/v1CXkTg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79C8E82D0F;
	Tue,  6 Feb 2024 20:03:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 6964F1BF409
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Feb 2024 20:03:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 60F9482D0F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Feb 2024 20:03:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 77kSL2gr1NfQ for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Feb 2024 20:03:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 883E782CCB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 883E782CCB
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 883E782CCB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Feb 2024 20:03:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A578ECE171D;
 Tue,  6 Feb 2024 20:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91561C433F1;
 Tue,  6 Feb 2024 20:03:04 +0000 (UTC)
Date: Tue, 6 Feb 2024 12:03:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alan Brady <alan.brady@intel.com>
Message-ID: <20240206120303.0fd22238@kernel.org>
In-Reply-To: <d93d8608-be23-401a-b163-da7ce4dc476f@intel.com>
References: <20240206033804.1198416-1-alan.brady@intel.com>
 <20240206105737.50149937@kernel.org>
 <d93d8608-be23-401a-b163-da7ce4dc476f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1707249784;
 bh=4Dd5Wi9bGR8FWGHP5XEo3Dl84oIpNLPmsNrGy3fOJIo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=S3+3ybpps768PVi4j5h2lcij3vHute1WC8cUt3k8N5/n98vWK1WiS3P0yhtfo2FOY
 D5VjYTbrr+aLOK7cumjlsudQFxIIrh+8BAjGYPgF8xbg9nD5UvAm7NECqqyxEIOCYZ
 AC2adBFFDCmqKLpGnzOpIQzVuS7XNBKOTIv6mlpnhExew4jsWhxLs63qGKzk21heKu
 T1UE+AKrTgSqnYNj5wZV71DC/j0iSzQLF9kvdQ+86GbOuQh+ZJcKxTJoklZbud/76N
 s5WvPVTYJAApivwPFN+iC00iTmwxmr1xR0YZIGo/C6iwQ/fUKNGPC32eGrQPgebBoP
 1OTBiZE/o+VBQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=S3+3ybpp
Subject: Re: [Intel-wired-lan] [PATCH v4 00/10 iwl-next] idpf: refactor
 virtchnl messages
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
Cc: willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 aleksander.lobakin@intel.com, intel-wired-lan@lists.osuosl.org,
 przemyslaw.kitszel@intel.com, igor.bagnucki@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 6 Feb 2024 11:18:48 -0800 Alan Brady wrote:
> We did run coccinelle check and see the min suggestions. It's triggering 
> on these statements I added:
> 
> return reply_sz < 0 ? reply_sz : 0;
> 
> A min here would change it to:
> 
> return min(reply_sz, 0);
> 
> I didn't really like that because it's misleading as though we're 
> returning the size of the reply and might accidentally encourage someone 
> to change it to a max. Here reply_sz will be negative if an error was 
> returned from message sending. But this function we only want to return 
> 0 or negative. By being explicit in what we want to do, it seems clearer 
> to me what the intention is but I could be wrong.
> 
> We can definitely change it however if that's preferred here.

Hm, okay, that does sound like making it worse.
I'll disable the minmax coccicheck for now, it seems noisy.
