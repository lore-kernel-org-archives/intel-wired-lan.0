From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 27 Apr 2016 14:19:58 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbevf: Remove unused parameter
In-Reply-To: <1461791950.2851.18.camel@intel.com>
References: <4C5EDC162D52824D9E7FB1446983F3EE962AF43C@ORSMSX116.amr.corp.intel.com>
 <1461791950.2851.18.camel@intel.com>
Message-ID: <1461791998.2851.19.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-04-27 at 14:19 -0700, Jeff Kirsher wrote:
> On Tue, 2016-04-26 at 23:29 +0000, Nguyen, Anthony L wrote:
> > ixgbevf_update_xcast_mode() is not using the netdev parameter;
> > removing it since it's unnecessary.
> >?
> > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > ---
> > ?drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
> > ?drivers/net/ethernet/intel/ixgbevf/vf.c?????????? | 4 +---
> > ?drivers/net/ethernet/intel/ixgbevf/vf.h?????????? | 2 +-
> > ?3 files changed, 3 insertions(+), 5 deletions(-)
> 
> 2 issues with this patch, first it was corrupted by whatever means
> you
> used to send this patch. ?Second this patch fails to compile (after I
> had to apply it by hand) because it was not generated against my
> lastest dev-queue branch.
> 
> There are only three things I ask when generating kernel patches:
> 1- always use my dev-queue branch to generate kernel patches against
> our Intel wired LAN drivers
> 2- run checkpatch.pl against your patch and fix the reported errors
> and
> possibly warnings
> 3- Compile test your patch before sending it off to intel-wired-lan at l
> is
> ts.osuosl.org?mailing list

Oh forgot to mention, dropping this patch for the v2 I created for Tony
:-(
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160427/26b19dc7/attachment.asc>
