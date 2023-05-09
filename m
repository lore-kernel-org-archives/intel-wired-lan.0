Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B42C77B7C
	for <intel-wired-lan@archiver.kernel.org>; Tue,  9 May 2023 15:08:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6417B410E8;
	Tue,  9 May 2023 15:08:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6417B410E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1683644907;
	bh=nga+B9UkgmEZmIi3scJDRspMucMtYBPWBN7XDHV9oAU=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=97YvzkGrcSAlX8EVDmrejHpxSXxn0iUrdVgwzuSmJjIx+5PwWsoVm6XD3HXcJSMiZ
	 Vp6LWI1d9WE8Lr56sFeee4NFS4VzaLMCGZgDdRvUFPJrnmSK8+A9yQJbYc2M0RfxGd
	 ssyie9gC51gtFgZWAtPdwf8FCsWlIZgyvvrpb7Zq7EhCZde4o5aD2PXtf2q/KUPO2i
	 pDizKONuxWwAEIxQbyAjvllUZZtkPTabZr8+Yrt1tZKe/TAF6EIWOIhB68Ci+BPLKZ
	 cCQ5Wn9Wk/As1MI2au3n69Tpv4jZbv66AxWfjouhfNPSS0gzy0T0fS3xAntKZeV/7v
	 oZKG0YR2/3Tgw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dwQhfy5xOQy4; Tue,  9 May 2023 15:08:23 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B44640F4E;
	Tue,  9 May 2023 15:08:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B44640F4E
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id AE6961BF2BE
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 May 2023 02:11:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 89FD4614AC
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 May 2023 02:11:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 89FD4614AC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lC59FOAfST1Q for <intel-wired-lan@lists.osuosl.org>;
 Tue,  9 May 2023 02:11:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0BBA461167
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0BBA461167
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 May 2023 02:11:41 +0000 (UTC)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QFhPX2PfYz18KBZ;
 Tue,  9 May 2023 10:07:28 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 9 May
 2023 10:11:37 +0800
To: Emil Tantilov <emil.s.tantilov@intel.com>,
 <intel-wired-lan@lists.osuosl.org>
References: <20230508194326.482-1-emil.s.tantilov@intel.com>
 <20230508194326.482-3-emil.s.tantilov@intel.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <b947416c-a2a6-5b2f-73b5-843541f9ac0c@huawei.com>
Date: Tue, 9 May 2023 10:11:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20230508194326.482-3-emil.s.tantilov@intel.com>
Content-Language: en-US
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 09 May 2023 15:08:22 +0000
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 02/15] idpf: add module
 register and probe functionality
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
Cc: willemb@google.com, pabeni@redhat.com,
 Shailendra Bhatnagar <shailendra.bhatnagar@intel.com>, leon@kernel.org,
 simon.horman@corigine.com, jesse.brandeburg@intel.com, edumazet@google.com,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org, kuba@kernel.org,
 Phani Burra <phani.r.burra@intel.com>, decot@google.com, davem@davemloft.net,
 shannon.nelson@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 2023/5/9 3:43, Emil Tantilov wrote:
> +
> +/**
> + * idpf_cfg_hw - Initialize HW struct
> + * @adapter: adapter to setup hw struct for
> + *
> + * Returns 0 on success, negative on failure
> + */
> +static int idpf_cfg_hw(struct idpf_adapter *adapter)
> +{
> +	struct pci_dev *pdev = adapter->pdev;
> +	struct idpf_hw *hw = &adapter->hw;
> +
> +	hw->hw_addr = pcim_iomap_table(pdev)[0];
> +	if (!hw->hw_addr) {
> +		pci_err(pdev, "failed to allocate PCI iomap table\n");
> +

Nit: unnecessary blank line here.

> +		return -ENOMEM;
> +	}
> +
> +	hw->back = adapter;
> +
> +	return 0;
> +}
> +
> +/**
> + * idpf_probe - Device initialization routine
> + * @pdev: PCI device information struct
> + * @ent: entry in idpf_pci_tbl
> + *
> + * Returns 0 on success, negative on failure
> + */
> +static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct idpf_adapter *adapter;
> +	int err;
> +
> +	adapter = kzalloc(sizeof(*adapter), GFP_KERNEL);
> +	if (!adapter)
> +		return -ENOMEM;

Nit: add a blank line here.

> +	adapter->pdev = pdev;
> +
> +	err = pcim_enable_device(pdev);
> +	if (err)
> +		goto err_free;
> +
> +	err = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
> +	if (err) {
> +		pci_err(pdev, "pcim_iomap_regions failed %pe\n", ERR_PTR(err));
> +
> +		goto err_free;
> +	}
> +
> +	/* set up for high or low dma */
> +	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (err) {
> +		pci_err(pdev, "DMA configuration failed: %pe\n", ERR_PTR(err));
> +
> +		goto err_free;
> +	}
> +
> +	pci_enable_pcie_error_reporting(pdev);

It seems pci_enable_pcie_error_reporting() has a return value, is there a reason
not to check the return value and handle it?

> +	pci_set_master(pdev);
> +	pci_set_drvdata(pdev, adapter);
> +
> +	/* setup msglvl */
> +	adapter->msg_enable = netif_msg_init(-1, IDPF_AVAIL_NETIF_M);
> +
> +	err = idpf_cfg_hw(adapter);
> +	if (err) {
> +		dev_err(dev, "Failed to configure HW structure for adapter: %d\n",
> +			err);
> +		goto err_cfg_hw;
> +	}
> +
> +	return 0;
> +
> +err_cfg_hw:

Is pci_clear_master() needed here?

> +	pci_disable_pcie_error_reporting(pdev);
> +err_free:
> +	kfree(adapter);
> +	return err;
> +}
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
