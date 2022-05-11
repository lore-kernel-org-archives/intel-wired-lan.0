From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 11 May 2022 08:41:34 +0200
Subject: [Intel-wired-lan] [PATCH] igb_ethtool: fix efficiency issues in
 igb_set_eeprom
In-Reply-To: <20220510012159.8924-1-lianglixue@greatwall.com.cn>
References: <20220510012159.8924-1-lianglixue@greatwall.com.cn>
Message-ID: <8d7e86ad-932c-d08c-3131-762edd553b22@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear lianglixue,


Thank you for your patch.

Am 10.05.22 um 03:21 schrieb lianglixue:

It?d be great if you spelled your name with spaces (if possible).

Also, currently your Google Mail address would be used for the Author 
field. If you want to use your company(?) address, please add a From: 
line at the top.

> Modify the value of eeprom in igb_set_eeprom. If the mac address
> of i210 is changed to illegal, then in igp_probe in the
> igb_main file, is_valid_eth_addr (netdev->dev_addr) exits
> with an error, causing the igb driver to fail to load,
> such as ethtool -E eth0 magic 0x15338086 offset 0 value 0x01.
> 
> In this way, the igb driver can no longer be loaded,
> and the legal mac address cannot be recovered through ethtool;
> add is_valid_eth_addr to igb_set_eeprom to determine
> whether it is legal to rewrite, so as to avoid driver
> errors due to illegal mac addresses.

Please reflow the text for 75 characters per line.

> Signed-off-by: lianglixue <lianglixue@greatwall.com.cn>
> ---
>   drivers/net/ethernet/intel/igb/igb_ethtool.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> index 2a5782063f4c..30554fd684db 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> @@ -798,6 +798,13 @@ static int igb_set_eeprom(struct net_device *netdev,
>   	if (eeprom->magic != (hw->vendor_id | (hw->device_id << 16)))
>   		return -EFAULT;
>   
> +	if (hw->mac.type == e1000_i210 && eeprom->offset == 0) {
> +		if (!is_valid_ether_addr(bytes)) {
> +			dev_err(&adapter->pdev->dev, "Invalid MAC Address for i210\n");
> +			return -EINVAL;
> +		}
> +	}
> +
>   	max_len = hw->nvm.word_size * 2;
>   
>   	first_word = eeprom->offset >> 1;


Kind regards,

Paul
