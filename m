Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E32CE7717D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Dec 2024 11:54:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B410D405CC;
	Fri, 13 Dec 2024 11:54:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SGmf6uI890Ui; Fri, 13 Dec 2024 11:54:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C0C214058F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1734090886;
	bh=rShDgTnzwc3npC3FIcFY6EJeSBdg6xutvc0Jf56TKwA=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=BFWY2XzJi+iOYVGUUsBL49K5w6pEQRMwd5vqBzMumgKHdninF5snSTFEbYL1wZNAL
	 ajllLQ9TTeosU23n+9bvuoyJFbaztHuCWpqkIz7b1e9mIf1aY2vN9fcdznnCyfD0BS
	 6hXs1TY8K/KGt7PPtBicEsb1KGjp8g+fspnDATiBXpAFq2nBg1gXyGQQrN/oPCo55V
	 cK2vqlzWeze8iuz7Ipp529jUg0I20x9sg5jxQxWBOrnAGkxosWhj6z3feGTFKa6ZNa
	 uqb7sr4GMdIi9vMrUeTzn9kyCjepVkd+P8eGIxayI+9Uj23oGIVladDLc2AlxKRE7f
	 0f9GLGHgGImdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0C214058F;
	Fri, 13 Dec 2024 11:54:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A9E1DECD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Dec 2024 11:54:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9206A8135D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Dec 2024 11:54:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7ogO3es1EiCh for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Dec 2024 11:54:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EB85F8132B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB85F8132B
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EB85F8132B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Dec 2024 11:54:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6AF4E5C32DC;
 Fri, 13 Dec 2024 11:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE190C4CED0;
 Fri, 13 Dec 2024 11:54:40 +0000 (UTC)
Date: Fri, 13 Dec 2024 11:54:38 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Schmidt <mschmidt@redhat.com>
Message-ID: <20241213115438.GP2110@kernel.org>
References: <20241212153417.165919-1-mschmidt@redhat.com>
 <20241212153417.165919-3-mschmidt@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212153417.165919-3-mschmidt@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1734090882;
 bh=nEQGTQHmIQhO0/A9uStQC/R0spmJDZztIzVtIEjRsyk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ESq6JEwktjriu1cljx3tf9sSHX+DDhg+Qm0bpw3zow1aJBEt9S/PWnlnint+AwgJG
 q8EI0fw4oTVEGvLMGAkjP2H7LwmMALFLMolYlZGeuopTmtaypJCBNt8jM7eTuj56Ih
 Ufs+Y8krPM6aSK8wSiRBkGmIHZpRFDCZfSfUC4q26wHfm3t+UTpzdQPci3i0pVmESZ
 EdW4G6baxNiCi+smBSpGKfhrUFKuAMtk6HHwAvp9UsEtVal7xTWKeHiM/zUF2TLuP4
 xJK9Ml6ZhO8pcA1YA3pBlWMTtrLuBDD1wmtjUiOxxmVIeQuJTw39JK7orudUwBHiwr
 QZcFzfEn5R34w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ESq6JEwk
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 2/3] ice: lower the latency
 of GNSS reads
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
Cc: netdev@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Dec 12, 2024 at 04:34:16PM +0100, Michal Schmidt wrote:
> The E810 is connected to the u-blox GNSS module over I2C. The ice driver
> periodically (every ~20ms) sends AdminQ commands to poll the u-blox for
> available data. Most of the time, there's no data. When the u-blox
> finally responds that data is available, usually it's around 800 bytes.
> It can be more or less, depending on how many NMEA messages were
> configured using ubxtool. ice then proceeds to read all the data.
> AdminQ and I2C are slow. The reading is performed in chunks of 15 bytes.
> ice reads all of the data before passing it to the kernel GNSS subsystem
> and onwards to userspace.
> 
> Improve the NMEA message receiving latency. Pass each 15-bytes chunk to
> userspace as soon as it's received.
> 
> Tested-by: Miroslav Lichvar <mlichvar@redhat.com>
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

