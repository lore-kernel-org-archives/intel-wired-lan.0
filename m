From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 16 Feb 2016 17:58:50 +0100
Subject: [Intel-wired-lan] [next] igb: allow setting MAC address on i211
 using a device tree blob V2
In-Reply-To: <56BFA87D.1010609@gmail.com>
References: <56BFA87D.1010609@gmail.com>
Message-ID: <20160216165850.GF29482@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, Feb 13, 2016 at 11:04:45PM +0100, John Holland wrote:
> Hello,
> 
> The Intel i211 LOM pcie ethernet controllers' iNVM operates as an
> OTP and has no externel EEPROM interface [1]. The following allows
> the driver to pickup the MAC address from a device tree blob when
> CONFIG_OF has been enabled.
> 
> [1] http://www.intel.com/content/www/us/en/embedded/products/networking/i211-ethernet-controller-datasheet.html
> 
> Changes V2
> - Restrict searching for compatible devices to current pci device.
> 
> Signed-off-by: John Holland <jotihojr@gmail.com>

Hi John

Thanks for fixing multiple device support.

Please could you add documentation in
Documentation/devicetree/bindings/net. I know these are standard
properties, but it is somewhat unusual to attach them to a PCI node,
so having an example would be good.

   Thanks
	Andrew
