From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 11 May 2022 16:53:56 +0200
Subject: [Intel-wired-lan] 
 =?utf-8?b?W1BBVENIXSBpZ2JfbWFpbu+8mkFkZGVkIGlu?=
 =?utf-8?q?valid_mac_address_handling_in_igb=5Fprobe?=
In-Reply-To: <20220511080716.10054-1-lianglixue@greatwall.com.cn>
References: <20220511080716.10054-1-lianglixue@greatwall.com.cn>
Message-ID: <f486b0a0-2f6b-13e9-e905-8ad9163020a7@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Lixue,


Thank you for the patch. Please tag patch iterations with a version. 
(Use `-v 2` in `git send-email` for example.)

Am 11.05.22 um 10:07 schrieb lixue liang:

Please use the normal colon : in the summary.

Also, please use imperative mood in present tense: Add ?

But, in this case

Handle invalid MAC address ?

is shorter. Or:

Assign random MAC address instead of fail in case of invalid one

> In some cases, when the user uses igb_set_eeprom to modify
> the mac address to be invalid, the igb driver will fail to load.
> If there is no network card device, the user must modify it to
> a valid mac address by other means. It is only the invalid
> mac address that causes the driver The fatal problem of

? MAC address causing the driver to failure. The fatal ?

> loading failure will cause most users no choice but to trouble.

Maybe remove this sentence, or rephrase.

> Since the mac address may be changed to be invalid, it must
> also be changed to a valid mac address, then add a random
> valid mac address to replace the invalid mac address in the
> driver, continue to load the igb network card driver,
> and output the relevant log reminder. vital to the user.

Please reflow for 75 characters per line. (More words fit in one line.)

> Signed-off-by: lixue liang <lianglixue@greatwall.com.cn>
> ---
>   drivers/net/ethernet/intel/igb/igb_main.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 34b33b21e0dc..a513570c2ad6 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -3359,9 +3359,10 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	eth_hw_addr_set(netdev, hw->mac.addr);
>   
>   	if (!is_valid_ether_addr(netdev->dev_addr)) {
> -		dev_err(&pdev->dev, "Invalid MAC Address\n");
> -		err = -EIO;
> -		goto err_eeprom;
> +		eth_random_addr(netdev->dev_addr);
> +		memcpy(hw->mac.addr, netdev->dev_addr, netdev->addr_len);
> +		dev_info(&pdev->dev,
> +			 "Invalid Mac Address, already got random Mac Address\n");

Is there a valid MAC address that should be only used for testing. Maybe 
that can be used. Maybe also log the address.

Lastly, please fully capitalize MAC.

>   	}
>   
>   	igb_set_default_mac_filter(adapter);


Kind regards,

Paul
