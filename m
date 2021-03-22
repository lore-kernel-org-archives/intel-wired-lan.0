From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Mon, 22 Mar 2021 08:56:17 +0200
Subject: [Intel-wired-lan] [PATCH net-next] e1000e: Mark
 e1000e_pm_prepare() as __maybe_unused
In-Reply-To: <20210317145234.3171021-1-weiyongjun1@huawei.com>
References: <20210317145234.3171021-1-weiyongjun1@huawei.com>
Message-ID: <80dcead2-f0e1-c1a4-037c-6215f960f32f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/17/2021 16:52, 'w00385741 wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> The function e1000e_pm_prepare() may have no callers depending
> on configuration, so it must be marked __maybe_unused to avoid
> harmless warning:
> 
> drivers/net/ethernet/intel/e1000e/netdev.c:6926:12:
>   warning: 'e1000e_pm_prepare' defined but not used [-Wunused-function]
>   6926 | static int e1000e_pm_prepare(struct device *dev)
>        |            ^~~~~~~~~~~~~~~~~
> 
> Fixes: ccf8b940e5fd ("e1000e: Leverage direct_complete to speed up s2ram")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index f1c9debd9f3b..d2e4653536c5 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -6923,7 +6923,7 @@ static int __e1000_resume(struct pci_dev *pdev)
>   	return 0;
>   }
>   
> -static int e1000e_pm_prepare(struct device *dev)
> +static __maybe_unused int e1000e_pm_prepare(struct device *dev)
>   {
>   	return pm_runtime_suspended(dev) &&
>   		pm_suspend_via_firmware();
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
