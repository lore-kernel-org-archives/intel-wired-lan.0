From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue, 31 May 2022 13:36:14 -0700
Subject: [Intel-wired-lan] [PATCH v3] igb_main: Assign random MAC
 address instead of fail in case of invalid one
In-Reply-To: <20220530105834.97175-1-lianglixuehao@126.com>
References: <d50b23b1-38b5-2522-cbf4-c360c0ed05cd@molgen.mpg.de>
 <20220530105834.97175-1-lianglixuehao@126.com>
Message-ID: <15b0507f-c810-8a75-e883-b23313a7badd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 5/30/2022 3:58 AM, Lixue Liang wrote:

nit: Please use just the driver name in the title, not the file being 
modified. i.e. igb: not igb_main:

Also, as Paul pointed out earlier, each time you do a revision, please 
increment the vX number and please include a changelog under the '---' 
to make review easier.

> From: Lixue Liang <lianglixue@greatwall.com.cn>
> 
> In some cases, when the user uses igb_set_eeprom to modify the MAC
> address to be invalid, the igb driver will fail to load. If there is no
> network card device, the user must modify it to a valid MAC address by
> other means.
> 
> Since the MAC address can be modified, then add a random valid MAC address
> to replace the invalid MAC address in the driver can be workable, it can
> continue to finish the loading, and output the relevant log reminder.
> 
> Signed-off-by: Lixue Liang <lianglixue@greatwall.com.cn>
> ---
>   drivers/net/ethernet/intel/igb/igb_main.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 34b33b21e0dc..40f43534a3af 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -3359,9 +3359,10 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	eth_hw_addr_set(netdev, hw->mac.addr);
>   
>   	if (!is_valid_ether_addr(netdev->dev_addr)) {
> -		dev_err(&pdev->dev, "Invalid MAC Address\n");
> -		err = -EIO;
> -		goto err_eeprom;
> +		eth_hw_addr_random(netdev);
> +		ether_addr_copy(hw->mac.addr, netdev->dev_addr);
> +		dev_err(&pdev->dev,
> +			"Invalid MAC address, already assigned random MAC address\n");

I prefer the message as Alex suggested [1]: "Invalid MAC address. 
Assigned random MAC address". "already assigned random MAC address" 
seems a bit confusing to me.

Thanks,
Tony

>   	}
>   
>   	igb_set_default_mac_filter(adapter);

[1] 
https://lore.kernel.org/netdev/ad8cf673c8e9e21cb2e7afeb5c7e66cc76a36995.camel at gmail.com/
