From: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Date: Sat, 23 May 2020 07:13:21 +0000
Subject: [Intel-wired-lan] [PATCH] Fix typo in the comment
In-Reply-To: <20200522103024.9697-1-harichandrakanthan@gmail.com>
References: <20200522103024.9697-1-harichandrakanthan@gmail.com>
Message-ID: <61CC2BC414934749BD9F5BF3D5D94044986D1159@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Hari
> Sent: Friday, May 22, 2020 03:30
> To: davem at davemloft.net; kuba at kernel.org
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org; Hari <harichandrakanthan@gmail.com>
> Subject: [Intel-wired-lan] [PATCH] Fix typo in the comment
[Kirsher, Jeffrey T] 

Please fix the title to "e1000: Fix typo in the comment", other than that your patch looks fine and I will add it to my queue after the title of your patch is fixed.

> 
> Continuous Double "the" in a comment. Changed it to single "the"
> 
> Signed-off-by: Hari <harichandrakanthan@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c
> b/drivers/net/ethernet/intel/e1000/e1000_hw.c
> index 48428d6a00be..623e516a9630 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
> @@ -3960,7 +3960,7 @@ static s32 e1000_do_read_eeprom(struct e1000_hw
> *hw, u16 offset, u16 words,
>   * @hw: Struct containing variables accessed by shared code
>   *
>   * Reads the first 64 16 bit words of the EEPROM and sums the values read.
> - * If the the sum of the 64 16 bit words is 0xBABA, the EEPROM's checksum is
> + * If the sum of the 64 16 bit words is 0xBABA, the EEPROM's checksum is
>   * valid.
>   */
>  s32 e1000_validate_eeprom_checksum(struct e1000_hw *hw)
> --
> 2.17.1
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
