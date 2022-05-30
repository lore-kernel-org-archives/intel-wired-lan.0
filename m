From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Mon, 30 May 2022 09:47:17 +0200
Subject: [Intel-wired-lan] [PATCH v3 3/3] igb_main: Assign random MAC
 address instead of fail in case of invalid one
In-Reply-To: <20220530031941.44006-1-lianglixuehao@126.com>
References: <d50b23b1-38b5-2522-cbf4-c360c0ed05cd@molgen.mpg.de>
 <20220530031941.44006-1-lianglixuehao@126.com>
Message-ID: <ade6c030-b1c5-e359-7321-fa21310a10f3@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Lixue,

Am 30.05.22 um 05:19 schrieb Lixue Liang:
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
>   drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 746233befade..40f43534a3af 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -3362,7 +3362,7 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   		eth_hw_addr_random(netdev);
>   		ether_addr_copy(hw->mac.addr, netdev->dev_addr);
>   		dev_err(&pdev->dev,
> -			"Invalid MAC Address, already assigned random MAC Address\n");
> +			"Invalid MAC address, already assigned random MAC address\n");
>   	}
>   
>   	igb_set_default_mac_filter(adapter);

The diff does not do what is described in the commit message. I also 
just noticed, that it was spelled ?MAC Address? before, so it would be 
fine for me if you send in this commit separately (but with the correct 
commit message).


Kind regards,

Paul
