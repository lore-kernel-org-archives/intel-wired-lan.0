From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Thu, 12 May 2022 15:55:53 +0200
Subject: [Intel-wired-lan] [PATCH v2 2/2] igb_main: Assign random MAC
 address instead of fail in case of invalid one
In-Reply-To: <20220512093918.86084-1-lianglixue@greatwall.com.cn>
References: <20220512093918.86084-1-lianglixue@greatwall.com.cn>
Message-ID: <d50b23b1-38b5-2522-cbf4-c360c0ed05cd@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Lixue,


Thank you for sending version 2. Some more minor nits.

Am 12.05.22 um 11:39 schrieb lixue liang:
> In some cases, when the user uses igb_set_eeprom to modify the MAC
> address to be invalid, the igb driver will fail to load. If there is no
> network card device, the user must modify it to a valid MAC address by
> other means.
> 
> Since the MAC address can be modified ,then add a random valid MAC address
> to replace the invalid MAC address in the driver can be workable, it can
> continue to finish the loading ,and output the relevant log reminder.

Please add the space after the comma.

> Reported-by: kernel test robot <lkp@intel.com>

This line is confusing. Maybe add that to the version change-log below 
the `---`.

> Signed-off-by: lixue liang <lianglixue@greatwall.com.cn>
> ---
>   drivers/net/ethernet/intel/igb/igb_main.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index a513570c2ad6..746233befade 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -3359,10 +3359,10 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	eth_hw_addr_set(netdev, hw->mac.addr);
>   
>   	if (!is_valid_ether_addr(netdev->dev_addr)) {
> -		eth_random_addr(netdev->dev_addr);
> -		memcpy(hw->mac.addr, netdev->dev_addr, netdev->addr_len);
> -		dev_info(&pdev->dev,
> -			 "Invalid Mac Address, already got random Mac Address\n");
> +		eth_hw_addr_random(netdev);
> +		ether_addr_copy(hw->mac.addr, netdev->dev_addr);
> +		dev_err(&pdev->dev,
> +			"Invalid MAC Address, already assigned random MAC Address\n");

Please spell it MAC address.

>   	}
>   
>   	igb_set_default_mac_filter(adapter);


Kind regards,

Paul
