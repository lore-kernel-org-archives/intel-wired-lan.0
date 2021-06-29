From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Tue, 29 Jun 2021 17:49:15 +0300
Subject: [Intel-wired-lan] [PATCH] driver core: fix e1000e ltr bug
In-Reply-To: <20210629082128.255988-1-seven.yi.lee@gmail.com>
References: <20210629082128.255988-1-seven.yi.lee@gmail.com>
Message-ID: <02ff77ef-e802-8e13-d169-1ab2c250405a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/29/2021 11:21, YeeLi wrote:
Yeeli,
> In e1000e driver, a PCIe-like device, the max snoop/no-snoop latency
> is the upper limit.So, directly compare the size of lat_enc and
> max_ltr_enc is incorrect.
> 
why?
>      In 1000Mbps, 0x8b9 < 0x1003, 189440 ns < 3145728 ns, correct.
> 
>      In 100Mbps, 0xc3a < 0x1003, 1900544 ns < 3145728 ns, correct.
> 
>      In 10Mbps, 0xe40 < 0x1003, 18874368 > 3145728, incorrect.
> 
Platform LTR encoded is 0x1003 - right. It is meant 1048576ns x 3 = 
3145738ns.
Now,
for 1000M: 0x08b9 => 185ns x 1024 = 189440ns (you are correct)
for 100M: 0x0c3a => 58ns x 32768 = 1900544ns (correct)
for 10M: 0x0e41 => 577ns x 32768 = 18907136ns (ok?)
18907136ns > 3145738ns, (latency encoded is great than maximum LTR 
encoded by platform) - so, there is no point to wait more than platform 
required, and lat_enc=max_ltr_enc. It is expected and we sent right 
value to the power management controller.
What is the problem you try solve?

> Decoded the lat_enc and max_ltr_enc before compare them is necessary.
> 
> Signed-off-by: YeeLi <seven.yi.lee@gmail.com>
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 23 ++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index 590ad110d383..3bff1b570b76 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -986,6 +986,27 @@ static s32 e1000_k1_workaround_lpt_lp(struct e1000_hw *hw, bool link)
>   	return ret_val;
>   }
>   
> +static u32 convert_e1000e_ltr_scale(u32 val)
> +{
> +	if (val > 5)
> +		return 0;
> +
> +	return 1U << (5 * val);
> +}
> +
> +static u64 decoded_ltr(u32 val)
> +{
> +	u64 decoded_latency;
> +	u32 value;
> +	u32 scale;
> +
> +	value = val & 0x03FF;
> +	scale = (val & 0x1C00) >> 10;
> +	decoded_latency = value * convert_e1000e_ltr_scale(scale);
> +
> +	return decoded_latency;
> +}
> +
>   /**
>    *  e1000_platform_pm_pch_lpt - Set platform power management values
>    *  @hw: pointer to the HW structure
> @@ -1059,7 +1080,7 @@ static s32 e1000_platform_pm_pch_lpt(struct e1000_hw *hw, bool link)
>   				     E1000_PCI_LTR_CAP_LPT + 2, &max_nosnoop);
>   		max_ltr_enc = max_t(u16, max_snoop, max_nosnoop);
>   
> -		if (lat_enc > max_ltr_enc)
> +		if (decoded_ltr(lat_enc) > decoded_ltr(max_ltr_enc))
>   			lat_enc = max_ltr_enc;
>   	}
>   
> 
sasha
