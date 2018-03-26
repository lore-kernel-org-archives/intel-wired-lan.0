From: Duyck, Alexander H <alexander.h.duyck@intel.com>
Date: Mon, 26 Mar 2018 15:39:38 +0000
Subject: [Intel-wired-lan] Patch for igb_main.c
In-Reply-To: <CAAMvbhES0YLfp__ErFxivfMHhpCrOq0z47a4w84JP547VBhd_Q@mail.gmail.com>
References: <CAAMvbhES0YLfp__ErFxivfMHhpCrOq0z47a4w84JP547VBhd_Q@mail.gmail.com>
Message-ID: <1522078775.2528.65.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2018-03-26 at 00:46 +0100, James Courtier-Dutton wrote:
> Hi,
> 
> I have a patch for igb_main.c that helps bring up the igb NIC on the
> Utilite Pro  embedded ARM PC.
> How do I get this added to the kernel?
> Summary below:
> 
> Kind Regards
> 
> James
> 
> 
> Author: James Courtier-Dutton <James.Dutton@gmail.com>
> Date:   Sat Jul 1 19:27:51 2017 +0100
> 
>     net: igb: This helps to bring up the igb NIC by using a random MAC
> address when no other sources of MAC addres are available.
> 
>     This help bring up the igb NIC on the Utilite.
> 
>     Signed-off-by: James Courtier-Dutton <James@superbug.co.uk>
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> b/drivers/net/ethernet/intel/igb/igb_main.c
> index be456ba..d7c2c99 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -2509,6 +2509,11 @@ static int igb_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent)
>                         dev_err(&pdev->dev, "NVM Read Error\n");
>         }
> 
> +       if (!is_valid_ether_addr(hw->mac.addr)) {
> +               dev_info(&pdev->dev, "Random MAC Address\n");
> +               random_ether_addr(hw->mac.addr);
> +       }
> +
>         memcpy(netdev->dev_addr, hw->mac.addr, netdev->addr_len);
> 
>         if (!is_valid_ether_addr(netdev->dev_addr)) {

Any idea why the MAC address is invalid? Does the part not have an NVM,
or is the NVM not populated correctly?

I'm really not a fan of us enabling a random MAC address for the device
if a valid one is not present. I would like to know more about why a
valid one is not present and see if we can address that before we start
working around it in the driver.

Thanks.

- Alex
