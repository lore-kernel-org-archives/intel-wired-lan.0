From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Mon, 15 Jul 2019 10:52:19 +0200
Subject: [Intel-wired-lan] [PATCH] e1000e: Make speed detection on
 hotplugging cable more reliable
In-Reply-To: <20190715084355.9962-1-kai.heng.feng@canonical.com>
References: <20190715084355.9962-1-kai.heng.feng@canonical.com>
Message-ID: <017771d5-f168-493a-46a1-88e513941ba1@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Kai-Heng,


Thank you for the patch.

On 7/15/19 10:43 AM, Kai-Heng Feng wrote:
> After hotplugging an 1Gbps ethernet cable with 1Gbps link partner, the
> MII_BMSR may reports 10Mbps, renders the network rather slow.

s/may reports/may report/
s/renders/rendering/

> The issue has much lower fail rate after commit 59653e6497d1 ("e1000e:
> Make watchdog use delayed work"), which esssentially introduces some

essentially

> delay before running the watchdog task.
> 
> But there's still a chance that the hotplugging event and the queued
> watchdog task gets run at the same time, then the original issue can be
> observed once again.
> 
> So let's use mod_delayed_work() to add a deterministic 1 second delay
> before running watchdog task, after an interrupt.

I am not clear about the effects for the user. Could you elaborate
please? Does the link now come up up to one second later?

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Any bug URL?

> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)


Kind regards,

Paul

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190715/187ece0b/attachment.p7s>
