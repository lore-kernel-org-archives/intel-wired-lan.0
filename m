From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Mon, 13 Apr 2015 17:05:53 -0700
Subject: [Intel-wired-lan] [PATCH v5] e1000e i219 fix unit hang on reset
 and runtime D3
In-Reply-To: <1428967221-32195-1-git-send-email-yanirx.lubetkin@intel.com>
References: <1428967221-32195-1-git-send-email-yanirx.lubetkin@intel.com>
Message-ID: <552C59E1.2020307@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 04/13/2015 04:20 PM, Yanir Lubetkin wrote:
> unit hang may occur if multiple descriptors are available in the rings during
> reset or runtime suspend. This state can be detected by testing bit 8 in the
> FEXTNVM7 register. if this bit is set and there are pending descriptors in one
> of the rings, we must flush them prior to reset. same applies entering runtime
> suspend.
>
> Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.h |   5 ++
>   drivers/net/ethernet/intel/e1000e/netdev.c  | 102 ++++++++++++++++++++++++++++
>   drivers/net/ethernet/intel/e1000e/regs.h    |   1 +
>   3 files changed, 108 insertions(+)
>

This looks okay to me.  The BUG_ON seems a bit aggressive but if you 
think you need to do the workaround rather than just avoid it in the 
case of TDT != next_to_use I suppose that works.  I would just suggest 
doing testing with heavy transmit and a link partner flooding flow 
control to see what happens.  That should be the test that would be most 
likely to trigger something like that.

Reviewed-by: Alexander Duyck <alexander.h.duyck@redhat.com>
