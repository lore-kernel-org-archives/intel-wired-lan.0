Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E606CA6004
	for <intel-wired-lan@archiver.kernel.org>; Sat, 10 Oct 2026 03:27:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 934A560631;
	Sat, 10 Oct 2026 03:27:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2hyJfGkiPSXs; Sat, 10 Oct 2026 03:27:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CC57C60638
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791602855;
	b=G2ICFqsubMnfLPDTiczDMAWiCH8xMNLUAyTsKppZq99sR4s3qTpxlJTAk7PmydpncT+W
	 fN3w7vzREXwd+6CGjwWxIO6D2/XNKSnz5tu+LgklGLimKwN4VLebr0AdM2yfkljKdbW4V
	 XppVngr7fnADTWaGVSlJvqBS0otykBX8DKEIciN+NIBLQeEEYNdPv9aF2e/TUgckwABh6
	 4EADxGgfX2GKwSnhgSAX9Qzh5ErbQIZ3Nrzzu+jf4sT9xI4QhAgF8rezRXle/4KspUIvq
	 38SA6MmeI0EdHcRWs9X1zFvqc5dub0vtkYlGwXQHk80obXwLchFvDnwB0NPoQk7qjLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791602855;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=kFOr+Eo+5w2XtapDC2C0Gi46PhHbd/iwe20ewRtiLOI=;
	b=fA1/xIh3AmKYtGweUuTcTq5Esu1nejYhKwIEPJuflFe9OATQZYKY1xTJopabcdMbk2HC
	 LJ04VnG685vtPjNPEekUp0gJTK/xLqGLV/WAUzYKQfnXZr/q3AvjDPk1hR70ww2w9Wk6u
	 54kx9eq1pEHnzZDmWhs1at1u03OrR9uMWkn9+A6BRVaBNJJZu90EzUfbXt2uiYBmQpvy+
	 LYhamwcnnyCB1mh1ClW3VVlnE81ns8GSybkBWshsITHLyML0uveOHjj+W6Nx+nww0826K
	 chksRlJ227UaQc3WcKf2umcOdVXqAcZnOFNkImVpD3KviqE8COqDCoSru8zzKFLUVtQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791602855;
	bh=kFOr+Eo+5w2XtapDC2C0Gi46PhHbd/iwe20ewRtiLOI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=fkerSsogcVjc5UiWrJ/4YsRh6fyjvZdPg9QIl0KA6Kcv9cRpS2n73gKA8lHZQpcoj
	 PUAfMyv3LOMnyzqrVkvx+5GCibjIYZKHolQqZLM3Zqy8j93Q6PcoAEyR3YdwRkAyCe
	 BZBuvyANf0xFrzykTw+gcvg01uowMNiVCJYCCdm8uYr3OQ2V9UO1oJEZqjQT2bzcDk
	 NrmYO9cybHgwkwR4jA5hP9kUIaCYQKEfi0In+DXSXFaGaqUJUIIVFYwEM4Ey2vmajF
	 JFdn4P+O2Hvjm8pXawROHO/EbFwkRE0bkVfJR8Anh1ahtsrTg9neNNSYV81qiT0smp
	 G3t3IV8aTi10w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC57C60638;
	Sat, 10 Oct 2026 03:27:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B3C39D1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 03:27:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F0F19400CC
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 03:27:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zk-T5U5bZHIg for <intel-wired-lan@lists.osuosl.org>;
 Sat, 10 Oct 2026 03:27:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B710340061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791602851;
 b=O1rg/yUvzYKDIbVhr83i6KXK3JL69dzAuJoJESxGakxCrwDpjn01vYqyOD58fVYUA4cC
 w5H2WutwN1GLg0UkjMQKzKmZUZEePb0HKnIA4Au1JnFXrL5e3UmW2tDcOIksaOskGY7Ls
 RB63nTzkE/4KwOKTvAunFrYnE4SjmXmVBLbGwc++f/vUVN6SsMmAmwaHVx7E96FxqaXQX
 VpL/+LZV123PsdZfzrM/rxOkWEbWIqtcFT/TQ7BDgDvP00eCqMquzEeflBVIlsFKAdh+N
 yz3I2afLdPaEAfAcAdXj6WHO1pyjC4y+eHB4D/rhZXFvEfZu0Nx+xNAaQjvvaLLEx9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791602851;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=kFOr+Eo+5w2XtapDC2C0Gi46PhHbd/iwe20ewRtiLOI=;
 b=LeAICuBuTch6GW01Cl6TNO/LmxwyD5H15X+v720UrVYPkUzbuKxCn8B6bP2ExWyttghM
 D2pjgYl91fbCWlONbV11p+f0Hay0AysR50r2+ixY2jXVSwWwlpcCmjV83ZWxwLfymeTEQ
 3yU4yhBBHio7UYkfTGKfToQVGBR9BX0HzWreVgD9RiubhLqDH8+6EwlDy4cyaRpbZucLn
 T8QDnHZIdMfIgte6XcqXK/YvGphXFLKqwEsr+mAs8buHw3V2swO2RDHW0BfnAc4gGLgC+
 RNxj42wnex0RdNgyW5wBxybW5Yn/vmcWTCd9yeniTPNu1iSHYwbau6RFcWf44CP6lmw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="KI65/lI2"; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KI65/lI2
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B710340061
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 03:27:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6A04942B32;
 Sat, 10 Oct 2026 03:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181191F000FF;
 Sat, 10 Oct 2026 03:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791602850;
 bh=kFOr+Eo+5w2XtapDC2C0Gi46PhHbd/iwe20ewRtiLOI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KI65/lI20irJihx/NZVHxXfiVWDwDefrtAztHgcBpHwEwIJFBG1xSKIMsjigSHuTl
 clJbUpM5lpfP5c8jhe8VfZ2QwjoIAP7wipI2lb4bqOQTKgjgHrej8/GPrlTiAcuWE4
 Xj0HwBUZFBkhvbQMmQhTePC1uMq9jAH6evmG7+fI7IytvHA9bdBYEAFKcVDjkDsgIM
 nOiwzDbqhIhjwCJCgac+AMpygbWOKDGKxMY8U4Zrp+KLi8S1fIjXWjyl597O95go3G
 e0etcUiOBIzglUhEL+4WlaJCRUIFqPDBCBikZQpsU6uDmnPsCljefRvs3junsb2Sex
 zSvpcffwU91bg==
Message-ID: <sashiko-outbox-166245@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net v3] idpf: keep the mailbox up while tearing down
 vports on shutdown
To: "Tian Xun Ng" <luckilystar08@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261009032706.94324-1-luckilystar08@gmail.com>
References: <20261009032706.94324-1-luckilystar08@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 03:27:29 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: idpf: use-after-free of PTP tx_tstamp_caps during shutdown
--

commit 5449e12bf292e1f9d4473ed0d51fe60b2a67f6b3
Author: Tian Xun Ng <tianxun.ng@bytedance.com>

idpf: keep the mailbox up while tearing down vports on shutdown

Since commit 4c9106f4906a ("idpf: fix adapter NULL pointer dereference
on reboot"), idpf_shutdown() calls idpf_vc_core_deinit() directly instead
of idpf_remove(), so IDPF_REMOVE_IN_PROG is not set on shutdown.
idpf_vc_core_deinit() uses that flag to decide when to shut the virtchnl
transaction manager down.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/et=
hernet/intel/idpf/idpf_main.c
> index 129bccaa6baa8..ec751f4a6deb6 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> @@ -194,8 +194,17 @@ static void idpf_shutdown(struct pci_dev *pdev)
>  {
>  	struct idpf_adapter *adapter =3D pci_get_drvdata(pdev);
> =20
> +	/* As in idpf_remove(): keep the event task from being requeued, and
> +	 * destroy the vports while the mailbox is still up.
> +	 */
> +	set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);

[Severity: High]
Does setting IDPF_REMOVE_IN_PROG here expose a use-after-free race during r=
eboot?

When this flag is set, idpf_vc_core_deinit() defers shutting down the
transaction manager (via libie_ctlq_xn_shutdown()) until the very end.
However, it also calls idpf_ptp_release() earlier in the function, which
synchronously frees vport->tx_tstamp_caps via idpf_ptp_release_vport_tstamp=
()
in drivers/net/ethernet/intel/idpf/idpf_ptp.c.

Because the transaction manager and mailbox task remain active during this
window, an asynchronous PTP Tx timestamp reply can still be received.

If that happens, the mailbox handler idpf_ptp_get_tx_tstamp_async_handler()
in drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c can dereference the
freed tx_tstamp_caps pointer, leading to a panic.

While the commit message mentions that a race already exists in the remove
path, setting this flag appears to newly expose the same vulnerability in t=
he
shutdown path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009032706.9432=
4-1-luckilystar08@gmail.com?part=3D1
