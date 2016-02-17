From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 17 Feb 2016 13:24:01 -0800
Subject: [Intel-wired-lan] [next] igb: allow setting MAC address on i211
 using a device tree blob V3
In-Reply-To: <56C4167B.7080705@gmail.com>
References: <56C4167B.7080705@gmail.com>
Message-ID: <1455744241.2958.14.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-02-17 at 07:43 +0100, John Holland wrote:
> Hello,
> 
> The Intel i211 LOM pcie ethernet controllers' iNVM operates as an OTP
> and has no externel EEPROM interface [1]. The following allows the
> driver to pickup the MAC address from a device tree blob when
> CONFIG_OF
> has been enabled.
> 
> [1]http://www.intel.com/content/www/us/en/embedded/products/networkin
> g/i211-ethernet-controller-datasheet.html
> 
> Changes V2
> - Restrict searching for compatible devices to current pci device.
> 
> Changes V3
> - Add device tree binding documentation.
> 
> Signed-off-by: John Holland<jotihojr@gmail.com>
> ---
> 
> ? Documentation/devicetree/bindings/net/intel,i210.txt | 36
> ++++++++++++++++++++++++++++++++++++
> ? drivers/net/ethernet/intel/igb/igb_main.c??????????? | 30
> ++++++++++++++++++++++++++++++
> ? 2 files changed, 66 insertions(+)

Does not apply cleanly to my tree, please make sure you rebase your
patches based off my dev-queue branch on my next-queue tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160217/c1f86a7c/attachment.asc>
