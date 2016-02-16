From: John Holland <jotihojr@gmail.com>
Date: Tue, 16 Feb 2016 23:34:07 +0100
Subject: [Intel-wired-lan] [next] igb: allow setting MAC address on i211
	using a device tree blob V2
In-Reply-To: <20160216165850.GF29482@lunn.ch>
References: <56BFA87D.1010609@gmail.com> <20160216165850.GF29482@lunn.ch>
Message-ID: <255BB17A-515B-467A-8ED6-96F1173D233E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> On Feb 16, 2016, at 17:58, Andrew Lunn <andrew@lunn.ch> wrote:
> 
>> On Sat, Feb 13, 2016 at 11:04:45PM +0100, John Holland wrote:
>> Hello,
>> 
>> The Intel i211 LOM pcie ethernet controllers' iNVM operates as an
>> OTP and has no externel EEPROM interface [1]. The following allows
>> the driver to pickup the MAC address from a device tree blob when
>> CONFIG_OF has been enabled.
>> 
>> [1] http://www.intel.com/content/www/us/en/embedded/products/networking/i211-ethernet-controller-datasheet.html
>> 
>> Changes V2
>> - Restrict searching for compatible devices to current pci device.
>> 
>> Signed-off-by: John Holland <jotihojr@gmail.com>
> 
> Hi John
> 
> Thanks for fixing multiple device support.
> 
> Please could you add documentation in
> Documentation/devicetree/bindings/net. I know these are standard
> properties, but it is somewhat unusual to attach them to a PCI node,
> so having an example would be good.
> 
>   Thanks
>    Andrew

Odd that the marvel sky2 allows just that, but supplies no documentation.

I can supply some kind of usage description/example, showing how to use this feature to pull in the MAC address from u-boot and route it to the i210. Just uncertain as how to name the respective file. igb.txt or i210.txt come to mind. Do you prefer one over the other?

John
