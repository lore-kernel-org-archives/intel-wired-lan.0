Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70DE1091901
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Mar 2026 17:45:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75FCF41932;
	Thu, 19 Mar 2026 17:45:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iYVcg5Yvu418; Thu, 19 Mar 2026 17:45:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E565041933
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773942313;
	bh=jcyjoy7P/IC49C66iLPkXEnlXcTxq1RgRmHR52vk+TQ=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=PEH1rjyHzWUSZVBoO/xgcBA7DOie/c/gMxot+j5E+/gb+vwVrLOvEvLzRKzwsapuV
	 P+RR1DPU6DbmaInwS3mR26PESRzGgnzYfmP3b4nrgk0/NytxEe/cHpUmCEyZMKcbgT
	 Z7s2B5VyxwNy/64bKFyYfJPKVand8duzLSYxqCTwd8+mcyiHHqUXmuSbxfQ2NUZtBl
	 dFaYnpJM6Te3dPRuEa7sQZqVnyXsoeH8jI6mRrHW4MdedJz3WWH9bybF+OB6zPfbRQ
	 LBbo+5nGpxplyg08mS6Ir66B93lXaPy6ued+Hxe2w7xgZd8izEE5Ismt4Zn7R6NM7P
	 boQVOmWiT9MBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E565041933;
	Thu, 19 Mar 2026 17:45:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D8A2C265
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Mar 2026 17:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C7CCC41932
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Mar 2026 17:45:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2dwJTRoyZGcs for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Mar 2026 17:45:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 02FD541933
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 02FD541933
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 02FD541933
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Mar 2026 17:45:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F14F260097;
 Thu, 19 Mar 2026 17:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A374C19424;
 Thu, 19 Mar 2026 17:45:06 +0000 (UTC)
Date: Thu, 19 Mar 2026 17:45:03 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Message-ID: <20260319174503.GO1753385@horms.kernel.org>
References: <20260318090654.611349-1-grzegorz.nitka@intel.com>
 <20260318090654.611349-2-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318090654.611349-2-grzegorz.nitka@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1773942309;
 bh=6CGzvuEPGSvPA+dPivezYFQso4zqZF1AmoyPvpSIKUo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aLzsGnyWnfIxc0yii4POgMlCmyEmqsjjz5FNpgiHFKrD5PottLn2hCw7gRilC/wAg
 J3nA5q4HyKWtYIdGsSronhYen6j8GdjtcFIN4Sh6bsNqQ4UGiRFJba0KwsYK/ybB/R
 laluDYr7Y97QGZecW8uNAzneNoHcUGxOeWstN/5SHi9CrBnxz0QNXV3wr6EDGGNTbm
 WV23wAu1L5jKlqDm7JFl30wOWFqD15cJSL7DyqHWuJmIH72UwsxH6yRwnIlZvlJaI8
 IHb4g4Jp9l4C+4GsUPAkkZx3bBeiTEly3M5eNbgjNdZIE73zMWAohND94+GNYQrsOA
 jhCoM5mcYibNA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=aLzsGnyW
Subject: Re: [Intel-wired-lan] [PATCH net-next 1/8] dpll: add new DPLL type
 for transmit clock (TXC) usage
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
Cc: ivecera@redhat.com, vadim.fedorenko@linux.dev, jiri@resnulli.us,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, netdev@vger.kernel.org,
 richardcochran@gmail.com, donald.hunter@gmail.com,
 linux-kernel@vger.kernel.org, arkadiusz.kubalewski@intel.com,
 Prathosh.Satish@microchip.com, andrew+netdev@lunn.ch,
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, pabeni@redhat.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Mar 18, 2026 at 10:06:47AM +0100, Grzegorz Nitka wrote:
> Extend the DPLL subsystem with a new DPLL type, DPLL_TYPE_TXC,
> representing devices that drive a transmit reference clock. Certain
> PHYs, MACs and SerDes blocks use a dedicated TX reference clock for
> link operation, and this clock domain is distinct from PPS- and
> EEC-driven synchronization sources. Defining a dedicated type allows
> user space and drivers to correctly classify and configure DPLLs
> intended for TX clock generation.
> 
> The corresponding netlink specification is updated to expose "txc"
> 
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>  Documentation/netlink/specs/dpll.yaml | 3 +++
>  include/uapi/linux/dpll.h             | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
> index 3dd48a32f783..2a2ee37a1fc0 100644
> --- a/Documentation/netlink/specs/dpll.yaml
> +++ b/Documentation/netlink/specs/dpll.yaml
> @@ -138,6 +138,9 @@ definitions:
>        -
>          name: eec
>          doc: dpll drives the Ethernet Equipment Clock
> +      -
> +        name: txc
> +        doc: dpll drives Tx reference clock
>      render-max: true
>    -
>      type: enum
> diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
> index de0005f28e5c..a277d08ac264 100644
> --- a/include/uapi/linux/dpll.h
> +++ b/include/uapi/linux/dpll.h
> @@ -109,10 +109,12 @@ enum dpll_clock_quality_level {
>   * enum dpll_type - type of dpll, valid values for DPLL_A_TYPE attribute
>   * @DPLL_TYPE_PPS: dpll produces Pulse-Per-Second signal
>   * @DPLL_TYPE_EEC: dpll drives the Ethernet Equipment Clock
> + * @DPLL_TYPE_TXC: dpll drives Tx reference clock signal
>   */
>  enum dpll_type {
>  	DPLL_TYPE_PPS = 1,
>  	DPLL_TYPE_EEC,
> +	DPLL_TYPE_TXC,
>  
>  	/* private: */
>  	__DPLL_TYPE_MAX,

I think that the spec and source code changes are inconsistent in this
patch.

With it applied I see:

./tools/net/ynl/ynl-regen.sh -f && git diff
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index a2b22d492114..4182bdbb6dbb 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -34,7 +34,7 @@ const struct nla_policy dpll_reference_sync_nl_policy[DPLL_A_PIN_STATE + 1] = {
 static const struct nla_policy dpll_device_id_get_nl_policy[DPLL_A_TYPE + 1] = {
        [DPLL_A_MODULE_NAME] = { .type = NLA_NUL_STRING, },
        [DPLL_A_CLOCK_ID] = { .type = NLA_U64, },
-       [DPLL_A_TYPE] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
+       [DPLL_A_TYPE] = NLA_POLICY_RANGE(NLA_U32, 1, 3),
 };

 /* DPLL_CMD_DEVICE_GET - do */
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index a277d08ac264..8f6db5d5bf0c 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -109,7 +109,7 @@ enum dpll_clock_quality_level {
  * enum dpll_type - type of dpll, valid values for DPLL_A_TYPE attribute
  * @DPLL_TYPE_PPS: dpll produces Pulse-Per-Second signal
  * @DPLL_TYPE_EEC: dpll drives the Ethernet Equipment Clock
- * @DPLL_TYPE_TXC: dpll drives Tx reference clock signal
+ * @DPLL_TYPE_TXC: dpll drives Tx reference clock
  */
 enum dpll_type {
        DPLL_TYPE_PPS = 1,

-- 
pw-bot: changes-requested
