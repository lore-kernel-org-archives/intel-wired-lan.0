From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 9 Feb 2016 12:54:30 +0100
Subject: [Intel-wired-lan] [next] igb: allow setting MAC address on i211
 using a device tree blob
In-Reply-To: <1455015744.3592.46.camel@intel.com>
References: <56ABE3A8.4010602@gmail.com> <1455015744.3592.46.camel@intel.com>
Message-ID: <20160209115430.GD18781@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> > +static void igb_read_mac_addr_dts(struct e1000_hw *hw)
> > +{
> > +???????const u8 *mac;
> > +???????struct device_node *dn;
> > +
> > +???????dn = of_find_compatible_node(NULL, NULL, "intel,i211");

Hi John

Would this also work for the i210?

If so, you normally use the compatible string for the first device
this works with. So maybe this should be changed to intel,i210?

Thanks
	Andrew
