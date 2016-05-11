From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 11 May 2016 21:12:33 +0000
Subject: [Intel-wired-lan] [PATCH] igb: properly start/stop PTP during
	suspend/resume
In-Reply-To: <20160511182335.12453-1-jacob.e.keller@intel.com>
References: <20160511182335.12453-1-jacob.e.keller@intel.com>
Message-ID: <1463001153.15592.0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-05-11 at 11:23 -0700, Jacob Keller wrote:
> Reported-by: Vidya Sagar <sagar.tv@gmail.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> ?drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
> ?1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> b/drivers/net/ethernet/intel/igb/igb_main.c
> index 21727692bef6..8f740bc69fc3 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -7527,6 +7527,8 @@ static int __igb_shutdown(struct pci_dev *pdev,
> bool *enable_wake,
> ?	if (netif_running(netdev))
> ?		__igb_close(netdev, true);
> ?
> +	igb_ptp_stop(adapter);
> +
> ?	igb_clear_interrupt_scheme(adapter);
> ?
> ?#ifdef CONFIG_PM
> @@ -7637,6 +7639,8 @@ static int igb_resume(struct device *dev)
> ?		return -ENOMEM;
> ?	}
> ?
> +	igb_ptp_init(adapter);
> +
> ?	igb_reset(adapter);
> ?
> ?	/* let the f/w know that the h/w is now under the control of
> the

Unfortunately I think this patch is wrong, my first pass at fixing was
to do igb_ptp_stop and igb_ptp_init, but this seems like it won't work
because we'll actually remove the PHC device, which we don't want to
do. I'm going to rework this patch and send a v2.

Thanks,
Jake
