From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 24 Jun 2015 20:03:22 +0000
Subject: [Intel-wired-lan] [PATCH 4/6] fm10k: reset Tx FIFO head and
 tail pointers as part of reset_work
In-Reply-To: <1434405656-10465-4-git-send-email-jacob.e.keller@intel.com>
References: <1434405656-10465-1-git-send-email-jacob.e.keller@intel.com>
 <1434405656-10465-4-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1435176202.17626.12.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2015-06-15 at 15:00 -0700, Jacob Keller wrote:
> This patch fixes a corner case issue with the PF/VF mailbox code.
> Currently, fm10k_mbx_reset_work clears various state about the
> mailbox. However, it did not clear the Tx FIFO head/tail pointers. 
> Thus,
> when the PF finally re-connects (say due to VF reset), it in
> -advertently
> might send some previous data in the Tx FIFO again. This was 
> discovered
> by attempting to perform a static VF MAC address assignment on the PF
> device. The VF would receive the message and then initiate a reset.
> During this process it disconnects and reconnects to the mailbox. If 
> the
> PF doesn't respond fast enough, it may not see the disconnect 
> message,
> and only sees a new connect message. In this flow, it does not 
> properly
> clear the Tx FIFO pointers. Thus, it will re-transmit the last 
> message
> in the Tx FIFO. However, it does not increment the mailbox Tx 
> messages
> because it has already reset mbx->pulled and thus does not think it 
> is
> actually sending any data. The fix is to simply reset the Tx FIFO
> pointers whenever we call fm10k_mbx_reset_work.
> 
> As a consequence, we no longer need both fm10k_mbx_fifo_drop_all and 
> calls
> to fm10k_mbx_update_max_size with a size of 0.

This patch will need a revision 2. There is some other issues this
patch creates which we need to properly resolve.

Clearing the Tx FIFO causes us to potentially drop untransmitted work
and thus fail to send repsonses with no error indication returning to
the base driver code.

I am working on a corrected fix now.

Regards,
Jake
