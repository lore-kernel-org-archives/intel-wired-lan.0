From: David Miller <davem@davemloft.net>
Date: Mon, 25 Jun 2018 17:05:47 +0900 (KST)
Subject: [Intel-wired-lan] [PATCH] igb: allow optionally getting mac
 address from device tree
In-Reply-To: <20180625080042.32286-1-marcel@ziswiler.com>
References: <20180625080042.32286-1-marcel@ziswiler.com>
Message-ID: <20180625.170547.658198698048994134.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Marcel Ziswiler <marcel@ziswiler.com>
Date: Mon, 25 Jun 2018 10:00:42 +0200

> @@ -3122,7 +3124,11 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		break;
>  	}
>  
> -	if (eth_platform_get_mac_address(&pdev->dev, hw->mac.addr)) {
> +	/* try to get the MAC address from device tree data */
> +	iap = of_get_mac_address(pdev->dev.of_node);
> +	if (iap)
> +		memcpy(hw->mac.addr, iap, ETH_ALEN);

This is exactly what eth_platform_get_mac_address() shoule be doing.
