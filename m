From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 28 Jul 2020 20:37:36 +0000
Subject: [Intel-wired-lan] [PATCH v2] igb: reinit_locked() should be
 called with rtnl_lock
In-Reply-To: <20200702223906.42B6C95C0494@us180.sjc.aristanetworks.com>
References: <20200702223906.42B6C95C0494@us180.sjc.aristanetworks.com>
Message-ID: <DM6PR11MB28903B2C52C7DE21578C17B4BC730@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Francesco Ruggeri
> Sent: Thursday, July 2, 2020 3:39 PM
> To: linux-kernel at vger.kernel.org; netdev at vger.kernel.org; intel-wired-
> lan at lists.osuosl.org; kuba at kernel.org; davem at davemloft.net; Kirsher, Jeffrey
> T <jeffrey.t.kirsher@intel.com>; fruggeri at arista.com
> Subject: [Intel-wired-lan] [PATCH v2] igb: reinit_locked() should be called with
> rtnl_lock
> 
> We observed two panics involving races with igb_reset_task.
> The first panic is caused by this race condition:
> 
> 	kworker			reboot -f
> 
> 	igb_reset_task
> 	igb_reinit_locked
> 	igb_down
> 	napi_synchronize
> 				__igb_shutdown
> 				igb_clear_interrupt_scheme
> 				igb_free_q_vectors
> 				igb_free_q_vector
> 				adapter->q_vector[v_idx] = NULL;
> 	napi_disable
> 	Panics trying to access
> 	adapter->q_vector[v_idx].napi_state
> 
> The second panic (a divide error) is caused by this race:
> 
> kworker		reboot -f	tx packet
> 
> igb_reset_task
> 		__igb_shutdown
> 		rtnl_lock()
> 		...
> 		igb_clear_interrupt_scheme
> 		igb_free_q_vectors
> 		adapter->num_tx_queues = 0
> 		...
> 		rtnl_unlock()
> rtnl_lock()
> igb_reinit_locked
> igb_down
> igb_up
> netif_tx_start_all_queues
> 				dev_hard_start_xmit
> 				igb_xmit_frame
> 				igb_tx_queue_mapping
> 				Panics on
> 				r_idx % adapter->num_tx_queues
> 
> This commit applies to igb_reset_task the same changes that
> were applied to ixgbe in commit 2f90b8657ec9 ("ixgbe: this patch
> adds support for DCB to the kernel and ixgbe driver"),
> commit 8f4c5c9fb87a ("ixgbe: reinit_locked() should be called with
> rtnl_lock") and commit 88adce4ea8f9 ("ixgbe: fix possible race in
> reset subtask").
> 
> v2: add fix for second race condition above.
> 
> Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
> 
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
