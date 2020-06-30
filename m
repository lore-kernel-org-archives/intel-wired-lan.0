From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 29 Jun 2020 17:16:12 -0700
Subject: [Intel-wired-lan] [PATCH] igb: reinit_locked() should be called
 with rtnl_lock
In-Reply-To: <20200629211801.C3D7095C0900@us180.sjc.aristanetworks.com>
References: <20200629211801.C3D7095C0900@us180.sjc.aristanetworks.com>
Message-ID: <20200629171612.49efbdaa@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 29 Jun 2020 14:18:01 -0700 Francesco Ruggeri wrote:
> We observed a panic in igb_reset_task caused by this race condition
> when doing a reboot -f:
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
> This commit applies to igb the same changes that were applied to ixgbe
> in commit 8f4c5c9fb87a ("ixgbe: reinit_locked() should be called with
> rtnl_lock") and commit 88adce4ea8f9 ("ixgbe: fix possible race in
> reset subtask").
> 
> Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>

Thanks for the patch..

Would you mind adding a fixes tag here? Probably:

Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")

And as a matter of fact it looks like e1000e and e1000 have the same
bug :/ Would you mind checking all Intel driver producing matches for
all the affected ones?
