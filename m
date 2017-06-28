From: Greg Edwards <gedwards@ddn.com>
Date: Wed, 28 Jun 2017 09:22:23 -0600
Subject: [Intel-wired-lan] [PATCH 0/3] igb: VF mailbox timeouts with
	multiple VF messages
Message-ID: <20170628152226.25369-1-gedwards@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We've encountered VF mailbox timeout issues with I350 VFs assigned to VMs, when
NetworkManager or lldpad (LLDP) are assigning multicast addresses in rapid
succession.  A VF message may encounter a mailbox timeout waiting for the ACK
from the PF, and the igbvf_watchdog_task will detect the condition and reset
the VF.  This pattern can continue for some time or indefinitely.

The igb (PF) driver drops the mailbox lock after reading the VF message from
the mailbox and ACK'ing it, and nothing prevents another VF message from being
posted to the mailbox before the PF wants to post its reply.  However, any VF
message posted to the mailbox during this time is silently dropped in
igb_write_mbx_pf() to make way for the PF reply.  This results in a VF mailbox
timeout for the command in the VM if the VF is waiting for an ACK.

Looking at the "Intel Ethernet Controller I350 Datasheet", Revision 2.4,
January 2016, Table 7-66 "PF to VF Messaging Flow", it seems the intent is to
handle this condition.  Before the PF writes a message to the mailbox, it
acquires the lock, then (step 4):

    Read MBVFICR register and verify that
    VFREQ bit of VF[n] is 0, otherwise clear
    PFU bit in PFMailbox[n] and respond to the
    VF message.

While we could implement the above, it seems cleaner with the current code to
not drop the lock in igb_rcv_msg_from_vf() between the read of the VF message
from the mailbox and the write of the PF reply at the end.  This closes the
PF/VF race.

The first patch cleans up some checkpatch.pl warnings in function declarations
touched by subsequent patches.

The second patch adds a new 'unlock' mailbox op, used by the third patch to
unlock the mailbox in some error paths in igb_rcv_msg_from_vf().

The third patch modifies the 'read' mailbox op to take an additional 'unlock'
argument that can be used to leave the mailbox locked after reading the VF
message.  The only read op call site that leaves the mailbox locked is the
mailbox read in igb_rcv_msg_from_vf().

The PF/VF mailbox lock retry logic added with 9ce0e8d72678 ("igb/igbvf:
don't give up") helps us out here as well, as the VF will continue to try to
grab the mailbox lock for up to 1 sec, if it finds it locked.

In my testing, these changes have resolved the VF mailbox timeout issues we
we were encountering.


Greg Edwards (3):
  igb: add argument names to mailbox op function declarations
  igb: expose mailbox unlock method
  igb: do not drop PF mailbox lock after read of VF message

 drivers/net/ethernet/intel/igb/e1000_hw.h  | 17 +++++----
 drivers/net/ethernet/intel/igb/e1000_mbx.c | 57 ++++++++++++++++++++++++++----
 drivers/net/ethernet/intel/igb/e1000_mbx.h | 14 ++++----
 drivers/net/ethernet/intel/igb/igb_main.c  | 14 +++++---
 4 files changed, 79 insertions(+), 23 deletions(-)

-- 
2.9.4

