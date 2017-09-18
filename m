From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 18 Sep 2017 17:01:10 +0000
Subject: [Intel-wired-lan] [PATCH v3 01/16] fm10k: stop spurious link
 down	messages when Tx FIFO is full
In-Reply-To: <20170710202319.22110-1-jacob.e.keller@intel.com>
References: <20170710202319.22110-1-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64AF65CF@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Jacob Keller
> Sent: Monday, July 10, 2017 1:23 PM
> To: jtkirhse at osuosl.org; Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: jekeller at osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 01/16] fm10k: stop spurious link down
> messages when Tx FIFO is full
> 
> In fm10k_get_host_state_generic, we check the mailbox tx_read() function
> to ensure that the mailbox is still open. This function also checks to
> make sure we have space to transmit another message. Unfortunately, if
> we just recently sent a bunch of messages (such as enabling hundreds of
> VLANs on a VF) this can result in a race where the watchdog task thinks
> the link went down just because we haven't had time to process all these
> messages yet.
> 
> Instead, lets just check whether the mailbox is still open. This ensures
> that we don't race with the Tx fifo, and we only link down once the
> mailbox is not open.
> 
> This is safe, because if the FIFO fills up and we're unable to send
> a message for too long, we'll end up triggering the timeout detection
> which results in a reset. Additionally, since we still check to ensure
> the mailbox state is OPEN, we'll transition to link down whenever the
> mailbox closes as well.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

