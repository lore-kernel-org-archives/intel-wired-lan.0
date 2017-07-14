From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 14 Jul 2017 21:50:12 +0000
Subject: [Intel-wired-lan] [PATCH 3/3] igb: do not drop PF mailbox
	lock	after read of VF message
In-Reply-To: <20170628152226.25369-4-gedwards@ddn.com>
References: <20170628152226.25369-1-gedwards@ddn.com>
 <20170628152226.25369-4-gedwards@ddn.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C64E047@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Greg Edwards
> Sent: Wednesday, June 28, 2017 8:22 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Greg Edwards <gedwards@ddn.com>
> Subject: [Intel-wired-lan] [PATCH 3/3] igb: do not drop PF mailbox lock after
> read of VF message
> 
> When the PF receives a mailbox message from the VF, it grabs the mailbox
> lock, reads the VF message from the mailbox, ACKs the message and drops
> the lock.
> 
> While the PF is performing the action for the VF message, nothing
> prevents another VF message from being posted to the mailbox.  The
> current code handles this condition by just dropping any new VF messages
> without processing them.  This results in a mailbox timeout in the VM
> for posted messages waiting for an ACK, and the VF is reset by the
> igbvf_watchdog_task in the VM.
> 
> Given the right sequence of VF messages and mailbox timeouts, this
> condition can go on ad infinitum.
> 
> Modify the PF mailbox read method to take an 'unlock' argument that
> optionally leaves the mailbox locked by the PF after reading the VF
> message.  This ensures another VF message is not posted to the mailbox
> until after the PF has completed processing the VF message and written
> its reply.
> 
> Signed-off-by: Greg Edwards <gedwards@ddn.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_hw.h  |  3 ++-
>  drivers/net/ethernet/intel/igb/e1000_mbx.c | 18 ++++++++++++------
>  drivers/net/ethernet/intel/igb/e1000_mbx.h |  3 ++-
>  drivers/net/ethernet/intel/igb/igb_main.c  | 14 ++++++++++----
>  4 files changed, 26 insertions(+), 12 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
