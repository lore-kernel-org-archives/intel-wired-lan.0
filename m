From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Sat, 11 Dec 2021 11:25:07 +0000
Subject: [Intel-wired-lan] [Patch 1/2] iavf: Fix panic in iavf_remove
In-Reply-To: <20211208102153.669338-2-jkc@redhat.com>
References: <20211208102153.669338-1-jkc@redhat.com>
 <20211208102153.669338-2-jkc@redhat.com>
Message-ID: <DM8PR11MB5621F5E938993A63D2424389AB729@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Ken Cox
> Sent: ?roda, 8 grudnia 2021 11:22
> To: intel-wired-lan at osuosl.org
> Cc: Ken Cox <jkc@redhat.com>
> Subject: [Intel-wired-lan] [Patch 1/2] iavf: Fix panic in iavf_remove
> 
> It's possible for the client_task to get scheduled by the watchdog after
> cancel_delayed_work_sync(&adapter->client_task);  This can cause a panic
> because free_netdev() is called with the client_task still queued on the work
> queue.
> 
> The stack backtrace usually looks similar to:
> 
> [  121.272963] Workqueue:  0x0 (iavf)
> [  121.272969] RIP: 0010:__list_del_entry_valid.cold.1+0x20/0x4c
> ...
> [  121.272980] Call Trace:
> [  121.272985]  move_linked_works+0x49/0xa0 [  121.272988]
> pwq_activate_delayed_work+0x43/0x100
> [  121.272991]  pwq_dec_nr_in_flight+0x5d/0x90 [  121.272993]
> worker_thread+0x30/0x370 [  121.272995]  ?
> process_one_work+0x420/0x420 [  121.272998]  kthread+0x15d/0x180 [
> 121.273000]  ? __kthread_parkme+0xa0/0xa0 [  121.273003]
> ret_from_fork+0x1f/0x40
> 
> Signed-off-by: Ken Cox <jkc@redhat.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 6c2afbc8acbcd..63eec7edbf60a 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -3940,7 +3940,6 @@ static void iavf_remove(struct pci_dev *pdev)

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
