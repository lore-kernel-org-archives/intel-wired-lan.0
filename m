Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E9BE8782F
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Feb 2026 13:53:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D52146083E;
	Tue,  3 Feb 2026 13:53:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id prdXzfiWJM-D; Tue,  3 Feb 2026 13:53:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A144606F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770126814;
	bh=WumWOs7FJGqx0XgG1T98oPyzhxUL0T3RGf6i4vVvYrQ=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9cbMtQGRwB6m3jy+6W2SbhUEVSY9xV0DwjZCVkSQa5AZ6jSAMN1Lt9QGDlRUnnOaf
	 96DNX30IsiPhO96uEDa+kgdaU3ORPXxgAECad66nSfugM0cjTGLRSh/0sTL+mDbjeM
	 nr4MLP1sGZpvgEzZcrODABURtw4Nb7Pt7IodteemmgUP6o3hCWXLPc0OKCCbETKc93
	 Qg8ORkHmnYWOKf8y3QdxhaQrwLkaAdye/DEbb85QTZhMHGY2KRWg4KyBILNfr1wFbc
	 As7+lEUO1LnfoHmrlGuezP6nMUfKjHL3Aj2OBHg16NnQ7/WN5C8i9osayoMFkwXYTN
	 a2hME6ylHT+aQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A144606F1;
	Tue,  3 Feb 2026 13:53:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9AEC413D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 13:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 87C35606F1
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 13:53:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zqipVW73m6Ek for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Feb 2026 13:53:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7F684606D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F684606D3
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F684606D3
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 13:53:30 +0000 (UTC)
Received: from ms-a2 (182.51.30.125.dy.iij4u.or.jp [125.30.51.182])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 613Dr2n1008421
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 3 Feb 2026 22:53:04 +0900 (JST) (envelope-from kohei@enjuk.jp)
From: Kohei Enju <kohei@enjuk.jp>
To: takkozu@amazon.com
Cc: aleksandr.loktionov@intel.com, andrew+netdev@lunn.ch,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 enjuk@amazon.com, horms@kernel.org, intel-wired-lan@lists.osuosl.org,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 piotr.kwapulinski@intel.com, pmenzel@molgen.mpg.de,
 przemyslaw.kitszel@intel.com, Kohei Enju <kohei@enjuk.jp>
Date: Tue,  3 Feb 2026 13:52:49 +0000
Message-ID: <20260203135300.2849-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260203125417.37285-8-takkozu@amazon.com>
References: <20260203125417.37285-8-takkozu@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=WumWOs7FJGqx0XgG1T98oPyzhxUL0T3RGf6i4vVvYrQ=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:To:Subject:Date:Message-ID;
 s=rs20251215; t=1770126785; v=1;
 b=T91IorZTIuJwtY8aCL8+p0dk3mQZ0vHFUuVjCG+igmGKyzGCIzzmmlABWZYdBEzb
 BpB/HSwLm/gS7IF9JAlIVe0OvRtrVReWNpKXX2YZWjtA7IMoMgElZYFIaUi1w43C
 qMr0wex1t6ZJmhyaU2NoDl8h5g36e6mE1X8TxHNKYC5GhR7Yl4+AJcFUa9HxIg8o
 kmLgCO2Rk/5c9O/rRNAfKGcBvX5uCfoh0zaF3KdoNkRMKum4clbI49qzzpeHpIHR
 93BjvdStkHqVETso4rdVK9naBEEy04vcFzXESp6gHCq5d6EWjVmsj2VDgOtcF46f
 2oAQRWCa2Kcq8QbGlMTSJw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=T91IorZT
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v6 3/3] igb: allow
 configuring RSS key via ethtool set_rxfh
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

On Tue, 3 Feb 2026 21:54:13 +0900, Takashi Kozu wrote:

> Change igb_set_rxfh() to accept and save a userspace-provided
> RSS key. When a key is provided, store it in the adapter and write the
> E1000 registers accordingly.
> 
> This can be tested using `ethtool -X <dev> hkey <key>`.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Takashi Kozu <takkozu@amazon.com>

Tested-by: Kohei Enju <kohei@enjuk.jp>

The details of testing: 
https://lore.kernel.org/intel-wired-lan/20260128072908.50245-1-kohei@enjuk.jp/
