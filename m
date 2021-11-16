From: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>
Date: Tue, 16 Nov 2021 12:57:05 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: avoid spin loop in
 i40e_asq_send_command()
Message-ID: <DM6PR11MB2731840AD08E22F73CE850B1F0999@DM6PR11MB2731.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Caleb Sander <csander at purestorage.com<mailto:csander@purestorage.com>>

> Sent: Friday, October 1, 2021 8:50 AM

> To: intel-wired-lan at lists.osuosl.org<mailto:intel-wired-lan@lists.osuosl.org>

> Cc: Brandeburg, Jesse <jesse.brandeburg at intel.com<mailto:jesse.brandeburg@intel.com>>; Nguyen, Anthony L

> <anthony.l.nguyen at intel.com<mailto:anthony.l.nguyen@intel.com>>; Caleb Sander <csander at purestorage.com<mailto:csander@purestorage.com>>

> Subject: [PATCH] i40e: avoid spin loop in i40e_asq_send_command()

>

> Previously, the kernel could spend up to 250 ms waiting for a command

> to be submitted to an admin queue. This function is also called in a

> loop, e.g., in

> i40e_get_module_eeprom() (through i40e_aq_get_phy_register()), so the

> time spent in the kernel may be even higher. We observed scheduling

> delays of over 2 seconds in production, with stacktraces pointing to

> this code as the culprit.

>

> Add a call to cond_resched() so the loop can yield the CPU.

> Also compute the total time using the jiffies counter instead of

> assuming

> udelay() waits the precise time interval requested.

>

> Signed-off-by: Caleb Sander <csander at purestorage.com<mailto:csander@purestorage.com>>

> Reviewed-by: Joern Engel <joern at purestorage.com<mailto:joern@purestorage.com>>

> ---

>  drivers/net/ethernet/intel/i40e/i40e_adminq.c | 6 +++---

>  1 file changed, 3 insertions(+), 3 deletions(-)

Hello Caleb,
Thank you for your patch fixing timing in  i40e_asq_send_command().
We have also already prepared patch which fixes that issue.
Moreover during tests was noticed that this should not be
changed globally and it should be invoked in atomic/nonatomic
context depending on the function that invoke asq_send_command().
Other functions in the code take advantage of this dependency,
so to maintain integrity I will upstream our solution.

Best regards,
Jedrzej


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20211116/23775fae/attachment-0001.html>
