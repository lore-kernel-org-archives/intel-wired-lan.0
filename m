From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Date: Mon, 25 Jun 2018 11:25:13 +0000
Subject: [Intel-wired-lan] [PATCH] igb: allow optionally getting mac
 address from device tree
In-Reply-To: <20180625.170547.658198698048994134.davem@davemloft.net>
References: <20180625080042.32286-1-marcel@ziswiler.com>
 <20180625.170547.658198698048994134.davem@davemloft.net>
Message-ID: <1529925911.12558.12.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi David

On Mon, 2018-06-25 at 17:05 +0900, David Miller wrote:
> From: Marcel Ziswiler <marcel@ziswiler.com>
> Date: Mon, 25 Jun 2018 10:00:42 +0200
> 
> > @@ -3122,7 +3124,11 @@ static int igb_probe(struct pci_dev *pdev,
> > const struct pci_device_id *ent)
> >  		break;
> >  	}
> >  
> > -	if (eth_platform_get_mac_address(&pdev->dev, hw-
> > >mac.addr)) {
> > +	/* try to get the MAC address from device tree data */
> > +	iap = of_get_mac_address(pdev->dev.of_node);
> > +	if (iap)
> > +		memcpy(hw->mac.addr, iap, ETH_ALEN);
> 
> This is exactly what eth_platform_get_mac_address() shoule be doing.

Yes, you are absolutely right. That indeed already works just fine given a
proper device tree. Struggling with the device tree part I probably missed
noticing this.

Sorry for the noise and thanks for the tip!

Cheers

Marcel
