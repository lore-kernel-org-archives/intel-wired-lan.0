Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6725FC282C1
	for <intel-wired-lan@archiver.kernel.org>; Fri, 28 Feb 2025 17:25:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CAA586022;
	Fri, 28 Feb 2025 17:25:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YK6tJvwJqITP; Fri, 28 Feb 2025 17:25:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7ACE18601F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1740763557;
	bh=JIgvYmEDN+wtXQIQGEYjDq3qvXyC/c2oECWwy2vN2Rc=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rucTNG8Q0IEsPbsl7ymvFpj12xyBsgR++vnGQ2+BGFldMQ7FQ0+aCJoDSuZWBv0qu
	 UXt2U+WrZkKIwpit+faG8EUhi6Tabj1mBCIEyBS3FcrCFkXNLIirtjWhhCagoVC01v
	 PGxRsWloIW6e8NweMnlkutsi4Ezx8i6reQQml4rwKy4jIYsLErJKnGLA8z67UMjzcl
	 uaZx31G5RuIeL+42NIXa3v9CXLm/FSmMhptXwLg7EeCQt8Q9dHtzEoN8VCapJZFxu1
	 8J+x9xDvGqa/Wr5KfmP1r18BpklqOxWYSaoO+NVwYCDwi3jUEtZyUDUl/0aEaBgnvZ
	 j75BLfxexKh8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7ACE18601F;
	Fri, 28 Feb 2025 17:25:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C33921CB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Feb 2025 17:18:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B55C40154
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Feb 2025 17:18:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LMCkueD39u5P for <intel-wired-lan@lists.osuosl.org>;
 Fri, 28 Feb 2025 17:18:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04::f03c:95ff:fe5e:7468; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DC316402E6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DC316402E6
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04::f03c:95ff:fe5e:7468])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DC316402E6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Feb 2025 17:18:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 61E0F61148;
 Fri, 28 Feb 2025 17:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8104FC4CEE5;
 Fri, 28 Feb 2025 17:18:48 +0000 (UTC)
Date: Fri, 28 Feb 2025 17:18:46 +0000
From: Simon Horman <horms@kernel.org>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Jan Glaza <jan.glaza@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Message-ID: <20250228171846.GO1615191@kernel.org>
References: <20250225090847.513849-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250225090847.513849-6-martyna.szapar-mudlaw@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225090847.513849-6-martyna.szapar-mudlaw@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1740763129;
 bh=7HijeybPsV5Qv1AFP1hGBIXylNHVAD2V5/bt1yISKXs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ULf7CA682U1hgZ9yE4rLNbJyinxTswKwaYBq/oBr6F0ZOkU6S5zNcrq8XYYZsCBln
 aVmYmVg901X4cl0rneOcuT7q96fKYQcWrR9Ucn1dqv7KJP5XmfVyT6KJryvQ3xKCFi
 rJICU3MFHj0kih08LcH3DYRmyIuqWoxm7By0sikqI1yAaHZoa2eMnJRKnwCJYEtfFd
 hRHztvwtRFNRPi/M120ZjZU6J067PlUtMCHuY8ycQ10va96wVgDG9CLJEjdk8fMSiS
 kijWQC4kuWsKh3Ssy+rGdGXd2+UOQHZM8vTQQACphToecjH5rXuWyjRRT/ceZNFH6e
 a2qrA4ZrPjO6Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=ULf7CA68
Subject: Re: [Intel-wired-lan] [iwl-net v2 3/5] ice: validate queue quanta
 parameters to prevent OOB access
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

On Tue, Feb 25, 2025 at 10:08:47AM +0100, Martyna Szapar-Mudlaw wrote:
> From: Jan Glaza <jan.glaza@intel.com>
> 
> Add queue wraparound prevention in quanta configuration.
> Ensure end_qid does not overflow by validating start_qid and num_queues.
> 
> Fixes: 015307754a19 ("ice: Support VF queue rate limit and quanta size configuration")
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Jan Glaza <jan.glaza@intel.com>
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

