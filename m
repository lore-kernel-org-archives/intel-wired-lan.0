From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 26 Mar 2020 18:41:28 +0800
Subject: [Intel-wired-lan] [PATCH] igb: Use a sperate mutex insead of
 rtnl_lock()
In-Reply-To: <20200326103926.20888-1-kai.heng.feng@canonical.com>
References: <20200326103926.20888-1-kai.heng.feng@canonical.com>
Message-ID: <EEE6C808-A7FC-42B6-8FA7-3958EE4C0BBC@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

> On Mar 26, 2020, at 18:39, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> Commit 9474933caf21 ("igb: close/suspend race in netif_device_detach")
> fixed race condition between close and power management ops by using
> rtnl_lock().
> 
> This fix is a preparation for next patch, to prevent a dead lock under
> rtnl_lock() when calling runtime resume routine.
> 
> However, we can't use device_lock() in igb_close() because when module
> is getting removed, the lock is already held for igb_remove(), and
> igb_close() gets called during unregistering the netdev, hence causing a
> deadlock. So let's introduce a new mutex so we don't cause a deadlock
> with driver core or netdev core.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Please drop "igb: Use device_lock() insead of rtnl_lock()" and use this one instead.
Thanks!

Kai-Heng

> ---
> drivers/net/ethernet/intel/igb/igb_main.c | 19 +++++++++++++------
> 1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index b46bff8fe056..dc7ed5dd216b 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -288,6 +288,8 @@ static const struct igb_reg_info igb_reg_info_tbl[] = {
> 	{}
> };
> 
> +static DEFINE_MUTEX(igb_mutex);
> +
> /* igb_regdump - register printout routine */
> static void igb_regdump(struct e1000_hw *hw, struct igb_reg_info *reginfo)
> {
> @@ -4026,9 +4028,14 @@ static int __igb_close(struct net_device *netdev, bool suspending)
> 
> int igb_close(struct net_device *netdev)
> {
> +	int err = 0;
> +
> +	mutex_lock(&igb_mutex);
> 	if (netif_device_present(netdev) || netdev->dismantle)
> -		return __igb_close(netdev, false);
> -	return 0;
> +		err = __igb_close(netdev, false);
> +	mutex_unlock(&igb_mutex);
> +
> +	return err;
> }
> 
> /**
> @@ -8760,7 +8767,7 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
> 	u32 wufc = runtime ? E1000_WUFC_LNKC : adapter->wol;
> 	bool wake;
> 
> -	rtnl_lock();
> +	mutex_lock(&igb_mutex);
> 	netif_device_detach(netdev);
> 
> 	if (netif_running(netdev))
> @@ -8769,7 +8776,7 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
> 	igb_ptp_suspend(adapter);
> 
> 	igb_clear_interrupt_scheme(adapter);
> -	rtnl_unlock();
> +	mutex_unlock(&igb_mutex);
> 
> 	status = rd32(E1000_STATUS);
> 	if (status & E1000_STATUS_LU)
> @@ -8897,13 +8904,13 @@ static int __maybe_unused igb_resume(struct device *dev)
> 
> 	wr32(E1000_WUS, ~0);
> 
> -	rtnl_lock();
> +	mutex_lock(&igb_mutex);
> 	if (!err && netif_running(netdev))
> 		err = __igb_open(netdev, true);
> 
> 	if (!err)
> 		netif_device_attach(netdev);
> -	rtnl_unlock();
> +	mutex_unlock(&igb_mutex);
> 
> 	return err;
> }
> -- 
> 2.17.1
> 

