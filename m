From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 Jan 2018 23:51:35 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: don't remove netdev->dev_addr
 when syncing uc list
In-Reply-To: <20171220160436.15288-1-alice.michael@intel.com>
References: <20171220160436.15288-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D5CA5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, December 20, 2017 8:05 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] i40e: don't remove netdev->dev_addr
> when syncing uc list
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> In some circumstances, such as with bridging, it is possible that the stack will
> add a devices own MAC address to its unicast address list.
> 
> If, later, the stack deletes this address, then the i40e driver will receive a
> request to remove this address.
> 
> The driver stores its current MAC address as part of the MAC/VLAN hash
> array, since it is convenient and matches exactly how the hardware expects
> to be told which traffic to receive.
> 
> This causes a problem, since for more devices, the MAC address is stored
> separately, and requests to delete a unicast address should not have the
> ability to remove the filter for the MAC address.
> 
> Fix this by forcing a check on every address sync to ensure we do not remove
> the device address.
> 
> There is a very narrow possibility of a race between .set_mac and
> .set_rx_mode, if we don't change netdev->dev_addr before updating our
> internal MAC list in .set_mac. This might be possible if .set_rx_mode is going
> to remove MAC "XYZ" from the list, at the same time as .set_mac changes
> our dev_addr to MAC "XYZ", we might possibly queue a delete, then an add
> in .set_mac, then queue a delete in .set_rx_mode's dev_uc_sync and then
> update netdev->dev_addr. We can avoid this by moving the copy into
> dev_addr prior to the changes to the MAC filter list.
> 
> A similar race on the other side does not cause problems, as if we're changing
> our MAC form A to B, and we race with .set_rx_mode, it could queue a
> delete from A, we'd update our address, and allow the delete.
> This seems like a race, but in reality we're about to queue a delete of A
> anyways, so it would not cause any issues.
> 
> A race in the initialization code is unlikely because the netdevice has not yet
> been fully initialized and the stack should not be adding or removing
> addresses yet.
> 
> Note that we don't (yet) need similar code for the VF driver because it does
> not make use of __dev_uc_sync and __dev_mc_sync, but instead roles its
> own method for handling updates to the MAC/VLAN list, which already has
> code to protect against removal of the hardware address.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


