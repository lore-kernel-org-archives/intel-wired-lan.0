From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 10 Aug 2016 13:50:03 -0700
Subject: [Intel-wired-lan] [next PATCH 1/5] i40e: Introduce devlink
 interface.
In-Reply-To: <1470329387-25138-1-git-send-email-sridhar.samudrala@intel.com>
References: <1470329387-25138-1-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <1470862203.2128.32.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2016-08-04 at 18:49 +0200, Sridhar Samudrala wrote:
> 
> With smode support in iproute2 'devlink' utility, switch mode can be set
> and get via following commands.
> 
> ??? # devlink dev smode pci/0000:05:00.0
> ??? mode: legacy
> ??? # devlink dev set pci/0000:05:00.0 smode switchdev
> ??? # devlink dev smode pci/0000:05:00.0
> ??? mode: switchdev
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
> ?drivers/net/ethernet/intel/Kconfig????????? |? 1 +
> ?drivers/net/ethernet/intel/i40e/i40e.h????? |? 3 ++
> ?drivers/net/ethernet/intel/i40e/i40e_main.c | 84
> ++++++++++++++++++++++++++---
> ?3 files changed, 80 insertions(+), 8 deletions(-)

Since there was no title patch to this series, I am using patch 1 of the
series to address the whole series.

Since Alex has brought up some good concerns/comments that should be
addressed (and the fact that this series does not apply cleanly to my
current tree), I am dropping this series. ?I will await a v2 where Alex's
comments are addressed and the series is rebased against my current dev-
queue branch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160810/8079a75b/attachment.asc>
