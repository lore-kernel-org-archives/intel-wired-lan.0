From: Alexander H Duyck <alexander.duyck@gmail.com>
Date: Wed, 11 May 2022 07:33:02 -0700
Subject: [Intel-wired-lan] 
 =?utf-8?b?W1BBVENIXSBpZ2JfbWFpbu+8mkFkZGVkIGlu?=
 =?utf-8?q?valid_mac_address_handling_in_igb=5Fprobe?=
In-Reply-To: <20220511080716.10054-1-lianglixue@greatwall.com.cn>
References: <20220511080716.10054-1-lianglixue@greatwall.com.cn>
Message-ID: <ad8cf673c8e9e21cb2e7afeb5c7e66cc76a36995.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2022-05-11 at 08:07 +0000, lixue liang wrote:
> In some cases, when the user uses igb_set_eeprom to modify
> the mac address to be invalid, the igb driver will fail to load.
> If there is no network card device, the user must modify it to
> a valid mac address by other means. It is only the invalid
> mac address that causes the driver The fatal problem of
> loading failure will cause most users no choice but to trouble.
> 
> Since the mac address may be changed to be invalid, it must
> also be changed to a valid mac address, then add a random
> valid mac address to replace the invalid mac address in the
> driver, continue to load the igb network card driver,
> and output the relevant log reminder. vital to the user.
> 
> Signed-off-by: lixue liang <lianglixue@greatwall.com.cn>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 34b33b21e0dc..a513570c2ad6 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -3359,9 +3359,10 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	eth_hw_addr_set(netdev, hw->mac.addr);
>  
>  	if (!is_valid_ether_addr(netdev->dev_addr)) {

It might make sense to look at adding a module parameter to control
this behavior similar to what was done for ixgbe for
"allow_unsupported_sfp". 
Otherwise such a failure is likely to end up causing other issues and
be harder to debug if it is just being automatically worked around as
the user may not see the issue as it is only being reported as 

Basically you could check for it here and either run the old code, or
allow the new code that would assign a random MAC address.

> -		dev_err(&pdev->dev, "Invalid MAC Address\n");
> -		err = -EIO;
> -		goto err_eeprom;
> +		eth_random_addr(netdev->dev_addr);
> +		memcpy(hw->mac.addr, netdev->dev_addr, netdev->addr_len);
> +		dev_info(&pdev->dev,
> +			 "Invalid Mac Address, already got random Mac Address\n");

We would probably want to make this a dev_err instead of just a
dev_info since the MAC address failing is pretty signficant. Also the
message may be better as "Invalid MAC address. Assigned random MAC
address". That way if somebody were to be parsing for the message they
would still find it since "MAC" hasn't been changed.

>  	}
>  
>  	igb_set_default_mac_filter(adapter);



