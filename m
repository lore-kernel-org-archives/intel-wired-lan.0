From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 28 Jul 2017 23:59:26 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] igbvf: add lock around mailbox ops
In-Reply-To: <20170720160058.8198-2-gedwards@ddn.com>
References: <20170720160058.8198-1-gedwards@ddn.com>
 <20170720160058.8198-2-gedwards@ddn.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C6646FA@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Greg Edwards
> Sent: Thursday, July 20, 2017 9:01 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Greg Edwards <gedwards@ddn.com>
> Subject: [Intel-wired-lan] [PATCH 1/2] igbvf: add lock around mailbox ops
> 
> The PF driver assumes the VF will not send another mailbox message until
> the PF has written its reply to the previous message.  If the VF does,
> that message will be silently dropped by the PF before it writes its
> reply to the mailbox.  This results in a VF mailbox timeout for posted
> messages waiting for an ACK, and the VF is reset by the
> igbvf_watchdog_task in the VM.
> 
> Add a lock around the VF mailbox ops to prevent the VF from sending
> another message while the PF is still processing the previous one.
> 
> Signed-off-by: Greg Edwards <gedwards@ddn.com>
> ---
>  drivers/net/ethernet/intel/igbvf/ethtool.c |  4 +++
>  drivers/net/ethernet/intel/igbvf/mbx.c     |  4 +++
>  drivers/net/ethernet/intel/igbvf/netdev.c  | 47
> ++++++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igbvf/vf.h      |  1 +
>  4 files changed, 56 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
