Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF61606A321
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=9sovZfNJ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gx0ANp02
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3390809CE;
	Mon, 23 Nov 2026 12:01:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id smHg64MOIo3U; Mon, 23 Nov 2026 12:01:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3B68580BEA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795435303;
	b=CPhgwl4dX9R2uojH6du4JL7DBdq5qDaMBfUR23LRM5fDt7MUTNHOOm3B9yAlhiJkVvXo
	 ZMBJlXpvPexrnqGVFnv8tbyuetItF05JF31t5acmksIwao8L9M5g55Vc093Z81jVIya7u
	 ynPru8OAifs2h3iQ1G2aVo5RBwDMmy+uAiCPM2KhLTo3oG2L2hontpjS9CyWKGplZrIAl
	 HU3CqcgD4Jf380asMOey7E2sTU+ZQrKXpyp0V9efc5mhgvJTIA+GGx1VoicVIxACeYjiz
	 3aJYG7m5y4xnYlZ99lfCiEaY3py12BoCbyOpDP5HC1NYpZPnNJ0kWBlfo9CU7cCD6Aw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795435303;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YnMwHbaiMPLKKj5/cjoUKKWrX4fraOVi4tcjJaxhKGA=;
	b=ltfRH3XJxjC1LZI69aBCpRv1SyMq9IXV2jXpDnTJR2wAu6iXy1y44fBiHG5DzeU3dlzX
	 O2JW7gBbrAceyF7mUHTsjEmn6sYN0NRWWB1hgvscma2SY0SDUl0SMk2oeibHpBtaWlZl1
	 UMk4C9S0mXhwpS7SYciKR2a56s5nwHpTLSSnLckZUp/QO5bgO+iG9YbVuqgkF9xapAcSi
	 hnTIp7fOOAd0Rk9AttUb1fj1csMwg3sJKHXJlTheII5drwE33rHeXR5WYNg0hmpWbklY1
	 wuPLKQEKoHxqFbuCGKNmc0u4GpnUfOls7GWAlgyR8IiaOcsK8Kr1tDJIxnrRejXOe2g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795435303;
	bh=YnMwHbaiMPLKKj5/cjoUKKWrX4fraOVi4tcjJaxhKGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9sovZfNJhSGafPSg7vyQhXfedOIwhMXJSm96tzHZeYnMpamRENWE/SXTyoEI7psPK
	 3RVZGSfBRpeauyjzrjeWpDxzTK/r7OHOJtcKmaw5mi2lqjLMibbbt8m/lQ8dCjcZVg
	 XBxftWPslUE7KOrCdeFhhipy5ZSd36fMcMjHB83BZ5RcwsxclhvLqJFHVEQgyHnPG8
	 TH20D4n/QK0cWBbIEtcrWXDjmlh0QtbsyU9FHRIzzaHGomPgIC2IT1iizBqQOk8Gy5
	 LwH0ADb4tZcK63XNToAjwPJviU4NWdXbsUz2N09Vq4QVxdTwLYHtrMpjH4Yp8L18W2
	 SywyJWf1Mi3kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B68580BEA;
	Mon, 23 Nov 2026 12:01:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BE403A8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 12:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5193F6071F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 12:01:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YZy0XOCRO4ya for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 12:01:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 57FD8605F8
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Gx0ANp02
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57FD8605F8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 12:01:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7A8F9620C2;
 Mon, 23 Nov 2026 12:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3501F000CA;
 Mon, 23 Nov 2026 12:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795435298;
 bh=YnMwHbaiMPLKKj5/cjoUKKWrX4fraOVi4tcjJaxhKGA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Gx0ANp02D3JqsPCteetrYneO5TI7uhaEJAiEWrKK9CT6pfG3zvICVfDt/pKF4AUS1
 wjH/F8JgMqlbejuPZV4i7cnHpoT5hiMhxYminv2oVZ8U1FN6RhGkNZXYULR3JZ32wz
 AqKHhT+Nk5o26cGyhf7iRRivIhvsEOx01OGJWxrgMi9V1VueTy++XRlVzM6s0/lR8y
 sjbREv7VuybQ1hQat32YWzIIixStS98CasnwbVfZQn9YtwpgS/VWmZLeveHsziAvQY
 AQI9j3a4Tsmg83KJ1oNStNgKVP+J9MDshLWhatknLEfzn3ylvZp5q6FHV57HvQukWs
 bbkbwgUwO1bmQ==
Date: Mon, 23 Nov 2026 12:01:34 +0000
From: Simon Horman <horms@kernel.org>
To: Changyul Lee <lcy8047@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net] i40e: hold mac_filter_hash_lock while validating
 VF cloud filters
Message-ID: <20261123120134.GA31322@horms.kernel.org>
References: <20261117031553.1728084-1-lcy8047@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117031553.1728084-1-lcy8047@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 10:15:53PM -0500, Changyul Lee wrote:
> i40e_validate_cloud_filter() runs in the VF message path, which holds
> neither RTNL nor vsi->mac_filter_hash_lock. It looks up the destination
> MAC with i40e_find_mac() and walks vsi->mac_filter_hash for the VLAN
> without the lock. Meanwhile the host can change the VF MAC or port VLAN
> with i40e_ndo_set_vf_mac() or i40e_ndo_set_vf_port_vlan(), which delete
> filters under the lock and free them in __i40e_del_filter() or
> i40e_sync_vsi_filters(). The lookup and the walk can then read a freed
> struct i40e_mac_filter.
> 
> Do the lookup and the walk under mac_filter_hash_lock, as
> i40e_vc_add_mac_addr_msg() does, and do not use the filter after
> dropping the lock.
> 
> Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
> Signed-off-by: Changyul Lee <lcy8047@gmail.com>
> ---
> Found with a static analysis tool we are developing.
> 
> Compile-tested only, with x86_64_defconfig plus PCI_IOV, I40E and W=1.

Thanks, as a fix this approach looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

I do wonder if, as a follow-up for net-next, it would be worth
factoring-out the basic filter check. It seems to lead to easier
handling of unlocking on error. And as a bonus, tighter scoping
of local variables.

Something along these lines (compile tested only!):

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index da1f1a9c4124..d4f0fb7b5996 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3579,6 +3579,62 @@ static int i40e_vc_disable_vlan_stripping(struct i40e_vf *vf, u8 *msg)
 				       aq_ret);
 }
 
+/**
+ * i40e_validate_basic_filter
+ * @vf: pointer to VF structure
+ * @tc_filter: pointer to filter requested
+ *
+ * This function validates a basic cloud filter programmed as TC filter for ADq
+ *
+ * Return: 0 on success, negative value on failure
+ **/
+static int i40e_validate_basic_filter(struct i40e_vf *vf,
+				      const struct virtchnl_filter *tc_filter)
+{
+	struct virtchnl_l4_spec mask = tc_filter->mask.tcp_spec;
+	struct virtchnl_l4_spec data = tc_filter->data.tcp_spec;
+	struct i40e_pf *pf = vf->pf;
+	struct i40e_mac_filter *f;
+	struct i40e_vsi *vsi;
+	struct hlist_node *h;
+	bool found = false;
+	int bkt, err;
+
+	vsi = pf->vsi[vf->lan_vsi_idx];
+	spin_lock_bh(&vsi->mac_filter_hash_lock);
+	f = i40e_find_mac(vsi, data.dst_mac);
+
+	if (!f) {
+		dev_info(&pf->pdev->dev,
+			 "Destination MAC %pM doesn't belong to VF %d\n",
+			 data.dst_mac, vf->vf_id);
+		err = -EIO;
+		goto out_unlock;
+	}
+
+	if (!mask.vlan_id)
+		goto out_unlock;
+
+	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist) {
+		if (f->vlan == ntohs(data.vlan_id)) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		dev_info(&pf->pdev->dev, "VF %d doesn't have any VLAN id %u\n",
+			 vf->vf_id, ntohs(data.vlan_id));
+		err = -EIO;
+		goto out_unlock;
+	}
+
+	err = 0;
+out_unlock:
+	spin_unlock_bh(&vsi->mac_filter_hash_lock);
+	return err;
+}
+
 /**
  * i40e_validate_cloud_filter
  * @vf: pointer to VF structure
@@ -3592,11 +3648,6 @@ static int i40e_validate_cloud_filter(struct i40e_vf *vf,
 	struct virtchnl_l4_spec mask = tc_filter->mask.tcp_spec;
 	struct virtchnl_l4_spec data = tc_filter->data.tcp_spec;
 	struct i40e_pf *pf = vf->pf;
-	struct i40e_vsi *vsi = NULL;
-	struct i40e_mac_filter *f;
-	struct hlist_node *h;
-	bool found = false;
-	int bkt;
 
 	if (tc_filter->action != VIRTCHNL_ACTION_TC_REDIRECT) {
 		dev_info(&pf->pdev->dev,
@@ -3623,37 +3674,9 @@ static int i40e_validate_cloud_filter(struct i40e_vf *vf,
 	 *		  Trusted.
 	 */
 	if (mask.dst_mac[0] && !mask.dst_ip[0]) {
-		vsi = pf->vsi[vf->lan_vsi_idx];
-		spin_lock_bh(&vsi->mac_filter_hash_lock);
-		f = i40e_find_mac(vsi, data.dst_mac);
-
-		if (!f) {
-			spin_unlock_bh(&vsi->mac_filter_hash_lock);
-			dev_info(&pf->pdev->dev,
-				 "Destination MAC %pM doesn't belong to VF %d\n",
-				 data.dst_mac, vf->vf_id);
-			goto err;
-		}
-
-		if (mask.vlan_id) {
-			hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f,
-					   hlist) {
-				if (f->vlan == ntohs(data.vlan_id)) {
-					found = true;
-					break;
-				}
-			}
-		}
-		spin_unlock_bh(&vsi->mac_filter_hash_lock);
-
-		if (mask.vlan_id) {
-			if (!found) {
-				dev_info(&pf->pdev->dev,
-					 "VF %d doesn't have any VLAN id %u\n",
-					 vf->vf_id, ntohs(data.vlan_id));
-				goto err;
-			}
-		}
+		int err = i40e_validate_basic_filter(vf, tc_filter);
+		if (err < 0)
+			return err;
 	} else {
 		/* Check if VF is trusted */
 		if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
