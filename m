From: David Miller <davem@davemloft.net>
Date: Sat, 05 Dec 2015 23:12:53 -0500 (EST)
Subject: [Intel-wired-lan] [PATCH v8] i40e: Look up MAC address in Open
	Firmware or IDPROM
In-Reply-To: <20151205203300.GA8863@oracle.com>
References: <20151205203300.GA8863@oracle.com>
Message-ID: <20151205.231253.1057553137456534699.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Sat, 5 Dec 2015 15:33:00 -0500

> +static void i40e_get_platform_mac_addr(struct pci_dev *pdev, struct i40e_pf *pf)
> +{
> +	struct device_node *dp = pci_device_to_OF_node(pdev);
> +	const unsigned char *addr;
> +	u8 *mac_addr = pf->hw.mac.addr;
> +
> +	pf->flags &= ~I40E_FLAG_PF_MAC;
> +	addr = of_get_mac_address(dp);
> +	if (addr) {
> +		ether_addr_copy(mac_addr, addr);
> +		pf->flags |= I40E_FLAG_PF_MAC;
> +	}
> +#ifdef CONFIG_SPARC
> +	ether_addr_copy(mac_addr, idprom->id_ethaddr);
> +	pf->flags |= I40E_FLAG_PF_MAC;
> +#endif /* CONFIG_SPARC */
> +}

This logic doesn't look right.

If we find an address via of_get_mac_address() we should not use the
IDPROM address.  But here you are, since the IDPROM code runs
unconditionally.
