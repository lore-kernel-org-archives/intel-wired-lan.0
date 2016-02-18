From: John Holland <jotihojr@gmail.com>
Date: Thu, 18 Feb 2016 14:43:59 +0100
Subject: [Intel-wired-lan] [next] igb: allow setting MAC address on i211
 using a device tree blob V5
In-Reply-To: <56C5A6BC.6030708@gmail.com>
References: <56C5A6BC.6030708@gmail.com>
Message-ID: <56C5CA9F.3000102@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 02/18/2016 12:10 PM, John Holland wrote:
> Hello,
>
> The Intel i211 LOM PCIe Ethernet controllers' iNVM operates as an OTP
> and has no external EEPROM interface [1]. The following allows the
> driver to pickup the MAC address from a device tree blob when CONFIG_OF
> has been enabled.
>
> +       if (eth_platform_get_mac_address(&pdev->dev, hw->mac.addr)) {

For later reference, putting all necessary information in one place.

This requires the dtb for the mac address routing to be properly 
positioned. On an imx6q using U-Boot, that required setting the U-Boot 
environment variable eth1addr and reworking the PCIe tree and allocating 
an alias as such:

1) Set intel,i211 MAC address.

# env set eth1addr <valid-mac-address>

2) Add an alias to pick up the MAC address from U-Boot and route it to 
the intel,i211 PCIe endpoint for an imx6qdl derivative.

/ {
         aliases {
                 ethernet1 = &eth1;
         };

};

&pcie {
         /* soc pcie bridge 00:00.0 */
         pcie at 0,0 {
                 reg = <0x000000 0 0 0 0>;
                 #address-cells = <3>;
                 #size-cells = <2>;

                 /* pcie endpoint 01:00.0 */
                 eth1: intel,i211 at pcie0,0 {
                         reg = <0x010000 0 0 0 0>;
                 };
         };
};

John
