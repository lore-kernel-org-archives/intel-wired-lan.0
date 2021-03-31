From: Bhandare, KiranX <kiranx.bhandare@intel.com>
Date: Wed, 31 Mar 2021 12:57:35 +0000
Subject: [Intel-wired-lan] [PATCH intel-net] i40e: fix receiving of
 single packets in xsk zero-copy mode
In-Reply-To: <20210319094410.3633-1-magnus.karlsson@gmail.com>
References: <20210319094410.3633-1-magnus.karlsson@gmail.com>
Message-ID: <DM6PR11MB3292D119D24C4E9291856E02F17C9@DM6PR11MB3292.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Magnus Karlsson
> Sent: Friday, March 19, 2021 3:14 PM
> To: Karlsson, Magnus <magnus.karlsson@intel.com>; intel-wired-
> lan at lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Cc: netdev at vger.kernel.org; Joshi, Sreedevi <sreedevi.joshi@intel.com>
> Subject: [Intel-wired-lan] [PATCH intel-net] i40e: fix receiving of single packets
> in xsk zero-copy mode
> 
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Fix so that single packets are received immediately instead of in batches of 8.
> If you sent 1 pss to a system, you received 8 packets every 8 seconds instead
> of 1 packet every second. The problem behind this was that the work_done
> reporting from the Tx part of the driver was broken. The work_done
> reporting in i40e controls not only the reporting back to the napi logic but
> also the setting of the interrupt throttling logic. When Tx or Rx reports that it
> has more to do, interrupts are throttled or coalesced and when they both
> report that they are done, interrupts are armed right away. If the wrong
> work_done value is returned, the logic will start to throttle interrupts in a
> situation where it should have just enabled them. This leads to the undesired
> batching behavior seen in user-space.
> 
> Fix this by returning the correct boolean value from the Tx xsk zero-copy
> path. Return true if there is nothing to do or if we got fewer packets to
> process than we asked for. Return false if we got as many packets as the
> budget since there might be more packets we can process.
> 
> Fixes: 3106c580fb7c ("i40e: Use batched xsk Tx interfaces to increase
> performance")
> Reported-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Tested-by: Kiran Bhandare <kiranx.bhandare@intel.com>  A Contingent Worker at Intel
