From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 10 Jun 2020 19:18:02 +0300
Subject: [Intel-wired-lan] [PATCH] e1000e: Squash an unused function
 warning
In-Reply-To: <20200610014907.148473-1-palmer@dabbelt.com>
References: <20200610014907.148473-1-palmer@dabbelt.com>
Message-ID: <8b01c6d6-db4d-d05c-d8cd-733cec31094e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/10/2020 04:49, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> e1000e_check_me is only used under CONFIG_PM_SLEEP but exists
> unconditionally, which triggers a warning.
> 
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index a279f4fa9962..f7148d1fcba2 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -134,6 +134,7 @@ static const struct e1000e_me_supported me_supported[] = {
>   	{0}
>   };
>   
> +#ifdef CONFIG_PM_SLEEP
Thanks Palmer for catching this warning,
can we use "__maybe_unused" declaration instead of wrapping? I think it 
is more convenient and consistent.
>   static bool e1000e_check_me(u16 device_id)
>   {
>   	struct e1000e_me_supported *id;
> @@ -145,6 +146,7 @@ static bool e1000e_check_me(u16 device_id)
>   
>   	return false;
>   }
> +#endif
>   
>   /**
>    * __ew32_prepare - prepare to write to MAC CSR register on certain parts
> 

